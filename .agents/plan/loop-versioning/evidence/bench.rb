#!/usr/bin/env ruby
# frozen_string_literal: true

# Timing harness for the loop-versioning plan (no hyperfine on this machine).
#
#   ruby bench.rb check          # idle check only; exit 0 idle, 2 busy
#   ruby bench.rb run SESSION    # idle check, then measure; refuses when busy
#
# Binaries come from regen.rb (tmp/loop-versioning/). A session: an idle
# check (uptime, top, pmset) written to bench/SESSION/idle-before.txt; each
# variant run once and its stdout compared with its expected text; WARMUP
# rounds discarded; ROUNDS rounds in which every variant runs once, always in
# the same order (A B C ... A B C ...); every sample written to
# bench/SESSION/samples.csv; the same idle check again afterwards
# (idle-after.txt); summary.txt with median, min, quartiles and IQR.
#
# A sample is the wall time of one process, spawn to exit, from
# CLOCK_MONOTONIC, stdout to /dev/null; user and sys CPU from the rusage the
# wait collects. Quartiles interpolate linearly between order statistics
# (q = x[(n-1)p], the default of R's quantile and numpy's percentile).

require "digest"
require "fileutils"
require "open3"

EV = File.expand_path(__dir__)
ROOT = File.expand_path("../../../..", EV)
BIN = File.join(ROOT, "tmp", "loop-versioning")
WARMUP = 3
ROUNDS = 40

# name => [binary, args, expected stdout (or a regexp)]
def variants
  mm150 = "-29502222\n-77855452\ndone\n"
  mm500 = /\A-?\d+\n-?\d+\ndone\n\z/
  dot = "-38908921792726.77\n"
  {
    "startup (puts 1)" => ["startup.spinel", [], "1\n"],
    "mm150 current" => ["mm150.spinel", [], mm150],
    "mm150 versioned" => ["mm150.versioned", [], mm150],
    "mm500 current (spinel)" => ["mm500.spinel", [], mm500],
    "mm500 current (direct cc)" => ["mm500.current-direct", [], mm500],
    "mm500 versioned -fno-vectorize" => ["mm500.versioned-novec", [], mm500],
    "mm500 versioned" => ["mm500.versioned", [], mm500],
    "dot current (spinel)" => ["dotbench.spinel", [], dot],
    "dot versioned -fno-vectorize" => ["dotbench.versioned-novec", [], dot],
    "dot versioned" => ["dotbench.versioned", [], dot]
  }
end

HEAVY = /\b(cc|clang|clang-\d+|ld|make|gmake|swift-frontend|swiftc|xcodebuild|cargo|rustc|node|mds_stores|mdworker\w*|spinel|ruby|python\d?|java|go)\b/

def sh(cmd)
  out, = Open3.capture2e(cmd)
  out
end

# Returns [report text, idle?, reasons]
def idle_check
  up = sh("uptime")
  top = sh("top -l 2 -o cpu -n 10 -s 1 -stats pid,command,cpu,state")
  batt = sh("pmset -g batt")
  therm = sh("pmset -g therm")
  lpm = sh("pmset -g").lines.grep(/lowpowermode/).join
  second = top.split(/^Processes:/).last.to_s
  idle = second[/CPU usage:.*?([\d.]+)% idle/, 1].to_f
  load1 = up[/load averages?: ([\d.]+)/, 1].to_f
  procs = second.lines.drop_while { |l| !l.start_with?("PID") }.drop(1).map do |l|
    f = l.split
    next if f.size < 4

    { pid: f[0], cmd: f[1...-2].join(" "), cpu: f[-2].to_f }
  end.compact
  reasons = []
  reasons << format("CPU idle %.1f%% < 90%%", idle) if idle < 90
  reasons << format("1-minute load %.2f > 2.0", load1) if load1 > 2.0
  procs.each do |p|
    next if p[:cmd].start_with?("top") || p[:pid] == Process.pid.to_s
    # the editor hosting the agent that runs this harness: it cannot be
    # stopped from here, so it is recorded in the report but not a veto
    next if p[:cmd].start_with?("Cursor Helper") && p[:cpu] < 40

    reasons << "#{p[:cmd]} (pid #{p[:pid]}) at #{p[:cpu]}% CPU" if p[:cpu] >= 15
    reasons << "#{p[:cmd]} (pid #{p[:pid]}) is a build/indexing process at #{p[:cpu]}% CPU" if p[:cmd] =~ HEAVY && p[:cpu] >= 5
  end
  reasons << "not on AC power" unless batt.include?("AC Power")
  reasons << "a CPU speed limit is recorded" if therm =~ /CPU_Speed_Limit\s*=\s*(\d+)/ && Regexp.last_match(1).to_i < 100
  reasons << "low power mode on" if lpm =~ /lowpowermode\s+1/
  report = +"## #{Time.now.utc.strftime('%Y-%m-%dT%H:%M:%SZ')}\n### uptime\n#{up}### top -l 2 -o cpu -n 10 -s 1 (second sample)\n" \
            "Processes:#{second}### pmset -g batt\n#{batt}### pmset -g therm\n#{therm}### pmset -g (lowpowermode)\n#{lpm}" \
            "### verdict: #{reasons.empty? ? 'IDLE' : "BUSY: #{reasons.uniq.join('; ')}"}\n"
  [report, reasons.empty?, reasons.uniq]
