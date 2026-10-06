# Guard-failure fixture: a nil inside the range the inner loop reads, as a
# run-time gap (b grown past its end). Analysis does not see it; the store
# that leaves the gap sets the array's may_nil flag at run time.
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

# elements 6 and 7 are nil, element 8 is 0.25
b = Array.new(n * n - 3, 0.5)
b[n * n - 1] = 0.25
c = Array.new(n * n, 0.0)
begin
  matmul_into(c, a, b, n)
  puts "no error"
rescue => e
  puts "#{e.class}: #{e.message}"
end
p c

