use alloc::collections::BTreeMap;
use alloc::vec::Vec;
use core::fmt::{Display, Formatter};

use crate::{config::PAGE_SIZE, fs::File};
use crate::config::MAP_FIXED;
use crate::fs::FileDescriptor;
use crate::mm::address::VPNRange;

use super::{
    frame_alloc, FrameTracker, MapPermission, page_table::PTEFlags, PageTable,
    PhysPageNum, translated_byte_buffer, UserBuffer, VirtAddr, VirtPageNum,
};

pub struct MemoryMapArea {
    pub vpn_range: VPNRange,
    pub data_frames: BTreeMap<VirtPageNum, FrameTracker>,
    pub map_perm: MapPermission,
    pub fd: isize,
    pub offset: usize,
    pub flags: usize,
    pub length: usize,
}

impl MemoryMapArea {
    pub fn new(
        start_va: VirtAddr,
        end_va: VirtAddr,
        map_perm: MapPermission,
        fd: isize,
        offset: usize,
        flags: usize,
    ) -> Self {
        let start_vpn: VirtPageNum = start_va.floor();
        let end_vpn: VirtPageNum = end_va.ceil();
        Self {
            vpn_range: VPNRange::new(start_vpn, end_vpn),
            data_frames: BTreeMap::new(),
            map_perm,
            fd,
            offset,
            flags,
            length: end_va.0 - start_va.0,
        }
    }

    pub fn from_another(another: &MemoryMapArea) -> Self {
        Self {
            vpn_range: another.vpn_range.clone(),
            data_frames: BTreeMap::new(),
            map_perm: another.map_perm,
            fd: another.fd,
            offset: another.offset,
            flags: another.flags,
            length: another.length,
        }
    }

    /// 分配内存, 同时映射文件
    /// 一次只分配一页
    pub fn map_one(
        &mut self,
        page_table: &mut PageTable,
        vpn: VirtPageNum,
        fd_table: &[Option<FileDescriptor>],
    ) -> bool {
        // 分配物理页
        let frame = frame_alloc().unwrap();
        let ppn = frame.ppn;
        self.data_frames.insert(vpn, frame);
        let pte_flags = PTEFlags::from_bits(self.map_perm.bits() as u16).unwrap();
        page_table.map(vpn, ppn, pte_flags);
        // println!(
        //     "mmap vpn: {:#X} -> ppn: {:#X}, {:#}",
        //     vpn.0, ppn.0, self.map_perm
        // );

        if self.fd == -1 {
            return true;
        }

        // 复制文件数据到内存
        if let Some(file_descriptor) = &fd_table[self.fd as usize] {
            match file_descriptor {
                FileDescriptor::Regular(inode) => {
                    if inode.readable() {
                        let va: usize = VirtAddr::from(vpn).into();
                        let mmap_base: usize = VirtAddr::from(self.vpn_range.get_start()).into();
                        let page_offset = va - mmap_base + self.offset;
                        let buf =
                            translated_byte_buffer(page_table.token(), va as *const u8, PAGE_SIZE);
                        inode.set_offset(page_offset);
                        inode.read(UserBuffer::new(buf));
                    }
                }
                FileDescriptor::Abstract(_) => todo!(),
            };
        }
        true
    }

    /// 取消映射所有页
    pub fn unmap(&mut self, page_table: &mut PageTable) {
        for vpn in self.vpn_range {
            if self.data_frames.contains_key(&vpn) {
                self.data_frames.remove(&vpn);
                page_table.unmap(vpn);
            }
        }
    }

    /// 分配内存, 同时映射文件
    /// 一次分配所有页
    pub fn map(
        &mut self,
        page_table: &mut PageTable,
        fd_table: &Vec<Option<FileDescriptor>>,
    ) -> bool {
        for vpn in self.vpn_range {
            let frame = frame_alloc().unwrap();
            let ppn = frame.ppn;
            let pte_flags = PTEFlags::from_bits(self.map_perm.bits() as u16).unwrap();
            self.data_frames.insert(vpn, frame);
            page_table.map(vpn, ppn, pte_flags);
            // println!("[debug] vpn: 0x{:X} -> ppn: 0x{:X}", vpn.0, ppn.0);
        }

        if self.fd < 0 {
            return true;
        }

        if let Some(file_descriptor) = &fd_table[self.fd as usize] {
            return match file_descriptor {
                FileDescriptor::Regular(inode) => {
                    if inode.readable() {
                        let va: usize = VirtAddr::from(self.vpn_range.get_start()).into();
                        inode.set_offset(self.offset);
                        // println!(
                        //     "[debug] token: 0x{:X}, va: 0x{:X}, offset: {}, len: {}",
                        //     page_table.token(),
                        //     va,
                        //     self.offset,
                        //     self.length
                        // );
                        let read_len = inode.read(UserBuffer::new(translated_byte_buffer(
                            page_table.token(),
                            va as *const u8,
                            self.length,
                            // 512
                        )));
                        // println!("[debug] read over, read_len: {}", read_len);
                        true
                    } else {
                        false
                    }
                }
                _ => false,
            };
        }
        false
    }
}

impl Display for MemoryMapArea {
    fn fmt(&self, f: &mut Formatter<'_>) -> core::fmt::Result {
        let start_virt_addr = VirtAddr::from(self.vpn_range.get_start());
        let end_virt_addr = VirtAddr::from(self.vpn_range.get_end());
        write!(
            f,
            "{:<#16x}  {:<#16x}   {:#}   fd: {}   FIXED: {}",
            start_virt_addr.0,
            end_virt_addr.0,
            self.map_perm,
            self.fd,
            self.flags & MAP_FIXED != 0
        )
    }
}
