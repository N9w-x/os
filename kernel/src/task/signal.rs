#![allow(non_snake_case)]

use _core::mem::size_of;

use bitflags::*;

use crate::{config::SIGRETURN_TRAMPOLINE, mm::{translated_byte_buffer, UserBuffer}, task::{current_process, current_task, suspend_current_and_run_next}};

use super::current_user_token;

pub const MAX_SIG: usize = 34;

// sigprocmask how
pub const SIG_BLOCK: usize = 0;
pub const SIG_UNBLOCK: usize = 1;
pub const SIG_SETMASK: usize = 2;

// sigaction sa_handler
pub const SIG_DFL: usize = 0; /* Default action.  */
pub const SIG_IGN: usize = 1; /* Ignore signal.  */

bitflags! {
    pub struct Signum: u64 {
        // 没有0号信号
        const NONE = 1 << 0;
        const SIGHUP = 1 << 1;
        const SIGINT = 1 << 2;
        const SIGQUIT = 1 << 3;
        const SIGILL = 1 << 4;
        const SIGTRAP = 1 << 5;
        const SIGABRT = 1 << 6;
        const SIGIOT = 1 << 6;
        const SIGBUS = 1 << 7;
        const SIGFPE = 1 << 8;
        const SIGKILL = 1 << 9;
        const SIGUSR1 = 1 << 10;
        const SIGSEGV = 1 << 11;
        const SIGUSR2 = 1 << 12;
        const SIGPIPE = 1 << 13;
        const SIGALRM = 1 << 14;
        const SIGTERM = 1 << 15;
        const SIGSTKFLT = 1 << 16;
        const SIGCHLD = 1 << 17;
        const SIGCONT = 1 << 18;
        const SIGSTOP = 1 << 19;
        const SIGTSTP = 1 << 20;
        const SIGTTIN = 1 << 21;
        const SIGTTOU = 1 << 22;
        const SIGURG = 1 << 23;
        const SIGXCPU = 1 << 24;
        const SIGXFSZ = 1 << 25;
        const SIGVTALRM = 1 << 26;
        const SIGPROF = 1 << 27;
        const SIGWINCH = 1 << 28;
        const SIGIO = 1 << 29;
        const SIGPWR = 1 << 30;
        const SIGSYS = 1 << 31;
        const SIGTIMER = 1 << 32;
        const SIGCANCEL = 1 << 33;
        const SIGSYNCCALL = 1 << 34;
    }
}

bitflags! {
    /* Bits in `sa_flags'.  */
    pub struct SaFlags: usize {
        const SA_NOCLDSTOP = 1;     /* Don't send SIGCHLD when children stop.  */
        const SA_NOCLDWAIT = 2;     /* Don't create zombie on child death.  */
        const SA_SIGINFO   = 4;     /* Invoke signal-catching function with three arguments instead of one.  */
        const SA_ONSTACK   = 0x08000000;    /* Use signal stack by using `sa_restorer'. */
        const SA_RESTART   = 0x10000000;    /* Restart syscall on signal return.  */
        const SA_NODEFER   = 0x40000000;    /* Don't automatically block the signal when its handler is being executed.  */
        const SA_RESETHAND = 0x80000000;    /* Reset to SIG_DFL on entry to handler.  */
        const SA_INTERRUPT = 0x20000000;    /* Historical no-op.  */
    }
}

pub struct SignalStruct {
    pub actions: [Option<SigAction>; MAX_SIG + 1],
}

impl Default for SignalStruct {
    fn default() -> Self {
        Self {
            actions: [None; MAX_SIG + 1],
        }
    }
}

impl Default for Signum {
    fn default() -> Self {
        Self::empty()
    }
}

impl Signum {
    // 从1~31之间的序号生成Signum
    pub fn from_serial(serial: usize) -> Option<Self> {
        if serial > 0 && serial <= MAX_SIG {
            Some(Self::from_bits_truncate(1 << serial))
        } else {
            None
        }
    }
    
