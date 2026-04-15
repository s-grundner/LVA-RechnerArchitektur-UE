.globl main
.text

collatz_recu:
  addi sp, sp, -4       # allocate stack space
  sw   ra, 0(sp)        # save return address

  addi t0, zero, 1
  beq  a0, t0, c_base   # if (n == 1)

  andi t1, a0, 1
  bnez t1, c_odd        # if (odd)

  jal  zero, c_even     # else

c_even:
  srli a0, a0, 1        # n = n >> 1 = n / 2

  jal  ra, collatz_recu # recursive call
  addi a0, a0, 1        # n++

  lw   ra, 0(sp)        # restore return address
  addi sp, sp, 4        # restore stack
  jalr zero, ra, 0      # return

c_odd:
  addi t0, zero, 3
  mul  t0, t0, a0       # 3n
  addi a0, t0, 1        # n = 3n + 1

  jal  ra, collatz_recu # recursive call
  addi a0, a0, 1        # n++

  lw   ra, 0(sp)        # restore return address
  addi sp, sp, 4        # restore stack
  jalr zero, ra, 0      # return

c_base:
  addi a0, zero, 0      # set base case n = 0
  addi sp, sp, 4        # restore stack
  jalr zero, ra, 0      # return

main:
  addi a0, zero, 42     # n = 42
  jal  ra, collatz_recu
  addi a1, a0, 0        # s0 = collatz(42)
  addi a0, zero, 1      # ecall print_int
  ecall
  addi a0, zero, 11     # ecall print_char
  addi a1, zero, '\n'
  ecall
  addi a0, zero, 1337   # n = 1337
  jal  ra, collatz_recu
  addi a1, a0, 0        # s1 = collatz(1337)
  addi a0, zero, 1      # ecall print_int
  ecall
