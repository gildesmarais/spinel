# spinel: int64 -- assumes a 64-bit Integer; not run on a 32-bit target
# Guard-failure fixture: the offset i*n of an index overflows sp_int. Under
# --int-overflow=raise spinel raises RangeError where CRuby goes to Bignum;
# this pins spinel's raise-mode answer, so it is not a CRuby-snapshot test.
def row_axpy(c, b, i, n, m)
  j = 0
  while j < m
    c[i * n + j] = c[i * n + j] + 2.0 * b[j]
    j = j + 1
  end
  c
end

c = Array.new(4, 1.0)
b = Array.new(4, 0.5)

# i*n = 2**64: the multiply overflows before the first element is touched
begin
  row_axpy(c, b, 4294967296, 4294967296, 4)
  puts "mul: no error"
rescue => e
  puts "mul: #{e.class}: #{e.message}"
end
p c

# i*n = 2**63 - 2 fits; i*n + j overflows at j = 2, after two passes
begin
  row_axpy(c, b, 9223372036854775806, 1, 4)
  puts "add: no error"
rescue => e
  puts "add: #{e.class}: #{e.message}"
end
p c

# in range: the loop runs to the end
p row_axpy(c, b, 0, 4, 4)
