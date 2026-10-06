# Guard-failure fixture: the written array c is frozen.
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

n = 2
a = Array.new(n * n, 0.5)
b = Array.new(n * n, 0.25)
c = Array.new(n * n, 0.0).freeze
begin
  matmul_into(c, a, b, n)
  puts "no error"
rescue => e
  puts e.class
  puts e.message
end
p c
p c.frozen?
