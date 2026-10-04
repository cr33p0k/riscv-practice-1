# Task 3a: print 1 if x equals the student's number, otherwise print 0.
# Student number: 3.
.eqv STUDENT_NUMBER 3

.text
.globl main
main:
    li   a7, 5                  # ReadInt: x -> a0
    ecall

    li   t0, STUDENT_NUMBER
    li   t1, 0
    bne  a0, t0, print_result
    li   t1, 1

print_result:
    mv   a0, t1
    li   a7, 1                  # PrintInt
    ecall
    li   a0, 10                 # Newline
    li   a7, 11                 # PrintChar
    ecall

    li   a7, 10                 # Exit
    ecall
