# clamped_sum(5, 10) returns 83
# clamped_sum(15, 50) returns 280

.data
array: .word 4, 6, 8, 2, 88, 9, 37, 200, 84, 18
size: .word 10

.globl main
.text

clamp_int:
  addi t0, a1, 0
  blt a0, a1, return  # (x < lo)
  addi t0, a2, 0
  blt a2, a0, return  # (x > hi)
  addi t0, a0, 0

return:
  add a0, zero, t0
  jalr zero, ra, 0

clamped_sum:
  # rescue registers
  addi sp, sp, -32
  sw ra, 28(sp)       # ra
  sw s0, 24(sp)       # sum
  sw s1, 20(sp)       # lo
  sw s2, 16(sp)       # hi
  sw s3, 12(sp)       # i
  sw s4, 8(sp)        # size
  sw s5, 4(sp)        # array

  # initialize
  lui s0, 0           # sum = 0
  addi s0, s0, 0
  addi s1, a0, 0      # rescue lo
  addi s2, a1, 0      # rescue hi
  lui s3, 0           # i = 0
  addi s3, s3, 0
  la t0, size         # t0 = &size
  lw s4, 0(t0)        # s4 = *size
  la s5, array        # s5 = array

for:
  bge s3, s4, done    # for (i < size)
  slli t1, s3, 2      # i * 4 (Offset for array-indices)
  add t1, t1, s5      # address of the i-th element

  lw a0, 0(t1)        # load current element in 0th argument
  mv a1, s1           # first argument for clamp_int(lo)
  mv a2, s2           # second argument for clamp_int(hi)

  jal ra, clamp_int   # function call clamp_int()

  add s0, s0, a0      # add v to sum

  addi s3, s3, 1      # i++
  jal zero, for

done:
  addi a0, s0, 0

  # restore registers
  lw ra, 28(sp)
  lw s0, 24(sp)
  lw s1, 20(sp)
  lw s2, 16(sp)
  lw s3, 12(sp)
  lw s4, 8(sp)
  lw s5, 4(sp)

  addi sp, sp, 32     # reset stack pointer
  jalr zero, ra, 0    # jump back to main

main:
  addi a0, zero, 5    # lo = 5
  addi a1, zero, 10   # hi = 10
  jal ra, clamped_sum
  addi s0, a0, 0      # s0 = sum1

  addi a0, zero, 15   # lo = 15
  addi a1, zero, 50   # hi = 50
  jal ra, clamped_sum
  addi s1, a0, 0      # s1 = sum2

  addi a0, zero, 1    # ecall print_int
  addi a1, s0, 0
  ecall

  addi a0, zero, 11   # ecall print_char
  addi a1, zero, '\n'
  ecall

  addi a0, zero, 1    # ecall print_int
  addi a1, s1, 0
  ecall
