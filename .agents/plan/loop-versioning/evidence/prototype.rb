#!/usr/bin/env ruby
# frozen_string_literal: true

# The loop-versioning prototype: rewrites C that `bin/spinel -S --no-line-map`
# emitted, inserting the entry guard and the fast loop that
# docs/internals/loop-versioning.md proposes in front of each header-cached
# loop it recognises. This stands in for the compiler change; it is not it.
#
# The guard is generated from per-kernel facts (which arrays are read and
# written, each array's offset B, the bound N, the nullable Float locals), as
# the compiler would generate it from the AST. The fast statement is written
# by hand per kernel. Today's loop text is kept, unchanged, as the else arm.
#
#   ruby prototype.rb IN.c OUT.c
#
# Every array in these kernels is read, so each is tested for may_nil; the
# arrays here are ones analysis did not mark, the only ones whose may_nil a
# store keeps up to date (lib/sp_types.h, sp_IntArray/sp_FloatArray).
#
# Build OUT.c with -DLV_TRACE to log, per loop entry, which arm ran.

KERNELS = [
  {
    # benchmark/bm_matmul.rb, fixtures lv_*.rb: c[i*n+j] = c[i*n+j] + aik * b[k*n+j]
    name: "matmul-inner",
    body_has: ["sp_int_add(sp_int_mul(lv_i, lv_n), lv_j)", "sp_int_add(sp_int_mul(lv_k, lv_n), lv_j)"],
    bound: "lv_n",
    arrays: { "lv_c" => { write: true, off: [:mul, "lv_i", "lv_n"] },
              "lv_b" => { write: false, off: [:mul, "lv_k", "lv_n"] } },
    nullable_float_locals: ["lv_aik"],
    fast: "D(lv_c)[O(lv_c) + lv_j] = D(lv_c)[O(lv_c) + lv_j] + lv_aik * D(lv_b)[O(lv_b) + lv_j];"
  },
  {
    # fixtures/lv_alias.rb: y[oy+j] = y[oy+j] + alpha * x[ox+j]
    name: "axpy",
    body_has: ["sp_int_add(lv_oy, lv_j)", "sp_int_add(lv_ox, lv_j)"],
    bound: "lv_n",
    arrays: { "lv_y" => { write: true, off: [:local, "lv_oy"] },
              "lv_x" => { write: false, off: [:local, "lv_ox"] } },
    nullable_float_locals: ["lv_alpha"],
    fast: "D(lv_y)[O(lv_y) + lv_j] = D(lv_y)[O(lv_y) + lv_j] + lv_alpha * D(lv_x)[O(lv_x) + lv_j];"
  },
  {
    # fixtures/lv_index_overflow.rb: c[i*n+j] = c[i*n+j] + 2.0 * b[j]
    name: "row-axpy",
    body_has: ["sp_int_add(sp_int_mul(lv_i, lv_n), lv_j)", "sp_FloatArray_get(lv_b, _t"],
    bound: "lv_m",
    arrays: { "lv_c" => { write: true, off: [:mul, "lv_i", "lv_n"] },
              "lv_b" => { write: false, off: [:zero] } },
    nullable_float_locals: [],
    fast: "D(lv_c)[O(lv_c) + lv_j] = D(lv_c)[O(lv_c) + lv_j] + 2.0 * D(lv_b)[O(lv_b) + lv_j];"
  },
  {
    # fixtures/dot.rb: sum = sum + x[j] * y[j] -- a reduction: checks hoisted, kept scalar
    name: "dot",
    body_has: ["lv_sum = (lv_sum +"],
    bound: "lv_n",
    arrays: { "lv_x" => { write: false, off: [:zero] },
              "lv_y" => { write: false, off: [:zero] } },
    nullable_float_locals: [],
    fast: "lv_sum = lv_sum + D(lv_x)[O(lv_x) + lv_j] * D(lv_y)[O(lv_y) + lv_j];"
  }
].freeze

