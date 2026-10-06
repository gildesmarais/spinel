#!/usr/bin/env ruby
# frozen_string_literal: true

# Benchmark run-time sessions (the 3 changed benchmarks, 30 rounds), kept
# only when both bracket readings pass settle.rb's rule (CPU idle >= 85%,
# no process >= 20%, no indexing, AC power).
#
#   ruby chain-bench.rb SESSION...
#
# Per session, up to 6 attempts: wait for settle.rb (every 30 s, 10 tries),
# `cost.rb idle SESSION-before`, check it, run, `cost.rb idle SESSION-after`,
# check it. A failed attempt's CSV and readings are renamed to
# SESSION-voidN-* and the session is retried.

require "fileutils"

DIR = __dir__
ROOT = File.expand_path("../..", DIR)
S = File.join(DIR, "cost.rb")
T = File.join(DIR, "settle.rb")
P = %w[bm_matmul bm_spectral_norm bm_huffman].map { |b| "benchmark/#{b}.rb" }

def log(msg) = puts("#{Time.now.strftime('%H:%M:%S')} #{msg}").tap { $stdout.flush }
def ruby(*args, env: {}) = system(env, "ruby", *args, chdir: ROOT)
def idle_file(label) = File.join(DIR, "idle", "#{label}.txt")

def void!(session)
  n = 1
  n += 1 while File.exist?(File.join(DIR, "run-#{session}-void#{n}.csv")) || File.exist?(idle_file("#{session}-void#{n}-before"))
  csv = File.join(DIR, "run-#{session}.csv")
  FileUtils.mv(csv, File.join(DIR, "run-#{session}-void#{n}.csv")) if File.exist?(csv)
  %w[before after].each do |w|
    f = idle_file("#{session}-#{w}")
    FileUtils.mv(f, idle_file("#{session}-void#{n}-#{w}")) if File.exist?(f)
  end
  log "#{session}: attempt voided as void#{n}"
end

ARGV.each do |session|
  done = 6.times.any? do |attempt|
    log "#{session}: attempt #{attempt + 1}"
    ready = 10.times.any? { |i| sleep 30 if i.positive?; ruby(T) }
    abort "#{session}: machine never settled" unless ready

    ruby(S, "idle", "#{session}-before")
    next void!(session) || false unless ruby(T, "--check", idle_file("#{session}-before"))

    abort "#{session}: cost.rb run failed" unless ruby(S, "run", session, *P, env: { "ROUNDS" => "30" })
    ruby(S, "idle", "#{session}-after")
    next void!(session) || false unless ruby(T, "--check", idle_file("#{session}-after"))

    log "#{session}: KEPT"
    true
  end
  abort "#{session}: no clean attempt in 6" unless done
end
log "CHAIN-DONE"
