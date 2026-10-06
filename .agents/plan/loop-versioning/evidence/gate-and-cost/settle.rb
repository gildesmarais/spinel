#!/usr/bin/env ruby
# frozen_string_literal: true

# One settle poll: uptime and `top -l 2 -o cpu -n 10 -s 1` (second sample),
# appended as one line to OUT/idle/settle.log. Ready when CPU idle >= 85%,
# no process (top itself excluded) at >= 20% CPU, no indexing process
# (mds_stores, mdworker*, mds) at >= 5%, and on AC power. Exit 0 ready, 2 busy.

require "fileutils"
require "open3"

#
#   ruby settle.rb                # take a reading
#   ruby settle.rb --check FILE   # judge a `cost.rb idle` report instead

OUT = File.expand_path(ENV.fetch("COST_OUT", "/Users/gil/versioned/gildesmarais/spinel/tmp/gc"))
sh = ->(c) { Open3.capture2e(c).first }
if ARGV[0] == "--check"
  rep = File.read(ARGV[1])
  up = rep[/^### uptime\n(.*)$/, 1].to_s
  batt = rep
  second = rep[/^Processes:(.*?)^### pmset/m, 1].to_s
else
  up = sh.("uptime").strip
  top = sh.("top -l 2 -o cpu -n 10 -s 1 -stats pid,command,cpu,state")
  batt = sh.("pmset -g batt")
  second = top.split(/^Processes:/).last.to_s
end
idle = second[/CPU usage:.*?([\d.]+)% idle/, 1].to_f
procs = second.lines.drop_while { |l| !l.start_with?("PID") }.drop(1).filter_map do |l|
  f = l.split
  { cmd: f[1...-2].join(" "), cpu: f[-2].to_f } if f.size >= 4
end.reject { |p| p[:cmd].start_with?("top") }
busy = []
busy << "battery" unless batt.include?("AC Power")
busy << format("idle %.1f%% < 85%%", idle) if idle < 85
procs.each do |p|
  busy << "#{p[:cmd]} #{p[:cpu]}%" if p[:cpu] >= 20 || (p[:cmd] =~ /\A(mds_stores|mdworker\w*|mds)\b/ && p[:cpu] >= 5)
end
load = up[/load averages?: (.*)\z/, 1]
tops = procs.first(4).map { |p| "#{p[:cmd]} #{p[:cpu]}" }.join(", ")
tag = ARGV[0] == "--check" ? "#{File.basename(ARGV[1], '.txt')}: " : ""
line = format("%s %sload %s idle %.1f%% top [%s] %s\n", Time.now.strftime("%H:%M:%S"), tag, load, idle, tops,
              busy.empty? ? "READY" : "BUSY: #{busy.uniq.join('; ')}")
FileUtils.mkdir_p(File.join(OUT, "idle"))
File.write(File.join(OUT, "idle", "settle.log"), line, mode: "a")
print line
exit(busy.empty? ? 0 : 2)
