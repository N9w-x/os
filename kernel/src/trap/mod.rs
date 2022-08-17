use core::arch::{asm, global_asm};

use riscv::register::{
    mtvec::TrapMode,
    scause::{self, Exception, Interrupt, Trap},
    sie, sscratch, sstatus, stval, stvec,
};

pub use context::TrapContext;
pub use pagefault::{lazy_check, cow_check};

use crate::{config::TRAMPOLINE, mm::{translated_byte_buffer, translated_ref}};
use crate::mm::{MapPermission, VirtAddr, VirtPageNum};
use crate::syscall::syscall;
use crate::task::{
    check_signals_of_current, current_add_signal, current_process, current_task, current_trap_cx,
    current_trap_cx_user_va, current_user_token, exit_current_and_run_next, handle_signals,
    ITIMER_MANAGER, SaFlags, Signum, suspend_current_and_run_next,
};
use crate::timer::{check_timer, set_next_trigger};

mod context;
mod pagefault;

global_asm!(include_str!("trap.S"));

pub fn init() {
    set_kernel_trap_entry();
}

fn set_kernel_trap_entry() {
    extern "C" {
        fn __alltraps();
        fn __alltraps_k();
    }
    let __alltraps_k_va = __alltraps_k as usize - __alltraps as usize + TRAMPOLINE;
    unsafe {
        stvec::write(__alltraps_k_va, TrapMode::Direct);
        sscratch::write(trap_from_kernel as usize);
    }
}

fn set_user_trap_entry() {
    unsafe {
        stvec::write(TRAMPOLINE as usize, TrapMode::Direct);
    }
}

pub fn enable_timer_interrupt() {
    unsafe {
        sie::set_stimer();
    }
}

fn enable_supervisor_interrupt() {
    unsafe {
        sstatus::set_sie();
    }
}

fn disable_supervisor_interrupt() {
    unsafe {
        sstatus::clear_sie();
    }
}

#[no_mangle]
pub fn trap_handler() -> ! {
    set_kernel_trap_entry();
    let scause = scause::read();
    let stval = stval::read();
    //println!("into {:?}", scause.cause());
    match scause.cause() {
        Trap::Exception(Exception::UserEnvCall) => {
            // jump to next instruction anyway
            let mut cx = current_trap_cx();
            cx.sepc += 4;
    
            enable_supervisor_interrupt();
    
            // get system call return value
            let result = syscall(
                cx.x[17],
                [cx.x[10], cx.x[11], cx.x[12], cx.x[13], cx.x[14], cx.x[15]],
            );
            // cx is changed during sys_exec, so we have to call it again
            cx = current_trap_cx();
            cx.x[10] = result as usize;
        }
        Trap::Exception(Exception::InstructionFault)
        | Trap::Exception(Exception::InstructionPageFault) => {
            println!(
                "[kernel] {:?} in application, bad addr = {:#x} bad inst = {:#x}",
                scause.cause(),
                stval,
                current_trap_cx().sepc
            );
            current_add_signal(Signum::SIGSEGV);
        }
        Trap::Exception(Exception::StoreFault)
        | Trap::Exception(Exception::StorePageFault)
        | Trap::Exception(Exception::LoadFault)
        | Trap::Exception(Exception::LoadPageFault) => {
            // let cause = scause.cause();
            // if cause == Trap::Exception(Exception::LoadPageFault) {
            //     let pcb = current_process();
            //     let inner = pcb.inner_exclusive_access();
            //     inner.memory_set.print_map_area();
            // }
            //let cause = scause.cause();
            //if cause == Trap::Exception(Exception::LoadPageFault) {
            //    let pcb = current_process();
            //    let mut inner = pcb.inner_exclusive_access();
            //    let start = VirtAddr::from(stval);
            //
            //    inner.memory_set.insert_framed_area(start, start, MapPermission::X);
            //}
            // println!("{:#?}", current_trap_cx());
            if !([
                Trap::Exception(Exception::StoreFault), 
                Trap::Exception(Exception::StorePageFault)
            ].contains(&scause.cause()) 
                && cow_check(stval) 
                || lazy_check(stval))
            {
                println!(
                    "[kernel] {:?} in application, bad addr = {:#x} bad inst = {:#x}",
                    scause.cause(),
                    stval,
                    current_trap_cx().sepc
                );
                current_add_signal(Signum::SIGSEGV);
                let process = current_process();
                process
                    .inner_exclusive_access()
                    .memory_set
                    .print_mmap_area();
            } 
            // else {
            //     println!("[pagefault] val: {:#X}", translated_ref(current_user_token(), stval as *const usize));
            // }
            unsafe {
                asm!("sfence.vma");
                asm!("fence.i");
            }
        }
        Trap::Exception(Exception::IllegalInstruction) => {
            println!(
                "[illegal instruction] bad inst = {:#x}",
                current_trap_cx().sepc
            );
            current_add_signal(Signum::SIGILL);
        }
        Trap::Interrupt(Interrupt::SupervisorTimer) => {
            set_next_trigger();
            check_timer();
            // ITIMER_MANAGER.lock().check_itimer(); // 检查定时器
            suspend_current_and_run_next();
        }
        Trap::Interrupt(Interrupt::SupervisorExternal) => {
            crate::board::irq_handler();
        }
        _ => {
            panic!(
                "Unsupported trap {:?}, stval = {:#x}!",
                scause.cause(),
                stval
            );
        }
    }
    
    handle_signals();
    
    // check signals
    if let Some((errno, msg)) = check_signals_of_current() {
        println!("[kernel] {}", msg);
        exit_current_and_run_next(errno, false);
    }
    
    trap_return();
}

#[no_mangle]
pub fn trap_return() -> ! {
    disable_supervisor_interrupt();
    set_user_trap_entry();
    current_trap_cx().sstatus.set_spp(sstatus::SPP::User);
    let trap_cx_user_va = current_trap_cx_user_va();
    let user_satp = current_user_token();
    extern "C" {
        fn __alltraps();
        fn __restore();
    }
    let restore_va = __restore as usize - __alltraps as usize + TRAMPOLINE;
    //println!("before return");
    unsafe {
        asm!(
        "fence.i",
        "jr {restore_va}",
        restore_va = in(reg) restore_va,
        in("a0") trap_cx_user_va,
        in("a1") user_satp,
        options(noreturn)
        )
    }
}

#[no_mangle]
pub fn trap_from_kernel(_trap_cx: &TrapContext) {
    let scause = scause::read();
    let stval = stval::read();
    match scause.cause() {
        Trap::Interrupt(Interrupt::SupervisorExternal) => {
            crate::board::irq_handler();
        }
        Trap::Interrupt(Interrupt::SupervisorTimer) => {
            set_next_trigger();
            check_timer();
            // ITIMER_MANAGER.lock().check_itimer(); // 检查定时器
            // do not schedule now
        }
        _ => {
            panic!(
                "Unsupported trap from kernel: {:?}, stval = {:#x}!",
                scause.cause(),
                stval
            );
        }
    }
}
