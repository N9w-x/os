bitflags! {
    pub struct CloneFlag: usize{
        const CLONE_CHILD_CLEARTID = 0x00_200_000;
        const CLONE_CHILD_SETTID   = 0x01_000_000;
        const CLONE_SIGHLD         = 17;
    }
}
