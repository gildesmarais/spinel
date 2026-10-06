#!/usr/bin/env ruby
# frozen_string_literal: true

# Run-time sessions in order, each gated by settle.rb and bracketed by
# `cost.rb idle`: r1 (3 changed benchmarks, 30 rounds), optcarrot fps
# (20 rounds), r2 (as r1). A settle gate is retried every 30 s, 10 tries;
# any other step that exits non-zero stops the chain.
# System sleep on AC is 0 (`pmset -g`), so no caffeinate.

DIR = __dir__
ROOT = File.expand_path("../..", DIR)
S = File.join(DIR, "cost.rb")
T = File.join(DIR, "settle.rb")
P = %w[bm_matmul bm_spectral_norm bm_huffman].map { |b| "benchmark/#{b}.rb" }
R30 = { "ROUNDS" => "30" }.freeze

steps = [
  [T], [S, "idle", "r1-before"], [R30, S, "run", "r1", *P], [S, "idle", "r1-after"],
  [T], [S, "idle", "fps-r1-before"], [S, "fps", "r1", "20"], [S, "idle", "fps-r1-after"],
  [T], [S, "idle", "r2-before"], [R30, S, "run", "r2", *P], [S, "idle", "r2-after"]
]
steps.each do |step|
  env = step.first.is_a?(Hash) ? step.first : {}
  args = env.empty? ? step : step.drop(1)
  puts "#{Time.now.strftime('%H:%M:%S')} >> #{args.map { File.basename(_1) }.join(' ')}"
  $stdout.flush
  tries = args.first == T ? 10 : 1
  ok = false
  tries.times do |i|
    sleep 30 if i.positive?
    break if (ok = system(env, "ruby", *args, chdir: ROOT))
  end
  next if ok

  puts "#{Time.now.strftime('%H:%M:%S')} STOPPED at #{args.join(' ')} (exit #{$?.exitstatus})"
  exit 1
end
puts "#{Time.now.strftime('%H:%M:%S')} CHAIN-DONE"
