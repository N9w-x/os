#![allow(unused)]

use core::arch::asm;

const SBI_SET_TIMER: usize = 0;
const SBI_CONSOLE_PUTCHAR: usize = 1;
const SBI_CONSOLE_GETCHAR: usize = 2;
const SBI_CLEAR_IPI: usize = 3;
const SBI_SEND_IPI: usize = 4;
const SBI_REMOTE_FENCE_I: usize = 5;
const SBI_REMOTE_SFENCE_VMA: usize = 6;
const SBI_REMOTE_SFENCE_VMA_ASID: usize = 7;
const SBI_SHUTDOWN: usize = 8;

const SBI_EXTENSION_HSM: usize = 0x48534d;

//sbi HSM function
const FUNCTION_HSM_HART_START: usize = 0x0;
const FUNCTION_HSM_HART_STOP: usize = 0x1;
const FUNCTION_HSM_HART_GET_STATUS: usize = 0x2;
const FUNCTION_HSM_HART_SUSPEND: usize = 0x3;

#[inline(always)]
fn sbi_call(extension: usize, function: usize, args: [usize; 3]) -> usize {
    let mut ret;
    unsafe {
        core::arch::asm!(
        "ecall",
        inlateout("a0") args[0] => ret,
        in("a1") args[1],
        in("a2") args[2],
        in("a7") extension,
        in("a6") function,
        );
    }
    ret
}

pub fn set_timer(timer: usize) {
    sbi_call(SBI_SET_TIMER, 0, [timer, 0, 0]);
}

pub fn console_putchar(c: usize) {
    sbi_call(SBI_CONSOLE_PUTCHAR, 0, [c, 0, 0]);
}

pub fn console_getchar() -> usize {
    sbi_call(SBI_CONSOLE_GETCHAR, 0, [0, 0, 0])
}

pub fn shutdown() -> ! {
    sbi_call(SBI_SHUTDOWN, 0, [0, 0, 0]);
    panic!("It should shutdown!");
}

pub fn send_ipi(mask: usize) {
    sbi_call(SBI_SEND_IPI, 0, [mask, 0, 0]);
}

pub fn hsm_hart_stop(hart_id: usize) -> usize {
    sbi_call(SBI_EXTENSION_HSM, FUNCTION_HSM_HART_STOP, [hart_id, 0, 0])
}
