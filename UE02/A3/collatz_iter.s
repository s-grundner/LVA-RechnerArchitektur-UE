.globl main
.text

collatz_iter:
  addi t3, zero, 0 # steps = 0
  addi t0, zero, 1
  beq a0, t0, c_done # if (n == 1) return 0

c_loop:
  andi t1, a0, 1
  bnez t1, c_odd # if (odd)
  srli a0, a0, 1 # n = n / 2
  addi t3, t3, 1 # steps++
  bne a0, t0, c_loop
  jal zero, c_done

c_odd:
  addi t2, zero, 3
  mul t2, t2, a0 # 3n
  addi a0, t2, 1 # n = 3n + 1
  addi t3, t3, 1 # steps++
  bne a0, t0, c_loop

c_done:
  addi a0, t3, 0
  jalr zero, ra, 0 # return steps

main:
  addi a0, zero, 42 # n = 42
  jal ra, collatz_iter
  addi a1, a0, 0 # s0 = collatz(42)
  addi a0, zero, 1 # ecall print_int
  ecall
  addi a0, zero, 11 # ecall print_char
  addi a1, zero, '\n'
  ecall
  addi a0, zero, 1337 # n = 1337
  jal ra, collatz_iter
  addi a1, a0, 0 # s1 = collatz(1337)
  addi a0, zero, 1 # ecall print_int
  ecall
