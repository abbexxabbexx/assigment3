    .syntax unified
    .cpu cortex-m0plus
    .thumb

    .equ LED0, 0
    .equ LED1, 1
    .equ BTN0, 2
    .equ BTN1, 3
    .equ SIO_BASE,      0xD0000000
    .equ GPIO_IN_OFFS,  0x004
    .equ GPIO_SET_OFFS, 0x014
    .equ GPIO_CLR_OFFS, 0x018
    .equ LED_MASK,  (1<<LED0) | (1<<LED1)
    .equ BTN0_MASK, (1<<BTN0)
    .equ BTN1_MASK, (1<<BTN1)

    .global main
    .thumb_func
main:
    MOVS R0, #LED0
    BL   link_gpio_init
    MOVS R0, #LED0
    MOVS R1, #1
    BL   link_gpio_set_dir

    MOVS R0, #LED1
    BL   link_gpio_init
    MOVS R0, #LED1
    MOVS R1, #1
    BL   link_gpio_set_dir

    MOVS R0, #BTN0
    BL   link_gpio_init
    MOVS R0, #BTN0
    MOVS R1, #0
    BL   link_gpio_set_dir
    MOVS R0, #BTN0
    BL   link_gpio_pull_up

    MOVS R0, #BTN1
    BL   link_gpio_init
    MOVS R0, #BTN1
    MOVS R1, #0
    BL   link_gpio_set_dir
    MOVS R0, #BTN1
    BL   link_gpio_pull_up

loop:
    LDR  R7, =SIO_BASE
    LDR  R0, [R7, #GPIO_IN_OFFS]
    MOVS R2, #0
    LDR  R6, =BTN0_MASK
    TST  R0, R6
    BNE  not_p0
    MOVS R2, #1
    
not_p0:
    MOVS R3, #0
    LDR  R6, =BTN1_MASK
    TST  R0, R6
    BNE  not_p1
    MOVS R3, #1
    
not_p1:
    CMP  R2, #1
    BNE  check_on
    CMP  R3, #1
    BEQ  end_case

check_on:
    CMP  R3, #1
    BNE  check_off
    CMP  R2, #0
    BNE  end_case
    LDR  R5, =LED_MASK
    STR  R5, [R7, #GPIO_SET_OFFS]
    B    end_case

check_off:
    CMP  R2, #1
    BNE  end_case
    CMP  R3, #0
    BNE  end_case
    LDR  R5, =LED_MASK
    STR  R5, [R7, #GPIO_CLR_OFFS]

end_case:
    MOVS R0, #15
delay:
    SUBS R0, R0, #1
    BNE  delay
    B    loop
