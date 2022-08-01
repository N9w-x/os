use alloc::sync::Arc;
use alloc::vec::Vec;

use fat32::BLOCK_SZ;
use lazy_static::lazy_static;

use crate::fs_fat::{FileType, open_file, OpenFlags, OSInode};
use crate::UPIntrFreeCell;

lazy_static! {
    pub static ref TEST_SH_DATA: UPIntrFreeCell<Vec<u8>> =
        unsafe { UPIntrFreeCell::new(load_test_sh()) };
}

fn load_test_sh() -> Vec<u8> {
    let file = open_file("/", "runtest.exe", OpenFlags::RDONLY, FileType::Regular).unwrap();
    file.read_all()
}

lazy_static! {
    pub static ref ENTRY_STATIC_DATA: UPIntrFreeCell<Vec<u8>> =
        unsafe { UPIntrFreeCell::new(load_half_entry_static()) };
}

#[inline]
fn open_entry_static() -> Arc<OSInode> {
    open_file(
        "/",
        "entry-static.exe",
        OpenFlags::RDONLY,
        FileType::Regular,
    )
        .unwrap()
}

fn load_half_entry_static() -> Vec<u8> {
    let file = open_entry_static();
    file.read_all_with_out()
}
