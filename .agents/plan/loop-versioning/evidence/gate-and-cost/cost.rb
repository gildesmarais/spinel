#!/usr/bin/env ruby
# frozen_string_literal: true

# Base-against-HEAD cost of loop versioning: which loops version, emitted C
# and binary size, compile time, run time. Two compilers, each built in its
# own worktree (tmp/wt-base at 52c5ccf74, tmp/wt-head at 4ca5b952a).
#
#   ruby cost.rb idle LABEL            # uptime, top, pmset -> OUT/idle/LABEL.txt; exit 2 when busy
#   ruby cost.rb emit                  # -c with --decisions-log, both sides -> OUT/emit.csv (not timed)
#   ruby cost.rb build ROUNDS [PROG..] # timed `spinel -c` and `spinel -o`, sides alternated -> OUT/build.csv
#   ruby cost.rb probe                 # one run of each benchmark binary, output checked -> OUT/probe.csv
#   ruby cost.rb run SESSION [PROG..]  # interleaved timing -> OUT/run-SESSION.csv
#
# A run sample is the wall time of one process, spawn to exit
# (CLOCK_MONOTONIC), stdout and stderr to /dev/null, cwd the repository root.
# Rounds alternate the order (base head, head base, ...) so neither side
# always runs first. Quartiles interpolate linearly (q = x[(n-1)p]).

require "csv"
require "fileutils"
require "open3"

ROOT = File.expand_path(ENV.fetch("SPINEL_ROOT", "/Users/gil/versioned/gildesmarais/spinel"))
OUT = File.expand_path(ENV.fetch("COST_OUT", File.join(ROOT, "tmp", "gc")))
SIDES = {
  "base" => File.join(ROOT, "tmp", "wt-base", "bin", "spinel"),
  "head" => File.join(ROOT, "tmp", "wt-head", "bin", "spinel")
}.freeze
HEAVY = /\b(cc|clang|clang-\d+|ld|make|gmake|swift-frontend|swiftc|xcodebuild|cargo|rustc|mds_stores|mdworker\w*|spinel|backupd)\b/

def progs(args)
  list = args.empty? ? Dir[File.join(ROOT, "benchmark", "bm_*.rb")].sort : args.map { |a| File.expand_path(a) }
  list.to_h { |p| [File.basename(p, ".rb"), p] }
end

def sh(cmd) = Open3.capture2e(cmd).first

def idle(label)
  up = sh("uptime")
  top = sh("top -l 2 -o cpu -n 10 -s 1 -stats pid,command,cpu,state")
  batt = sh("pmset -g batt")
  therm = sh("pmset -g therm")
  lpm = sh("pmset -g").lines.grep(/lowpowermode/).join
  second = top.split(/^Processes:/).last.to_s
  idle_pct = second[/CPU usage:.*?([\d.]+)% idle/, 1].to_f
  procs = second.lines.drop_while { |l| !l.start_with?("PID") }.drop(1).filter_map do |l|
    f = l.split
    { pid: f[0], cmd: f[1...-2].join(" "), cpu: f[-2].to_f } if f.size >= 4
  end
  veto = []
  veto << "not on AC power" unless batt.include?("AC Power")
  veto << "CPU speed limit" if therm =~ /CPU_Speed_Limit\s*=\s*(\d+)/ && Regexp.last_match(1).to_i < 100
  veto << "low power mode on" if lpm =~ /lowpowermode\s+1/
  procs.each do |p|
    next if p[:cmd].start_with?("top")
    veto << "#{p[:cmd]} (pid #{p[:pid]}) at #{p[:cpu]}% CPU" if p[:cpu] >= 80
    veto << "#{p[:cmd]} (pid #{p[:pid]}) build/indexing at #{p[:cpu]}% CPU" if p[:cmd] =~ HEAVY && p[:cpu] >= 5
  end
  verdict = veto.empty? ? "OK" : "ABORT: #{veto.uniq.join('; ')}"
  report = +"## #{label} #{Time.now.strftime('%Y-%m-%dT%H:%M:%S%z')}\n### uptime\n#{up}" \
             "### top -l 2 -o cpu -n 10 -s 1 (second sample)\nProcesses:#{second}" \
             "### pmset -g batt\n#{batt}### pmset -g therm\n#{therm}### pmset -g (lowpowermode)\n#{lpm}"
  report << format("### CPU idle %.1f%%\n### verdict: %s\n", idle_pct, verdict)
  FileUtils.mkdir_p(File.join(OUT, "idle"))
  File.write(File.join(OUT, "idle", "#{label}.txt"), report)
  [report, veto.empty?]
