# Guard fixture: one array under two names. The guard does not fail here
# (aliasing is legal); the fast loop must still compute what the sequential
# Ruby loop computes, which is what the C compiler's own runtime overlap
# check has to preserve.
def matmul(a, b, n)
  c = Array.new(n * n, 0.0)
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

# y[oy + j] += alpha * x[ox + j]; with x == y and oy = ox + 1 each pass reads
# the element the previous pass wrote (a loop-carried dependence).
def axpy(y, x, n, oy, ox, alpha)
  j = 0
  while j < n
    y[oy + j] = y[oy + j] + alpha * x[ox + j]
    j = j + 1
  end
  y
end

def ramp(len)
  v = Array.new(len, 0.0)
  i = 0
  while i < len
    v[i] = i * 0.5 + 1.0
    i = i + 1
  end
  v
end

n = 4
m = ramp(n * n)
p matmul(m, m, n)            # a and b the same array

c = ramp(n * n)
p matmul_into(c, c, c, n)    # c written while read as a and as b

v = ramp(24)
p axpy(v, v, 20, 1, 0, 0.5)  # write ahead of the read: dependence carried
v = ramp(24)
p axpy(v, v, 20, 0, 1, 0.5)  # write behind the read
v = ramp(24)
p axpy(v, v, 20, 3, 0, 0.5)  # distance 3, under a 4-lane vector
w = ramp(24)
p axpy(w, ramp(24), 20, 0, 0, 0.5)  # distinct arrays
