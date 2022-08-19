use alloc::collections::BTreeMap;
use alloc::string::{String, ToString};
use alloc::sync::Arc;
use alloc::vec::Vec;

use fat32::VFile;
use lazy_static::lazy_static;
use spin::RwLock;

use crate::fs::inode::ROOT_INODE;

lazy_static! {
    pub static ref FS_TREE: RwLock<BTreeMap<String, Arc<VFile>>> = RwLock::new(BTreeMap::new());
}

pub fn search_vfile(path: &str) -> Option<Arc<VFile>> {
    if path == "/" {
        Some(ROOT_INODE.clone())
    } else {
        FS_TREE.read().get(path).cloned()
    }
}

pub fn insert_vfile(path: &str, vfile: Arc<VFile>) {
    FS_TREE.write().insert(path.to_string(), vfile);
}

pub fn remove_vfile(path: &str) {
    FS_TREE.write().remove(path);
}

pub fn get_abs_path(work_path: &str, path: &str) -> String {
    let path_vec = path
        .split('/')
        .filter(|&t| !t.is_empty())
        .collect::<Vec<&str>>();

    let mut work_path_vec = work_path
        .split('/')
        .filter(|&s| !s.is_empty())
        .collect::<Vec<&str>>();
    
    for path_part in path_vec.iter() {
        match *path_part {
            "." => continue,
            ".." => {
                work_path_vec.pop();
            }
            _ => work_path_vec.push(path_part),
        }
    }
    let mut abs_path = String::from('/');
    abs_path.push_str(&work_path_vec.join("/"));
    abs_path
}