end

def now = Process.clock_gettime(Process::CLOCK_MONOTONIC)

def timed(*cmd)
  t0 = now
  out, st = Open3.capture2e(*cmd, chdir: ROOT)
  [(now - t0) * 1000, st.success?, out]
end

def run_once(bin)
  t0 = now
  pid = Process.spawn(bin, out: File::NULL, err: File::NULL, chdir: ROOT)
  _, st = Process.wait2(pid)
  [(now - t0) * 1000, st.exitstatus]
end

def quantile(s, p)
  h = (s.size - 1) * p
  s[h.floor] + (s[h.ceil] - s[h.floor]) * (h - h.floor)
end

def cdir(side) = File.join(OUT, side).tap { |d| FileUtils.mkdir_p(d) }

def bin_path(side, name) = File.join(cdir(side), "#{name}.bin")

case ARGV[0]
when "idle"
  report, ok = idle(ARGV[1] || "check")
  puts report
  exit(ok ? 0 : 2)
when "emit"
  rows = []
  progs(ARGV.drop(1)).each do |name, path|
    row = { "prog" => name }
    SIDES.each do |side, spinel|
      c = File.join(cdir(side), "#{name}.c")
      dec = File.join(cdir(side), "#{name}.dec")
      FileUtils.rm_f([c, dec])
      _, ok, out = timed(spinel, path, "-c", "-o", c, "--decisions-log=#{dec}")
      File.write(File.join(cdir(side), "#{name}.emit.log"), out)
      src = ok ? File.read(c) : ""
      keys = File.exist?(dec) ? File.readlines(dec, chomp: true).grep(/\Aloop-version@/) : []
      row["#{side}_ok"] = ok
      row["#{side}_c_bytes"] = ok ? File.size(c) : nil
      row["#{side}_lv_keys"] = keys.size
      row["#{side}_lv_guards"] = src.scan(/\bint _lvg(\d+) = 1;/).uniq.size
      row["#{side}_lv_chunked"] = src.scan(/\bsp_int _lvc(\d+) = /).uniq.size
      row["#{side}_threads"] = src.include?("SPINEL_USES_THREADS")
      row["#{side}_keys"] = keys.join(" ")
    end
    a = File.join(cdir("base"), "#{name}.c")
    b = File.join(cdir("head"), "#{name}.c")
    row["c_identical"] = File.exist?(a) && File.exist?(b) && File.binread(a) == File.binread(b)
    noline = ->(f) { File.readlines(f).reject { |l| l.start_with?("#line ") } }
    row["c_identical_but_line"] = File.exist?(a) && File.exist?(b) && noline.(a) == noline.(b)
    rows << row
    puts row.values_at("prog", "base_c_bytes", "head_c_bytes", "head_lv_keys", "head_lv_guards", "head_lv_chunked", "c_identical", "c_identical_but_line").join(",")
  end
  CSV.open(File.join(OUT, ENV.fetch("EMIT_CSV", "emit.csv")), "w") do |csv|
    csv << rows.first.keys
    rows.each { |r| csv << r.values }
  end
when "build"
  rounds = Integer(ARGV[1])
  list = progs(ARGV.drop(2))
  file = File.join(OUT, "build.csv")
  fresh = !File.exist?(file)
  CSV.open(file, "a") do |csv|
    csv << %w[round prog side spinel_c_ms total_ms ok bin_bytes stripped_bytes c_bytes] if fresh
    rounds.times do |r|
      list.each do |name, path|
        order = r.even? ? SIDES.keys : SIDES.keys.reverse
        order.each do |side|
          spinel = SIDES[side]
          c = File.join(cdir(side), "#{name}.timed.c")
          bin = bin_path(side, name)
          FileUtils.rm_f([c, bin])
          tc, okc, = timed(spinel, path, "-c", "-o", c)
          tt, okb, out = timed(spinel, path, "-o", bin)
          File.write("#{bin}.log", out) unless okb
          strip = "#{bin}.stripped"
          sz = ss = nil
          if okb
            sz = File.size(bin)
            FileUtils.cp(bin, strip)
            ss = sh("strip #{strip} 2>&1 && echo ok").include?("ok") ? File.size(strip) : nil
          end
          csv << [r + 1, name, side, tc.round(1), tt.round(1), okc && okb, sz, ss, okc ? File.size(c) : nil]
          csv.flush
          puts format("%d %-28s %s spinel-c %8.1f ms  total %8.1f ms  %s", r + 1, name, side, tc, tt, okc && okb ? "ok" : "FAIL")
        end
      end
    end
  end
