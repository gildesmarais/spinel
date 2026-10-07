# A nil the program stores (`b[5] = nil`), which analysis sees: b is no
# longer a FloatArray, so the inner loop is not one the header cache takes,
# today or with loop versioning. Pins that the guard is not what handles it.
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
b2 = Array.new(n * n, 0.5)
b2[5] = nil
c2 = Array.new(n * n, 0.0)
begin
  matmul_into(c2, a, b2, n)
  puts "no error"
rescue => e
  puts "#{e.class}: #{e.message}"
end
p c2
