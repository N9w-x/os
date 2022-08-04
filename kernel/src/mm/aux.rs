use core::fmt::{Display, Formatter};

pub struct AuxHeader {
    pub _type: usize,
    pub value: usize,
}

impl AuxHeader {
    #[inline]
    pub fn new(_type: usize, value: usize) -> Self {
        Self { _type, value }
    }
}

impl Display for AuxHeader {
    fn fmt(&self, f: &mut Formatter<'_>) -> core::fmt::Result {
        write!(f, "AuxHeader type: {} value: {}", self._type, self.value)
    }
}