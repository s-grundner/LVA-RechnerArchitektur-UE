.globl main

.data
arr: .word 0x4, 0x8, 0x12, 0x11, 0x5, 0x21, 0x1, 0x99, 0x41, 0xFF, 0xAB
n: .word 11

.text
main: 
    la t0, arr        # arr = t0
    addi a0, zero, 0  # sum = 0 = a0
    lw t1, n          #n = t1

    add t2, t0, zero  # left pointer, t2 = &arr[0]
    addi t3, t1, -1   # t3 = n - 1
    slli t3, t3, 2    # t3 = t3 << 2 = (n - 1) * 4
    add t4, t0, t3    # right pointer, t4 = &arr[n - 1]

loop: 
    blt t4, t2, loop_end  # jumps out of loop if right pointer < left pointer
    beq t2, t4, mid_elem  # jumps out of loop if left pointer == right pointer, array length is an odd number

    lw t5, 0(t2)      # get data of left pointer
    lw t6, 0(t4)      # get data of right pointer

    sw t6, 0(t2)      # store data into left element
    sw t5, 0(t4)      # store data into right element

    add a0, a0, t5      # add data of left pointer to sum
    add a0, a0, t6      # add data of right pointer to sum

    addi t2, t2, 4      # move left pointer to the right
    addi t4, t4, -4     # move right pointer to the left

    jal zero, loop      # back to loop beginning

mid_elem:          # left and right pointer point to the same address
    lw t5, 0(t2)   # get data of left pointer
    add a0, a0, t5 # add data to sum

loop_end:
