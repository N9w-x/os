#![no_std]
#![no_main]
#![allow(unused)]
#![feature(panic_info_message)]
#![feature(alloc_error_handler)]

extern crate alloc;
#[macro_use]
extern crate bitflags;

use lazy_static::*;

use sync::UPIntrFreeCell;

use crate::sbi::{hsm_hart_stop, send_ipi};
use crate::task::{get_hart_id, store_hart_id};

#[cfg(feature = "board_k210")]
#[path = "boards/k210.rs"]
mod board;
#[cfg(not(any(feature = "board_k210")))]
#[path = "boards/qemu.rs"]
mod board;

#[macro_use]
mod console;
mod config;
mod drivers;
mod fs_fat;
mod lang_items;
mod mm;
mod sbi;
mod sync;
mod syscall;
mod task;
mod timer;
mod trap;

core::arch::global_asm!(include_str!("entry.asm"));
core::arch::global_asm!(include_str!("start_app.S"));

fn clear_bss() {
    extern "C" {
        fn sbss();
        fn ebss();
    }
    unsafe {
        core::slice::from_raw_parts_mut(sbss as usize as *mut u8, ebss as usize - sbss as usize)
            .fill(0);
    }
}

lazy_static! {
    pub static ref DEV_NON_BLOCKING_ACCESS: UPIntrFreeCell<bool> =
        unsafe { UPIntrFreeCell::new(false) };
}

#[no_mangle]
pub fn rust_main() -> ! {
    store_hart_id();
    let hart_id = get_hart_id();
    if hart_id == 0 {
        clear_bss();
        mm::init();
        trap::init();
        trap::enable_timer_interrupt();
        timer::set_next_trigger();
        board::device_init();
        fs_fat::list_apps();
        task::add_initproc();
        *DEV_NON_BLOCKING_ACCESS.exclusive_access() = true;
        println!("start run tasks");
        task::run_tasks();
        panic!("Unreachable in rust_main!");
    } else {
        //todo 多核调度,目前在启动后仅仅输出hartID,然后停止运行
        println!("hello from hart {}", hart_id);
        hsm_hart_stop(hart_id);
        unreachable!("unreachable in rust_main")
    }
}
