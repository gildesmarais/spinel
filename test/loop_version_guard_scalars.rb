# Guard-failure fixture: the scalars the entry guard tests before the fast
# arm runs. A nil bound n, a nil offset local (bare, or folded away by
# `o * 0`), a nil Integer or Float local the body reads, and a negative
# offset each turn the guard away, and today's loop raises or reads what
# CRuby does. Every loop here is versioned; every call with a non-nil
# scalar and an offset that stays in range takes the fast arm.
def nil_n(y, x, flag)
  n = flag ? 4 : nil
  j = 0
  while j < n
    y[j] = x[j] * 2.0
    j = j + 1
  end
  y
end

def nil_ofs(y, x, flag)
  o = flag ? 1 : nil
  j = 0
  while j < 4
    y[j] = x[o + j] * 2.0
    j = j + 1
  end
  y
end

# SP_INT_NIL * 0 is 0: only the offset local's own nil test turns this away
def nil_ofs_folded(y, x, flag)
  o = flag ? 1 : nil
  j = 0
  while j < 4
    y[j] = x[o * 0 + j] * 2.0
    j = j + 1
  end
  y
end

def nil_f(y, x, flag)
  f = flag ? 2.0 : nil
  j = 0
  while j < 4
    y[j] = x[j] * f
    j = j + 1
  end
  y
end

def nil_k(y, x, flag)
  k = flag ? 3 : nil
  j = 0
  while j < 4
    y[j] = x[j] < k ? 1 : 0
    j = j + 1
  end
  y
end

def neg_ofs(y, x, o)
  j = 0
  while j < 4
    y[j] = x[o + j] * 2.0
    j = j + 1
  end
  y
end

def run(label)
  r = yield
  puts "#{label}: #{r.inspect}"
rescue => e
  puts "#{label}: #{e.class}: #{e.message}"
end

x = Array.new(8, 0.0)
xi = Array.new(8, 0)
i = 0
while i < 8
  x[i] = i * 1.0
  xi[i] = i
  i += 1
end
[true, false].each do |fl|
  run("nil_n #{fl}") { nil_n(Array.new(4, 0.0), x, fl) }
  run("nil_ofs #{fl}") { nil_ofs(Array.new(4, 0.0), x, fl) }
  run("nil_ofs_folded #{fl}") { nil_ofs_folded(Array.new(4, 0.0), x, fl) }
  run("nil_f #{fl}") { nil_f(Array.new(4, 0.0), x, fl) }
  run("nil_k #{fl}") { nil_k(Array.new(4, 0), xi, fl) }
end
run("neg_ofs -1") { neg_ofs(Array.new(4, 0.0), x, -1) }
run("neg_ofs -6") { neg_ofs(Array.new(4, 0.0), x, -6) }
run("neg_ofs 5") { neg_ofs(Array.new(4, 0.0), x, 5) }
