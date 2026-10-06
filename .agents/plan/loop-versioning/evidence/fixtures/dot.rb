# A Float reduction, the shape the design leaves scalar: sum = sum + x[j]*y[j].
# The terms span many magnitudes, so any reordering of the additions shows in
# the printed bits.
def dot(x, y, n)
  sum = 0.0
  j = 0
  while j < n
    sum = sum + x[j] * y[j]
    j = j + 1
  end
  sum
end

n = 4096
x = Array.new(n, 0.0)
y = Array.new(n, 0.0)
i = 0
while i < n
  x[i] = 1.0 / (i + 1)
  y[i] = (i % 7 - 3) * 1.0e10 + 1.0 / (i + 3)
  i = i + 1
end
s = dot(x, y, n)
p s
p [s].pack("D").unpack1("Q").to_s(16)
