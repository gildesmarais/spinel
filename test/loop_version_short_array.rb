# Guard-failure fixture: b is shorter than n*n, so the inner loop reads past
# its end (nil in Ruby) partway through.
def matmul_into(c, a, b, n)
  i = 0
  while i < n
    k = 0
    while k < n
      aik = a[i * n + k]
      j = 0
      while j < n
        c[i * n + j] = c[i * n + j] + aik * b[k * n + j]
        j = j + 1
      end
      k = k + 1
    end
    i = i + 1
  end
  c
end

n = 3
a = Array.new(n * n, 0.5)
b = Array.new(n * n - 2, 0.5)
c = Array.new(n * n, 0.0)
begin
  matmul_into(c, a, b, n)
  puts "no error"
rescue => e
  puts "#{e.class}: #{e.message}"
end
p c