end

def run_once(bin, args)
  t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  c0 = Process.times
  pid = Process.spawn(bin, *args, out: File::NULL, err: File::NULL)
  _, st = Process.wait2(pid)
  t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  c1 = Process.times
  raise "#{bin} exited #{st.exitstatus}" unless st.success?

  [(t1 - t0) * 1000, (c1.cutime - c0.cutime) * 1000, (c1.cstime - c0.cstime) * 1000]
end

def quantile(sorted, p)
  h = (sorted.size - 1) * p
  lo = sorted[h.floor]
  hi = sorted[h.ceil]
  lo + (hi - lo) * (h - h.floor)
end

def summarize(samples)
  out = +format("%-32s %5s %10s %10s %10s %10s %10s %10s\n", "variant", "n", "median_ms", "min_ms", "q1_ms", "q3_ms",
                "iqr_ms", "max_ms")
  med = {}
  samples.group_by { |s| s[:variant] }.each do |v, ss|
    w = ss.map { |s| s[:wall] }.sort
    med[v] = quantile(w, 0.5)
    out << format("%-32s %5d %10.2f %10.2f %10.2f %10.2f %10.2f %10.2f\n", v, w.size, med[v], w.first,
                  quantile(w, 0.25), quantile(w, 0.75), quantile(w, 0.75) - quantile(w, 0.25), w.last)
  end
  out << "\nratios of medians\n"
  [["mm500 current (spinel)", "mm500 versioned -fno-vectorize"], ["mm500 versioned -fno-vectorize", "mm500 versioned"],
   ["mm500 current (spinel)", "mm500 versioned"], ["mm500 current (spinel)", "mm500 current (direct cc)"],
   ["dot current (spinel)", "dot versioned -fno-vectorize"], ["dot versioned -fno-vectorize", "dot versioned"],
   ["mm150 current", "mm150 versioned"], ["mm150 current", "startup (puts 1)"]].each do |a, b|
    out << format("  %-32s / %-32s = %.2fx\n", a, b, med[a] / med[b]) if med[a] && med[b]
  end
  out
end

case ARGV[0]
when "check"
  report, ok, = idle_check
  puts report
  exit(ok ? 0 : 2)
when "run"
  session = ARGV[1] or abort "usage: bench.rb run SESSION"
  dir = File.join(EV, "bench", session)
  abort "#{dir} exists; pick a new session name" if File.exist?(dir)
  report, ok, reasons = idle_check
  unless ok
    puts report
    abort "busy, not measuring: #{reasons.join('; ')}"
  end
  FileUtils.mkdir_p(dir)
  File.write(File.join(dir, "idle-before.txt"), report)
  vs = variants
  check = +"# one run per variant, stdout compared with the expected text\n"
  vs.each do |name, (bin, args, exp)|
    path = File.join(BIN, bin)
    out, st = Open3.capture2(path, *args)
    good = st.success? && (exp.is_a?(Regexp) ? exp.match?(out) : out == exp)
    check << "#{name}: #{path.sub("#{ROOT}/", '')} sha256 #{Digest::SHA256.file(path).hexdigest[0, 16]} " \
             "-> #{out.inspect} #{good ? 'ok' : 'UNEXPECTED'}\n"
    abort "#{name}: unexpected output #{out.inspect}" unless good
  end
  File.write(File.join(dir, "output-check.txt"), check)
  WARMUP.times { vs.each_value { |bin, args, _| run_once(File.join(BIN, bin), args) } }
  samples = []
  started = Time.now.utc
  ROUNDS.times do |r|
    vs.each do |name, (bin, args, _)|
      w, u, s = run_once(File.join(BIN, bin), args)
      samples << { round: r + 1, variant: name, wall: w, user: u, sys: s }
    end
  end
  finished = Time.now.utc
  File.open(File.join(dir, "samples.csv"), "w") do |f|
    f.puts "round,variant,wall_ms,user_ms,sys_ms"
    samples.each { |s| f.puts format("%d,%s,%.3f,%.3f,%.3f", s[:round], s[:variant], s[:wall], s[:user], s[:sys]) }
  end
  after, ok_after, reasons_after = idle_check
  File.write(File.join(dir, "idle-after.txt"), after)
  sum = +"# session #{session}: #{WARMUP} warm-up rounds discarded, #{ROUNDS} rounds, variants interleaved in the order below\n"
  sum << "# measured #{started.strftime('%Y-%m-%dT%H:%M:%SZ')} .. #{finished.strftime('%Y-%m-%dT%H:%M:%SZ')}\n"
  sum << "# idle after: #{ok_after ? 'IDLE' : "BUSY: #{reasons_after.join('; ')}"}\n\n"
  sum << summarize(samples)
  File.write(File.join(dir, "summary.txt"), sum)
  puts sum
else
  abort "usage: bench.rb check | run SESSION"
end
