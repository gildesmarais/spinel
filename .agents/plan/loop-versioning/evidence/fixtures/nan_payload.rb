# Can a Ruby program reach SP_FLOAT_NIL_BITS through arithmetic on Floats that
# are not nil? Only from a NaN it built bit by bit: a signaling NaN with
# payload 1, which any arithmetic quiets into exactly the sentinel.
snan = [0x7FF0000000000001].pack("Q").unpack1("D")
qnan = [0x7FF8000000000002].pack("Q").unpack1("D")
p snan.nan?
p [snan].pack("D").unpack1("Q").to_s(16)
x = snan + 0.0
p x
p [x].pack("D").unpack1("Q").to_s(16)
y = qnan + 0.0
p y
p [y].pack("D").unpack1("Q").to_s(16)
p (0.0 / 0.0).nan?
p [0.0 / 0.0].pack("D").unpack1("Q").to_s(16)
