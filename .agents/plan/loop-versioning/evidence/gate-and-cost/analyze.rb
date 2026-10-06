#!/usr/bin/env ruby
# frozen_string_literal: true

# Summaries of cost.rb's CSVs (OUT = COST_OUT, default next to this file).
#
#   ruby analyze.rb run SESSION...   # run-time medians, IQR, head/base, noise verdict
#   ruby analyze.rb build            # sizes and compile times, per program and in total
#   ruby analyze.rb optcarrot FILE   # fps samples (prog,round,side,fps)
#
# "Outside the noise" means both: the two sides' interquartile ranges do not
# overlap, and a two-sided Mann-Whitney U test (normal approximation, tie
# corrected) gives p < 0.01. Quartiles interpolate linearly (q = x[(n-1)p]).

require "csv"

OUT = File.expand_path(ENV.fetch("COST_OUT", __dir__))

def quantile(s, p)
  h = (s.size - 1) * p
  s[h.floor] + (s[h.ceil] - s[h.floor]) * (h - h.floor)
end

def stats(xs)
  s = xs.sort
  { n: s.size, med: quantile(s, 0.5), q1: quantile(s, 0.25), q3: quantile(s, 0.75), min: s.first, max: s.last }
end

def erfc(x)
  # Abramowitz-Stegun 7.1.26
  t = 1.0 / (1.0 + 0.3275911 * x.abs)
  y = t * (0.254829592 + t * (-0.284496736 + t * (1.421413741 + t * (-1.453152027 + t * 1.061405429)))) * Math.exp(-x * x)
  x >= 0 ? y : 2.0 - y
end

def mann_whitney_p(a, b)
  all = (a.map { |v| [v, 0] } + b.map { |v| [v, 1] }).sort_by(&:first)
  ranks = Array.new(all.size)
  ties = 0.0
  i = 0
  while i < all.size
    j = i
    j += 1 while j + 1 < all.size && all[j + 1][0] == all[i][0]
    r = (i + j) / 2.0 + 1
    (i..j).each { |k| ranks[k] = r }
    t = j - i + 1
    ties += t**3 - t
    i = j + 1
  end
  r1 = all.each_index.sum { |k| all[k][1].zero? ? ranks[k] : 0 }
  n1 = a.size
  n2 = b.size
  u = r1 - n1 * (n1 + 1) / 2.0
  mu = n1 * n2 / 2.0
  n = n1 + n2
  sd = Math.sqrt(n1 * n2 / 12.0 * ((n + 1) - ties / (n * (n - 1))))
  return 1.0 if sd.zero?

  z = (u - mu).abs / sd
  erfc(z / Math.sqrt(2))
end

def verdict(sa, sb, p)
  apart = sa[:q3] < sb[:q1] || sb[:q3] < sa[:q1]
  return "within noise" unless apart && p < 0.01

  sb[:med] > sa[:med] ? "SLOWER (outside noise)" : "FASTER (outside noise)"
end

case ARGV[0]
when "run"
  rows = ARGV.drop(1).flat_map { |s| CSV.read(File.join(OUT, "run-#{s}.csv"), headers: true).map(&:to_h) }
  emit = CSV.read(File.join(OUT, "emit.csv"), headers: true).to_h { |r| [r["prog"], r] }
  puts "| benchmark | loops versioned | n | base median ms (IQR) | head median ms (IQR) | head/base | MWU p | verdict |"
  puts "| --- | --: | --: | --: | --: | --: | --: | --- |"
  out = 0
  rows.group_by { |r| r["prog"] }.each do |prog, rs|
    a = rs.select { |r| r["side"] == "base" }.map { |r| r["wall_ms"].to_f }
    b = rs.select { |r| r["side"] == "head" }.map { |r| r["wall_ms"].to_f }
    bad = rs.reject { |r| r["exit"] == "0" }
    sa = stats(a)
    sb = stats(b)
    p = mann_whitney_p(a, b)
    v = verdict(sa, sb, p)
    out += 1 unless v == "within noise"
    lv = emit.dig(prog, "head_lv_keys") || "?"
    puts format("| %s | %s | %d/%d | %.2f (%.2f) | %.2f (%.2f) | %.3f | %.2g | %s%s |", prog, lv, sa[:n], sb[:n], sa[:med],
                sa[:q3] - sa[:q1], sb[:med], sb[:q3] - sb[:q1], sb[:med] / sa[:med], p, v,
                bad.empty? ? "" : " (#{bad.size} nonzero exits)")
  end
  puts "\n#{out} of #{rows.map { |r| r['prog'] }.uniq.size} outside the noise"