    pub fn check_error(&self) -> Option<(i32, &'static str)> {
        if self.contains(Self::SIGINT) {
            Some((-2, "Killed, SIGINT=2"))
        } else if self.contains(Self::SIGILL) {
            Some((-4, "Illegal Instruction, SIGILL=4"))
        } else if self.contains(Self::SIGABRT) {
            Some((-6, "Aborted, SIGABRT=6"))
        } else if self.contains(Self::SIGFPE) {
            Some((-8, "Erroneous Arithmetic Operation, SIGFPE=8"))
        } else if self.contains(Self::SIGSEGV) {
            Some((-11, "Segmentation Fault, SIGSEGV=11"))
        } else {
            None
        }
    }
}

// #[allow(non_camel_case_types)]
// #[derive(Copy, Clone)]
// pub enum SigactionHandlerType {
//     /// 默认处理
//     SIG_DFL,
//     /// 忽略该信号
//     SIG_IGN,
//     /// Used if SA_SIGINFO is not set
//     sa_handler(fn(isize)),
//     /// Used if SA_SIGINFO is set
//     sa_sigaction(fn(isize, SigInfo, *mut SigInfo)),
// }

#[repr(C)]
#[derive(Copy, Clone)]
pub struct SigInfo {
    pub signo: i32,
    pub errno: i32,
    pub code: i32,
}

const SIGINFO_PAD_SIZE: usize =
    128 - 2 * core::mem::size_of::<i32>() - core::mem::size_of::<usize>();

#[repr(C)]
#[derive(Copy, Clone)]
pub union SiginfoFields {
    pad: [u8; SIGINFO_PAD_SIZE],
    // TODO: fill this union
}

impl Default for SiginfoFields {
    fn default() -> Self {
        SiginfoFields {
            pad: [0; SIGINFO_PAD_SIZE],
        }
    }
}

impl Default for SaFlags {
    fn default() -> Self {
        Self::empty()
    }
}

#[repr(C)]
#[derive(Copy, Clone, Default)]
pub struct SigAction {
    /// 信号处理函数
    pub sa_handler: usize,
    pub sa_sigaction: usize,
    /// 信号处理函数执行期间需要屏蔽的信号
    pub sa_mask: Signum,
    /// 指定信号处理的行为
    pub sa_flags: SaFlags,
    pub sa_restorer: usize,
}

#[repr(C)]
pub struct UContext {
    pub __bits: [usize; 25]
}

impl UContext {
    pub fn new() -> Self {
        Self {
            __bits: [0; 25]
        }
    }
    
    pub fn as_bytes(&self) -> &[u8] {
        let size = core::mem::size_of::<Self>();
        unsafe { core::slice::from_raw_parts(self as *const _ as usize as *mut u8, size) }
    }
    
    pub fn pc_offset() -> usize {
        176
    }
    
    pub fn mc_pc(&mut self) -> &mut usize {
        &mut self.__bits[Self::pc_offset() / size_of::<usize>()]
    }
}

pub fn check_pending_signals() {
    // for signum in 1..=MAX_SIG {
    //     let can_handle = {
    //         let signum = Signum::from_serial(signum).unwrap();
    //         let process = current_process();
    //         let mut inner = process.inner_exclusive_access();
    
    //         let is_waiting = inner.signals.contains(signum);
    //         let is_masked = inner.signal_masks.contains(signum);
    
    //         // 当前正在处理的信号的sigaction是否被指定屏蔽该信号
    //         let is_sigaction_masked =
    //             if let Some(sigaction) = inner.signal_actions.actions[inner.signal_handling] {
    //                 sigaction.sa_mask.contains(signum)
    //             } else {
    //                 // 默认sigaction只屏蔽与自身相同的信号
    //                 signum.bits as usize == inner.signal_handling
    //             };
    
    //         is_waiting && !is_masked && !is_sigaction_masked
    //     };
    
    //     if can_handle {
    //         match Signum::from_serial(signum) {
    //             Some(Signum::SIGKILL | Signum::SIGSTOP | Signum::SIGCONT) | None => {
    //                 call_kernel_signal_handler(signum)
    //             }
    //             _ => call_user_signal_handler(signum),
    //         }
    //     }
    // }
    
    for signum in 1..=MAX_SIG {
        let can_handle = {
            let signum = Signum::from_bits(1 << signum).unwrap();
            let process = current_process();
            let mut process_inner = process.inner_exclusive_access();
            let task = current_task().unwrap();
            let mut task_inner = task.inner_exclusive_access();
    
            let is_waiting = task_inner.signals.contains(signum);
            let is_masked = task_inner.signal_masks.contains(signum);
    
            // 当前正在处理的信号的sigaction是否被指定屏蔽该信号
            let is_sigaction_masked =
                if let Some(sigaction) = process_inner.signal_actions.actions[task_inner.signal_handling] {
                    sigaction.sa_mask.contains(signum)
                } else {
                    // 默认sigaction只屏蔽与自身相同的信号
                    signum.bits as usize == task_inner.signal_handling
                };
    
            is_waiting && !is_masked && !is_sigaction_masked
        };
        
        if can_handle {
            match Signum::from_bits(1 << signum) {
                Some(Signum::SIGKILL | Signum::SIGSTOP | Signum::SIGCONT) | None => {
                    call_kernel_signal_handler(signum)
                }
                _ => {
                    call_user_signal_handler(signum)
                }
            }
        }
    }
}

