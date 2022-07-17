#![allow(non_snake_case)]

use crate::task::{current_process, current_task, suspend_current_and_run_next};
use bitflags::*;

pub const MAX_SIG: usize = 31;

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

bitflags! {
    pub struct Signum: u32 {
        // 没有0号信号
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
        if serial > 0 && serial < 32 {
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

#[allow(non_camel_case_types)]
#[derive(Copy, Clone)]
pub enum SigactionHandlerType {
    /// 默认处理
    SIG_DFL,
    /// 忽略该信号
    SIG_IGN,
    /// Used if SA_SIGINFO is not set
    sa_handler(fn(isize)),
    /// Used if SA_SIGINFO is set
    sa_sigaction(fn(isize, SigInfo, *mut SigInfo)),
}

impl Default for SigactionHandlerType {
    fn default() -> Self {
        Self::SIG_DFL
    }
}

pub struct SigInfo {}

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

impl Default for SaFlags {
    fn default() -> Self {
        Self::empty()
    }
}

#[derive(Copy, Clone, Default)]
pub struct SigAction {
    /// 信号处理函数
    pub sigaction_handler: SigactionHandlerType,
    /// 信号处理函数执行期间需要屏蔽的信号
    pub sa_mask: Signum,
    /// 指定信号处理的行为
    pub sa_flags: SaFlags,
    pub sa_restorer: Option<fn()>,
}

pub fn check_pending_signals() {
    for signum in 1..=MAX_SIG {
        let can_handle = {
            let signum = Signum::from_serial(signum).unwrap();
            let process = current_process();
            let mut inner = process.inner_exclusive_access();

            let is_waiting = inner.signals.contains(signum);
            let is_masked = inner.signal_masks.contains(signum);

            // 当前正在处理的信号的sigaction是否被指定屏蔽该信号
            let is_sigaction_masked =
                if let Some(sigaction) = inner.signal_actions.actions[inner.signal_handling] {
                    sigaction.sa_mask.contains(signum)
                } else {
                    // 默认sigaction只屏蔽与自身相同的信号
                    signum.bits as usize == inner.signal_handling
                };

            is_waiting && !is_masked && !is_sigaction_masked
        };

        if can_handle {
            match Signum::from_serial(signum) {
                Some(Signum::SIGKILL | Signum::SIGSTOP | Signum::SIGCONT) | None => {
                    call_kernel_signal_handler(signum)
                }
                _ => call_user_signal_handler(signum),
            }
        }
    }
}

pub fn handle_signals() {
    check_pending_signals();
    loop {
        let (frozen, killed) = {
            let process = current_process();
            let mut inner = process.inner_exclusive_access();

            (inner.frozen, inner.killed)
        };

        if !frozen || killed {
            break;
        }

        check_pending_signals();
        suspend_current_and_run_next();
    }
}

pub fn call_kernel_signal_handler(signum: usize) {
    let process = current_process();
    let mut inner = process.inner_exclusive_access();

    let signum = Signum::from_serial(signum).unwrap();

    match signum {
        // 停止运行
        Signum::SIGSTOP => {
            inner.frozen = true;
            inner.signals.remove(signum);
        }

        // 继续运行
        Signum::SIGCONT => {
            if inner.signals.contains(signum) {
                inner.signals.remove(signum);
                inner.frozen = false;
            }
        }

        // 剩下的就简单粗暴的杀死进程
        _ => {
            inner.killed = true;
        }
    }
}

pub fn call_user_signal_handler(signum: usize) {
    let task = current_task().unwrap();
    let mut inner = task.inner_exclusive_access();
    let process = task.process.upgrade().unwrap();
    let mut process_inner = process.inner_exclusive_access();

    if let Some(sigaction) = process_inner.signal_actions.actions[signum] {
        let trap_cx = inner.get_trap_cx();

        process_inner.trap_ctx_backup = Some(*trap_cx);
        process_inner.signal_masks = sigaction.sa_mask;
        process_inner.signal_handling = signum;
        process_inner
            .signals
            .remove(Signum::from_serial(signum).unwrap());

        let sa_flags = sigaction.sa_flags;
        if !sa_flags.contains(SaFlags::SA_SIGINFO) {
            match sigaction.sigaction_handler {
                SigactionHandlerType::SIG_IGN => {}
                SigactionHandlerType::SIG_DFL => {
                    unimplemented!()
                }
                SigactionHandlerType::sa_handler(handler) => {
                    // 设置返回用户态时首先执行handler处的代码
                    trap_cx.sepc = handler as usize;
                    trap_cx.x[10] = signum;
                }
                _ => panic!("when sa_flags not contains SA_SIGINFO, sigaction_handler cannot be sa_sigaction"),
            }
        } else {
            match sigaction.sigaction_handler {
                SigactionHandlerType::sa_sigaction(handler) => {
                    unimplemented!()
                }
                _ => panic!(
                    "when sa_flags contains SA_SIGINFO, sigaction_handler cannot be sa_handler"
                ),
            }
        }
    }
}