when "build"
  rows = CSV.read(File.join(OUT, "build.csv"), headers: true).map(&:to_h)
  emit = CSV.read(File.join(OUT, "emit.csv"), headers: true).to_h { |r| [r["prog"], r] }
  emit.merge!(CSV.read(File.join(OUT, "emit-optcarrot.csv"), headers: true).to_h { |r| [r["prog"], r] }) if File.exist?(File.join(OUT, "emit-optcarrot.csv"))
  puts "| program | loops | C bytes base -> head (delta) | stripped bytes base -> head (delta) | spinel -c ms base / head | spinel+cc ms base / head (head/base) | spinel+cc IQR base / head |"
  puts "| --- | --: | --- | --- | --- | --- | --- |"
  tot = Hash.new(0.0)
  worst = []
  rows.group_by { |r| r["prog"] }.each do |prog, rs|
    bad = rs.reject { |r| r["ok"] == "true" }
    by = rs.group_by { |r| r["side"] }
    m = ->(side, k) { stats(by[side].map { |r| r[k].to_f }) }
    one = ->(side, k) { by[side].map { |r| r[k] }.uniq }
    cb = one.("base", "c_bytes")
    ch = one.("head", "c_bytes")
    sbz = one.("base", "stripped_bytes")
    shz = one.("head", "stripped_bytes")
    tb = m.("base", "total_ms")
    th = m.("head", "total_ms")
    sc_b = m.("base", "spinel_c_ms")
    sc_h = m.("head", "spinel_c_ms")
    dc = ch.first.to_i - cb.first.to_i
    ds = shz.first.to_i - sbz.first.to_i
    tot[:cb] += cb.first.to_i
    tot[:ch] += ch.first.to_i
    tot[:sb] += sbz.first.to_i
    tot[:sh] += shz.first.to_i
    tot[:tb] += tb[:med]
    tot[:th] += th[:med]
    worst << [prog, dc, ds, th[:med] / tb[:med], th[:med] - tb[:med]]
    note = []
    pc = mann_whitney_p(by["base"].map { |r| r["total_ms"].to_f }, by["head"].map { |r| r["total_ms"].to_f })
    note << format("p %.2g, %s", pc, verdict(tb, th, pc))
    note << "#{bad.size} failed builds" unless bad.empty?
    note << "sizes vary across rounds" if [cb, ch, sbz, shz].any? { |x| x.size > 1 }
    puts format("| %s | %s | %d -> %d (%+d, %+.1f%%) | %d -> %d (%+d, %+.1f%%) | %.0f / %.0f | %.0f / %.0f (%.3f) | %.0f / %.0f |%s", prog,
                emit.dig(prog, "head_lv_keys") || "?", cb.first.to_i, ch.first.to_i, dc, 100.0 * dc / cb.first.to_f,
                sbz.first.to_i, shz.first.to_i, ds, 100.0 * ds / sbz.first.to_f, sc_b[:med], sc_h[:med], tb[:med], th[:med],
                th[:med] / tb[:med], tb[:q3] - tb[:q1], th[:q3] - th[:q1], note.empty? ? "" : " #{note.join('; ')}")
  end
  puts format("\ntotals (median compile time summed): C %d -> %d (%+d, %+.2f%%); stripped %d -> %d (%+d, %+.2f%%); spinel+cc %.0f -> %.0f ms (%+.2f%%)",
              tot[:cb], tot[:ch], tot[:ch] - tot[:cb], 100 * (tot[:ch] - tot[:cb]) / tot[:cb], tot[:sb], tot[:sh], tot[:sh] - tot[:sb],
              100 * (tot[:sh] - tot[:sb]) / tot[:sb], tot[:tb], tot[:th], 100 * (tot[:th] - tot[:tb]) / tot[:tb])
  puts "largest C growth: #{worst.max_by { |w| w[1] }.inspect}"
  puts "largest binary growth: #{worst.max_by { |w| w[2] }.inspect}"
  puts "largest compile-time ratio: #{worst.max_by { |w| w[3] }.inspect}"
when "optcarrot"
  rows = CSV.read(ARGV[1], headers: true).map(&:to_h)
  a = rows.select { |r| r["side"] == "base" }.map { |r| r["fps"].to_f }
  b = rows.select { |r| r["side"] == "head" }.map { |r| r["fps"].to_f }
  sa = stats(a)
  sb = stats(b)
  p = mann_whitney_p(a, b)
  apart = sa[:q3] < sb[:q1] || sb[:q3] < sa[:q1]
  puts format("optcarrot fps: base median %.1f (IQR %.1f, n %d), head median %.1f (IQR %.1f, n %d), head/base %.3f, MWU p %.2g, %s",
              sa[:med], sa[:q3] - sa[:q1], sa[:n], sb[:med], sb[:q3] - sb[:q1], sb[:n], sb[:med] / sa[:med], p,
              apart && p < 0.01 ? "outside noise" : "within noise")
end
