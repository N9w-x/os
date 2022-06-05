    .section .text.entry
    .globl _start
_start:
    la      t1, boot_stack
    add     t0, a0, 1
    slli    t0, t0, 15
    add     sp, t1, t0
    call    rust_main

    .section .bss.stack
    .globl boot_stack
boot_stack:
    # stack of 2 cores
    .space 4096 * 16 * 2
    .globl boot_stack_top
boot_stack_top:
