# Loop versioning in a threaded build (docs/internals/loop-versioning.md,
# "Polls"): the fast arm runs in chunks with the polls between them, and after
# a poll it re-tests its entry guard for the rest of the range. Here a second
# thread shrinks the array one loop reads, and freezes the array another
# loop writes, while those loops run pass after pass. Where in a pass that
# lands is the scheduler's choice, so what is printed is what every
# interleaving shares: each pass finishes or stops with the error today's
# loop raises, what the passes wrote is a prefix of the right answer, and
# once the change has landed every later pass sees it.

def double_into(c, x, n)
  j = 0
  while j < n
    c[j] = x[j] * 2.0
    j = j + 1
  end
  j
end

# c holds 2.0 * k for k below some point and 0.0 from there on
def prefix?(c)
  k = 0
  while k < c.length && c[k] == 2.0 * k
    k += 1
  end
  while k < c.length
    return false if c[k] != 0.0
    k += 1
  end
  true
end

# "ok" passes, then only failed ones
def ordered?(log)
  failed = false
  i = 0
  while i < log.length
    if log[i] == "ok"
      return false if failed
    else
      failed = true
    end
    i += 1
  end
  true
end

n = 100_000
passes = 12

x = Array.new(n, 0.0)
i = 0
while i < n
  x[i] = i.to_f
  i += 1
end
c = Array.new(n, 0.0)
shrink = Thread.new do
  k = 0
  while k < 1000
    x.pop
    k += 1
  end
end
log = []
pass = 0
while pass < passes
  begin
    double_into(c, x, n)
    log << "ok"
  rescue NoMethodError, TypeError => e
    log << e.class.name
  end
  pass += 1
end
shrink.join
puts "shrink: x.length #{x.length}"
puts "shrink: c a prefix #{prefix?(c)}"
puts "shrink: passes ordered #{ordered?(log)}"
puts "shrink: errors #{log.reject { |s| s == "ok" }.uniq.length <= 1}"
begin
  double_into(c, x, n)
  puts "shrink: after join ok"
rescue NoMethodError, TypeError
  puts "shrink: after join raised"
end

w = Array.new(n, 0.0)
freeze = Thread.new { w.freeze }
log = []
pass = 0
while pass < passes
  begin
    double_into(w, x, n - 1000)
    log << "ok"
  rescue FrozenError
    log << "FrozenError"
  end
  pass += 1
end
freeze.join
puts "freeze: w frozen #{w.frozen?}"
puts "freeze: w a prefix #{prefix?(w)}"
puts "freeze: passes ordered #{ordered?(log)}"
begin
  double_into(w, x, n - 1000)
  puts "freeze: after join ok"
rescue FrozenError
  puts "freeze: after join raised FrozenError"
end
