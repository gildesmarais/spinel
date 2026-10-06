# Loop versioning in a polling build (docs/internals/loop-versioning.md,
# "Polls"): a change that lands at the poll between two chunks of the fast
# arm, made deterministic. A finalizer shrinks the array the loop reads, or
# freezes the one it writes. Its object dies before double_into, and the
# 32 MB array double_into allocates sets off a collection at its next
# allocation, which leaves the finalizer pending: one that a collection
# frees runs at the next safe point, never inside the allocation. From there
# to the loop nothing polls, and the fast arm polls only between chunks, so
# the finalizer runs on the looping thread after the first chunk (j = 4096).
# The cache refreshes, the guard is tested again, it fails, and today's loop
# goes on from j: it raises at the shrunk length, or at the first write to
# the frozen array. A fast arm that kept running past that poll would read
# past x's length or write into the frozen array, and print `finished`.
# The GC.start ahead of each pass collects what came before, so the next
# collection's trigger is at a size the 32 MB passes.
class Holder
  def initialize(k); @k = k; end
end

def arm_shrink(x, keep)
  ObjectSpace.define_finalizer(Holder.new(keep), proc { |_id| x.pop while x.length > keep })
  nil
end

def arm_freeze(c)
  ObjectSpace.define_finalizer(Holder.new(0), proc { |_id| c.freeze })
  nil
end

def double_into(c, x, n)
  big = Array.new(1 << 22, 0.0)
  big = nil
  tick = Array.new(1, 0.0)
  j = 0
  while j < n
    c[j] = x[j] * 2.0
    j = j + 1
  end
  j + tick.length
end

def filled(c)
  k = 0
  k += 1 while k < c.length && c[k] == 2.0 * k
  k
end

n = 20_000
keep = 10_000
x = Array.new(n, 0.0)
i = 0
while i < n
  x[i] = i.to_f
  i += 1
end
Thread.new { }.join

c = Array.new(n, 0.0)
GC.start
arm_shrink(x, keep)
begin
  double_into(c, x, n)
  puts "shrink: finished"
rescue NoMethodError
  puts "shrink: NoMethodError"
end
puts "shrink: x.length #{x.length}"
puts "shrink: filled #{filled(c)}"

i = 0
while i < keep
  x << 0.0
  i += 1
end
w = Array.new(n, 0.0)
GC.start
arm_freeze(w)
begin
  double_into(w, x, n)
  puts "freeze: finished"
rescue FrozenError
  puts "freeze: FrozenError"
end
puts "freeze: w frozen #{w.frozen?}"
