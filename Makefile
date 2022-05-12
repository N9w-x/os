all:
	make -C kernel build-pull BOARD=k210
	@mv ./kernel/target/riscv64gc-unknown-none-elf/release/os.bin ./os.bin