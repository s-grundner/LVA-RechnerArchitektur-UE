.globl main

.text

main:
	addi a0, zero, 5
	jal  ra, fib

	addi a1, a0, 0
	addi a0, zero, 1
	ecall

	addi a0, zero, 10
	ecall

fib:
	addi sp, sp, -12
	sw   ra, 0(sp)
	sw   a0, 4(sp)
	;    sw s0, 8(sp); Option 1

	addi t0, zero, 2
	bge  a0, t0, return; Anker

	addi a0, a0, -1; n-1
	jal  ra, fib; fib(n-1) rekursiver Aufruf mit n-1
	sw   a0, 8(sp); Option 2

	; addi s0, a0, 0; Option 1

	addi a0, a0, -2; n-1-1
	jal  ra, fib; fib(n-2) rekursiver Aufruf mit n-2

	add a0, a0, t0; fib(n-1) + fib(n-2)

return:
	lw ra, 0(sp)
	;  lw s0, 8(sp) option 1

	addi sp, sp, 12
	jalr zero, ra, 0; Jump nach ra