when "probe"
  CSV.open(File.join(OUT, "probe.csv"), "w") do |csv|
    csv << %w[prog side ms exit output_ok]
    progs(ARGV.drop(1)).each do |name, path|
      exp = File.exist?("#{path}.expected") ? File.read("#{path}.expected").gsub("\r\n", "\n") : nil
      SIDES.each_key do |side|
        bin = bin_path(side, name)
        t0 = now
        out, st = Open3.capture2(bin, chdir: ROOT)
        ms = (now - t0) * 1000
        ok = exp.nil? ? "no-expected" : (out.gsub("\r\n", "\n") == exp)
        csv << [name, side, ms.round(2), st.exitstatus, ok]
        puts format("%-28s %s %9.2f ms exit %s output %s", name, side, ms, st.exitstatus, ok)
      end
    end
  end
when "run"
  session = ARGV[1] or abort "usage: cost.rb run SESSION [PROG..]"
  list = progs(ARGV.drop(2))
  probe = CSV.read(File.join(OUT, "probe.csv"), headers: true).group_by { |r| r["prog"] }
  file = File.join(OUT, "run-#{session}.csv")
  abort "#{file} exists" if File.exist?(file)
  CSV.open(file, "w") do |csv|
    csv << %w[prog round side wall_ms exit]
    list.each_key do |name|
      abort "#{Time.now.strftime('%H:%M:%S')} ABORT before #{name}: not on AC power" unless sh("pmset -g batt").include?("AC Power")
      ms = probe.fetch(name).map { |r| r["ms"].to_f }.max
      rounds = ENV["ROUNDS"]&.to_i || (ms > 3000 ? 10 : 20)
      warm = ms > 3000 ? 1 : 2
      warm.times { SIDES.each_key { |s| run_once(bin_path(s, name)) } }
      rows = []
      rounds.times do |r|
        order = r.even? ? SIDES.keys : SIDES.keys.reverse
        order.each do |side|
          w, ex = run_once(bin_path(side, name))
          rows << [name, r + 1, side, w.round(3), ex]
        end
      end
      abort "#{Time.now.strftime('%H:%M:%S')} ABORT after #{name}: not on AC power; its samples dropped" unless sh("pmset -g batt").include?("AC Power")
      rows.each { |row| csv << row }
      csv.flush
      puts "#{Time.now.strftime('%H:%M:%S')} #{name}: #{rounds} rounds"
    end
  end
when "fps"
  session = ARGV[1] or abort "usage: cost.rb fps SESSION ROUNDS"
  rounds = Integer(ARGV[2] || 20)
  file = File.join(OUT, "fps-#{session}.csv")
  abort "#{file} exists" if File.exist?(file)
  bins = SIDES.keys.to_h { |s| [s, File.join(cdir(s), "optcarrot-harness")] }
  fps = lambda do |bin|
    out, st = Open3.capture2e(bin, chdir: ROOT)
    raise "#{bin}: exit #{st.exitstatus}" unless st.success? && out.include?("checksum: 59662")

    out[/^fps: ([\d.]+)$/, 1].to_f
  end
  2.times { bins.each_value { |b| fps.(b) } }
  CSV.open(file, "w") do |csv|
    csv << %w[prog round side fps]
    rounds.times do |r|
      (r.even? ? SIDES.keys : SIDES.keys.reverse).each { |s| csv << ["optcarrot", r + 1, s, fps.(bins[s]).round(1)] }
    end
  end
  puts "#{Time.now.strftime('%H:%M:%S')} optcarrot: #{rounds} rounds"
else
  abort "usage: cost.rb idle LABEL | emit | build ROUNDS [PROG..] | probe | run SESSION [PROG..] | fps SESSION ROUNDS"
end