pub fn handle_signals() {
    check_pending_signals();
    loop {
        let (frozen, killed) = {
            // let process = current_process();
            // let mut inner = process.inner_exclusive_access();
            let task = current_task().unwrap();
            let mut task_inner = task.inner_exclusive_access();
            // println!("[pc = {:#X}]", task_inner.get_trap_cx().sepc);
            (task_inner.frozen, task_inner.killed)
        };
        if !frozen || killed {
            break;
        }
    
        check_pending_signals();
        suspend_current_and_run_next();
    }
}

pub fn call_kernel_signal_handler(signum: usize) {
    let task = current_task().unwrap();
    let mut task_inner = task.inner_exclusive_access();
    
    let signum = Signum::from_bits(1 << signum).unwrap();
    
    match signum {
        // 停止运行
        Signum::SIGSTOP => {
            task_inner.frozen = true;
            task_inner.signals.remove(signum);
        }
        
        // 继续运行
        Signum::SIGCONT => {
            if task_inner.signals.contains(signum) {
                task_inner.signals.remove(signum);
                task_inner.frozen = false;
            }
        }
        
        // 剩下的就简单粗暴的杀死进程
        _ => {
            task_inner.killed = true;
        }
    }
}

pub fn call_user_signal_handler(signum: usize) {
    let token = current_user_token();
    let task = current_task().unwrap();
    let mut task_inner = task.inner_exclusive_access();
    let process = current_process();
    let mut process_inner = process.inner_exclusive_access();
    
    if let Some(sigaction) = process_inner.signal_actions.actions[signum] {
        let trap_cx = task_inner.get_trap_cx();
        
        task_inner.trap_ctx_backup = Some(*trap_cx);
        task_inner.signal_masks = sigaction.sa_mask;
        task_inner.signal_handling = signum;
        task_inner
            .signals
            .remove(Signum::from_bits(1 << signum).unwrap());
        
        let sa_flags = sigaction.sa_flags;
        match sigaction.sa_handler {
            SIG_IGN => {}
            SIG_DFL => {
                // 默认处理，即杀死进程
                task_inner.killed = true;
            }
            handler => {
                // sa_handler处理
                // 设置返回用户态时首先执行handler处的代码
                extern "C" {
                    fn __sigreturn();
                    fn __alltraps();
                }
                trap_cx.x[1] = __sigreturn as usize - __alltraps as usize + SIGRETURN_TRAMPOLINE;
                trap_cx.x[10] = signum;
                if sa_flags.contains(SaFlags::SA_SIGINFO) {
                    trap_cx.x[2] -= size_of::<UContext>();
                    trap_cx.x[12] = trap_cx.x[2];
                    let mut userbuf = UserBuffer::new(translated_byte_buffer(
                        token,
                        trap_cx.x[2] as *const u8,
                        size_of::<UContext>()),
                    );
                    let mut ucontext = UContext::new();
                    *ucontext.mc_pc() = trap_cx.sepc;
                    userbuf.write(ucontext.as_bytes());
                }
    
                drop(task_inner);
                // println!("[signal] tid: {} handler: {:#X}, signum: {}, old_pc: {:#X}, new_pc: {:#X}", task.gettid(), handler, signum, trap_cx.sepc, handler);
    
                trap_cx.sepc = handler as usize;
            }
        }
    }
}
