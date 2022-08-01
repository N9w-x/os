use alloc::string::{String, ToString};
use alloc::vec;
use alloc::vec::Vec;
use core::fmt::{Display, Formatter};

//线程当前工作目录
//以目录或者文件为单位分割,便于相对路径的修改
//绝对路径
//相对路径 (处理. 和 ..)
#[derive(Clone)]
pub struct WorkPath {
    pub path: Vec<String>,
}

impl WorkPath {
    //只有init proc使用,其他线程 clone自父线程
    pub fn new() -> Self {
        Self {
            path: vec![String::from("/")],
        }
    }

    //依据输入的path更新路径
    pub fn modify_path(&mut self, input_path: &str) {
        #[inline]
        fn split(work_path: &mut WorkPath, path: &str) -> Vec<String> {
            let split_path: Vec<&str> = path.split('/').collect();
            let mut vec = vec![];
            for part_path in split_path {
                match part_path {
                    "" | "." => (),
                    ".." => {
                        work_path.path.pop();
                    }
                    part => vec.push(part.to_string()),
                    _ => (),
                }
            }
            vec
        };
        let path_vec = split(self, input_path);
        if WorkPath::is_abs_path(input_path) {
            //绝对路径补上根目录"/"
            self.path = vec![String::from("/")];
        }
        //如果是绝对路径,当前path中只包含"/"
        //如果是相对路径,当前path中为处理过.和..的path
        //和split生成的路径合并得到新路径
        self.path.extend_from_slice(&path_vec);
    }

    pub fn is_abs_path(path: &str) -> bool {
        path.starts_with("/")
    }
}

impl Display for WorkPath {
    fn fmt(&self, f: &mut Formatter<'_>) -> core::fmt::Result {
        write!(f, "{}", self.path.join(""))
    }
}
