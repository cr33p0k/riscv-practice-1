# Task 3c: read up to 16 + 3 = 19 integers into an array.
# Zero terminates input and is not stored. Print the stored values afterwards.
.eqv ARRAY_SIZE 19

.data
.align 2
array: .space 76                # 19 words, 4 bytes each
count: .word 0                  # Number of stored elements

.text
.globl main
main:
    la   t0, array
    li   t1, 0
    li   t2, ARRAY_SIZE

read_loop:
    bge  t1, t2, read_done
    li   a7, 5                  # ReadInt
    ecall
    beqz a0, read_done

    sw   a0, 0(t0)
    addi t0, t0, 4
    addi t1, t1, 1
    j    read_loop

read_done:
    la   t0, count
    sw   t1, 0(t0)
    la   t0, array
    li   t2, 0

print_loop:
    bge  t2, t1, done
    beqz t2, print_value
    li   a0, 32
    li   a7, 11
    ecall

print_value:
    lw   a0, 0(t0)
    li   a7, 1
    ecall
    addi t0, t0, 4
    addi t2, t2, 1
    j    print_loop

done:
    li   a0, 10
    li   a7, 11
    ecall
    li   a7, 10
    ecall
