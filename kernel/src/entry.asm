    .section .text.entry
    .globl _start
_start:
    la sp, boot_stack_top
    la t1, boot_stack
    add t0, a0, 1
    slli t0,t0,15
    add sp, t1,t0
    call rust_main

    .section .bss.stack
    .globl boot_stack
boot_stack:
    .space 4096 * 16
    .globl boot_stack_top
boot_stack_top:
