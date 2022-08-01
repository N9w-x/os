all:
	make -C kernel handin-qemu BOARD=qemu RUN_MODE=autotest
