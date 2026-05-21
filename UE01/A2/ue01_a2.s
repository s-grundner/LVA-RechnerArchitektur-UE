.globl main
.text

main: addi t0, zero, 0 # fib_curr = t0
    addi t1, zero, 1   # fib_prev = t1
    addi t2, zero, 0   # k = t2

fib: add t3, t0, t1      # tmp = fib_curr + fib_prev
    bltu t3, t0, fib_end # Integer overflow, if result smaller after wrapping around the integer interval
    addi t1, t0, 0       # fib_prev = fib_curr
    addi t0, t3, 0       # fib_curr = tmp
    addi t2, t2, 1       # k++
    jal zero, fib

fib_end: addi a0, t0, 0  # fib_curr = a0
    addi a1, t2, 0       # k = a1