LOOP_RE = /
  ^(?<def>\#define\ _SP_HCR(?<id>\d+)\(\)\ \(\{\ (?<entries>.*?)\(void\)0;\ \}\)\n)
  (?<pre>[ ]*_SP_HCR\k<id>\(\);\n)
  (?<loop>(?<ind>[ ]*)while\ \(\(lv_j\ <\ (?<bound>lv_\w+)\)\)\ \{\n(?<body>.*?)\n\k<ind>\}\n)
  (?=\#undef\ _SP_HCR\k<id>\n)
/mx

def offset_code(off, var)
  case off[0]
  when :mul then "!__builtin_mul_overflow(#{off[1]}, #{off[2]}, &#{var})"
  when :local then "((#{var} = #{off[1]}), 1)"
  when :zero then "((#{var} = 0), 1)"
  end
end

def rewrite(src)
  hits = []
  out = src.gsub(LOOP_RE) do
    m = Regexp.last_match
    id = m[:id]
    entries = m[:entries].scan(/sp_(Int|Float)Array \*_a = (lv_\w+); _hcd#{id}_(\d+)/)
                         .to_h { |_k, recv, e| [recv, e.to_i] }
    k = KERNELS.find do |kk|
      kk[:bound] == m[:bound] && kk[:body_has].all? { |s| m[:body].include?(s) } &&
        kk[:arrays].keys.all? { |r| entries.key?(r) }
    end
    next m[0] unless k

    hits << k[:name]
    ind = m[:ind]
    n = k[:bound]
    decl = []
    conds = ["#{n} >= 0"]
    k[:arrays].each do |recv, a|
      e = entries.fetch(recv)
      o = "_lvo#{id}_#{e}"
      l = "_lve#{id}_#{e}"
      decl << "sp_int #{o}, #{l};"
      conds << "#{recv} != NULL" << "_hcd#{id}_#{e} != NULL"
      conds << "_hcw#{id}_#{e}" if a[:write]
      conds << "!SP_MAY_NIL(#{recv})"
      conds << offset_code(a[:off], o) << "#{o} >= 0" <<
        "!__builtin_add_overflow(#{o}, #{n}, &#{l})" << "#{l} <= _hcl#{id}_#{e}"
    end
    k[:nullable_float_locals].each { |v| conds << "!sp_float_is_nil(#{v})" }
    fast = k[:fast].gsub(/D\((lv_\w+)\)/) { "_hcd#{id}_#{entries.fetch(Regexp.last_match(1))}" }
                   .gsub(/O\((lv_\w+)\)/) { "_lvo#{id}_#{entries.fetch(Regexp.last_match(1))}" }
    guard = +""
    guard << "#{ind}/* loop-versioning prototype (#{k[:name]}): entry guard */\n"
    guard << "#{ind}#{decl.join(' ')}\n"
    guard << "#{ind}if (#{conds.join("\n#{ind}    && ")}) {\n"
    guard << "#{ind}  LV_NOTE(\"#{k[:name]} fast\");\n"
    guard << "#{ind}  for (; lv_j < #{n}; lv_j++)\n"
    guard << "#{ind}    #{fast}\n"
    guard << "#{ind}} else {\n"
    guard << "#{ind}  LV_NOTE(\"#{k[:name]} slow\");\n"
    "#{m[:def]}#{m[:pre]}#{guard}#{m[:loop]}#{ind}}\n"
  end
  trace = <<~C
    #ifdef LV_TRACE
    #define LV_NOTE(s) fprintf(stderr, "loop-version: %s\\n", s)
    #else
    #define LV_NOTE(s) ((void)0)
    #endif
  C
  out = out.sub(%(#include "spinel_rt.h"\n)) { |inc| inc + trace }
  [out, hits]
end

if $PROGRAM_NAME == __FILE__
  abort "usage: #{$PROGRAM_NAME} IN.c OUT.c" unless ARGV.size == 2
  out, hits = rewrite(File.read(ARGV[0]))
  abort "prototype: no loop recognised in #{ARGV[0]}" if hits.empty?
  File.write(ARGV[1], out)
  warn "prototype: #{ARGV[0]} -> #{ARGV[1]}: versioned #{hits.tally.map { |k, v| "#{k} x#{v}" }.join(', ')}"
end
