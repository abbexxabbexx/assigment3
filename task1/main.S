    .syntax unified
    .cpu cortex-m0plus
    .thumb

    .thumb_func
    .global main

main:
    BL  stdio_init_all

loop:
    LDR R0, =my_array   
    MOVS R1, #8
    BL  average   

    MOV  R1, R0
    LDR  R0, =message_str
    BL   printf
    B    loop

average:
    MOVS R2, #0
    MOV  R3, R1

sum_loop:
    LDR  R4, [R0]
    ADDS R2, R2, R4
    ADDS R0, R0, #4
    SUBS R1, R1, #1
    CMP  R1, #0
    BNE  sum_loop

div_loop:
    CMP  R3, #1
    BEQ  div_done
    LSRS R2, R2, #1
    LSRS R3, R3, #1
    B    div_loop

div_done:
    MOV  R0, R2
    BX   LR

    .data
    .align 4
message_str: .asciz "Average value %d\n"

    .align 4
my_array: .word 10, 20, 30, 40, 50, 60, 70, 80
