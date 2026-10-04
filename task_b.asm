# Task 3b: print min(x, 138), min(x, 138) + 3, ... up to max(x, 138).
# Group: M3O-138SV-26; student number and step: 3.
.eqv GROUP_NUMBER 138
.eqv STEP 3

.text
.globl main
main:
    li   a7, 5                  # ReadInt
    ecall
    li   t1, GROUP_NUMBER
    mv   t0, a0
    ble  t0, t1, range_ready

    mv   t0, t1                 # x > y: lower bound is y
    mv   t1, a0                 # Upper bound is x

range_ready:
    li   t2, STEP

print_value:
    mv   a0, t0
    li   a7, 1                  # PrintInt
    ecall

    # Compare the unsigned distance before adding, avoiding signed overflow.
    sub  t3, t1, t0
    bltu t3, t2, done

    li   a0, 32                 # Space between values
    li   a7, 11
    ecall
    add  t0, t0, t2
    j    print_value

done:
    li   a0, 10
    li   a7, 11
    ecall
    li   a7, 10
    ecall
