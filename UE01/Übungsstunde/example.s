# data section
.data
string: .string "Hello World!\n"
array: .word 34, 561, 7, 1, 124

.globl main # program entry point

# program code section
.text

main: addi s0, zero, 0 # sum = s0
    addi t0, zero, 5   # len = t0
    addi t1, zero, 0   # i = t1
    la t2, array       # a = t2

loop: bge t1, t0, loop_end # jump out of loop if i >= len
    lw t3, 0(t2)           # get data behind pointer a
    mul t4, t3, t0         # multiply with len
    add s0, s0, t4         # add to sum

    addi t1, t1, 1         # increment i
    addi t2, t2, 4         # increment a (4 byte = 1 word)

    jal zero, loop         # back to loop beginning

loop_end: addi a0, zero, 4 # add print_string operation
la a1, string              # add address of string
ecall
