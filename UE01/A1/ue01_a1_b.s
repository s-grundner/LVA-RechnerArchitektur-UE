# int a = 0xdeadbeef;
addi t0, zero, 0xdeadbeef

# int b = 0x0badc0de;
lui t1, 47836
addi t1, t1, 222

# ~a
sub t2, zero, t0

# ~b
xori t3, t1, -1

# (~a & ~b)
and t4, t2, t3

# (a ^ b)
xor t5, t0, t1

# (~a & ~b) | (a ^ b)
or a0, t4, t5