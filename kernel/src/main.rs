#![no_std]
#![no_main]
#![allow(unused)]
#![feature(panic_info_message)]
#![feature(alloc_error_handler)]
#![feature(map_try_insert)]
#![feature(map_first_last)]
#![feature(bool_to_option)]
#![feature(let_chains)]

extern crate alloc;
#[macro_use]
extern crate bitflags;

use lazy_static::*;
use riscv::register::mstatus::set_fs;
use riscv::register::sstatus::{FS, Sstatus};

use crate::sbi::send_ipi;
use crate::task::{get_hart_id, save_hart_id};

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
mod fs;
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
    pub static ref DEV_NON_BLOCKING_ACCESS: spin::Mutex<bool> = unsafe { spin::Mutex::new(false) };
}

extern "C" fn wait_core(hart_id: usize) {
    println!("core {} start", hart_id);
    loop {}
}

#[no_mangle]
pub fn rust_main() -> ! {
    save_hart_id();
    let hart_id = get_hart_id();
    if hart_id != 0 {
        sbi::hart_suspend(0x0, wait_core as usize);
        loop {}
    } else {
        unsafe {
            riscv::register::sstatus::set_fs(FS::Clean);
        };
        clear_bss();
        mm::init();
        trap::init();
        trap::enable_timer_interrupt();
        timer::set_next_trigger();
        //board::device_init();
        fs::list_apps();
        fs::init_rootfs();
        task::add_initproc();
        *DEV_NON_BLOCKING_ACCESS.lock() = true;
        println!("start run tasks");
        task::run_tasks();
        panic!("Unreachable in rust_main!");
    }
    //clear_bss();
    //mm::init();
    //trap::init();
    //trap::enable_timer_interrupt();
    //timer::set_next_trigger();
    //board::device_init();
    //fs_fat::list_apps();
    //task::add_initproc();
    //*DEV_NON_BLOCKING_ACCESS.exclusive_access() = true;
    //println!("start run tasks");
    //task::run_tasks();
    //panic!("Unreachable in rust_main!");
}
