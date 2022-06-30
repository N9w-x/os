
runtest.exe:	file format elf64-littleriscv

Disassembly of section .text:

0000000000010120 <exit>:
   10120: 13 01 01 fe  	addi	sp, sp, -32
   10124: 23 34 a1 00  	sd	a0, 8(sp)
   10128: 23 3c 11 00  	sd	ra, 24(sp)
   1012c: ef 10 80 55  	jal	0x11684 <dummy>
   10130: ef 10 80 55  	jal	0x11688 <libc_exit_fini>
   10134: ef 70 10 15  	jal	0x17a84 <__stdio_exit_needed>
   10138: 03 35 81 00  	ld	a0, 8(sp)
   1013c: ef 40 d0 2b  	jal	0x14bf8 <_Exit>

0000000000010140 <main>:
   10140: 13 01 01 f1  	addi	sp, sp, -240
   10144: 23 38 21 0d  	sd	s2, 208(sp)
   10148: 37 a9 01 00  	lui	s2, 26
   1014c: 23 30 81 0e  	sd	s0, 224(sp)
   10150: 23 3c 91 0c  	sd	s1, 216(sp)
   10154: 23 34 31 0d  	sd	s3, 200(sp)
   10158: 23 30 41 0d  	sd	s4, 192(sp)
   1015c: 23 3c 51 0b  	sd	s5, 184(sp)
   10160: 23 38 61 0b  	sd	s6, 176(sp)
   10164: 23 34 71 0b  	sd	s7, 168(sp)
   10168: 23 30 81 0b  	sd	s8, 160(sp)
   1016c: 23 34 11 0e  	sd	ra, 232(sp)
   10170: 93 04 05 00  	mv	s1, a0
   10174: 13 84 05 00  	mv	s0, a1
   10178: 13 0a 50 00  	li	s4, 5
   1017c: 13 09 89 66  	addi	s2, s2, 1640
   10180: 37 ab 01 00  	lui	s6, 26
   10184: 93 0a f0 ff  	li	s5, -1
   10188: 93 0b 40 07  	li	s7, 116
   1018c: 13 0c 70 07  	li	s8, 119
   10190: 13 06 0b 4a  	addi	a2, s6, 1184
   10194: 93 05 04 00  	mv	a1, s0
   10198: 13 85 04 00  	mv	a0, s1
   1019c: ef 20 d0 16  	jal	0x12b08 <getopt>
   101a0: 93 07 05 00  	mv	a5, a0
   101a4: 63 12 55 03  	bne	a0, s5, 0x101c8 <main+0x88>
   101a8: 83 a5 c1 98  	lw	a1, -1652(gp)
   101ac: 63 ce 95 02  	blt	a1, s1, 0x101e8 <main+0xa8>
   101b0: 83 35 04 00  	ld	a1, 0(s0)
   101b4: 37 a5 01 00  	lui	a0, 26
   101b8: 13 05 05 45  	addi	a0, a0, 1104
   101bc: ef 00 50 10  	jal	0x10ac0 <t_printf>
   101c0: 13 05 f0 ff  	li	a0, -1
   101c4: ef f0 df f5  	jal	0x10120 <exit>
   101c8: 63 88 77 01  	beq	a5, s7, 0x101d8 <main+0x98>
   101cc: e3 92 87 ff  	bne	a5, s8, 0x101b0 <main+0x70>
   101d0: 03 b9 01 a0  	ld	s2, -1536(gp)
   101d4: 6f f0 df fb  	j	0x10190 <main+0x50>
   101d8: 03 b5 01 a0  	ld	a0, -1536(gp)
   101dc: ef 30 50 1e  	jal	0x13bc0 <atoi>
   101e0: 13 0a 05 00  	mv	s4, a0
   101e4: 6f f0 df fa  	j	0x10190 <main+0x50>
   101e8: 93 95 35 00  	slli	a1, a1, 3
   101ec: 13 05 01 02  	addi	a0, sp, 32
   101f0: 33 04 b4 00  	add	s0, s0, a1
   101f4: ef 30 80 1e  	jal	0x133dc <sigemptyset>
   101f8: 93 05 10 01  	li	a1, 17
   101fc: 13 05 01 02  	addi	a0, sp, 32
   10200: ef 30 40 18  	jal	0x13384 <sigaddset>
   10204: 13 06 00 00  	li	a2, 0
   10208: 93 05 01 02  	addi	a1, sp, 32
   1020c: 13 05 00 00  	li	a0, 0
   10210: ef 30 00 24  	jal	0x13450 <sigprocmask>
   10214: b7 05 01 00  	lui	a1, 16
   10218: 93 85 c5 5b  	addi	a1, a1, 1468
   1021c: 13 05 10 01  	li	a0, 17
   10220: ef 30 80 1c  	jal	0x133e8 <signal>
   10224: 03 36 04 00  	ld	a2, 0(s0)
   10228: 37 a5 01 00  	lui	a0, 26
   1022c: 93 05 09 00  	mv	a1, s2
   10230: 13 05 85 4a  	addi	a0, a0, 1192
   10234: ef 00 d0 08  	jal	0x10ac0 <t_printf>
   10238: ef 30 80 00  	jal	0x13240 <fork>
   1023c: 93 04 05 00  	mv	s1, a0
   10240: 63 1e 05 04  	bnez	a0, 0x1029c <main+0x15c>
   10244: b7 95 01 00  	lui	a1, 25
   10248: 13 05 30 00  	li	a0, 3
   1024c: ef 00 90 4b  	jal	0x10f04 <t_setrlim>
   10250: 83 47 09 00  	lbu	a5, 0(s2)
   10254: 63 86 07 00  	beqz	a5, 0x10260 <main+0x120>
   10258: 23 3c 24 ff  	sd	s2, -8(s0)
   1025c: 13 04 84 ff  	addi	s0, s0, -8
   10260: 03 35 04 00  	ld	a0, 0(s0)
   10264: 93 05 04 00  	mv	a1, s0
   10268: ef 20 90 7a  	jal	0x13210 <execv>
   1026c: 83 35 04 00  	ld	a1, 0(s0)
   10270: 23 34 b1 00  	sd	a1, 8(sp)
   10274: ef 10 c0 3a  	jal	0x11620 <__errno_location>
   10278: 03 25 05 00  	lw	a0, 0(a0)
   1027c: ef 10 c0 3f  	jal	0x11678 <strerror>
   10280: 83 35 81 00  	ld	a1, 8(sp)
   10284: 13 06 05 00  	mv	a2, a0
   10288: 37 a5 01 00  	lui	a0, 26
   1028c: 13 05 05 4d  	addi	a0, a0, 1232
   10290: ef 00 10 03  	jal	0x10ac0 <t_printf>
   10294: 13 05 10 00  	li	a0, 1
   10298: 6f f0 df f2  	j	0x101c4 <main+0x84>
   1029c: 93 09 00 00  	li	s3, 0
   102a0: 63 10 55 05  	bne	a0, s5, 0x102e0 <main+0x1a0>
   102a4: 83 35 04 00  	ld	a1, 0(s0)
   102a8: 93 09 10 00  	li	s3, 1
   102ac: 23 34 b1 00  	sd	a1, 8(sp)
   102b0: ef 10 00 37  	jal	0x11620 <__errno_location>
   102b4: 03 25 05 00  	lw	a0, 0(a0)
   102b8: ef 10 00 3c  	jal	0x11678 <strerror>
   102bc: 83 35 81 00  	ld	a1, 8(sp)
   102c0: 13 06 05 00  	mv	a2, a0
   102c4: 37 a5 01 00  	lui	a0, 26
   102c8: 13 05 05 50  	addi	a0, a0, 1280
   102cc: ef 00 40 7f  	jal	0x10ac0 <t_printf>
   102d0: 83 35 04 00  	ld	a1, 0(s0)
   102d4: 37 a5 01 00  	lui	a0, 26
   102d8: 13 05 05 53  	addi	a0, a0, 1328
   102dc: ef 00 40 7e  	jal	0x10ac0 <t_printf>
   102e0: 13 06 01 01  	addi	a2, sp, 16
   102e4: 93 05 00 00  	li	a1, 0
   102e8: 13 05 01 02  	addi	a0, sp, 32
   102ec: 23 3c 01 00  	sd	zero, 24(sp)
   102f0: 23 38 41 01  	sd	s4, 16(sp)
   102f4: ef 30 40 19  	jal	0x13488 <sigtimedwait>
   102f8: 93 07 f0 ff  	li	a5, -1
   102fc: 93 0a 00 00  	li	s5, 0
   10300: 63 10 f5 08  	bne	a0, a5, 0x10380 <main+0x240>
   10304: ef 10 c0 31  	jal	0x11620 <__errno_location>
   10308: 13 0a 05 00  	mv	s4, a0
   1030c: 03 25 05 00  	lw	a0, 0(a0)
   10310: 93 07 b0 00  	li	a5, 11
   10314: 93 0a 10 00  	li	s5, 1
   10318: 63 06 f5 02  	beq	a0, a5, 0x10344 <main+0x204>
   1031c: 83 35 04 00  	ld	a1, 0(s0)
   10320: 93 09 10 00  	li	s3, 1
   10324: 93 0a 00 00  	li	s5, 0
   10328: 23 34 b1 00  	sd	a1, 8(sp)
   1032c: ef 10 c0 34  	jal	0x11678 <strerror>
   10330: 83 35 81 00  	ld	a1, 8(sp)
   10334: 13 06 05 00  	mv	a2, a0
   10338: 37 a5 01 00  	lui	a0, 26
   1033c: 13 05 85 54  	addi	a0, a0, 1352
   10340: ef 00 00 78  	jal	0x10ac0 <t_printf>
   10344: 93 05 90 00  	li	a1, 9
   10348: 13 85 04 00  	mv	a0, s1
   1034c: ef 30 40 01  	jal	0x13360 <kill>
   10350: 93 07 f0 ff  	li	a5, -1
   10354: 63 16 f5 02  	bne	a0, a5, 0x10380 <main+0x240>
   10358: 83 35 04 00  	ld	a1, 0(s0)
   1035c: 03 25 0a 00  	lw	a0, 0(s4)
   10360: 93 09 10 00  	li	s3, 1
   10364: 23 34 b1 00  	sd	a1, 8(sp)
   10368: ef 10 00 31  	jal	0x11678 <strerror>
   1036c: 83 35 81 00  	ld	a1, 8(sp)
   10370: 13 06 05 00  	mv	a2, a0
   10374: 37 a5 01 00  	lui	a0, 26
   10378: 13 05 05 58  	addi	a0, a0, 1408
   1037c: ef 00 40 74  	jal	0x10ac0 <t_printf>
   10380: 13 06 00 00  	li	a2, 0
   10384: 93 05 01 01  	addi	a1, sp, 16
   10388: 13 85 04 00  	mv	a0, s1
   1038c: ef 20 50 74  	jal	0x132d0 <waitpid>
   10390: 63 00 95 04  	beq	a0, s1, 0x103d0 <main+0x290>
   10394: 83 35 04 00  	ld	a1, 0(s0)
   10398: 93 09 10 00  	li	s3, 1
   1039c: 23 34 b1 00  	sd	a1, 8(sp)
   103a0: ef 10 00 28  	jal	0x11620 <__errno_location>
   103a4: 03 25 05 00  	lw	a0, 0(a0)
   103a8: ef 10 00 2d  	jal	0x11678 <strerror>
   103ac: 83 35 81 00  	ld	a1, 8(sp)
   103b0: 13 06 05 00  	mv	a2, a0
   103b4: 37 a5 01 00  	lui	a0, 26
   103b8: 13 05 05 5b  	addi	a0, a0, 1456
   103bc: ef 00 40 70  	jal	0x10ac0 <t_printf>
   103c0: 83 35 04 00  	ld	a1, 0(s0)
   103c4: 37 a5 01 00  	lui	a0, 26
   103c8: 13 05 05 53  	addi	a0, a0, 1328
   103cc: ef 00 40 6f  	jal	0x10ac0 <t_printf>
   103d0: 03 26 01 01  	lw	a2, 16(sp)
   103d4: 13 75 f6 07  	andi	a0, a2, 127
   103d8: 63 14 05 06  	bnez	a0, 0x10440 <main+0x300>
   103dc: 1b 56 86 40  	sraiw	a2, a2, 8
   103e0: 13 76 f6 0f  	andi	a2, a2, 255
   103e4: 63 0a 06 0a  	beqz	a2, 0x10498 <main+0x358>
   103e8: 83 35 04 00  	ld	a1, 0(s0)
   103ec: 37 a5 01 00  	lui	a0, 26
   103f0: 13 05 05 5e  	addi	a0, a0, 1504
   103f4: ef 00 c0 6c  	jal	0x10ac0 <t_printf>
   103f8: 03 36 04 00  	ld	a2, 0(s0)
   103fc: 37 a5 01 00  	lui	a0, 26
   10400: 93 05 09 00  	mv	a1, s2
   10404: 13 05 85 64  	addi	a0, a0, 1608
   10408: ef 00 80 6b  	jal	0x10ac0 <t_printf>
   1040c: 83 30 81 0e  	ld	ra, 232(sp)
   10410: 03 34 01 0e  	ld	s0, 224(sp)
   10414: 83 34 81 0d  	ld	s1, 216(sp)
   10418: 03 39 01 0d  	ld	s2, 208(sp)
   1041c: 83 39 81 0c  	ld	s3, 200(sp)
   10420: 03 3a 01 0c  	ld	s4, 192(sp)
   10424: 83 3a 81 0b  	ld	s5, 184(sp)
   10428: 03 3b 01 0b  	ld	s6, 176(sp)
   1042c: 83 3b 81 0a  	ld	s7, 168(sp)
   10430: 03 3c 01 0a  	ld	s8, 160(sp)
   10434: 13 05 10 00  	li	a0, 1
   10438: 13 01 01 0f  	addi	sp, sp, 240
   1043c: 67 80 00 00  	ret
   10440: 83 35 04 00  	ld	a1, 0(s0)
   10444: 63 8a 0a 00  	beqz	s5, 0x10458 <main+0x318>
   10448: 37 a5 01 00  	lui	a0, 26
   1044c: 13 05 85 5f  	addi	a0, a0, 1528
   10450: ef 00 00 67  	jal	0x10ac0 <t_printf>
   10454: 6f f0 5f fa  	j	0x103f8 <main+0x2b8>
   10458: 13 16 06 03  	slli	a2, a2, 48
   1045c: 13 56 06 03  	srli	a2, a2, 48
   10460: 1b 06 f6 ff  	addiw	a2, a2, -1
   10464: 93 07 e0 0f  	li	a5, 254
   10468: 63 e2 c7 02  	bltu	a5, a2, 0x1048c <main+0x34c>
   1046c: 23 34 b1 00  	sd	a1, 8(sp)
   10470: ef 30 50 66  	jal	0x142d4 <strsignal>
   10474: 83 35 81 00  	ld	a1, 8(sp)
   10478: 13 06 05 00  	mv	a2, a0
   1047c: 37 a5 01 00  	lui	a0, 26
   10480: 13 05 05 61  	addi	a0, a0, 1552
   10484: ef 00 c0 63  	jal	0x10ac0 <t_printf>
   10488: 6f f0 1f f7  	j	0x103f8 <main+0x2b8>
   1048c: 37 a5 01 00  	lui	a0, 26
   10490: 13 05 85 62  	addi	a0, a0, 1576
   10494: 6f f0 df fb  	j	0x10450 <main+0x310>
   10498: e3 90 09 f6  	bnez	s3, 0x103f8 <main+0x2b8>
   1049c: 37 a5 01 00  	lui	a0, 26
   104a0: 13 05 05 64  	addi	a0, a0, 1600
   104a4: ef 00 c0 61  	jal	0x10ac0 <t_printf>
   104a8: 6f f0 1f f5  	j	0x103f8 <main+0x2b8>

00000000000104ac <_start>:
   104ac: 97 d1 00 00  	auipc	gp, 13
   104b0: 93 81 41 35  	addi	gp, gp, 852
   104b4: 13 05 01 00  	mv	a0, sp
   104b8: 93 05 00 00  	li	a1, 0
   104bc: 13 71 01 ff  	andi	sp, sp, -16
   104c0: 6f 00 40 00  	j	0x104c4 <_start_c>

00000000000104c4 <_start_c>:
   104c4: 83 25 05 00  	lw	a1, 0(a0)
   104c8: 37 17 01 00  	lui	a4, 17
   104cc: b7 16 01 00  	lui	a3, 17
   104d0: 13 06 85 00  	addi	a2, a0, 8
   104d4: 37 05 01 00  	lui	a0, 16
   104d8: 93 07 00 00  	li	a5, 0
   104dc: 13 07 47 68  	addi	a4, a4, 1668
   104e0: 93 86 46 37  	addi	a3, a3, 884
   104e4: 13 05 05 14  	addi	a0, a0, 320
   104e8: 6f 10 00 0e  	j	0x115c8 <__libc_start_main>

00000000000104ec <deregister_tm_clones>:
   104ec: 13 87 81 8e  	addi	a4, gp, -1816
   104f0: 93 87 81 8e  	addi	a5, gp, -1816
   104f4: 63 8a e7 00  	beq	a5, a4, 0x10508 <deregister_tm_clones+0x1c>
   104f8: 93 07 00 00  	li	a5, 0
   104fc: 63 86 07 00  	beqz	a5, 0x10508 <deregister_tm_clones+0x1c>
   10500: 13 85 81 8e  	addi	a0, gp, -1816
   10504: 67 80 07 00  	jr	a5
   10508: 67 80 00 00  	ret

000000000001050c <register_tm_clones>:
   1050c: 93 85 81 8e  	addi	a1, gp, -1816
   10510: 93 87 81 8e  	addi	a5, gp, -1816
   10514: b3 85 f5 40  	sub	a1, a1, a5
   10518: 93 d5 35 40  	srai	a1, a1, 3
   1051c: 93 07 20 00  	li	a5, 2
   10520: b3 c5 f5 02  	<unknown>
   10524: 63 8a 05 00  	beqz	a1, 0x10538 <register_tm_clones+0x2c>
   10528: 93 07 00 00  	li	a5, 0
   1052c: 63 86 07 00  	beqz	a5, 0x10538 <register_tm_clones+0x2c>
   10530: 13 85 81 8e  	addi	a0, gp, -1816
   10534: 67 80 07 00  	jr	a5
   10538: 67 80 00 00  	ret

000000000001053c <__do_global_dtors_aux>:
   1053c: 03 c7 01 a9  	lbu	a4, -1392(gp)
   10540: 63 14 07 04  	bnez	a4, 0x10588 <__do_global_dtors_aux+0x4c>
   10544: 13 01 01 ff  	addi	sp, sp, -16
   10548: 23 30 81 00  	sd	s0, 0(sp)
   1054c: 23 34 11 00  	sd	ra, 8(sp)
   10550: 13 84 07 00  	mv	s0, a5
   10554: ef f0 9f f9  	jal	0x104ec <deregister_tm_clones>
   10558: 93 07 00 00  	li	a5, 0
   1055c: 63 8a 07 00  	beqz	a5, 0x10570 <__do_global_dtors_aux+0x34>
   10560: 37 c5 01 00  	lui	a0, 28
   10564: 13 05 05 e8  	addi	a0, a0, -384
   10568: 97 00 00 00  	auipc	ra, 0
   1056c: e7 00 00 00  	jalr	zero
   10570: 93 07 10 00  	li	a5, 1
   10574: 83 30 81 00  	ld	ra, 8(sp)
   10578: 23 88 f1 a8  	sb	a5, -1392(gp)
   1057c: 03 34 01 00  	ld	s0, 0(sp)
   10580: 13 01 01 01  	addi	sp, sp, 16
   10584: 67 80 00 00  	ret
   10588: 67 80 00 00  	ret

000000000001058c <frame_dummy>:
   1058c: 93 07 00 00  	li	a5, 0
   10590: 63 84 07 02  	beqz	a5, 0x105b8 <frame_dummy+0x2c>
   10594: 37 c5 01 00  	lui	a0, 28
   10598: 13 01 01 ff  	addi	sp, sp, -16
   1059c: 93 85 81 a9  	addi	a1, gp, -1384
   105a0: 13 05 05 e8  	addi	a0, a0, -384
   105a4: 23 34 11 00  	sd	ra, 8(sp)
   105a8: 97 00 00 00  	auipc	ra, 0
   105ac: e7 00 00 00  	jalr	zero
   105b0: 83 30 81 00  	ld	ra, 8(sp)
   105b4: 13 01 01 01  	addi	sp, sp, 16
   105b8: 6f f0 5f f5  	j	0x1050c <register_tm_clones>

00000000000105bc <handler>:
   105bc: 67 80 00 00  	ret

00000000000105c0 <t_fdfill>:
   105c0: 13 01 01 fe  	addi	sp, sp, -32
   105c4: 13 05 10 00  	li	a0, 1
   105c8: 23 38 81 00  	sd	s0, 16(sp)
   105cc: 23 3c 11 00  	sd	ra, 24(sp)
   105d0: 23 34 91 00  	sd	s1, 8(sp)
   105d4: ef 40 00 2d  	jal	0x148a4 <dup>
   105d8: 93 07 f0 ff  	li	a5, -1
   105dc: 13 04 10 00  	li	s0, 1
   105e0: 63 14 f5 02  	bne	a0, a5, 0x10608 <t_fdfill+0x48>
   105e4: ef 10 c0 03  	jal	0x11620 <__errno_location>
   105e8: 03 27 05 00  	lw	a4, 0(a0)
   105ec: 93 07 80 01  	li	a5, 24
   105f0: 63 04 f7 02  	beq	a4, a5, 0x10618 <t_fdfill+0x58>
   105f4: 37 a5 01 00  	lui	a0, 26
   105f8: 93 05 00 00  	li	a1, 0
   105fc: 13 05 05 67  	addi	a0, a0, 1648
   10600: ef 10 00 0d  	jal	0x116d0 <open64>
   10604: 13 04 05 00  	mv	s0, a0
   10608: 93 04 f0 ff  	li	s1, -1
   1060c: 13 05 04 00  	mv	a0, s0
   10610: ef 40 40 29  	jal	0x148a4 <dup>
   10614: e3 1c 95 fe  	bne	a0, s1, 0x1060c <t_fdfill+0x4c>
   10618: 83 30 81 01  	ld	ra, 24(sp)
   1061c: 03 34 01 01  	ld	s0, 16(sp)
   10620: 83 34 81 00  	ld	s1, 8(sp)
   10624: 13 01 01 02  	addi	sp, sp, 32
   10628: 67 80 00 00  	ret

000000000001062c <t_memfill>:
   1062c: 13 01 01 ff  	addi	sp, sp, -16
   10630: 13 06 00 00  	li	a2, 0
   10634: 93 05 00 00  	li	a1, 0
   10638: 13 05 00 00  	li	a0, 0
   1063c: 23 30 81 00  	sd	s0, 0(sp)
   10640: 23 34 11 00  	sd	ra, 8(sp)
   10644: ef 00 50 24  	jal	0x11088 <t_vmfill>
   10648: 13 04 00 00  	li	s0, 0
   1064c: 63 52 05 02  	bgez	a0, 0x10670 <t_memfill+0x44>
   10650: ef 00 10 7d  	jal	0x11620 <__errno_location>
   10654: 03 25 05 00  	lw	a0, 0(a0)
   10658: 13 04 f0 ff  	li	s0, -1
   1065c: ef 10 c0 01  	jal	0x11678 <strerror>
   10660: 93 05 05 00  	mv	a1, a0
   10664: 37 a5 01 00  	lui	a0, 26
   10668: 13 05 05 68  	addi	a0, a0, 1664
   1066c: ef 00 40 45  	jal	0x10ac0 <t_printf>
   10670: 93 05 00 00  	li	a1, 0
   10674: 13 05 20 00  	li	a0, 2
   10678: ef 00 d0 08  	jal	0x10f04 <t_setrlim>
   1067c: 63 44 05 02  	bltz	a0, 0x106a4 <t_memfill+0x78>
   10680: 63 12 04 02  	bnez	s0, 0x106a4 <t_memfill+0x78>
   10684: 13 05 10 00  	li	a0, 1
   10688: ef 10 90 4a  	jal	0x12330 <malloc>
   1068c: e3 1c 05 fe  	bnez	a0, 0x10684 <t_memfill+0x58>
   10690: 83 30 81 00  	ld	ra, 8(sp)
   10694: 13 05 04 00  	mv	a0, s0
   10698: 03 34 01 00  	ld	s0, 0(sp)
   1069c: 13 01 01 01  	addi	sp, sp, 16
   106a0: 67 80 00 00  	ret
   106a4: 13 04 f0 ff  	li	s0, -1
   106a8: 6f f0 9f fe  	j	0x10690 <t_memfill+0x64>

00000000000106ac <eulpf>:
   106ac: 1b 55 75 01  	srliw	a0, a0, 23
   106b0: 13 75 f5 0f  	andi	a0, a0, 255
   106b4: 63 14 05 00  	bnez	a0, 0x106bc <eulpf+0x10>
   106b8: 13 05 10 00  	li	a0, 1
   106bc: 1b 05 a5 f6  	addiw	a0, a0, -150
   106c0: 67 80 00 00  	ret

00000000000106c4 <eulp>:
   106c4: 13 55 45 03  	srli	a0, a0, 52
   106c8: 13 75 f5 7f  	andi	a0, a0, 2047
   106cc: 63 14 05 00  	bnez	a0, 0x106d4 <eulp+0x10>
   106d0: 13 05 10 00  	li	a0, 1
   106d4: 1b 05 d5 bc  	addiw	a0, a0, -1075
   106d8: 67 80 00 00  	ret

00000000000106dc <eulpl>:
   106dc: 13 05 00 00  	li	a0, 0
   106e0: 67 80 00 00  	ret

00000000000106e4 <ulperrf>:
   106e4: 13 01 01 fe  	addi	sp, sp, -32
   106e8: 23 24 a1 00  	sw	a0, 8(sp)
   106ec: 03 27 81 00  	lw	a4, 8(sp)
   106f0: b7 07 00 80  	lui	a5, 524288
   106f4: 93 c7 f7 ff  	not	a5, a5
   106f8: d3 07 06 f0  	fmv.w.x	fa5, a2
   106fc: 23 38 81 00  	sd	s0, 16(sp)
   10700: 23 3c 11 00  	sd	ra, 24(sp)
   10704: 33 76 f7 00  	and	a2, a4, a5
   10708: b7 06 80 7f  	lui	a3, 522240
   1070c: 13 84 05 00  	mv	s0, a1
   10710: 63 fc c6 00  	bgeu	a3, a2, 0x10728 <ulperrf+0x44>
   10714: b3 f7 87 00  	and	a5, a5, s0
   10718: 9b 87 07 00  	sext.w	a5, a5
   1071c: 63 f6 f6 0a  	bgeu	a3, a5, 0x107c8 <ulperrf+0xe4>
   10720: d3 07 00 f0  	fmv.w.x	fa5, zero
   10724: 6f 00 40 02  	j	0x10748 <ulperrf+0x64>
   10728: 07 27 81 00  	<unknown>
   1072c: d3 86 05 f0  	fmv.w.x	fa3, a1
   10730: d3 27 d7 a0  	<unknown>
   10734: 63 84 07 02  	beqz	a5, 0x1075c <ulperrf+0x78>
   10738: 1b 57 f7 01  	srliw	a4, a4, 31
   1073c: 1b 54 f4 01  	srliw	s0, s0, 31
   10740: 63 04 87 00  	beq	a4, s0, 0x10748 <ulperrf+0x64>
   10744: 87 a7 81 94  	<unknown>
   10748: 83 30 81 01  	ld	ra, 24(sp)
   1074c: 03 34 01 01  	ld	s0, 16(sp)
   10750: 53 85 07 e0  	fmv.x.w	a0, fa5
   10754: 13 01 01 02  	addi	sp, sp, 32
   10758: 67 80 00 00  	ret
   1075c: 63 16 d6 02  	bne	a2, a3, 0x10788 <ulperrf+0xa4>
   10760: 03 a5 c1 94  	lw	a0, -1716(gp)
   10764: 83 25 81 00  	lw	a1, 8(sp)
   10768: 27 26 f1 00  	<unknown>
   1076c: ef 20 c0 20  	jal	0x12978 <copysignf>
   10770: d3 07 04 f0  	fmv.w.x	fa5, s0
   10774: 07 a7 01 95  	<unknown>
   10778: 23 24 a1 00  	sw	a0, 8(sp)
   1077c: d3 f7 e7 10  	<unknown>
   10780: 53 84 07 e0  	fmv.x.w	s0, fa5
   10784: 87 27 c1 00  	<unknown>
   10788: 13 05 04 00  	mv	a0, s0
   1078c: 27 26 f1 00  	<unknown>
   10790: ef f0 df f1  	jal	0x106ac <eulpf>
   10794: 87 27 81 00  	<unknown>
   10798: 53 07 04 f0  	fmv.w.x	fa4, s0
   1079c: bb 05 a0 40  	negw	a1, a0
   107a0: 53 f7 e7 08  	<unknown>
   107a4: d3 07 07 42  	<unknown>
   107a8: 53 85 07 e2  	<unknown>
   107ac: ef 20 00 1e  	jal	0x1298c <scalbn>
   107b0: 87 27 c1 00  	<unknown>
   107b4: 53 07 05 f2  	<unknown>
   107b8: d3 87 07 42  	<unknown>
   107bc: d3 f7 e7 02  	<unknown>
   107c0: d3 f7 17 40  	<unknown>
   107c4: 6f f0 5f f8  	j	0x10748 <ulperrf+0x64>
   107c8: 07 27 81 00  	<unknown>
   107cc: d3 86 05 f0  	fmv.w.x	fa3, a1
   107d0: d3 27 d7 a0  	<unknown>
   107d4: e3 8a 07 fa  	beqz	a5, 0x10788 <ulperrf+0xa4>
   107d8: 6f f0 1f f6  	j	0x10738 <ulperrf+0x54>

00000000000107dc <ulperr>:
   107dc: 93 07 f0 ff  	li	a5, -1
   107e0: 13 01 01 fe  	addi	sp, sp, -32
   107e4: 93 d7 17 00  	srli	a5, a5, 1
   107e8: 13 07 f0 7f  	li	a4, 2047
   107ec: 53 07 06 f0  	fmv.w.x	fa4, a2
   107f0: 23 38 81 00  	sd	s0, 16(sp)
   107f4: 23 3c 11 00  	sd	ra, 24(sp)
   107f8: 33 f6 a7 00  	and	a2, a5, a0
   107fc: 13 17 47 03  	slli	a4, a4, 52
   10800: 13 84 05 00  	mv	s0, a1
   10804: 93 06 05 00  	mv	a3, a0
   10808: 63 7a c7 00  	bgeu	a4, a2, 0x1081c <ulperr+0x40>
   1080c: b3 f7 f5 00  	and	a5, a1, a5
   10810: 63 76 f7 0a  	bgeu	a4, a5, 0x108bc <ulperr+0xe0>
   10814: 53 07 00 f0  	fmv.w.x	fa4, zero
   10818: 6f 00 40 02  	j	0x1083c <ulperr+0x60>
   1081c: d3 07 05 f2  	<unknown>
   10820: d3 86 05 f2  	<unknown>
   10824: d3 a7 d7 a2  	<unknown>
   10828: 63 84 07 02  	beqz	a5, 0x10850 <ulperr+0x74>
   1082c: 93 a6 06 00  	slti	a3, a3, 0
   10830: 13 24 04 00  	slti	s0, s0, 0
   10834: 63 84 86 00  	beq	a3, s0, 0x1083c <ulperr+0x60>
   10838: 07 a7 81 94  	<unknown>
   1083c: 83 30 81 01  	ld	ra, 24(sp)
   10840: 03 34 01 01  	ld	s0, 16(sp)
   10844: 53 05 07 e0  	fmv.x.w	a0, fa4
   10848: 13 01 01 02  	addi	sp, sp, 32
   1084c: 67 80 00 00  	ret
   10850: 63 14 e6 02  	bne	a2, a4, 0x10878 <ulperr+0x9c>
   10854: 93 05 05 00  	mv	a1, a0
   10858: 03 b5 81 90  	ld	a0, -1784(gp)
   1085c: 27 20 e1 00  	<unknown>
   10860: ef 20 40 10  	jal	0x12964 <copysign>
   10864: 53 07 04 f2  	<unknown>
   10868: 87 b7 01 91  	<unknown>
   1086c: d3 77 f7 12  	<unknown>
   10870: 07 27 01 00  	<unknown>
   10874: 53 84 07 e2  	<unknown>
   10878: d3 07 05 f2  	<unknown>
   1087c: 27 26 e1 00  	<unknown>
   10880: 53 07 04 f2  	<unknown>
   10884: 13 05 04 00  	mv	a0, s0
   10888: d3 f7 e7 0a  	<unknown>
   1088c: 27 30 f1 00  	<unknown>
   10890: ef f0 5f e3  	jal	0x106c4 <eulp>
   10894: 87 37 01 00  	<unknown>
   10898: bb 05 a0 40  	negw	a1, a0
   1089c: 53 85 07 e2  	<unknown>
   108a0: ef 20 c0 0e  	jal	0x1298c <scalbn>
   108a4: 07 27 c1 00  	<unknown>
   108a8: d3 07 05 f2  	<unknown>
   108ac: 53 07 07 42  	<unknown>
   108b0: 53 77 f7 02  	<unknown>
   108b4: 53 77 17 40  	<unknown>
   108b8: 6f f0 5f f8  	j	0x1083c <ulperr+0x60>
   108bc: d3 07 05 f2  	<unknown>
   108c0: d3 86 05 f2  	<unknown>
   108c4: d3 a7 d7 a2  	<unknown>
   108c8: e3 88 07 fa  	beqz	a5, 0x10878 <ulperr+0x9c>
   108cc: 6f f0 1f f6  	j	0x1082c <ulperr+0x50>

00000000000108d0 <ulperrl>:
   108d0: 03 a5 81 94  	lw	a0, -1720(gp)
   108d4: 67 80 00 00  	ret

00000000000108d8 <estr>:
   108d8: 13 01 01 fa  	addi	sp, sp, -96
   108dc: 23 34 91 04  	sd	s1, 72(sp)
   108e0: b7 a4 01 00  	lui	s1, 26
   108e4: 23 38 41 03  	sd	s4, 48(sp)
   108e8: 23 34 51 03  	sd	s5, 40(sp)
   108ec: 23 30 61 03  	sd	s6, 32(sp)
   108f0: 93 84 04 74  	addi	s1, s1, 1856
   108f4: b7 aa 01 00  	lui	s5, 26
   108f8: 37 ab 01 00  	lui	s6, 26
   108fc: 23 38 81 04  	sd	s0, 80(sp)
   10900: 23 30 21 05  	sd	s2, 64(sp)
   10904: 23 3c 31 03  	sd	s3, 56(sp)
   10908: 23 38 81 01  	sd	s8, 16(sp)
   1090c: 23 34 91 01  	sd	s9, 8(sp)
   10910: 23 3c 11 04  	sd	ra, 88(sp)
   10914: 23 3c 71 01  	sd	s7, 24(sp)
   10918: 93 09 05 00  	mv	s3, a0
   1091c: 13 8c 04 05  	addi	s8, s1, 80
   10920: 13 04 00 00  	li	s0, 0
   10924: 13 89 81 ac  	addi	s2, gp, -1336
   10928: b7 ac 01 00  	lui	s9, 26
   1092c: 93 8a 0a 6b  	addi	s5, s5, 1712
   10930: 13 0b 8b 66  	addi	s6, s6, 1640
   10934: 83 ab 04 00  	lw	s7, 0(s1)
   10938: b3 f7 3b 01  	and	a5, s7, s3
   1093c: 63 84 07 02  	beqz	a5, 0x10964 <estr+0x8c>
   10940: 13 86 0a 00  	mv	a2, s5
   10944: 63 14 04 00  	bnez	s0, 0x1094c <estr+0x74>
   10948: 13 06 0b 00  	mv	a2, s6
   1094c: 83 b6 84 00  	ld	a3, 8(s1)
   10950: 13 05 09 00  	mv	a0, s2
   10954: 93 85 0c 6c  	addi	a1, s9, 1728
   10958: ef 30 40 07  	jal	0x139cc <sprintf>
   1095c: 33 09 a9 00  	add	s2, s2, a0
   10960: 33 e4 8b 00  	or	s0, s7, s0
   10964: 93 84 04 01  	addi	s1, s1, 16
   10968: e3 96 84 fd  	bne	s1, s8, 0x10934 <estr+0x5c>
   1096c: 63 06 34 03  	beq	s0, s3, 0x10998 <estr+0xc0>
   10970: 63 1e 04 06  	bnez	s0, 0x109ec <estr+0x114>
   10974: 37 a6 01 00  	lui	a2, 26
   10978: 13 06 86 66  	addi	a2, a2, 1640
   1097c: 93 46 f4 ff  	not	a3, s0
   10980: b7 a5 01 00  	lui	a1, 26
   10984: 13 05 09 00  	mv	a0, s2
   10988: b3 f6 36 01  	and	a3, a3, s3
   1098c: 93 85 85 6c  	addi	a1, a1, 1736
   10990: ef 30 c0 03  	jal	0x139cc <sprintf>
   10994: 33 09 a9 00  	add	s2, s2, a0
   10998: 63 90 09 06  	bnez	s3, 0x109f8 <estr+0x120>
   1099c: 37 a6 01 00  	lui	a2, 26
   109a0: 13 06 86 6b  	addi	a2, a2, 1720
   109a4: b7 a5 01 00  	lui	a1, 26
   109a8: 13 05 09 00  	mv	a0, s2
   109ac: 93 85 05 6d  	addi	a1, a1, 1744
   109b0: ef 30 c0 01  	jal	0x139cc <sprintf>
   109b4: 83 30 81 05  	ld	ra, 88(sp)
   109b8: 03 34 01 05  	ld	s0, 80(sp)
   109bc: 83 34 81 04  	ld	s1, 72(sp)
   109c0: 03 39 01 04  	ld	s2, 64(sp)
   109c4: 83 39 81 03  	ld	s3, 56(sp)
   109c8: 83 3a 81 02  	ld	s5, 40(sp)
   109cc: 03 3b 01 02  	ld	s6, 32(sp)
   109d0: 83 3b 81 01  	ld	s7, 24(sp)
   109d4: 03 3c 01 01  	ld	s8, 16(sp)
   109d8: 83 3c 81 00  	ld	s9, 8(sp)
   109dc: 13 85 81 ac  	addi	a0, gp, -1336
   109e0: 03 3a 01 03  	ld	s4, 48(sp)
   109e4: 13 01 01 06  	addi	sp, sp, 96
   109e8: 67 80 00 00  	ret
   109ec: 37 a6 01 00  	lui	a2, 26
   109f0: 13 06 06 6b  	addi	a2, a2, 1712
   109f4: 6f f0 9f f8  	j	0x1097c <estr+0xa4>
   109f8: 37 a6 01 00  	lui	a2, 26
   109fc: 13 06 86 66  	addi	a2, a2, 1640
   10a00: 6f f0 5f fa  	j	0x109a4 <estr+0xcc>

0000000000010a04 <rstr>:
   10a04: 93 07 30 00  	li	a5, 3
   10a08: 63 e0 a7 02  	bltu	a5, a0, 0x10a28 <rstr+0x24>
   10a0c: 13 15 05 02  	slli	a0, a0, 32
   10a10: b7 a7 01 00  	lui	a5, 26
   10a14: 93 87 07 74  	addi	a5, a5, 1856
   10a18: 13 55 d5 01  	srli	a0, a0, 29
   10a1c: 33 85 a7 00  	add	a0, a5, a0
   10a20: 03 35 05 05  	ld	a0, 80(a0)
   10a24: 67 80 00 00  	ret
   10a28: 37 a5 01 00  	lui	a0, 26
   10a2c: 13 05 85 6d  	addi	a0, a0, 1752
   10a30: 67 80 00 00  	ret

0000000000010a34 <t_pathrel>:
   10a34: 13 01 01 fd  	addi	sp, sp, -48
   10a38: 23 30 81 02  	sd	s0, 32(sp)
   10a3c: 23 3c 91 00  	sd	s1, 24(sp)
   10a40: 13 04 05 00  	mv	s0, a0
   10a44: 93 84 05 00  	mv	s1, a1
   10a48: 13 05 06 00  	mv	a0, a2
   10a4c: 93 05 f0 02  	li	a1, 47
   10a50: 23 34 d1 00  	sd	a3, 8(sp)
   10a54: 23 34 11 02  	sd	ra, 40(sp)
   10a58: 23 30 c1 00  	sd	a2, 0(sp)
   10a5c: ef 30 50 04  	jal	0x142a0 <strrchr>
   10a60: 83 36 81 00  	ld	a3, 8(sp)
   10a64: 63 02 05 04  	beqz	a0, 0x10aa8 <t_pathrel+0x74>
   10a68: 03 37 01 00  	ld	a4, 0(sp)
   10a6c: 37 a6 01 00  	lui	a2, 26
   10a70: 93 87 06 00  	mv	a5, a3
   10a74: 13 06 06 7b  	addi	a2, a2, 1968
   10a78: bb 06 e5 40  	subw	a3, a0, a4
   10a7c: 93 85 04 00  	mv	a1, s1
   10a80: 13 05 04 00  	mv	a0, s0
   10a84: ef 20 50 71  	jal	0x13998 <snprintf>
   10a88: 63 64 95 00  	bltu	a0, s1, 0x10a90 <t_pathrel+0x5c>
   10a8c: 13 04 00 00  	li	s0, 0
   10a90: 83 30 81 02  	ld	ra, 40(sp)
   10a94: 13 05 04 00  	mv	a0, s0
   10a98: 03 34 01 02  	ld	s0, 32(sp)
   10a9c: 83 34 81 01  	ld	s1, 24(sp)
   10aa0: 13 01 01 03  	addi	sp, sp, 48
   10aa4: 67 80 00 00  	ret
   10aa8: 37 a6 01 00  	lui	a2, 26
   10aac: 13 06 86 7b  	addi	a2, a2, 1976
   10ab0: 93 85 04 00  	mv	a1, s1
   10ab4: 13 05 04 00  	mv	a0, s0
   10ab8: ef 20 10 6e  	jal	0x13998 <snprintf>
   10abc: 6f f0 df fc  	j	0x10a88 <t_pathrel+0x54>

0000000000010ac0 <t_printf>:
   10ac0: 13 01 01 da  	addi	sp, sp, -608
   10ac4: 23 34 b1 22  	sd	a1, 552(sp)
   10ac8: 23 38 c1 22  	sd	a2, 560(sp)
   10acc: 23 3c d1 22  	sd	a3, 568(sp)
   10ad0: 13 06 05 00  	mv	a2, a0
   10ad4: 23 30 e1 24  	sd	a4, 576(sp)
   10ad8: 23 34 f1 24  	sd	a5, 584(sp)
   10adc: 13 07 10 00  	li	a4, 1
   10ae0: 93 06 81 22  	addi	a3, sp, 552
   10ae4: 93 05 00 20  	li	a1, 512
   10ae8: 13 05 01 01  	addi	a0, sp, 16
   10aec: 23 3c 11 20  	sd	ra, 536(sp)
   10af0: 23 38 01 25  	sd	a6, 592(sp)
   10af4: 23 3c 11 25  	sd	a7, 600(sp)
   10af8: 23 a0 e1 9a  	sw	a4, -1632(gp)
   10afc: 23 34 d1 00  	sd	a3, 8(sp)
   10b00: ef 20 10 7e  	jal	0x13ae0 <vsnprintf>
   10b04: 13 06 00 00  	li	a2, 0
   10b08: 63 46 05 02  	bltz	a0, 0x10b34 <t_printf+0x74>
   10b0c: 93 07 f0 1f  	li	a5, 511
   10b10: 13 06 05 00  	mv	a2, a0
   10b14: 63 d0 a7 02  	bge	a5, a0, 0x10b34 <t_printf+0x74>
   10b18: 93 07 a0 00  	li	a5, 10
   10b1c: a3 07 f1 20  	sb	a5, 527(sp)
   10b20: 93 07 e0 02  	li	a5, 46
   10b24: 23 07 f1 20  	sb	a5, 526(sp)
   10b28: a3 06 f1 20  	sb	a5, 525(sp)
   10b2c: 23 06 f1 20  	sb	a5, 524(sp)
   10b30: 13 06 00 20  	li	a2, 512
   10b34: 93 05 01 01  	addi	a1, sp, 16
   10b38: 13 05 10 00  	li	a0, 1
   10b3c: ef 30 d0 58  	jal	0x148c8 <write>
   10b40: 83 30 81 21  	ld	ra, 536(sp)
   10b44: 1b 05 05 00  	sext.w	a0, a0
   10b48: 13 01 01 26  	addi	sp, sp, 608
   10b4c: 67 80 00 00  	ret

0000000000010b50 <rand64>:
   10b50: 03 b5 01 98  	ld	a0, -1664(gp)
   10b54: 83 b7 81 91  	ld	a5, -1768(gp)
   10b58: 33 05 f5 02  	<unknown>
   10b5c: 13 05 15 00  	addi	a0, a0, 1
   10b60: b3 07 f5 02  	<unknown>
   10b64: 13 55 05 02  	srli	a0, a0, 32
   10b68: 13 15 05 02  	slli	a0, a0, 32
   10b6c: 93 87 17 00  	addi	a5, a5, 1
   10b70: 23 b0 f1 98  	sd	a5, -1664(gp)
   10b74: 93 d7 07 02  	srli	a5, a5, 32
   10b78: 33 65 f5 00  	or	a0, a0, a5
   10b7c: 67 80 00 00  	ret

0000000000010b80 <t_randseed>:
   10b80: 23 b0 a1 98  	sd	a0, -1664(gp)
   10b84: 67 80 00 00  	ret

0000000000010b88 <t_randn>:
   10b88: 13 01 01 fe  	addi	sp, sp, -32
   10b8c: 23 38 81 00  	sd	s0, 16(sp)
   10b90: 13 04 f0 ff  	li	s0, -1
   10b94: 33 74 a4 02  	<unknown>
   10b98: 23 34 91 00  	sd	s1, 8(sp)
   10b9c: 23 3c 11 00  	sd	ra, 24(sp)
   10ba0: 93 04 05 00  	mv	s1, a0
   10ba4: 13 44 f4 ff  	not	s0, s0
   10ba8: ef f0 9f fa  	jal	0x10b50 <rand64>
   10bac: e3 7e 85 fe  	bgeu	a0, s0, 0x10ba8 <t_randn+0x20>
   10bb0: 83 30 81 01  	ld	ra, 24(sp)
   10bb4: 03 34 01 01  	ld	s0, 16(sp)
   10bb8: 33 75 95 02  	<unknown>
   10bbc: 83 34 81 00  	ld	s1, 8(sp)
   10bc0: 13 01 01 02  	addi	sp, sp, 32
   10bc4: 67 80 00 00  	ret

0000000000010bc8 <shuffle2>:
   10bc8: 13 01 01 fd  	addi	sp, sp, -48
   10bcc: 23 3c 91 00  	sd	s1, 24(sp)
   10bd0: 93 14 36 00  	slli	s1, a2, 3
   10bd4: 23 30 81 02  	sd	s0, 32(sp)
   10bd8: 23 38 21 01  	sd	s2, 16(sp)
   10bdc: 23 34 31 01  	sd	s3, 8(sp)
   10be0: 23 30 41 01  	sd	s4, 0(sp)
   10be4: 23 34 11 02  	sd	ra, 40(sp)
   10be8: 93 09 05 00  	mv	s3, a0
   10bec: 13 8a 05 00  	mv	s4, a1
   10bf0: 13 04 06 00  	mv	s0, a2
   10bf4: 13 89 06 00  	mv	s2, a3
   10bf8: b3 04 95 00  	add	s1, a0, s1
   10bfc: 63 12 04 02  	bnez	s0, 0x10c20 <shuffle2+0x58>
   10c00: 83 30 81 02  	ld	ra, 40(sp)
   10c04: 03 34 01 02  	ld	s0, 32(sp)
   10c08: 83 34 81 01  	ld	s1, 24(sp)
   10c0c: 03 39 01 01  	ld	s2, 16(sp)
   10c10: 83 39 81 00  	ld	s3, 8(sp)
   10c14: 03 3a 01 00  	ld	s4, 0(sp)
   10c18: 13 01 01 03  	addi	sp, sp, 48
   10c1c: 67 80 00 00  	ret
   10c20: 33 05 24 01  	add	a0, s0, s2
   10c24: ef f0 5f f6  	jal	0x10b88 <t_randn>
   10c28: 03 b7 84 ff  	ld	a4, -8(s1)
   10c2c: 63 72 25 03  	bgeu	a0, s2, 0x10c50 <shuffle2+0x88>
   10c30: 93 17 35 00  	slli	a5, a0, 3
   10c34: b3 07 fa 00  	add	a5, s4, a5
   10c38: 83 b6 07 00  	ld	a3, 0(a5)
   10c3c: 13 04 f4 ff  	addi	s0, s0, -1
   10c40: 93 84 84 ff  	addi	s1, s1, -8
   10c44: 23 b0 d4 00  	sd	a3, 0(s1)
   10c48: 23 b0 e7 00  	sd	a4, 0(a5)
   10c4c: 6f f0 1f fb  	j	0x10bfc <shuffle2+0x34>
   10c50: b3 07 25 41  	sub	a5, a0, s2
   10c54: 93 97 37 00  	slli	a5, a5, 3
   10c58: b3 87 f9 00  	add	a5, s3, a5
   10c5c: 6f f0 df fd  	j	0x10c38 <shuffle2+0x70>

0000000000010c60 <t_randint>:
   10c60: 13 01 01 ff  	addi	sp, sp, -16
   10c64: b3 85 a5 40  	sub	a1, a1, a0
   10c68: 23 30 81 00  	sd	s0, 0(sp)
   10c6c: 23 34 11 00  	sd	ra, 8(sp)
   10c70: 13 04 05 00  	mv	s0, a0
   10c74: 13 85 15 00  	addi	a0, a1, 1
   10c78: 63 1a 05 00  	bnez	a0, 0x10c8c <t_randint+0x2c>
   10c7c: 03 34 01 00  	ld	s0, 0(sp)
   10c80: 83 30 81 00  	ld	ra, 8(sp)
   10c84: 13 01 01 01  	addi	sp, sp, 16
   10c88: 6f f0 9f ec  	j	0x10b50 <rand64>
   10c8c: ef f0 df ef  	jal	0x10b88 <t_randn>
   10c90: 83 30 81 00  	ld	ra, 8(sp)
   10c94: 33 05 85 00  	add	a0, a0, s0
   10c98: 03 34 01 00  	ld	s0, 0(sp)
   10c9c: 13 01 01 01  	addi	sp, sp, 16
   10ca0: 67 80 00 00  	ret

0000000000010ca4 <t_shuffle>:
   10ca4: 13 86 05 00  	mv	a2, a1
   10ca8: 93 06 00 00  	li	a3, 0
   10cac: 93 05 00 00  	li	a1, 0
   10cb0: 6f f0 9f f1  	j	0x10bc8 <shuffle2>

0000000000010cb4 <t_randrange>:
   10cb4: 93 87 05 00  	mv	a5, a1
   10cb8: 93 05 00 00  	li	a1, 0
   10cbc: 63 94 f5 00  	bne	a1, a5, 0x10cc4 <t_randrange+0x10>
   10cc0: 6f f0 5f fe  	j	0x10ca4 <t_shuffle>
   10cc4: 13 97 35 00  	slli	a4, a1, 3
   10cc8: 33 07 e5 00  	add	a4, a0, a4
   10ccc: 23 30 b7 00  	sd	a1, 0(a4)
   10cd0: 93 85 15 00  	addi	a1, a1, 1
   10cd4: 6f f0 9f fe  	j	0x10cbc <t_randrange+0x8>

0000000000010cd8 <t_choose>:
   10cd8: 63 7c b5 02  	bgeu	a0, a1, 0x10d10 <t_choose+0x38>
   10cdc: 13 05 f0 ff  	li	a0, -1
   10ce0: 67 80 00 00  	ret
   10ce4: 13 05 f0 ff  	li	a0, -1
   10ce8: 83 30 81 04  	ld	ra, 72(sp)
   10cec: 03 34 01 04  	ld	s0, 64(sp)
   10cf0: 83 34 81 03  	ld	s1, 56(sp)
   10cf4: 03 39 01 03  	ld	s2, 48(sp)
   10cf8: 83 39 81 02  	ld	s3, 40(sp)
   10cfc: 03 3a 01 02  	ld	s4, 32(sp)
   10d00: 83 3a 81 01  	ld	s5, 24(sp)
   10d04: 03 3b 01 01  	ld	s6, 16(sp)
   10d08: 13 01 01 05  	addi	sp, sp, 80
   10d0c: 67 80 00 00  	ret
   10d10: 13 01 01 fb  	addi	sp, sp, -80
   10d14: 23 30 81 04  	sd	s0, 64(sp)
   10d18: 23 3c 91 02  	sd	s1, 56(sp)
   10d1c: 23 38 21 03  	sd	s2, 48(sp)
   10d20: 23 34 11 04  	sd	ra, 72(sp)
   10d24: 23 34 31 03  	sd	s3, 40(sp)
   10d28: 23 30 41 03  	sd	s4, 32(sp)
   10d2c: 23 3c 51 01  	sd	s5, 24(sp)
   10d30: 23 38 61 01  	sd	s6, 16(sp)
   10d34: 93 07 f0 00  	li	a5, 15
   10d38: 93 04 05 00  	mv	s1, a0
   10d3c: 13 84 05 00  	mv	s0, a1
   10d40: 13 09 06 00  	mv	s2, a2
   10d44: 63 ec a7 02  	bltu	a5, a0, 0x10d7c <t_choose+0xa4>
   10d48: 63 16 04 00  	bnez	s0, 0x10d54 <t_choose+0x7c>
   10d4c: 13 05 00 00  	li	a0, 0
   10d50: 6f f0 9f f9  	j	0x10ce8 <t_choose+0x10>
   10d54: 13 85 04 00  	mv	a0, s1
   10d58: 93 89 f4 ff  	addi	s3, s1, -1
   10d5c: ef f0 df e2  	jal	0x10b88 <t_randn>
   10d60: 63 7a 85 00  	bgeu	a0, s0, 0x10d74 <t_choose+0x9c>
   10d64: 13 04 f4 ff  	addi	s0, s0, -1
   10d68: 93 17 34 00  	slli	a5, s0, 3
   10d6c: b3 07 f9 00  	add	a5, s2, a5
   10d70: 23 b0 37 01  	sd	s3, 0(a5)
   10d74: 93 84 09 00  	mv	s1, s3
   10d78: 6f f0 1f fd  	j	0x10d48 <t_choose+0x70>
   10d7c: 93 07 70 00  	li	a5, 7
   10d80: 63 e6 b7 04  	bltu	a5, a1, 0x10dcc <t_choose+0xf4>
   10d84: 93 09 00 00  	li	s3, 0
   10d88: 6f 00 40 03  	j	0x10dbc <t_choose+0xe4>
   10d8c: 13 9a 39 00  	slli	s4, s3, 3
   10d90: 13 85 04 00  	mv	a0, s1
   10d94: ef f0 5f df  	jal	0x10b88 <t_randn>
   10d98: 33 0a 49 01  	add	s4, s2, s4
   10d9c: 23 30 aa 00  	sd	a0, 0(s4)
   10da0: 93 07 00 00  	li	a5, 0
   10da4: 13 97 37 00  	slli	a4, a5, 3
   10da8: 33 07 e9 00  	add	a4, s2, a4
   10dac: 03 37 07 00  	ld	a4, 0(a4)
   10db0: 63 1a e5 00  	bne	a0, a4, 0x10dc4 <t_choose+0xec>
   10db4: 63 94 f9 00  	bne	s3, a5, 0x10dbc <t_choose+0xe4>
   10db8: 93 89 19 00  	addi	s3, s3, 1
   10dbc: e3 e8 89 fc  	bltu	s3, s0, 0x10d8c <t_choose+0xb4>
   10dc0: 6f f0 df f8  	j	0x10d4c <t_choose+0x74>
   10dc4: 93 87 17 00  	addi	a5, a5, 1
   10dc8: 6f f0 df fd  	j	0x10da4 <t_choose+0xcc>
   10dcc: 93 07 50 00  	li	a5, 5
   10dd0: b3 87 f5 02  	<unknown>
   10dd4: 63 6e f5 04  	bltu	a0, a5, 0x10e30 <t_choose+0x158>
   10dd8: 93 97 15 00  	slli	a5, a1, 1
   10ddc: 13 0a 00 01  	li	s4, 16
   10de0: 63 6c fa 0c  	bltu	s4, a5, 0x10eb8 <t_choose+0x1e0>
   10de4: 93 05 80 00  	li	a1, 8
   10de8: 13 05 0a 00  	mv	a0, s4
   10dec: ef 10 10 05  	jal	0x1263c <calloc>
   10df0: 93 09 05 00  	mv	s3, a0
   10df4: e3 08 05 ee  	beqz	a0, 0x10ce4 <t_choose+0xc>
   10df8: 93 0a 00 00  	li	s5, 0
   10dfc: 13 0b fa ff  	addi	s6, s4, -1
   10e00: 63 90 8a 0c  	bne	s5, s0, 0x10ec0 <t_choose+0x1e8>
   10e04: 93 07 00 00  	li	a5, 0
   10e08: 63 88 47 07  	beq	a5, s4, 0x10e78 <t_choose+0x1a0>
   10e0c: 13 97 37 00  	slli	a4, a5, 3
   10e10: 33 87 e9 00  	add	a4, s3, a4
   10e14: 03 37 07 00  	ld	a4, 0(a4)
   10e18: 63 08 07 00  	beqz	a4, 0x10e28 <t_choose+0x150>
   10e1c: 13 07 f7 ff  	addi	a4, a4, -1
   10e20: 23 30 e9 00  	sd	a4, 0(s2)
   10e24: 13 09 89 00  	addi	s2, s2, 8
   10e28: 93 87 17 00  	addi	a5, a5, 1
   10e2c: 6f f0 df fd  	j	0x10e08 <t_choose+0x130>
   10e30: 33 06 b5 40  	sub	a2, a0, a1
   10e34: 13 15 36 00  	slli	a0, a2, 3
   10e38: 23 34 c1 00  	sd	a2, 8(sp)
   10e3c: ef 10 40 4f  	jal	0x12330 <malloc>
   10e40: 93 09 05 00  	mv	s3, a0
   10e44: e3 00 05 ea  	beqz	a0, 0x10ce4 <t_choose+0xc>
   10e48: 03 36 81 00  	ld	a2, 8(sp)
   10e4c: 93 07 00 00  	li	a5, 0
   10e50: 63 9a 87 02  	bne	a5, s0, 0x10e84 <t_choose+0x1ac>
   10e54: 13 87 09 00  	mv	a4, s3
   10e58: 93 07 04 00  	mv	a5, s0
   10e5c: 63 9e 97 02  	bne	a5, s1, 0x10e98 <t_choose+0x1c0>
   10e60: 63 74 c4 04  	bgeu	s0, a2, 0x10ea8 <t_choose+0x1d0>
   10e64: 93 06 06 00  	mv	a3, a2
   10e68: 93 85 09 00  	mv	a1, s3
   10e6c: 13 06 04 00  	mv	a2, s0
   10e70: 13 05 09 00  	mv	a0, s2
   10e74: ef f0 5f d5  	jal	0x10bc8 <shuffle2>
   10e78: 13 85 09 00  	mv	a0, s3
   10e7c: ef 10 d0 09  	jal	0x12718 <free>
   10e80: 6f f0 df ec  	j	0x10d4c <t_choose+0x74>
   10e84: 13 97 37 00  	slli	a4, a5, 3
   10e88: 33 07 e9 00  	add	a4, s2, a4
   10e8c: 23 30 f7 00  	sd	a5, 0(a4)
   10e90: 93 87 17 00  	addi	a5, a5, 1
   10e94: 6f f0 df fb  	j	0x10e50 <t_choose+0x178>
   10e98: 23 30 f7 00  	sd	a5, 0(a4)
   10e9c: 93 87 17 00  	addi	a5, a5, 1
   10ea0: 13 07 87 00  	addi	a4, a4, 8
   10ea4: 6f f0 9f fb  	j	0x10e5c <t_choose+0x184>
   10ea8: 93 06 04 00  	mv	a3, s0
   10eac: 93 05 09 00  	mv	a1, s2
   10eb0: 13 85 09 00  	mv	a0, s3
   10eb4: 6f f0 1f fc  	j	0x10e74 <t_choose+0x19c>
   10eb8: 13 1a 1a 00  	slli	s4, s4, 1
   10ebc: 6f f0 5f f2  	j	0x10de0 <t_choose+0x108>
   10ec0: 13 85 04 00  	mv	a0, s1
   10ec4: ef f0 5f cc  	jal	0x10b88 <t_randn>
   10ec8: 13 05 15 00  	addi	a0, a0, 1
   10ecc: b3 77 65 01  	and	a5, a0, s6
   10ed0: 93 06 10 00  	li	a3, 1
   10ed4: 13 97 37 00  	slli	a4, a5, 3
   10ed8: 33 87 e9 00  	add	a4, s3, a4
   10edc: 03 36 07 00  	ld	a2, 0(a4)
   10ee0: 63 18 06 00  	bnez	a2, 0x10ef0 <t_choose+0x218>
   10ee4: 23 30 a7 00  	sd	a0, 0(a4)
   10ee8: 93 8a 1a 00  	addi	s5, s5, 1
   10eec: 6f f0 5f f1  	j	0x10e00 <t_choose+0x128>
   10ef0: e3 08 c5 fc  	beq	a0, a2, 0x10ec0 <t_choose+0x1e8>
   10ef4: b3 87 f6 00  	add	a5, a3, a5
   10ef8: b3 77 fb 00  	and	a5, s6, a5
   10efc: 93 86 16 00  	addi	a3, a3, 1
   10f00: 6f f0 5f fd  	j	0x10ed4 <t_choose+0x1fc>

0000000000010f04 <t_setrlim>:
   10f04: 13 01 01 fd  	addi	sp, sp, -48
   10f08: 23 30 81 02  	sd	s0, 32(sp)
   10f0c: 13 84 05 00  	mv	s0, a1
   10f10: 93 05 01 00  	mv	a1, sp
   10f14: 23 38 21 01  	sd	s2, 16(sp)
   10f18: 23 34 11 02  	sd	ra, 40(sp)
   10f1c: 23 3c 91 00  	sd	s1, 24(sp)
   10f20: 13 09 05 00  	mv	s2, a0
   10f24: ef 10 10 66  	jal	0x12d84 <getrlimit64>
   10f28: 63 02 05 04  	beqz	a0, 0x10f6c <t_setrlim+0x68>
   10f2c: ef 00 40 6f  	jal	0x11620 <__errno_location>
   10f30: 03 25 05 00  	lw	a0, 0(a0)
   10f34: ef 00 40 74  	jal	0x11678 <strerror>
   10f38: 13 06 05 00  	mv	a2, a0
   10f3c: 37 a5 01 00  	lui	a0, 26
   10f40: 93 05 09 00  	mv	a1, s2
   10f44: 13 05 05 7c  	addi	a0, a0, 1984
   10f48: ef f0 9f b7  	jal	0x10ac0 <t_printf>
   10f4c: 93 04 f0 ff  	li	s1, -1
   10f50: 83 30 81 02  	ld	ra, 40(sp)
   10f54: 03 34 01 02  	ld	s0, 32(sp)
   10f58: 03 39 01 01  	ld	s2, 16(sp)
   10f5c: 13 85 04 00  	mv	a0, s1
   10f60: 83 34 81 01  	ld	s1, 24(sp)
   10f64: 13 01 01 03  	addi	sp, sp, 48
   10f68: 67 80 00 00  	ret
   10f6c: 83 37 81 00  	ld	a5, 8(sp)
   10f70: e3 ee 87 fc  	bltu	a5, s0, 0x10f4c <t_setrlim+0x48>
   10f74: 93 04 05 00  	mv	s1, a0
   10f78: 63 96 87 00  	bne	a5, s0, 0x10f84 <t_setrlim+0x80>
   10f7c: 83 37 01 00  	ld	a5, 0(sp)
   10f80: e3 08 f4 fc  	beq	s0, a5, 0x10f50 <t_setrlim+0x4c>
   10f84: 93 05 01 00  	mv	a1, sp
   10f88: 13 05 09 00  	mv	a0, s2
   10f8c: 23 34 81 00  	sd	s0, 8(sp)
   10f90: 23 30 81 00  	sd	s0, 0(sp)
   10f94: ef 10 90 70  	jal	0x12e9c <setrlimit64>
   10f98: e3 0c 05 fa  	beqz	a0, 0x10f50 <t_setrlim+0x4c>
   10f9c: ef 00 40 68  	jal	0x11620 <__errno_location>
   10fa0: 03 25 05 00  	lw	a0, 0(a0)
   10fa4: ef 00 40 6d  	jal	0x11678 <strerror>
   10fa8: 93 06 05 00  	mv	a3, a0
   10fac: 37 a5 01 00  	lui	a0, 26
   10fb0: 13 06 04 00  	mv	a2, s0
   10fb4: 93 05 09 00  	mv	a1, s2
   10fb8: 13 05 05 7f  	addi	a0, a0, 2032
   10fbc: ef f0 5f b0  	jal	0x10ac0 <t_printf>
   10fc0: 6f f0 df f8  	j	0x10f4c <t_setrlim+0x48>

0000000000010fc4 <t_setutf8>:
   10fc4: b7 b5 01 00  	lui	a1, 27
   10fc8: 13 01 01 ff  	addi	sp, sp, -16
   10fcc: 93 85 85 82  	addi	a1, a1, -2008
   10fd0: 13 05 00 00  	li	a0, 0
   10fd4: 23 30 81 00  	sd	s0, 0(sp)
   10fd8: 23 34 11 00  	sd	ra, 8(sp)
   10fdc: ef 00 d0 13  	jal	0x11918 <setlocale>
   10fe0: 37 b4 01 00  	lui	s0, 27
   10fe4: 63 1e 05 04  	bnez	a0, 0x11040 <t_setutf8+0x7c>
   10fe8: b7 b5 01 00  	lui	a1, 27
   10fec: 93 85 05 83  	addi	a1, a1, -2000
   10ff0: ef 00 90 12  	jal	0x11918 <setlocale>
   10ff4: 63 16 05 04  	bnez	a0, 0x11040 <t_setutf8+0x7c>
   10ff8: b7 b5 01 00  	lui	a1, 27
   10ffc: 93 85 05 84  	addi	a1, a1, -1984
   11000: ef 00 90 11  	jal	0x11918 <setlocale>
   11004: 63 1e 05 02  	bnez	a0, 0x11040 <t_setutf8+0x7c>
   11008: b7 b5 01 00  	lui	a1, 27
   1100c: 93 85 05 85  	addi	a1, a1, -1968
   11010: ef 00 90 10  	jal	0x11918 <setlocale>
   11014: 63 16 05 02  	bnez	a0, 0x11040 <t_setutf8+0x7c>
   11018: b7 b5 01 00  	lui	a1, 27
   1101c: 93 85 05 86  	addi	a1, a1, -1952
   11020: ef 00 90 0f  	jal	0x11918 <setlocale>
   11024: 63 1e 05 00  	bnez	a0, 0x11040 <t_setutf8+0x7c>
   11028: 93 05 04 87  	addi	a1, s0, -1936
   1102c: ef 00 d0 0e  	jal	0x11918 <setlocale>
   11030: 63 18 05 00  	bnez	a0, 0x11040 <t_setutf8+0x7c>
   11034: b7 a5 01 00  	lui	a1, 26
   11038: 93 85 85 66  	addi	a1, a1, 1640
   1103c: ef 00 d0 0d  	jal	0x11918 <setlocale>
   11040: 13 05 e0 00  	li	a0, 14
   11044: ef 00 90 0c  	jal	0x1190c <nl_langinfo>
   11048: 93 05 04 87  	addi	a1, s0, -1936
   1104c: ef 30 40 1d  	jal	0x14220 <strcmp>
   11050: 63 04 05 02  	beqz	a0, 0x11078 <t_setutf8+0xb4>
   11054: 13 05 e0 00  	li	a0, 14
   11058: ef 00 50 0b  	jal	0x1190c <nl_langinfo>
   1105c: 03 34 01 00  	ld	s0, 0(sp)
   11060: 83 30 81 00  	ld	ra, 8(sp)
   11064: 93 05 05 00  	mv	a1, a0
   11068: 37 b5 01 00  	lui	a0, 27
   1106c: 13 05 85 87  	addi	a0, a0, -1928
   11070: 13 01 01 01  	addi	sp, sp, 16
   11074: 6f f0 df a4  	j	0x10ac0 <t_printf>
   11078: 83 30 81 00  	ld	ra, 8(sp)
   1107c: 03 34 01 00  	ld	s0, 0(sp)
   11080: 13 01 01 01  	addi	sp, sp, 16
   11084: 67 80 00 00  	ret

0000000000011088 <t_vmfill>:
   11088: 13 01 01 fb  	addi	sp, sp, -80
   1108c: 23 3c 91 02  	sd	s1, 56(sp)
   11090: 93 04 f0 ff  	li	s1, -1
   11094: 23 38 21 03  	sd	s2, 48(sp)
   11098: 23 34 31 03  	sd	s3, 40(sp)
   1109c: 23 30 41 03  	sd	s4, 32(sp)
   110a0: 23 3c 51 01  	sd	s5, 24(sp)
   110a4: 23 34 11 04  	sd	ra, 72(sp)
   110a8: 23 30 81 04  	sd	s0, 64(sp)
   110ac: 23 38 61 01  	sd	s6, 16(sp)
   110b0: 23 34 71 01  	sd	s7, 8(sp)
   110b4: 23 30 81 01  	sd	s8, 0(sp)
   110b8: 93 09 05 00  	mv	s3, a0
   110bc: 13 8a 05 00  	mv	s4, a1
   110c0: 93 0a 06 00  	mv	s5, a2
   110c4: 13 09 00 00  	li	s2, 0
   110c8: 93 94 f4 03  	slli	s1, s1, 63
   110cc: 1b 0b 09 00  	sext.w	s6, s2
   110d0: 13 84 04 00  	mv	s0, s1
   110d4: 93 8b 04 00  	mv	s7, s1
   110d8: 13 05 e0 01  	li	a0, 30
   110dc: ef 00 40 0e  	jal	0x111c0 <sysconf>
   110e0: 63 fe ab 04  	bgeu	s7, a0, 0x1113c <t_vmfill+0xb4>
   110e4: 13 05 e0 01  	li	a0, 30
   110e8: ef 00 80 0d  	jal	0x111c0 <sysconf>
   110ec: b3 07 a0 40  	neg	a5, a0
   110f0: 33 f4 87 00  	and	s0, a5, s0
   110f4: 63 0c 04 08  	beqz	s0, 0x1118c <t_vmfill+0x104>
   110f8: 93 07 00 00  	li	a5, 0
   110fc: 13 07 f0 ff  	li	a4, -1
   11100: 93 06 20 02  	li	a3, 34
   11104: 13 06 00 00  	li	a2, 0
   11108: 93 05 04 00  	mv	a1, s0
   1110c: 13 05 00 00  	li	a0, 0
   11110: ef 10 d0 60  	jal	0x12f1c <mmap64>
   11114: 93 07 f0 ff  	li	a5, -1
   11118: 63 08 f5 06  	beq	a0, a5, 0x11188 <t_vmfill+0x100>
   1111c: 63 5c 5b 01  	bge	s6, s5, 0x11134 <t_vmfill+0xac>
   11120: 93 17 39 00  	slli	a5, s2, 3
   11124: 33 87 f9 00  	add	a4, s3, a5
   11128: 23 30 a7 00  	sd	a0, 0(a4)
   1112c: b3 07 fa 00  	add	a5, s4, a5
   11130: 23 b0 87 00  	sd	s0, 0(a5)
   11134: 13 09 19 00  	addi	s2, s2, 1
   11138: 6f f0 5f f9  	j	0x110cc <t_vmfill+0x44>
   1113c: 93 07 00 00  	li	a5, 0
   11140: 13 07 f0 ff  	li	a4, -1
   11144: 93 06 20 02  	li	a3, 34
   11148: 13 06 00 00  	li	a2, 0
   1114c: 93 05 04 00  	mv	a1, s0
   11150: 13 05 00 00  	li	a0, 0
   11154: ef 10 90 5c  	jal	0x12f1c <mmap64>
   11158: 93 07 f0 ff  	li	a5, -1
   1115c: 13 dc 1b 00  	srli	s8, s7, 1
   11160: 63 18 f5 00  	bne	a0, a5, 0x11170 <t_vmfill+0xe8>
   11164: 33 04 84 41  	sub	s0, s0, s8
   11168: 93 0b 0c 00  	mv	s7, s8
   1116c: 6f f0 df f6  	j	0x110d8 <t_vmfill+0x50>
   11170: 93 05 04 00  	mv	a1, s0
   11174: ef 10 50 70  	jal	0x13078 <munmap>
   11178: 63 14 74 01  	bne	s0, s7, 0x11180 <t_vmfill+0xf8>
   1117c: 93 04 04 00  	mv	s1, s0
   11180: 33 04 84 01  	add	s0, s0, s8
   11184: 6f f0 5f fe  	j	0x11168 <t_vmfill+0xe0>
   11188: 13 0b f0 ff  	li	s6, -1
   1118c: 83 30 81 04  	ld	ra, 72(sp)
   11190: 03 34 01 04  	ld	s0, 64(sp)
   11194: 83 34 81 03  	ld	s1, 56(sp)
   11198: 03 39 01 03  	ld	s2, 48(sp)
   1119c: 83 39 81 02  	ld	s3, 40(sp)
   111a0: 03 3a 01 02  	ld	s4, 32(sp)
   111a4: 83 3a 81 01  	ld	s5, 24(sp)
   111a8: 83 3b 81 00  	ld	s7, 8(sp)
   111ac: 03 3c 01 00  	ld	s8, 0(sp)
   111b0: 13 05 0b 00  	mv	a0, s6
   111b4: 03 3b 01 01  	ld	s6, 16(sp)
   111b8: 13 01 01 05  	addi	sp, sp, 80
   111bc: 67 80 00 00  	ret

00000000000111c0 <sysconf>:
   111c0: 13 01 01 e7  	addi	sp, sp, -400
   111c4: 23 34 11 18  	sd	ra, 392(sp)
   111c8: 23 30 81 18  	sd	s0, 384(sp)
   111cc: 23 3c 91 16  	sd	s1, 376(sp)
   111d0: 93 07 80 0f  	li	a5, 248
   111d4: 63 e0 a7 02  	bltu	a5, a0, 0x111f4 <sysconf+0x34>
   111d8: 37 b7 01 00  	lui	a4, 27
   111dc: 93 17 15 00  	slli	a5, a0, 1
   111e0: 13 07 07 8f  	addi	a4, a4, -1808
   111e4: b3 07 f7 00  	add	a5, a4, a5
   111e8: 13 04 05 00  	mv	s0, a0
   111ec: 03 95 07 00  	lh	a0, 0(a5)
   111f0: 63 14 05 02  	bnez	a0, 0x11218 <sysconf+0x58>
   111f4: ef 00 c0 42  	jal	0x11620 <__errno_location>
   111f8: 93 07 60 01  	li	a5, 22
   111fc: 23 20 f5 00  	sw	a5, 0(a0)
   11200: 13 05 f0 ff  	li	a0, -1
   11204: 83 30 81 18  	ld	ra, 392(sp)
   11208: 03 34 01 18  	ld	s0, 384(sp)
   1120c: 83 34 81 17  	ld	s1, 376(sp)
   11210: 13 01 01 19  	addi	sp, sp, 400
   11214: 67 80 00 00  	ret
   11218: 93 04 f0 ff  	li	s1, -1
   1121c: 1b 07 05 00  	sext.w	a4, a0
   11220: e3 52 95 fe  	bge	a0, s1, 0x11204 <sysconf+0x44>
   11224: 93 07 00 f0  	li	a5, -256
   11228: 63 58 f7 02  	bge	a4, a5, 0x11258 <sysconf+0x98>
   1122c: 13 15 25 03  	slli	a0, a0, 50
   11230: 93 05 01 00  	mv	a1, sp
   11234: 13 55 25 03  	srli	a0, a0, 50
   11238: ef 10 d0 34  	jal	0x12d84 <getrlimit64>
   1123c: 83 37 01 00  	ld	a5, 0(sp)
   11240: 13 05 f0 ff  	li	a0, -1
   11244: e3 80 97 fc  	beq	a5, s1, 0x11204 <sysconf+0x44>
   11248: 13 85 07 00  	mv	a0, a5
   1124c: e3 dc 07 fa  	bgez	a5, 0x11204 <sysconf+0x44>
   11250: 13 d5 14 00  	srli	a0, s1, 1
   11254: 6f f0 1f fb  	j	0x11204 <sysconf+0x44>
   11258: 9b 07 f5 ff  	addiw	a5, a0, -1
   1125c: 93 f7 f7 0f  	andi	a5, a5, 255
   11260: 13 07 a0 00  	li	a4, 10
   11264: e3 60 f7 fa  	bltu	a4, a5, 0x11204 <sysconf+0x44>
   11268: 37 b7 01 00  	lui	a4, 27
   1126c: 93 97 27 00  	slli	a5, a5, 2
   11270: 13 07 07 8c  	addi	a4, a4, -1856
   11274: b3 87 e7 00  	add	a5, a5, a4
   11278: 83 a7 07 00  	lw	a5, 0(a5)
   1127c: 67 80 07 00  	jr	a5
   11280: 37 05 02 00  	lui	a0, 32
   11284: 6f f0 1f f8  	j	0x11204 <sysconf+0x44>
   11288: 37 85 00 00  	lui	a0, 8
   1128c: 6f f0 9f f7  	j	0x11204 <sysconf+0x44>
   11290: 03 b5 01 c0  	ld	a0, -1024(gp)
   11294: 6f f0 1f f7  	j	0x11204 <sysconf+0x44>
   11298: 37 05 00 80  	lui	a0, 524288
   1129c: 13 45 f5 ff  	not	a0, a0
   112a0: 6f f0 5f f6  	j	0x11204 <sysconf+0x44>
   112a4: 93 07 10 00  	li	a5, 1
   112a8: 13 06 80 07  	li	a2, 120
   112ac: 93 05 00 00  	li	a1, 0
   112b0: 13 05 81 00  	addi	a0, sp, 8
   112b4: 23 30 f1 00  	sd	a5, 0(sp)
   112b8: ef 20 d0 5c  	jal	0x14084 <memset>
   112bc: 93 08 b0 07  	li	a7, 123
   112c0: 13 05 00 00  	li	a0, 0
   112c4: 93 05 00 08  	li	a1, 128
   112c8: 13 06 01 00  	mv	a2, sp
   112cc: 73 00 00 00  	ecall	
   112d0: 13 07 00 00  	li	a4, 0
   112d4: 13 05 00 00  	li	a0, 0
   112d8: 13 06 00 08  	li	a2, 128
   112dc: 93 07 01 17  	addi	a5, sp, 368
   112e0: b3 86 e7 00  	add	a3, a5, a4
   112e4: 83 c7 06 e9  	lbu	a5, -368(a3)
   112e8: 63 98 07 00  	bnez	a5, 0x112f8 <sysconf+0x138>
   112ec: 1b 07 17 00  	addiw	a4, a4, 1
   112f0: e3 16 c7 fe  	bne	a4, a2, 0x112dc <sysconf+0x11c>
   112f4: 6f f0 1f f1  	j	0x11204 <sysconf+0x44>
   112f8: 9b 85 f7 ff  	addiw	a1, a5, -1
   112fc: b3 f7 b7 00  	and	a5, a5, a1
   11300: 23 88 f6 e8  	sb	a5, -368(a3)
   11304: 1b 05 15 00  	addiw	a0, a0, 1
   11308: 6f f0 5f fd  	j	0x112dc <sysconf+0x11c>
   1130c: 13 05 01 00  	mv	a0, sp
   11310: ef 00 40 4b  	jal	0x117c4 <sysinfo>
   11314: 83 27 81 06  	lw	a5, 104(sp)
   11318: 63 96 07 00  	bnez	a5, 0x11324 <sysconf+0x164>
   1131c: 93 07 10 00  	li	a5, 1
   11320: 23 24 f1 06  	sw	a5, 104(sp)
   11324: 93 07 50 05  	li	a5, 85
   11328: 63 14 f4 02  	bne	s0, a5, 0x11350 <sysconf+0x190>
   1132c: 83 37 01 02  	ld	a5, 32(sp)
   11330: 03 65 81 06  	lwu	a0, 104(sp)
   11334: 33 05 f5 02  	<unknown>
   11338: 83 b7 01 c0  	ld	a5, -1024(gp)
   1133c: 33 55 f5 02  	<unknown>
   11340: e3 52 05 ec  	bgez	a0, 0x11204 <sysconf+0x44>
   11344: 13 05 f0 ff  	li	a0, -1
   11348: 13 55 15 00  	srli	a0, a0, 1
   1134c: 6f f0 9f eb  	j	0x11204 <sysconf+0x44>
   11350: 03 35 81 02  	ld	a0, 40(sp)
   11354: 83 37 81 03  	ld	a5, 56(sp)
   11358: b3 07 f5 00  	add	a5, a0, a5
   1135c: 6f f0 5f fd  	j	0x11330 <sysconf+0x170>
   11360: 13 05 00 00  	li	a0, 0
   11364: 6f f0 1f ea  	j	0x11204 <sysconf+0x44>
   11368: 37 15 03 00  	lui	a0, 49
   1136c: 13 05 95 06  	addi	a0, a0, 105
   11370: 6f f0 5f e9  	j	0x11204 <sysconf+0x44>

0000000000011374 <dummy>:
   11374: 67 80 00 00  	ret

0000000000011378 <dummy1>:
   11378: 67 80 00 00  	ret

000000000001137c <__init_libc>:
   1137c: 13 01 01 e8  	addi	sp, sp, -384
   11380: 23 30 21 17  	sd	s2, 352(sp)
   11384: 13 09 01 03  	addi	s2, sp, 48
   11388: 23 38 81 16  	sd	s0, 368(sp)
   1138c: 23 34 91 16  	sd	s1, 360(sp)
   11390: 13 84 05 00  	mv	s0, a1
   11394: 93 04 05 00  	mv	s1, a0
   11398: 13 06 00 13  	li	a2, 304
   1139c: 93 05 00 00  	li	a1, 0
   113a0: 13 05 09 00  	mv	a0, s2
   113a4: 23 3c 11 16  	sd	ra, 376(sp)
   113a8: ef 20 d0 4d  	jal	0x14084 <memset>
   113ac: 23 b8 91 a2  	sd	s1, -1488(gp)
   113b0: 13 05 00 00  	li	a0, 0
   113b4: 93 17 35 00  	slli	a5, a0, 3
   113b8: b3 87 f4 00  	add	a5, s1, a5
   113bc: 83 b7 07 00  	ld	a5, 0(a5)
   113c0: 13 05 15 00  	addi	a0, a0, 1
   113c4: e3 98 07 fe  	bnez	a5, 0x113b4 <__init_libc+0x38>
   113c8: 13 15 35 00  	slli	a0, a0, 3
   113cc: 33 85 a4 00  	add	a0, s1, a0
   113d0: 93 87 81 bc  	addi	a5, gp, -1080
   113d4: 23 b8 a7 00  	sd	a0, 16(a5)
   113d8: 93 84 81 bc  	addi	s1, gp, -1080
   113dc: 13 07 50 02  	li	a4, 37
   113e0: 83 37 05 00  	ld	a5, 0(a0)
   113e4: 63 9e 07 0e  	bnez	a5, 0x114e0 <__init_libc+0x164>
   113e8: 03 37 01 0b  	ld	a4, 176(sp)
   113ec: 23 b8 e1 9a  	sd	a4, -1616(gp)
   113f0: 83 37 01 13  	ld	a5, 304(sp)
   113f4: 63 84 07 00  	beqz	a5, 0x113fc <__init_libc+0x80>
   113f8: 23 b4 f1 9a  	sd	a5, -1624(gp)
   113fc: 83 37 01 06  	ld	a5, 96(sp)
   11400: 23 bc f4 02  	sd	a5, 56(s1)
   11404: 63 1a 04 00  	bnez	s0, 0x11418 <__init_libc+0x9c>
   11408: 03 34 81 12  	ld	s0, 296(sp)
   1140c: 63 16 04 00  	bnez	s0, 0x11418 <__init_libc+0x9c>
   11410: 37 a4 01 00  	lui	s0, 26
   11414: 13 04 84 66  	addi	s0, s0, 1640
   11418: 23 b0 81 9c  	sd	s0, -1600(gp)
   1141c: 23 bc 81 9a  	sd	s0, -1608(gp)
   11420: 93 06 f0 02  	li	a3, 47
   11424: 13 04 14 00  	addi	s0, s0, 1
   11428: 03 47 f4 ff  	lbu	a4, -1(s0)
   1142c: 63 1a 07 0c  	bnez	a4, 0x11500 <__init_libc+0x184>
   11430: 13 05 09 00  	mv	a0, s2
   11434: ef 30 80 62  	jal	0x14a5c <static_init_tls>
   11438: 03 35 81 0f  	ld	a0, 248(sp)
   1143c: ef f0 df f3  	jal	0x11378 <dummy1>
   11440: 03 37 81 08  	ld	a4, 136(sp)
   11444: 83 37 01 09  	ld	a5, 144(sp)
   11448: 63 1c f7 00  	bne	a4, a5, 0x11460 <__init_libc+0xe4>
   1144c: 03 37 81 09  	ld	a4, 152(sp)
   11450: 83 37 01 0a  	ld	a5, 160(sp)
   11454: 63 16 f7 00  	bne	a4, a5, 0x11460 <__init_libc+0xe4>
   11458: 83 37 81 0e  	ld	a5, 232(sp)
   1145c: 63 82 07 0c  	beqz	a5, 0x11520 <__init_libc+0x1a4>
   11460: 23 30 01 02  	sd	zero, 32(sp)
   11464: 93 07 10 00  	li	a5, 1
   11468: 23 34 01 02  	sd	zero, 40(sp)
   1146c: 23 20 f1 02  	sw	a5, 32(sp)
   11470: 93 07 20 00  	li	a5, 2
   11474: 23 3c 01 00  	sd	zero, 24(sp)
   11478: 23 24 f1 02  	sw	a5, 40(sp)
   1147c: 23 34 01 00  	sd	zero, 8(sp)
   11480: 23 38 01 00  	sd	zero, 16(sp)
   11484: 93 08 90 04  	li	a7, 73
   11488: 13 05 81 01  	addi	a0, sp, 24
   1148c: 93 05 30 00  	li	a1, 3
   11490: 13 06 81 00  	addi	a2, sp, 8
   11494: 93 06 00 00  	li	a3, 0
   11498: 13 07 80 00  	li	a4, 8
   1149c: 73 00 00 00  	ecall	
   114a0: 1b 05 05 00  	sext.w	a0, a0
   114a4: 93 07 81 01  	addi	a5, sp, 24
   114a8: 63 48 05 02  	bltz	a0, 0x114d8 <__init_libc+0x15c>
   114ac: 37 86 00 00  	lui	a2, 8
   114b0: b7 a6 01 00  	lui	a3, 26
   114b4: 13 06 26 00  	addi	a2, a2, 2
   114b8: 03 d7 67 00  	lhu	a4, 6(a5)
   114bc: 13 77 07 02  	andi	a4, a4, 32
   114c0: 63 08 07 04  	beqz	a4, 0x11510 <__init_libc+0x194>
   114c4: 93 08 80 03  	li	a7, 56
   114c8: 13 05 c0 f9  	li	a0, -100
   114cc: 93 85 06 67  	addi	a1, a3, 1648
   114d0: 73 00 00 00  	ecall	
   114d4: 63 5e 05 02  	bgez	a0, 0x11510 <__init_libc+0x194>
   114d8: 23 00 00 00  	sb	zero, 0(zero)
   114dc: 73 00 10 00  	ebreak	
   114e0: 63 6c f7 00  	bltu	a4, a5, 0x114f8 <__init_libc+0x17c>
   114e4: 93 06 01 16  	addi	a3, sp, 352
   114e8: 93 97 37 00  	slli	a5, a5, 3
   114ec: b3 87 f6 00  	add	a5, a3, a5
   114f0: 83 36 85 00  	ld	a3, 8(a0)
   114f4: 23 b8 d7 ec  	sd	a3, -304(a5)
   114f8: 13 05 05 01  	addi	a0, a0, 16
   114fc: 6f f0 5f ee  	j	0x113e0 <__init_libc+0x64>
   11500: 63 14 d7 00  	bne	a4, a3, 0x11508 <__init_libc+0x18c>
   11504: 23 bc 81 9a  	sd	s0, -1608(gp)
   11508: 13 04 14 00  	addi	s0, s0, 1
   1150c: 6f f0 df f1  	j	0x11428 <__init_libc+0xac>
   11510: 93 87 87 00  	addi	a5, a5, 8
   11514: e3 12 f9 fa  	bne	s2, a5, 0x114b8 <__init_libc+0x13c>
   11518: 93 07 10 00  	li	a5, 1
   1151c: 23 a4 f4 00  	sw	a5, 8(s1)
   11520: 83 30 81 17  	ld	ra, 376(sp)
   11524: 03 34 01 17  	ld	s0, 368(sp)
   11528: 83 34 81 16  	ld	s1, 360(sp)
   1152c: 03 39 01 16  	ld	s2, 352(sp)
   11530: 13 01 01 18  	addi	sp, sp, 384
   11534: 67 80 00 00  	ret

0000000000011538 <libc_start_init>:
   11538: 13 01 01 fe  	addi	sp, sp, -32
   1153c: 23 38 81 00  	sd	s0, 16(sp)
   11540: 23 34 91 00  	sd	s1, 8(sp)
   11544: 37 d4 01 00  	lui	s0, 29
   11548: b7 d4 01 00  	lui	s1, 29
   1154c: 23 3c 11 00  	sd	ra, 24(sp)
   11550: 13 04 04 ff  	addi	s0, s0, -16
   11554: ef f0 1f e2  	jal	0x11374 <dummy>
   11558: 93 84 84 ff  	addi	s1, s1, -8
   1155c: 63 6c 94 00  	bltu	s0, s1, 0x11574 <libc_start_init+0x3c>
   11560: 83 30 81 01  	ld	ra, 24(sp)
   11564: 03 34 01 01  	ld	s0, 16(sp)
   11568: 83 34 81 00  	ld	s1, 8(sp)
   1156c: 13 01 01 02  	addi	sp, sp, 32
   11570: 67 80 00 00  	ret
   11574: 83 37 04 00  	ld	a5, 0(s0)
   11578: 13 04 84 00  	addi	s0, s0, 8
   1157c: e7 80 07 00  	jalr	a5
   11580: 6f f0 df fd  	j	0x1155c <libc_start_init+0x24>

0000000000011584 <libc_start_main_stage2>:
   11584: 13 01 01 fd  	addi	sp, sp, -48
   11588: 23 30 81 02  	sd	s0, 32(sp)
   1158c: 13 84 15 00  	addi	s0, a1, 1
   11590: 13 14 34 00  	slli	s0, s0, 3
   11594: 23 34 11 02  	sd	ra, 40(sp)
   11598: 23 3c 91 00  	sd	s1, 24(sp)
   1159c: 23 38 21 01  	sd	s2, 16(sp)
   115a0: 93 84 05 00  	mv	s1, a1
   115a4: 13 09 05 00  	mv	s2, a0
   115a8: 33 04 86 00  	add	s0, a2, s0
   115ac: 23 34 c1 00  	sd	a2, 8(sp)
   115b0: ef f0 9f f8  	jal	0x11538 <libc_start_init>
   115b4: 83 35 81 00  	ld	a1, 8(sp)
   115b8: 13 06 04 00  	mv	a2, s0
   115bc: 13 85 04 00  	mv	a0, s1
   115c0: e7 00 09 00  	jalr	s2
   115c4: ef e0 df b5  	jal	0x10120 <exit>

00000000000115c8 <__libc_start_main>:
   115c8: 13 01 01 fd  	addi	sp, sp, -48
   115cc: 23 30 81 02  	sd	s0, 32(sp)
   115d0: 23 3c 91 00  	sd	s1, 24(sp)
   115d4: 13 84 05 00  	mv	s0, a1
   115d8: 93 04 05 00  	mv	s1, a0
   115dc: 13 85 15 00  	addi	a0, a1, 1
   115e0: 83 35 06 00  	ld	a1, 0(a2)
   115e4: 13 15 35 00  	slli	a0, a0, 3
   115e8: 33 05 a6 00  	add	a0, a2, a0
   115ec: 23 34 11 02  	sd	ra, 40(sp)
   115f0: 23 34 c1 00  	sd	a2, 8(sp)
   115f4: ef f0 9f d8  	jal	0x1137c <__init_libc>
   115f8: b7 17 01 00  	lui	a5, 17
   115fc: 93 87 47 58  	addi	a5, a5, 1412
   11600: 93 05 04 00  	mv	a1, s0
   11604: 03 34 01 02  	ld	s0, 32(sp)
   11608: 03 36 81 00  	ld	a2, 8(sp)
   1160c: 83 30 81 02  	ld	ra, 40(sp)
   11610: 13 85 04 00  	mv	a0, s1
   11614: 83 34 81 01  	ld	s1, 24(sp)
   11618: 13 01 01 03  	addi	sp, sp, 48
   1161c: 67 80 07 00  	jr	a5

0000000000011620 <__errno_location>:
   11620: 13 05 02 00  	mv	a0, tp
   11624: 13 05 c5 f5  	addi	a0, a0, -164
   11628: 67 80 00 00  	ret

000000000001162c <strerror_l>:
   1162c: b7 b6 01 00  	lui	a3, 27
   11630: 93 07 00 00  	li	a5, 0
   11634: 93 86 86 ae  	addi	a3, a3, -1304
   11638: 33 86 f6 00  	add	a2, a3, a5
   1163c: 03 46 06 00  	lbu	a2, 0(a2)
   11640: 1b 87 07 00  	sext.w	a4, a5
   11644: 63 06 06 00  	beqz	a2, 0x11650 <strerror_l+0x24>
   11648: 93 87 17 00  	addi	a5, a5, 1
   1164c: e3 16 a6 fe  	bne	a2, a0, 0x11638 <strerror_l+0xc>
   11650: 37 b5 01 00  	lui	a0, 27
   11654: 13 05 85 b4  	addi	a0, a0, -1208
   11658: 6f 00 40 01  	j	0x1166c <strerror_l+0x40>
   1165c: 83 47 05 00  	lbu	a5, 0(a0)
   11660: 13 05 15 00  	addi	a0, a0, 1
   11664: e3 9c 07 fe  	bnez	a5, 0x1165c <strerror_l+0x30>
   11668: 1b 07 f7 ff  	addiw	a4, a4, -1
   1166c: e3 18 07 fe  	bnez	a4, 0x1165c <strerror_l+0x30>
   11670: 83 b5 85 02  	ld	a1, 40(a1)
   11674: 6f 00 80 17  	j	0x117ec <__lctrans>

0000000000011678 <strerror>:
   11678: 93 07 02 00  	mv	a5, tp
   1167c: 83 b5 07 fd  	ld	a1, -48(a5)
   11680: 6f f0 df fa  	j	0x1162c <strerror_l>

0000000000011684 <dummy>:
   11684: 67 80 00 00  	ret

0000000000011688 <libc_exit_fini>:
   11688: 13 01 01 fe  	addi	sp, sp, -32
   1168c: 23 38 81 00  	sd	s0, 16(sp)
   11690: 23 34 91 00  	sd	s1, 8(sp)
   11694: 37 d4 01 00  	lui	s0, 29
   11698: b7 d4 01 00  	lui	s1, 29
   1169c: 23 3c 11 00  	sd	ra, 24(sp)
   116a0: 13 04 04 00  	mv	s0, s0
   116a4: 93 84 84 ff  	addi	s1, s1, -8
   116a8: 63 ec 84 00  	bltu	s1, s0, 0x116c0 <libc_exit_fini+0x38>
   116ac: 03 34 01 01  	ld	s0, 16(sp)
   116b0: 83 30 81 01  	ld	ra, 24(sp)
   116b4: 83 34 81 00  	ld	s1, 8(sp)
   116b8: 13 01 01 02  	addi	sp, sp, 32
   116bc: 6f f0 9f fc  	j	0x11684 <dummy>
   116c0: 83 37 84 ff  	ld	a5, -8(s0)
   116c4: 13 04 84 ff  	addi	s0, s0, -8
   116c8: e7 80 07 00  	jalr	a5
   116cc: 6f f0 df fd  	j	0x116a8 <libc_exit_fini+0x20>

00000000000116d0 <open64>:
   116d0: 13 01 01 fb  	addi	sp, sp, -80
   116d4: 23 38 81 00  	sd	s0, 16(sp)
   116d8: 23 3c f1 02  	sd	a5, 56(sp)
   116dc: 23 3c 11 00  	sd	ra, 24(sp)
   116e0: 23 30 c1 02  	sd	a2, 32(sp)
   116e4: 23 34 d1 02  	sd	a3, 40(sp)
   116e8: 23 38 e1 02  	sd	a4, 48(sp)
   116ec: 23 30 01 05  	sd	a6, 64(sp)
   116f0: 23 34 11 05  	sd	a7, 72(sp)
   116f4: 93 f7 05 04  	andi	a5, a1, 64
   116f8: 13 84 05 00  	mv	s0, a1
   116fc: 63 9c 07 00  	bnez	a5, 0x11714 <open64+0x44>
   11700: b7 07 41 00  	lui	a5, 1040
   11704: b3 f7 f5 00  	and	a5, a1, a5
   11708: b7 06 41 00  	lui	a3, 1040
   1170c: 13 07 00 00  	li	a4, 0
   11710: 63 98 d7 00  	bne	a5, a3, 0x11720 <open64+0x50>
   11714: 03 27 01 02  	lw	a4, 32(sp)
   11718: 93 07 01 02  	addi	a5, sp, 32
   1171c: 23 34 f1 00  	sd	a5, 8(sp)
   11720: 13 17 07 02  	slli	a4, a4, 32
   11724: b7 86 00 00  	lui	a3, 8
   11728: 93 07 00 00  	li	a5, 0
   1172c: 13 06 05 00  	mv	a2, a0
   11730: 13 08 00 00  	li	a6, 0
   11734: 13 57 07 02  	srli	a4, a4, 32
   11738: b3 66 d4 00  	or	a3, s0, a3
   1173c: 93 05 c0 f9  	li	a1, -100
   11740: 13 05 80 03  	li	a0, 56
   11744: ef 20 d0 55  	jal	0x144a0 <__syscall_cp>
   11748: 9b 07 05 00  	sext.w	a5, a0
   1174c: 63 c2 07 02  	bltz	a5, 0x11770 <open64+0xa0>
   11750: 13 54 34 01  	srli	s0, s0, 19
   11754: 13 74 14 00  	andi	s0, s0, 1
   11758: 63 0c 04 00  	beqz	s0, 0x11770 <open64+0xa0>
   1175c: 93 08 90 01  	li	a7, 25
   11760: 13 85 07 00  	mv	a0, a5
   11764: 93 05 20 00  	li	a1, 2
   11768: 13 06 10 00  	li	a2, 1
   1176c: 73 00 00 00  	ecall	
   11770: 13 85 07 00  	mv	a0, a5
   11774: ef 00 80 01  	jal	0x1178c <__syscall_ret>
   11778: 83 30 81 01  	ld	ra, 24(sp)
   1177c: 03 34 01 01  	ld	s0, 16(sp)
   11780: 1b 05 05 00  	sext.w	a0, a0
   11784: 13 01 01 05  	addi	sp, sp, 80
   11788: 67 80 00 00  	ret

000000000001178c <__syscall_ret>:
   1178c: 13 01 01 ff  	addi	sp, sp, -16
   11790: 23 30 81 00  	sd	s0, 0(sp)
   11794: 23 34 11 00  	sd	ra, 8(sp)
   11798: b7 f7 ff ff  	lui	a5, 1048575
   1179c: 13 04 05 00  	mv	s0, a0
   117a0: 63 fa a7 00  	bgeu	a5, a0, 0x117b4 <__syscall_ret+0x28>
   117a4: ef f0 df e7  	jal	0x11620 <__errno_location>
   117a8: 3b 04 80 40  	negw	s0, s0
   117ac: 23 20 85 00  	sw	s0, 0(a0)
   117b0: 13 05 f0 ff  	li	a0, -1
   117b4: 83 30 81 00  	ld	ra, 8(sp)
   117b8: 03 34 01 00  	ld	s0, 0(sp)
   117bc: 13 01 01 01  	addi	sp, sp, 16
   117c0: 67 80 00 00  	ret

00000000000117c4 <sysinfo>:
   117c4: 13 01 01 ff  	addi	sp, sp, -16
   117c8: 23 34 11 00  	sd	ra, 8(sp)
   117cc: 93 08 30 0b  	li	a7, 179
   117d0: 73 00 00 00  	ecall	
   117d4: ef f0 9f fb  	jal	0x1178c <__syscall_ret>
   117d8: 83 30 81 00  	ld	ra, 8(sp)
   117dc: 1b 05 05 00  	sext.w	a0, a0
   117e0: 13 01 01 01  	addi	sp, sp, 16
   117e4: 67 80 00 00  	ret

00000000000117e8 <dummy>:
   117e8: 67 80 00 00  	ret

00000000000117ec <__lctrans>:
   117ec: 6f 30 40 42  	j	0x14c10 <__lctrans_impl>

00000000000117f0 <__lctrans_cur>:
   117f0: 93 07 02 00  	mv	a5, tp
   117f4: 83 b7 07 fd  	ld	a5, -48(a5)
   117f8: 83 b5 87 02  	ld	a1, 40(a5)
   117fc: 6f 30 40 41  	j	0x14c10 <__lctrans_impl>

0000000000011800 <nl_langinfo_l>:
   11800: 37 07 01 00  	lui	a4, 16
   11804: 13 06 f7 ff  	addi	a2, a4, -1
   11808: 13 08 e0 00  	li	a6, 14
   1180c: 93 57 05 41  	srai	a5, a0, 16
   11810: b3 76 c5 00  	and	a3, a0, a2
   11814: 63 1c 05 01  	bne	a0, a6, 0x1182c <nl_langinfo_l+0x2c>
   11818: 83 b7 05 00  	ld	a5, 0(a1)
   1181c: 63 9c 07 0c  	bnez	a5, 0x118f4 <nl_langinfo_l+0xf4>
   11820: 37 b5 01 00  	lui	a0, 27
   11824: 13 05 05 27  	addi	a0, a0, 624
   11828: 67 80 00 00  	ret
   1182c: 63 92 c6 02  	bne	a3, a2, 0x11850 <nl_langinfo_l+0x50>
   11830: 13 07 50 00  	li	a4, 5
   11834: 63 48 f7 02  	blt	a4, a5, 0x11864 <nl_langinfo_l+0x64>
   11838: 93 97 37 00  	slli	a5, a5, 3
   1183c: b3 87 f5 00  	add	a5, a1, a5
   11840: 03 b5 07 00  	ld	a0, 0(a5)
   11844: 63 0e 05 0a  	beqz	a0, 0x11900 <nl_langinfo_l+0x100>
   11848: 13 05 05 01  	addi	a0, a0, 16
   1184c: 67 80 00 00  	ret
   11850: 13 06 20 00  	li	a2, 2
   11854: 63 8c c7 06  	beq	a5, a2, 0x118cc <nl_langinfo_l+0xcc>
   11858: 63 4c f6 00  	blt	a2, a5, 0x11870 <nl_langinfo_l+0x70>
   1185c: 13 06 10 00  	li	a2, 1
   11860: 63 8c c7 02  	beq	a5, a2, 0x11898 <nl_langinfo_l+0x98>
   11864: 37 a5 01 00  	lui	a0, 26
   11868: 13 05 85 66  	addi	a0, a0, 1640
   1186c: 67 80 00 00  	ret
   11870: 13 06 40 00  	li	a2, 4
   11874: e3 88 c7 fe  	beq	a5, a2, 0x11864 <nl_langinfo_l+0x64>
   11878: 13 06 50 00  	li	a2, 5
   1187c: e3 94 c7 fe  	bne	a5, a2, 0x11864 <nl_langinfo_l+0x64>
   11880: 13 07 c7 ff  	addi	a4, a4, -4
   11884: 33 75 e5 00  	and	a0, a0, a4
   11888: e3 1e 05 fc  	bnez	a0, 0x11864 <nl_langinfo_l+0x64>
   1188c: 37 b5 01 00  	lui	a0, 27
   11890: 13 05 85 27  	addi	a0, a0, 632
   11894: 6f 00 40 01  	j	0x118a8 <nl_langinfo_l+0xa8>
   11898: 13 07 e7 ff  	addi	a4, a4, -2
   1189c: 33 75 e5 00  	and	a0, a0, a4
   118a0: e3 12 05 fc  	bnez	a0, 0x11864 <nl_langinfo_l+0x64>
   118a4: 13 85 81 95  	addi	a0, gp, -1704
   118a8: 63 9c 06 02  	bnez	a3, 0x118e0 <nl_langinfo_l+0xe0>
   118ac: 13 07 10 00  	li	a4, 1
   118b0: e3 8e e7 fa  	beq	a5, a4, 0x1186c <nl_langinfo_l+0x6c>
   118b4: 03 47 05 00  	lbu	a4, 0(a0)
   118b8: e3 0a 07 fa  	beqz	a4, 0x1186c <nl_langinfo_l+0x6c>
   118bc: 93 97 37 00  	slli	a5, a5, 3
   118c0: b3 87 f5 00  	add	a5, a1, a5
   118c4: 83 b5 07 00  	ld	a1, 0(a5)
   118c8: 6f f0 5f f2  	j	0x117ec <__lctrans>
   118cc: 13 07 10 03  	li	a4, 49
   118d0: e3 4a d7 f8  	blt	a4, a3, 0x11864 <nl_langinfo_l+0x64>
   118d4: 37 b5 01 00  	lui	a0, 27
   118d8: 13 05 05 29  	addi	a0, a0, 656
   118dc: 6f f0 df fc  	j	0x118a8 <nl_langinfo_l+0xa8>
   118e0: 03 47 05 00  	lbu	a4, 0(a0)
   118e4: 13 05 15 00  	addi	a0, a0, 1
   118e8: e3 1c 07 fe  	bnez	a4, 0x118e0 <nl_langinfo_l+0xe0>
   118ec: 9b 86 f6 ff  	addiw	a3, a3, -1
   118f0: 6f f0 9f fb  	j	0x118a8 <nl_langinfo_l+0xa8>
   118f4: 37 b5 01 00  	lui	a0, 27
   118f8: 13 05 05 87  	addi	a0, a0, -1936
   118fc: 67 80 00 00  	ret
   11900: 37 b5 01 00  	lui	a0, 27
   11904: 13 05 85 26  	addi	a0, a0, 616
   11908: 67 80 00 00  	ret

000000000001190c <nl_langinfo>:
   1190c: 93 07 02 00  	mv	a5, tp
   11910: 83 b5 07 fd  	ld	a1, -48(a5)
   11914: 6f f0 df ee  	j	0x11800 <nl_langinfo_l>

0000000000011918 <setlocale>:
   11918: 13 01 01 f5  	addi	sp, sp, -176
   1191c: 23 30 41 09  	sd	s4, 128(sp)
   11920: 23 34 11 0a  	sd	ra, 168(sp)
   11924: 23 30 81 0a  	sd	s0, 160(sp)
   11928: 23 3c 91 08  	sd	s1, 152(sp)
   1192c: 23 38 21 09  	sd	s2, 144(sp)
   11930: 23 34 31 09  	sd	s3, 136(sp)
   11934: 23 3c 51 07  	sd	s5, 120(sp)
   11938: 23 38 61 07  	sd	s6, 112(sp)
   1193c: 23 34 71 07  	sd	s7, 104(sp)
   11940: 23 30 81 07  	sd	s8, 96(sp)
   11944: 23 3c 91 05  	sd	s9, 88(sp)
   11948: 23 38 a1 05  	sd	s10, 80(sp)
   1194c: 13 0a 60 00  	li	s4, 6
   11950: 63 62 aa 0a  	bltu	s4, a0, 0x119f4 <setlocale+0xdc>
   11954: 13 04 05 00  	mv	s0, a0
   11958: 13 85 81 9c  	addi	a0, gp, -1592
   1195c: 93 84 05 00  	mv	s1, a1
   11960: 13 89 09 00  	mv	s2, s3
   11964: ef 20 d0 1a  	jal	0x14310 <__lock>
   11968: 63 1e 44 17  	bne	s0, s4, 0x11ae4 <setlocale+0x1cc>
   1196c: 63 88 04 0a  	beqz	s1, 0x11a1c <setlocale+0x104>
   11970: b7 b7 01 00  	lui	a5, 27
   11974: 83 b7 07 3d  	ld	a5, 976(a5)
   11978: 93 0a 01 02  	addi	s5, sp, 32
   1197c: 23 38 01 00  	sd	zero, 16(sp)
   11980: 23 34 f1 00  	sd	a5, 8(sp)
   11984: 23 3c 01 00  	sd	zero, 24(sp)
   11988: 13 0a 00 00  	li	s4, 0
   1198c: 13 8b 0a 00  	mv	s6, s5
   11990: 13 0c 70 01  	li	s8, 23
   11994: 93 0c f0 ff  	li	s9, -1
   11998: 93 0b 60 00  	li	s7, 6
   1199c: 93 05 b0 03  	li	a1, 59
   119a0: 13 85 04 00  	mv	a0, s1
   119a4: ef 20 80 7d  	jal	0x1417c <strchrnul>
   119a8: b3 09 95 40  	sub	s3, a0, s1
   119ac: 13 04 05 00  	mv	s0, a0
   119b0: 63 46 3c 03  	blt	s8, s3, 0x119dc <setlocale+0xc4>
   119b4: 13 86 09 00  	mv	a2, s3
   119b8: 93 85 04 00  	mv	a1, s1
   119bc: 13 05 81 00  	addi	a0, sp, 8
   119c0: ef 20 00 28  	jal	0x13c40 <memcpy>
   119c4: 93 07 01 05  	addi	a5, sp, 80
   119c8: b3 89 37 01  	add	s3, a5, s3
   119cc: 23 8c 09 fa  	sb	zero, -72(s3)
   119d0: 83 47 04 00  	lbu	a5, 0(s0)
   119d4: 63 84 07 00  	beqz	a5, 0x119dc <setlocale+0xc4>
   119d8: 93 04 14 00  	addi	s1, s0, 1
   119dc: 93 05 81 00  	addi	a1, sp, 8
   119e0: 13 05 0a 00  	mv	a0, s4
   119e4: ef 30 00 27  	jal	0x14c54 <__get_locale>
   119e8: 63 1a 95 01  	bne	a0, s9, 0x119fc <setlocale+0xe4>
   119ec: 13 85 81 9c  	addi	a0, gp, -1592
   119f0: ef 20 90 21  	jal	0x14408 <__unlock>
   119f4: 13 04 00 00  	li	s0, 0
   119f8: 6f 00 00 0b  	j	0x11aa8 <setlocale+0x190>
   119fc: 23 b0 aa 00  	sd	a0, 0(s5)
   11a00: 1b 0a 1a 00  	addiw	s4, s4, 1
   11a04: 93 8a 8a 00  	addi	s5, s5, 8
   11a08: e3 1a 7a f9  	bne	s4, s7, 0x1199c <setlocale+0x84>
   11a0c: 13 06 00 03  	li	a2, 48
   11a10: 93 05 0b 00  	mv	a1, s6
   11a14: 13 85 81 c0  	addi	a0, gp, -1016
   11a18: ef 20 80 22  	jal	0x13c40 <memcpy>
   11a1c: 13 8a 81 bc  	addi	s4, gp, -1080
   11a20: 37 bc 01 00  	lui	s8, 27
   11a24: 93 89 81 c3  	addi	s3, gp, -968
   11a28: 93 0c 0a 03  	addi	s9, s4, 48
   11a2c: 93 0b 00 00  	li	s7, 0
   11a30: 13 8b 81 bc  	addi	s6, gp, -1080
   11a34: 93 8a 81 c3  	addi	s5, gp, -968
   11a38: 13 0c 8c 26  	addi	s8, s8, 616
   11a3c: 13 0d b0 03  	li	s10, 59
   11a40: 83 37 0a 04  	ld	a5, 64(s4)
   11a44: 03 37 0b 04  	ld	a4, 64(s6)
   11a48: 63 14 f7 00  	bne	a4, a5, 0x11a50 <setlocale+0x138>
   11a4c: 9b 8b 1b 00  	addiw	s7, s7, 1
   11a50: 13 04 0c 00  	mv	s0, s8
   11a54: 63 84 07 00  	beqz	a5, 0x11a5c <setlocale+0x144>
   11a58: 13 84 07 01  	addi	s0, a5, 16
   11a5c: 13 05 04 00  	mv	a0, s0
   11a60: ef 20 40 7e  	jal	0x14244 <strlen>
   11a64: 93 04 05 00  	mv	s1, a0
   11a68: 13 06 05 00  	mv	a2, a0
   11a6c: 93 05 04 00  	mv	a1, s0
   11a70: 13 85 09 00  	mv	a0, s3
   11a74: ef 20 c0 1c  	jal	0x13c40 <memcpy>
   11a78: b3 87 99 00  	add	a5, s3, s1
   11a7c: 23 80 a7 01  	sb	s10, 0(a5)
   11a80: 93 84 14 00  	addi	s1, s1, 1
   11a84: 13 0a 8a 00  	addi	s4, s4, 8
   11a88: b3 89 99 00  	add	s3, s3, s1
   11a8c: e3 9a 4c fb  	bne	s9, s4, 0x11a40 <setlocale+0x128>
   11a90: a3 8f 09 fe  	sb	zero, -1(s3)
   11a94: 13 85 81 9c  	addi	a0, gp, -1592
   11a98: ef 20 10 17  	jal	0x14408 <__unlock>
   11a9c: 93 07 60 00  	li	a5, 6
   11aa0: 63 84 fb 00  	beq	s7, a5, 0x11aa8 <setlocale+0x190>
   11aa4: 13 84 0a 00  	mv	s0, s5
   11aa8: 83 30 81 0a  	ld	ra, 168(sp)
   11aac: 13 05 04 00  	mv	a0, s0
   11ab0: 03 34 01 0a  	ld	s0, 160(sp)
   11ab4: 83 34 81 09  	ld	s1, 152(sp)
   11ab8: 03 39 01 09  	ld	s2, 144(sp)
   11abc: 83 39 81 08  	ld	s3, 136(sp)
   11ac0: 03 3a 01 08  	ld	s4, 128(sp)
   11ac4: 83 3a 81 07  	ld	s5, 120(sp)
   11ac8: 03 3b 01 07  	ld	s6, 112(sp)
   11acc: 83 3b 81 06  	ld	s7, 104(sp)
   11ad0: 03 3c 01 06  	ld	s8, 96(sp)
   11ad4: 83 3c 81 05  	ld	s9, 88(sp)
   11ad8: 03 3d 01 05  	ld	s10, 80(sp)
   11adc: 13 01 01 0b  	addi	sp, sp, 176
   11ae0: 67 80 00 00  	ret
   11ae4: 63 88 04 04  	beqz	s1, 0x11b34 <setlocale+0x21c>
   11ae8: 93 85 04 00  	mv	a1, s1
   11aec: 13 05 04 00  	mv	a0, s0
   11af0: ef 30 40 16  	jal	0x14c54 <__get_locale>
   11af4: 93 07 f0 ff  	li	a5, -1
   11af8: 63 16 f5 00  	bne	a0, a5, 0x11b04 <setlocale+0x1ec>
   11afc: 13 85 81 9c  	addi	a0, gp, -1592
   11b00: 6f f0 1f ef  	j	0x119f0 <setlocale+0xd8>
   11b04: 13 04 84 00  	addi	s0, s0, 8
   11b08: 13 14 34 00  	slli	s0, s0, 3
   11b0c: 93 87 81 bc  	addi	a5, gp, -1080
   11b10: 33 84 87 00  	add	s0, a5, s0
   11b14: 23 30 a4 00  	sd	a0, 0(s0)
   11b18: 13 04 05 01  	addi	s0, a0, 16
   11b1c: 63 16 05 00  	bnez	a0, 0x11b28 <setlocale+0x210>
   11b20: 37 b4 01 00  	lui	s0, 27
   11b24: 13 04 84 26  	addi	s0, s0, 616
   11b28: 13 85 81 9c  	addi	a0, gp, -1592
   11b2c: ef 20 d0 0d  	jal	0x14408 <__unlock>
   11b30: 6f f0 9f f7  	j	0x11aa8 <setlocale+0x190>
   11b34: 13 04 84 00  	addi	s0, s0, 8
   11b38: 13 14 34 00  	slli	s0, s0, 3
   11b3c: 93 87 81 bc  	addi	a5, gp, -1080
   11b40: 33 84 87 00  	add	s0, a5, s0
   11b44: 03 35 04 00  	ld	a0, 0(s0)
   11b48: 6f f0 1f fd  	j	0x11b18 <setlocale+0x200>

0000000000011b4c <__simple_malloc>:
   11b4c: 13 01 01 fb  	addi	sp, sp, -80
   11b50: 23 3c 91 02  	sd	s1, 56(sp)
   11b54: 23 3c 51 01  	sd	s5, 24(sp)
   11b58: 23 34 11 04  	sd	ra, 72(sp)
   11b5c: 23 30 81 04  	sd	s0, 64(sp)
   11b60: 23 38 21 03  	sd	s2, 48(sp)
   11b64: 23 34 31 03  	sd	s3, 40(sp)
   11b68: 23 30 41 03  	sd	s4, 32(sp)
   11b6c: 93 0a 05 00  	mv	s5, a0
   11b70: 93 04 10 00  	li	s1, 1
   11b74: 63 04 05 00  	beqz	a0, 0x11b7c <__simple_malloc+0x30>
   11b78: 93 04 05 00  	mv	s1, a0
   11b7c: 93 07 50 00  	li	a5, 5
   11b80: 13 04 10 00  	li	s0, 1
   11b84: 63 62 94 08  	bltu	s0, s1, 0x11c08 <__simple_malloc+0xbc>
   11b88: 13 85 01 9e  	addi	a0, gp, -1568
   11b8c: ef 20 40 78  	jal	0x14310 <__lock>
   11b90: 03 b7 01 9d  	ld	a4, -1584(gp)
   11b94: 93 07 f0 ff  	li	a5, -1
   11b98: 93 97 f7 03  	slli	a5, a5, 63
   11b9c: b3 09 e0 40  	neg	s3, a4
   11ba0: 13 04 f4 ff  	addi	s0, s0, -1
   11ba4: 93 87 f7 00  	addi	a5, a5, 15
   11ba8: b3 f9 89 00  	and	s3, s3, s0
   11bac: 13 89 01 9d  	addi	s2, gp, -1584
   11bb0: 63 f4 57 07  	bgeu	a5, s5, 0x11c18 <__simple_malloc+0xcc>
   11bb4: 83 b7 81 9d  	ld	a5, -1576(gp)
   11bb8: 93 8a 81 9d  	addi	s5, gp, -1576
   11bbc: b3 87 e7 40  	sub	a5, a5, a4
   11bc0: 63 f0 97 08  	bgeu	a5, s1, 0x11c40 <__simple_malloc+0xf4>
   11bc4: 13 05 81 00  	addi	a0, sp, 8
   11bc8: 23 34 91 00  	sd	s1, 8(sp)
   11bcc: ef 30 40 3b  	jal	0x14f80 <__expand_heap>
   11bd0: 13 04 05 00  	mv	s0, a0
   11bd4: 63 16 05 04  	bnez	a0, 0x11c20 <__simple_malloc+0xd4>
   11bd8: 13 85 01 9e  	addi	a0, gp, -1568
   11bdc: ef 20 d0 02  	jal	0x14408 <__unlock>
   11be0: 83 30 81 04  	ld	ra, 72(sp)
   11be4: 13 05 04 00  	mv	a0, s0
   11be8: 03 34 01 04  	ld	s0, 64(sp)
   11bec: 83 34 81 03  	ld	s1, 56(sp)
   11bf0: 03 39 01 03  	ld	s2, 48(sp)
   11bf4: 83 39 81 02  	ld	s3, 40(sp)
   11bf8: 03 3a 01 02  	ld	s4, 32(sp)
   11bfc: 83 3a 81 01  	ld	s5, 24(sp)
   11c00: 13 01 01 05  	addi	sp, sp, 80
   11c04: 67 80 00 00  	ret
   11c08: 9b 87 f7 ff  	addiw	a5, a5, -1
   11c0c: e3 8e 07 f6  	beqz	a5, 0x11b88 <__simple_malloc+0x3c>
   11c10: 13 14 14 00  	slli	s0, s0, 1
   11c14: 6f f0 1f f7  	j	0x11b84 <__simple_malloc+0x38>
   11c18: b3 84 34 01  	add	s1, s1, s3
   11c1c: 6f f0 9f f9  	j	0x11bb4 <__simple_malloc+0x68>
   11c20: 83 b7 0a 00  	ld	a5, 0(s5)
   11c24: 63 88 a7 00  	beq	a5, a0, 0x11c34 <__simple_malloc+0xe8>
   11c28: b3 84 34 41  	sub	s1, s1, s3
   11c2c: 23 30 a9 00  	sd	a0, 0(s2)
   11c30: 93 09 00 00  	li	s3, 0
   11c34: 03 35 81 00  	ld	a0, 8(sp)
   11c38: 33 04 a4 00  	add	s0, s0, a0
   11c3c: 23 b0 8a 00  	sd	s0, 0(s5)
   11c40: 83 37 09 00  	ld	a5, 0(s2)
   11c44: 33 84 37 01  	add	s0, a5, s3
   11c48: b3 87 97 00  	add	a5, a5, s1
   11c4c: 23 30 f9 00  	sd	a5, 0(s2)
   11c50: 6f f0 9f f8  	j	0x11bd8 <__simple_malloc+0x8c>

0000000000011c54 <__simple_calloc>:
   11c54: 63 86 05 00  	beqz	a1, 0x11c60 <__simple_calloc+0xc>
   11c58: b3 37 b5 02  	<unknown>
   11c5c: 63 96 07 00  	bnez	a5, 0x11c68 <__simple_calloc+0x14>
   11c60: 33 85 a5 02  	<unknown>
   11c64: 6f f0 9f ee  	j	0x11b4c <__simple_malloc>
   11c68: 13 01 01 ff  	addi	sp, sp, -16
   11c6c: 23 34 11 00  	sd	ra, 8(sp)
   11c70: ef f0 1f 9b  	jal	0x11620 <__errno_location>
   11c74: 83 30 81 00  	ld	ra, 8(sp)
   11c78: 93 07 c0 00  	li	a5, 12
   11c7c: 23 20 f5 00  	sw	a5, 0(a0)
   11c80: 13 05 00 00  	li	a0, 0
   11c84: 13 01 01 01  	addi	sp, sp, 16
   11c88: 67 80 00 00  	ret

0000000000011c8c <bin_index>:
   11c8c: 93 57 55 00  	srli	a5, a0, 5
   11c90: 93 87 f7 ff  	addi	a5, a5, -1
   11c94: 13 07 00 02  	li	a4, 32
   11c98: 63 66 f7 00  	bltu	a4, a5, 0x11ca4 <bin_index+0x18>
   11c9c: 1b 85 07 00  	sext.w	a0, a5
   11ca0: 67 80 00 00  	ret
   11ca4: 13 07 f0 1f  	li	a4, 511
   11ca8: 63 6e f7 00  	bltu	a4, a5, 0x11cc4 <bin_index+0x38>
   11cac: 37 b7 01 00  	lui	a4, 27
   11cb0: 13 07 87 3e  	addi	a4, a4, 1000
   11cb4: 93 d7 37 00  	srli	a5, a5, 3
   11cb8: b3 07 f7 00  	add	a5, a4, a5
   11cbc: 03 c5 c7 ff  	lbu	a0, -4(a5)
   11cc0: 67 80 00 00  	ret
   11cc4: 37 27 00 00  	lui	a4, 2
   11cc8: 13 07 07 c0  	addi	a4, a4, -1024
   11ccc: 13 05 f0 03  	li	a0, 63
   11cd0: 63 6e f7 00  	bltu	a4, a5, 0x11cec <bin_index+0x60>
   11cd4: 37 b7 01 00  	lui	a4, 27
   11cd8: 93 d7 77 00  	srli	a5, a5, 7
   11cdc: 13 07 87 3e  	addi	a4, a4, 1000
   11ce0: b3 07 f7 00  	add	a5, a4, a5
   11ce4: 03 c5 c7 ff  	lbu	a0, -4(a5)
   11ce8: 1b 05 05 01  	addiw	a0, a0, 16
   11cec: 67 80 00 00  	ret

0000000000011cf0 <adjust_size>:
   11cf0: 03 b6 01 c0  	ld	a2, -1024(gp)
   11cf4: 83 37 05 00  	ld	a5, 0(a0)
   11cf8: 13 07 f0 fb  	li	a4, -65
   11cfc: 13 57 17 00  	srli	a4, a4, 1
   11d00: 93 86 f7 ff  	addi	a3, a5, -1
   11d04: 33 07 c7 40  	sub	a4, a4, a2
   11d08: 63 7e d7 02  	bgeu	a4, a3, 0x11d44 <adjust_size+0x54>
   11d0c: 63 84 07 02  	beqz	a5, 0x11d34 <adjust_size+0x44>
   11d10: 13 01 01 ff  	addi	sp, sp, -16
   11d14: 23 34 11 00  	sd	ra, 8(sp)
   11d18: ef f0 9f 90  	jal	0x11620 <__errno_location>
   11d1c: 83 30 81 00  	ld	ra, 8(sp)
   11d20: 93 07 c0 00  	li	a5, 12
   11d24: 23 20 f5 00  	sw	a5, 0(a0)
   11d28: 13 05 f0 ff  	li	a0, -1
   11d2c: 13 01 01 01  	addi	sp, sp, 16
   11d30: 67 80 00 00  	ret
   11d34: 93 07 00 02  	li	a5, 32
   11d38: 23 30 f5 00  	sd	a5, 0(a0)
   11d3c: 13 05 00 00  	li	a0, 0
   11d40: 67 80 00 00  	ret
   11d44: 93 87 f7 02  	addi	a5, a5, 47
   11d48: 93 f7 07 fe  	andi	a5, a5, -32
   11d4c: 6f f0 df fe  	j	0x11d38 <adjust_size+0x48>

0000000000011d50 <lock>:
   11d50: 93 87 81 bc  	addi	a5, gp, -1080
   11d54: 83 a7 c7 00  	lw	a5, 12(a5)
   11d58: 9b 87 07 00  	sext.w	a5, a5
   11d5c: 63 8c 07 06  	beqz	a5, 0x11dd4 <lock+0x84>
   11d60: 13 01 01 fe  	addi	sp, sp, -32
   11d64: 23 38 81 00  	sd	s0, 16(sp)
   11d68: 23 34 91 00  	sd	s1, 8(sp)
   11d6c: 23 30 21 01  	sd	s2, 0(sp)
   11d70: 23 3c 11 00  	sd	ra, 24(sp)
   11d74: 13 04 05 00  	mv	s0, a0
   11d78: 93 04 10 00  	li	s1, 1
   11d7c: 13 09 45 00  	addi	s2, a0, 4
   11d80: 83 27 04 00  	lw	a5, 0(s0)
   11d84: 9b 87 07 00  	sext.w	a5, a5
   11d88: 2f 27 04 16  	<unknown>
   11d8c: 63 16 f7 00  	bne	a4, a5, 0x11d98 <lock+0x48>
   11d90: af 26 94 1e  	<unknown>
   11d94: e3 9a 06 fe  	bnez	a3, 0x11d88 <lock+0x38>
   11d98: 1b 07 07 00  	sext.w	a4, a4
   11d9c: e3 92 e7 fe  	bne	a5, a4, 0x11d80 <lock+0x30>
   11da0: 63 9e 07 00  	bnez	a5, 0x11dbc <lock+0x6c>
   11da4: 83 30 81 01  	ld	ra, 24(sp)
   11da8: 03 34 01 01  	ld	s0, 16(sp)
   11dac: 83 34 81 00  	ld	s1, 8(sp)
   11db0: 03 39 01 00  	ld	s2, 0(sp)
   11db4: 13 01 01 02  	addi	sp, sp, 32
   11db8: 67 80 00 00  	ret
   11dbc: 93 06 10 00  	li	a3, 1
   11dc0: 13 06 10 00  	li	a2, 1
   11dc4: 93 05 09 00  	mv	a1, s2
   11dc8: 13 05 04 00  	mv	a0, s0
   11dcc: ef 20 00 70  	jal	0x144cc <__wait>
   11dd0: 6f f0 1f fb  	j	0x11d80 <lock+0x30>
   11dd4: 67 80 00 00  	ret

0000000000011dd8 <lock_bin>:
   11dd8: 13 01 01 fe  	addi	sp, sp, -32
   11ddc: 23 34 91 00  	sd	s1, 8(sp)
   11de0: 93 04 80 01  	li	s1, 24
   11de4: b3 04 95 02  	<unknown>
   11de8: 23 38 81 00  	sd	s0, 16(sp)
   11dec: 13 84 81 cc  	addi	s0, gp, -824
   11df0: 23 3c 11 00  	sd	ra, 24(sp)
   11df4: 13 85 84 00  	addi	a0, s1, 8
   11df8: 33 05 a4 00  	add	a0, s0, a0
   11dfc: ef f0 5f f5  	jal	0x11d50 <lock>
   11e00: 33 05 94 00  	add	a0, s0, s1
   11e04: 83 37 05 01  	ld	a5, 16(a0)
   11e08: 63 96 07 00  	bnez	a5, 0x11e14 <lock_bin+0x3c>
   11e0c: 23 3c a5 00  	sd	a0, 24(a0)
   11e10: 23 38 a5 00  	sd	a0, 16(a0)
   11e14: 83 30 81 01  	ld	ra, 24(sp)
   11e18: 03 34 01 01  	ld	s0, 16(sp)
   11e1c: 83 34 81 00  	ld	s1, 8(sp)
   11e20: 13 01 01 02  	addi	sp, sp, 32
   11e24: 67 80 00 00  	ret

0000000000011e28 <unlock>:
   11e28: 03 27 05 00  	lw	a4, 0(a0)
   11e2c: 93 07 05 00  	mv	a5, a0
   11e30: 1b 07 07 00  	sext.w	a4, a4
   11e34: 63 00 07 04  	beqz	a4, 0x11e74 <unlock+0x4c>
   11e38: 0f 00 30 03  	fence	rw, rw
   11e3c: 23 20 05 00  	sw	zero, 0(a0)
   11e40: 0f 00 30 03  	fence	rw, rw
   11e44: 03 27 45 00  	lw	a4, 4(a0)
   11e48: 1b 07 07 00  	sext.w	a4, a4
   11e4c: 63 04 07 02  	beqz	a4, 0x11e74 <unlock+0x4c>
   11e50: 93 08 20 06  	li	a7, 98
   11e54: 93 05 10 08  	li	a1, 129
   11e58: 13 06 10 00  	li	a2, 1
   11e5c: 73 00 00 00  	ecall	
   11e60: 13 07 a0 fd  	li	a4, -38
   11e64: 63 18 e5 00  	bne	a0, a4, 0x11e74 <unlock+0x4c>
   11e68: 13 85 07 00  	mv	a0, a5
   11e6c: 93 05 10 00  	li	a1, 1
   11e70: 73 00 00 00  	ecall	
   11e74: 67 80 00 00  	ret

0000000000011e78 <unbin>:
   11e78: 03 37 85 01  	ld	a4, 24(a0)
   11e7c: 83 37 05 01  	ld	a5, 16(a0)
   11e80: 63 10 f7 08  	bne	a4, a5, 0x11f00 <unbin+0x88>
   11e84: 93 07 10 00  	li	a5, 1
   11e88: b3 97 b7 00  	sll	a5, a5, a1
   11e8c: 93 c7 f7 ff  	not	a5, a5
   11e90: 1b 88 07 00  	sext.w	a6, a5
   11e94: 13 07 f0 ff  	li	a4, -1
   11e98: 63 06 e8 02  	beq	a6, a4, 0x11ec4 <unbin+0x4c>
   11e9c: 93 86 81 cc  	addi	a3, gp, -824
   11ea0: 03 a7 06 00  	lw	a4, 0(a3)
   11ea4: 1b 07 07 00  	sext.w	a4, a4
   11ea8: b3 75 e8 00  	and	a1, a6, a4
   11eac: 2f a6 06 16  	<unknown>
   11eb0: 63 16 e6 00  	bne	a2, a4, 0x11ebc <unbin+0x44>
   11eb4: af a8 b6 1e  	<unknown>
   11eb8: e3 9a 08 fe  	bnez	a7, 0x11eac <unbin+0x34>
   11ebc: 1b 06 06 00  	sext.w	a2, a2
   11ec0: e3 10 c7 fe  	bne	a4, a2, 0x11ea0 <unbin+0x28>
   11ec4: 93 d7 07 42  	srai	a5, a5, 32
   11ec8: 13 07 f0 ff  	li	a4, -1
   11ecc: 63 8a e7 02  	beq	a5, a4, 0x11f00 <unbin+0x88>
   11ed0: 93 86 81 cc  	addi	a3, gp, -824
   11ed4: 9b 87 07 00  	sext.w	a5, a5
   11ed8: 93 85 46 00  	addi	a1, a3, 4
   11edc: 03 a7 46 00  	lw	a4, 4(a3)
   11ee0: 1b 07 07 00  	sext.w	a4, a4
   11ee4: 33 f8 e7 00  	and	a6, a5, a4
   11ee8: 2f a6 05 16  	<unknown>
   11eec: 63 16 e6 00  	bne	a2, a4, 0x11ef8 <unbin+0x80>
   11ef0: af a8 05 1f  	<unknown>
   11ef4: e3 9a 08 fe  	bnez	a7, 0x11ee8 <unbin+0x70>
   11ef8: 1b 06 06 00  	sext.w	a2, a2
   11efc: e3 10 c7 fe  	bne	a4, a2, 0x11edc <unbin+0x64>
   11f00: 03 37 85 01  	ld	a4, 24(a0)
   11f04: 83 37 05 01  	ld	a5, 16(a0)
   11f08: 23 38 f7 00  	sd	a5, 16(a4)
   11f0c: 23 bc e7 00  	sd	a4, 24(a5)
   11f10: 83 37 85 00  	ld	a5, 8(a0)
   11f14: 13 e7 17 00  	ori	a4, a5, 1
   11f18: 93 f7 e7 ff  	andi	a5, a5, -2
   11f1c: 23 34 e5 00  	sd	a4, 8(a0)
   11f20: 33 05 f5 00  	add	a0, a0, a5
   11f24: 83 37 05 00  	ld	a5, 0(a0)
   11f28: 93 e7 17 00  	ori	a5, a5, 1
   11f2c: 23 30 f5 00  	sd	a5, 0(a0)
   11f30: 67 80 00 00  	ret

0000000000011f34 <alloc_rev>:
   11f34: 13 01 01 fc  	addi	sp, sp, -64
   11f38: 23 3c 31 01  	sd	s3, 24(sp)
   11f3c: 23 34 91 02  	sd	s1, 40(sp)
   11f40: 23 38 41 01  	sd	s4, 16(sp)
   11f44: 23 3c 11 02  	sd	ra, 56(sp)
   11f48: 23 38 81 02  	sd	s0, 48(sp)
   11f4c: 23 30 21 03  	sd	s2, 32(sp)
   11f50: 93 04 05 00  	mv	s1, a0
   11f54: 93 89 81 cc  	addi	s3, gp, -824
   11f58: 13 0a 80 01  	li	s4, 24
   11f5c: 03 b9 04 00  	ld	s2, 0(s1)
   11f60: 93 77 19 00  	andi	a5, s2, 1
   11f64: 63 86 07 00  	beqz	a5, 0x11f70 <alloc_rev+0x3c>
   11f68: 13 05 00 00  	li	a0, 0
   11f6c: 6f 00 40 04  	j	0x11fb0 <alloc_rev+0x7c>
   11f70: 13 05 09 00  	mv	a0, s2
   11f74: ef f0 9f d1  	jal	0x11c8c <bin_index>
   11f78: 23 34 a1 00  	sd	a0, 8(sp)
   11f7c: ef f0 df e5  	jal	0x11dd8 <lock_bin>
   11f80: 83 35 81 00  	ld	a1, 8(sp)
   11f84: 83 b7 04 00  	ld	a5, 0(s1)
   11f88: 33 84 45 03  	<unknown>
   11f8c: 13 04 84 00  	addi	s0, s0, 8
   11f90: 33 84 89 00  	add	s0, s3, s0
   11f94: 63 9e 27 03  	bne	a5, s2, 0x11fd0 <alloc_rev+0x9c>
   11f98: 93 f7 e7 ff  	andi	a5, a5, -2
   11f9c: 33 85 f4 40  	sub	a0, s1, a5
   11fa0: ef f0 9f ed  	jal	0x11e78 <unbin>
   11fa4: 13 05 04 00  	mv	a0, s0
   11fa8: ef f0 1f e8  	jal	0x11e28 <unlock>
   11fac: 13 05 10 00  	li	a0, 1
   11fb0: 83 30 81 03  	ld	ra, 56(sp)
   11fb4: 03 34 01 03  	ld	s0, 48(sp)
   11fb8: 83 34 81 02  	ld	s1, 40(sp)
   11fbc: 03 39 01 02  	ld	s2, 32(sp)
   11fc0: 83 39 81 01  	ld	s3, 24(sp)
   11fc4: 03 3a 01 01  	ld	s4, 16(sp)
   11fc8: 13 01 01 04  	addi	sp, sp, 64
   11fcc: 67 80 00 00  	ret
   11fd0: 13 05 04 00  	mv	a0, s0
   11fd4: ef f0 5f e5  	jal	0x11e28 <unlock>
   11fd8: 6f f0 5f f8  	j	0x11f5c <alloc_rev+0x28>

0000000000011fdc <alloc_fwd>:
   11fdc: 13 01 01 fc  	addi	sp, sp, -64
   11fe0: 23 3c 31 01  	sd	s3, 24(sp)
   11fe4: 23 34 91 02  	sd	s1, 40(sp)
   11fe8: 23 38 41 01  	sd	s4, 16(sp)
   11fec: 23 3c 11 02  	sd	ra, 56(sp)
   11ff0: 23 38 81 02  	sd	s0, 48(sp)
   11ff4: 23 30 21 03  	sd	s2, 32(sp)
   11ff8: 93 04 05 00  	mv	s1, a0
   11ffc: 93 89 81 cc  	addi	s3, gp, -824
   12000: 13 0a 80 01  	li	s4, 24
   12004: 03 b9 84 00  	ld	s2, 8(s1)
   12008: 93 77 19 00  	andi	a5, s2, 1
   1200c: 63 86 07 00  	beqz	a5, 0x12018 <alloc_fwd+0x3c>
   12010: 13 05 00 00  	li	a0, 0
   12014: 6f 00 00 04  	j	0x12054 <alloc_fwd+0x78>
   12018: 13 05 09 00  	mv	a0, s2
   1201c: ef f0 1f c7  	jal	0x11c8c <bin_index>
   12020: 23 34 a1 00  	sd	a0, 8(sp)
   12024: ef f0 5f db  	jal	0x11dd8 <lock_bin>
   12028: 83 35 81 00  	ld	a1, 8(sp)
   1202c: 83 b7 84 00  	ld	a5, 8(s1)
   12030: 33 84 45 03  	<unknown>
   12034: 13 04 84 00  	addi	s0, s0, 8
   12038: 33 84 89 00  	add	s0, s3, s0
   1203c: 63 9c 27 03  	bne	a5, s2, 0x12074 <alloc_fwd+0x98>
   12040: 13 85 04 00  	mv	a0, s1
   12044: ef f0 5f e3  	jal	0x11e78 <unbin>
   12048: 13 05 04 00  	mv	a0, s0
   1204c: ef f0 df dd  	jal	0x11e28 <unlock>
   12050: 13 05 10 00  	li	a0, 1
   12054: 83 30 81 03  	ld	ra, 56(sp)
   12058: 03 34 01 03  	ld	s0, 48(sp)
   1205c: 83 34 81 02  	ld	s1, 40(sp)
   12060: 03 39 01 02  	ld	s2, 32(sp)
   12064: 83 39 81 01  	ld	s3, 24(sp)
   12068: 03 3a 01 01  	ld	s4, 16(sp)
   1206c: 13 01 01 04  	addi	sp, sp, 64
   12070: 67 80 00 00  	ret
   12074: 13 05 04 00  	mv	a0, s0
   12078: ef f0 1f db  	jal	0x11e28 <unlock>
   1207c: 6f f0 9f f8  	j	0x12004 <alloc_fwd+0x28>

0000000000012080 <__bin_chunk>:
   12080: 83 37 85 00  	ld	a5, 8(a0)
   12084: 13 01 01 f8  	addi	sp, sp, -128
   12088: 23 3c 71 03  	sd	s7, 56(sp)
   1208c: 93 fb e7 ff  	andi	s7, a5, -2
   12090: 23 34 91 06  	sd	s1, 104(sp)
   12094: b3 04 75 01  	add	s1, a0, s7
   12098: 03 b7 04 00  	ld	a4, 0(s1)
   1209c: 23 3c 11 06  	sd	ra, 120(sp)
   120a0: 23 38 81 06  	sd	s0, 112(sp)
   120a4: 23 30 21 07  	sd	s2, 96(sp)
   120a8: 23 3c 31 05  	sd	s3, 88(sp)
   120ac: 23 38 41 05  	sd	s4, 80(sp)
   120b0: 23 34 51 05  	sd	s5, 72(sp)
   120b4: 23 30 61 05  	sd	s6, 64(sp)
   120b8: 23 38 81 03  	sd	s8, 48(sp)
   120bc: 23 34 91 03  	sd	s9, 40(sp)
   120c0: 23 30 a1 03  	sd	s10, 32(sp)
   120c4: 23 3c b1 01  	sd	s11, 24(sp)
   120c8: 63 86 e7 00  	beq	a5, a4, 0x120d4 <__bin_chunk+0x54>
   120cc: 23 00 00 00  	sb	zero, 0(zero)
   120d0: 73 00 10 00  	ebreak	
   120d4: 13 89 81 cc  	addi	s2, gp, -824
   120d8: 13 04 05 00  	mv	s0, a0
   120dc: 13 8a 0b 00  	mv	s4, s7
   120e0: 93 0a 00 00  	li	s5, 0
   120e4: 13 0c 89 60  	addi	s8, s2, 1544
   120e8: 13 0d 80 01  	li	s10, 24
   120ec: b7 8c 02 00  	lui	s9, 40
   120f0: 83 37 04 00  	ld	a5, 0(s0)
   120f4: 03 b7 84 00  	ld	a4, 8(s1)
   120f8: b3 f7 e7 00  	and	a5, a5, a4
   120fc: 93 f7 17 00  	andi	a5, a5, 1
   12100: 63 8c 07 04  	beqz	a5, 0x12158 <__bin_chunk+0xd8>
   12104: 93 67 1a 00  	ori	a5, s4, 1
   12108: 23 34 f4 00  	sd	a5, 8(s0)
   1210c: 23 b0 f4 00  	sd	a5, 0(s1)
   12110: 13 05 0a 00  	mv	a0, s4
   12114: ef f0 9f b7  	jal	0x11c8c <bin_index>
   12118: 93 0d 05 00  	mv	s11, a0
   1211c: ef f0 df cb  	jal	0x11dd8 <lock_bin>
   12120: 13 05 0c 00  	mv	a0, s8
   12124: ef f0 df c2  	jal	0x11d50 <lock>
   12128: b3 86 ad 03  	<unknown>
   1212c: 83 37 04 00  	ld	a5, 0(s0)
   12130: 03 b7 84 00  	ld	a4, 8(s1)
   12134: b3 f7 e7 00  	and	a5, a5, a4
   12138: 93 f7 17 00  	andi	a5, a5, 1
   1213c: 93 89 86 00  	addi	s3, a3, 8
   12140: b3 09 39 01  	add	s3, s2, s3
   12144: 63 90 07 08  	bnez	a5, 0x121c4 <__bin_chunk+0x144>
   12148: 13 05 0c 00  	mv	a0, s8
   1214c: ef f0 df cd  	jal	0x11e28 <unlock>
   12150: 13 85 09 00  	mv	a0, s3
   12154: ef f0 5f cd  	jal	0x11e28 <unlock>
   12158: 13 05 04 00  	mv	a0, s0
   1215c: ef f0 9f dd  	jal	0x11f34 <alloc_rev>
   12160: 63 08 05 02  	beqz	a0, 0x12190 <__bin_chunk+0x110>
   12164: 83 37 04 00  	ld	a5, 0(s0)
   12168: 93 f7 e7 ff  	andi	a5, a5, -2
   1216c: 33 04 f4 40  	sub	s0, s0, a5
   12170: 83 37 84 00  	ld	a5, 8(s0)
   12174: 93 f7 e7 ff  	andi	a5, a5, -2
   12178: 33 87 fb 00  	add	a4, s7, a5
   1217c: 33 0a fa 00  	add	s4, s4, a5
   12180: 63 f8 ec 00  	bgeu	s9, a4, 0x12190 <__bin_chunk+0x110>
   12184: 33 47 f7 00  	xor	a4, a4, a5
   12188: 63 f4 e7 00  	bgeu	a5, a4, 0x12190 <__bin_chunk+0x110>
   1218c: 93 0a 10 00  	li	s5, 1
   12190: 13 85 04 00  	mv	a0, s1
   12194: ef f0 9f e4  	jal	0x11fdc <alloc_fwd>
   12198: e3 0c 05 f4  	beqz	a0, 0x120f0 <__bin_chunk+0x70>
   1219c: 83 b7 84 00  	ld	a5, 8(s1)
   121a0: 93 f7 e7 ff  	andi	a5, a5, -2
   121a4: 33 87 fb 00  	add	a4, s7, a5
   121a8: 33 0a fa 00  	add	s4, s4, a5
   121ac: 63 f8 ec 00  	bgeu	s9, a4, 0x121bc <__bin_chunk+0x13c>
   121b0: 33 47 f7 00  	xor	a4, a4, a5
   121b4: 63 f4 e7 00  	bgeu	a5, a4, 0x121bc <__bin_chunk+0x13c>
   121b8: 93 0a 10 00  	li	s5, 1
   121bc: b3 84 f4 00  	add	s1, s1, a5
   121c0: 6f f0 1f f3  	j	0x120f0 <__bin_chunk+0x70>
   121c4: 83 37 09 00  	ld	a5, 0(s2)
   121c8: b3 d7 b7 01  	srl	a5, a5, s11
   121cc: 93 f7 17 00  	andi	a5, a5, 1
   121d0: 63 88 07 0a  	beqz	a5, 0x12280 <__bin_chunk+0x200>
   121d4: 23 34 44 01  	sd	s4, 8(s0)
   121d8: 13 85 01 2d  	addi	a0, gp, 720
   121dc: 23 b0 44 01  	sd	s4, 0(s1)
   121e0: 23 34 d1 00  	sd	a3, 8(sp)
   121e4: ef f0 5f c4  	jal	0x11e28 <unlock>
   121e8: 13 05 80 01  	li	a0, 24
   121ec: b3 8d ad 02  	<unknown>
   121f0: 83 36 81 00  	ld	a3, 8(sp)
   121f4: b3 06 d9 00  	add	a3, s2, a3
   121f8: 23 38 d4 00  	sd	a3, 16(s0)
   121fc: 33 09 b9 01  	add	s2, s2, s11
   12200: 83 37 89 01  	ld	a5, 24(s2)
   12204: 23 3c f4 00  	sd	a5, 24(s0)
   12208: 23 bc 86 00  	sd	s0, 24(a3)
   1220c: 83 37 84 01  	ld	a5, 24(s0)
   12210: 23 b8 87 00  	sd	s0, 16(a5)
   12214: 63 86 0a 02  	beqz	s5, 0x12240 <__bin_chunk+0x1c0>
   12218: 03 b5 01 c0  	ld	a0, -1024(gp)
   1221c: 93 84 04 fe  	addi	s1, s1, -32
   12220: 13 06 40 00  	li	a2, 4
   12224: b3 05 a0 40  	neg	a1, a0
   12228: 13 05 f5 01  	addi	a0, a0, 31
   1222c: 33 05 a4 00  	add	a0, s0, a0
   12230: 33 75 b5 00  	and	a0, a0, a1
   12234: b3 f5 b4 00  	and	a1, s1, a1
   12238: b3 85 a5 40  	sub	a1, a1, a0
   1223c: ef 00 90 4b  	jal	0x12ef4 <madvise>
   12240: 03 34 01 07  	ld	s0, 112(sp)
   12244: 83 30 81 07  	ld	ra, 120(sp)
   12248: 83 34 81 06  	ld	s1, 104(sp)
   1224c: 03 39 01 06  	ld	s2, 96(sp)
   12250: 03 3a 01 05  	ld	s4, 80(sp)
   12254: 83 3a 81 04  	ld	s5, 72(sp)
   12258: 03 3b 01 04  	ld	s6, 64(sp)
   1225c: 83 3b 81 03  	ld	s7, 56(sp)
   12260: 03 3c 01 03  	ld	s8, 48(sp)
   12264: 83 3c 81 02  	ld	s9, 40(sp)
   12268: 03 3d 01 02  	ld	s10, 32(sp)
   1226c: 83 3d 81 01  	ld	s11, 24(sp)
   12270: 13 85 09 00  	mv	a0, s3
   12274: 83 39 81 05  	ld	s3, 88(sp)
   12278: 13 01 01 08  	addi	sp, sp, 128
   1227c: 6f f0 df ba  	j	0x11e28 <unlock>
   12280: 93 07 10 00  	li	a5, 1
   12284: b3 97 b7 01  	sll	a5, a5, s11
   12288: 1b 85 07 00  	sext.w	a0, a5
   1228c: 63 1e 05 02  	bnez	a0, 0x122c8 <__bin_chunk+0x248>
   12290: 93 d7 07 42  	srai	a5, a5, 32
   12294: e3 80 07 f4  	beqz	a5, 0x121d4 <__bin_chunk+0x154>
   12298: 9b 87 07 00  	sext.w	a5, a5
   1229c: 93 05 49 00  	addi	a1, s2, 4
   122a0: 03 27 49 00  	lw	a4, 4(s2)
   122a4: 1b 07 07 00  	sext.w	a4, a4
   122a8: 33 e5 e7 00  	or	a0, a5, a4
   122ac: 2f a6 05 16  	<unknown>
   122b0: 63 16 e6 00  	bne	a2, a4, 0x122bc <__bin_chunk+0x23c>
   122b4: 2f a8 a5 1e  	<unknown>
   122b8: e3 1a 08 fe  	bnez	a6, 0x122ac <__bin_chunk+0x22c>
   122bc: 1b 06 06 00  	sext.w	a2, a2
   122c0: e3 10 c7 fe  	bne	a4, a2, 0x122a0 <__bin_chunk+0x220>
   122c4: 6f f0 1f f1  	j	0x121d4 <__bin_chunk+0x154>
   122c8: 03 27 09 00  	lw	a4, 0(s2)
   122cc: 1b 07 07 00  	sext.w	a4, a4
   122d0: b3 65 e5 00  	or	a1, a0, a4
   122d4: 2f 26 09 16  	<unknown>
   122d8: 63 16 e6 00  	bne	a2, a4, 0x122e4 <__bin_chunk+0x264>
   122dc: 2f 28 b9 1e  	<unknown>
   122e0: e3 1a 08 fe  	bnez	a6, 0x122d4 <__bin_chunk+0x254>
   122e4: 1b 06 06 00  	sext.w	a2, a2
   122e8: e3 10 c7 fe  	bne	a4, a2, 0x122c8 <__bin_chunk+0x248>
   122ec: 6f f0 5f fa  	j	0x12290 <__bin_chunk+0x210>

00000000000122f0 <trim>:
   122f0: 83 37 85 00  	ld	a5, 8(a0)
   122f4: 13 07 05 00  	mv	a4, a0
   122f8: 93 f7 e7 ff  	andi	a5, a5, -2
   122fc: 93 86 07 ff  	addi	a3, a5, -16
   12300: 63 f6 d5 02  	bgeu	a1, a3, 0x1232c <trim+0x3c>
   12304: 33 05 b5 00  	add	a0, a0, a1
   12308: 93 e6 15 00  	ori	a3, a1, 1
   1230c: b3 85 b7 40  	sub	a1, a5, a1
   12310: 93 e5 15 00  	ori	a1, a1, 1
   12314: 23 30 d5 00  	sd	a3, 0(a0)
   12318: 23 34 b5 00  	sd	a1, 8(a0)
   1231c: b3 07 f7 00  	add	a5, a4, a5
   12320: 23 b0 b7 00  	sd	a1, 0(a5)
   12324: 23 34 d7 00  	sd	a3, 8(a4)
   12328: 6f f0 9f d5  	j	0x12080 <__bin_chunk>
   1232c: 67 80 00 00  	ret

0000000000012330 <malloc>:
   12330: 13 01 01 f9  	addi	sp, sp, -112
   12334: 23 34 a1 00  	sd	a0, 8(sp)
   12338: 13 05 81 00  	addi	a0, sp, 8
   1233c: 23 34 11 06  	sd	ra, 104(sp)
   12340: 23 30 81 06  	sd	s0, 96(sp)
   12344: 23 3c 91 04  	sd	s1, 88(sp)
   12348: 23 38 21 05  	sd	s2, 80(sp)
   1234c: 23 34 31 05  	sd	s3, 72(sp)
   12350: 23 30 41 05  	sd	s4, 64(sp)
   12354: 23 3c 51 03  	sd	s5, 56(sp)
   12358: 23 38 61 03  	sd	s6, 48(sp)
   1235c: 23 34 71 03  	sd	s7, 40(sp)
   12360: 23 30 81 03  	sd	s8, 32(sp)
   12364: ef f0 df 98  	jal	0x11cf0 <adjust_size>
   12368: 63 5e 05 02  	bgez	a0, 0x123a4 <malloc+0x74>
   1236c: 13 04 00 00  	li	s0, 0
   12370: 83 30 81 06  	ld	ra, 104(sp)
   12374: 13 05 04 00  	mv	a0, s0
   12378: 03 34 01 06  	ld	s0, 96(sp)
   1237c: 83 34 81 05  	ld	s1, 88(sp)
   12380: 03 39 01 05  	ld	s2, 80(sp)
   12384: 83 39 81 04  	ld	s3, 72(sp)
   12388: 03 3a 01 04  	ld	s4, 64(sp)
   1238c: 83 3a 81 03  	ld	s5, 56(sp)
   12390: 03 3b 01 03  	ld	s6, 48(sp)
   12394: 83 3b 81 02  	ld	s7, 40(sp)
   12398: 03 3c 01 02  	ld	s8, 32(sp)
   1239c: 13 01 01 07  	addi	sp, sp, 112
   123a0: 67 80 00 00  	ret
   123a4: 83 37 81 00  	ld	a5, 8(sp)
   123a8: 37 87 03 00  	lui	a4, 56
   123ac: 63 7a f7 04  	bgeu	a4, a5, 0x12400 <malloc+0xd0>
   123b0: 83 b5 01 c0  	ld	a1, -1024(gp)
   123b4: 93 06 20 02  	li	a3, 34
   123b8: 13 07 f0 ff  	li	a4, -1
   123bc: 33 84 b7 00  	add	s0, a5, a1
   123c0: 13 04 f4 00  	addi	s0, s0, 15
   123c4: b3 05 b0 40  	neg	a1, a1
   123c8: 33 74 b4 00  	and	s0, s0, a1
   123cc: 93 07 00 00  	li	a5, 0
   123d0: 13 06 30 00  	li	a2, 3
   123d4: 93 05 04 00  	mv	a1, s0
   123d8: 13 05 00 00  	li	a0, 0
   123dc: ef 00 10 34  	jal	0x12f1c <mmap64>
   123e0: 93 07 f0 ff  	li	a5, -1
   123e4: e3 04 f5 f8  	beq	a0, a5, 0x1236c <malloc+0x3c>
   123e8: 13 04 04 ff  	addi	s0, s0, -16
   123ec: 93 07 00 01  	li	a5, 16
   123f0: 23 3c 85 00  	sd	s0, 24(a0)
   123f4: 23 38 f5 00  	sd	a5, 16(a0)
   123f8: 13 04 05 02  	addi	s0, a0, 32
   123fc: 6f f0 5f f7  	j	0x12370 <malloc+0x40>
   12400: 93 d7 57 00  	srli	a5, a5, 5
   12404: 93 84 f7 ff  	addi	s1, a5, -1
   12408: 13 07 00 02  	li	a4, 32
   1240c: 63 62 97 06  	bltu	a4, s1, 0x12470 <malloc+0x140>
   12410: 9b 84 04 00  	sext.w	s1, s1
   12414: 03 bb 01 92  	ld	s6, -1760(gp)
   12418: 93 09 f0 ff  	li	s3, -1
   1241c: 37 ba 01 00  	lui	s4, 27
   12420: b3 99 99 00  	sll	s3, s3, s1
   12424: 13 8c 81 cc  	addi	s8, gp, -824
   12428: 13 0a 8a 42  	addi	s4, s4, 1064
   1242c: 93 0a 80 01  	li	s5, 24
   12430: 83 37 0c 00  	ld	a5, 0(s8)
   12434: 33 f7 37 01  	and	a4, a5, s3
   12438: 63 1c 07 10  	bnez	a4, 0x12550 <malloc+0x220>
   1243c: 83 37 81 00  	ld	a5, 8(sp)
   12440: 13 85 01 9f  	addi	a0, gp, -1552
   12444: 93 87 07 02  	addi	a5, a5, 32
   12448: 23 3c f1 00  	sd	a5, 24(sp)
   1244c: ef f0 5f 90  	jal	0x11d50 <lock>
   12450: 13 05 81 01  	addi	a0, sp, 24
   12454: ef 20 d0 32  	jal	0x14f80 <__expand_heap>
   12458: 13 04 05 00  	mv	s0, a0
   1245c: 13 85 04 00  	mv	a0, s1
   12460: 63 16 04 04  	bnez	s0, 0x124ac <malloc+0x17c>
   12464: 13 85 01 9f  	addi	a0, gp, -1552
   12468: ef f0 1f 9c  	jal	0x11e28 <unlock>
   1246c: 6f f0 5f f0  	j	0x12370 <malloc+0x40>
   12470: 37 b7 01 00  	lui	a4, 27
   12474: 93 87 e7 ff  	addi	a5, a5, -2
   12478: 93 06 f0 1f  	li	a3, 511
   1247c: 13 07 87 3e  	addi	a4, a4, 1000
   12480: 63 ec f6 00  	bltu	a3, a5, 0x12498 <malloc+0x168>
   12484: 93 d7 37 00  	srli	a5, a5, 3
   12488: b3 07 f7 00  	add	a5, a4, a5
   1248c: 83 c4 c7 ff  	lbu	s1, -4(a5)
   12490: 9b 84 14 00  	addiw	s1, s1, 1
   12494: 6f f0 1f f8  	j	0x12414 <malloc+0xe4>
   12498: 93 d7 77 00  	srli	a5, a5, 7
   1249c: b3 07 f7 00  	add	a5, a4, a5
   124a0: 83 c4 c7 ff  	lbu	s1, -4(a5)
   124a4: 9b 84 14 01  	addiw	s1, s1, 17
   124a8: 6f f0 df f6  	j	0x12414 <malloc+0xe4>
   124ac: 83 b4 81 9e  	ld	s1, -1560(gp)
   124b0: 13 87 81 9e  	addi	a4, gp, -1560
   124b4: 63 0e 94 00  	beq	s0, s1, 0x124d0 <malloc+0x1a0>
   124b8: 83 37 81 01  	ld	a5, 24(sp)
   124bc: 93 04 04 02  	addi	s1, s0, 32
   124c0: 93 87 07 fe  	addi	a5, a5, -32
   124c4: 23 3c f1 00  	sd	a5, 24(sp)
   124c8: 93 07 10 00  	li	a5, 1
   124cc: 23 38 f4 00  	sd	a5, 16(s0)
   124d0: 83 37 81 01  	ld	a5, 24(sp)
   124d4: 13 85 01 9f  	addi	a0, gp, -1552
   124d8: 13 84 04 ff  	addi	s0, s1, -16
   124dc: b3 86 f4 00  	add	a3, s1, a5
   124e0: 23 30 d7 00  	sd	a3, 0(a4)
   124e4: 93 e7 17 00  	ori	a5, a5, 1
   124e8: 13 07 10 00  	li	a4, 1
   124ec: 23 b8 f6 fe  	sd	a5, -16(a3)
   124f0: 23 bc e6 fe  	sd	a4, -8(a3)
   124f4: 23 bc f4 fe  	sd	a5, -8(s1)
   124f8: ef f0 1f 93  	jal	0x11e28 <unlock>
   124fc: 13 05 04 00  	mv	a0, s0
   12500: ef f0 5f a3  	jal	0x11f34 <alloc_rev>
   12504: 63 0c 05 02  	beqz	a0, 0x1253c <malloc+0x20c>
   12508: 83 b7 04 ff  	ld	a5, -16(s1)
   1250c: 83 b6 84 ff  	ld	a3, -8(s1)
   12510: 93 f7 e7 ff  	andi	a5, a5, -2
   12514: b3 07 f4 40  	sub	a5, s0, a5
   12518: 03 b7 87 00  	ld	a4, 8(a5)
   1251c: 13 77 e7 ff  	andi	a4, a4, -2
   12520: 33 07 d7 00  	add	a4, a4, a3
   12524: 23 b4 e7 00  	sd	a4, 8(a5)
   12528: 03 b5 84 ff  	ld	a0, -8(s1)
   1252c: 13 75 e5 ff  	andi	a0, a0, -2
   12530: 33 04 a4 00  	add	s0, s0, a0
   12534: 23 30 e4 00  	sd	a4, 0(s0)
   12538: 13 84 07 00  	mv	s0, a5
   1253c: 83 35 81 00  	ld	a1, 8(sp)
   12540: 13 05 04 00  	mv	a0, s0
   12544: 13 04 04 01  	addi	s0, s0, 16
   12548: ef f0 9f da  	jal	0x122f0 <trim>
   1254c: 6f f0 5f e2  	j	0x12370 <malloc+0x40>
   12550: b3 07 e0 40  	neg	a5, a4
   12554: b3 f7 e7 00  	and	a5, a5, a4
   12558: b3 87 67 03  	<unknown>
   1255c: 93 d7 a7 03  	srli	a5, a5, 58
   12560: b3 07 fa 00  	add	a5, s4, a5
   12564: 83 cb 07 00  	lbu	s7, 0(a5)
   12568: 1b 89 0b 00  	sext.w	s2, s7
   1256c: 13 05 09 00  	mv	a0, s2
   12570: ef f0 9f 86  	jal	0x11dd8 <lock_bin>
   12574: b3 07 59 03  	<unknown>
   12578: b3 07 fc 00  	add	a5, s8, a5
   1257c: 03 b4 07 01  	ld	s0, 16(a5)
   12580: b3 87 5b 03  	<unknown>
   12584: 93 8b 87 00  	addi	s7, a5, 8
   12588: b3 07 fc 00  	add	a5, s8, a5
   1258c: b3 0b 7c 01  	add	s7, s8, s7
   12590: 63 00 f4 0a  	beq	s0, a5, 0x12630 <malloc+0x300>
   12594: 93 07 70 02  	li	a5, 39
   12598: 63 d6 27 03  	bge	a5, s2, 0x125c4 <malloc+0x294>
   1259c: 9b 84 24 00  	addiw	s1, s1, 2
   125a0: 83 39 81 00  	ld	s3, 8(sp)
   125a4: 63 c8 24 03  	blt	s1, s2, 0x125d4 <malloc+0x2a4>
   125a8: 93 07 f0 03  	li	a5, 63
   125ac: 63 1c f9 00  	bne	s2, a5, 0x125c4 <malloc+0x294>
   125b0: 83 34 84 00  	ld	s1, 8(s0)
   125b4: b7 87 03 00  	lui	a5, 56
   125b8: 93 f4 e4 ff  	andi	s1, s1, -2
   125bc: 33 87 34 41  	sub	a4, s1, s3
   125c0: 63 ee e7 00  	bltu	a5, a4, 0x125dc <malloc+0x2ac>
   125c4: 93 05 09 00  	mv	a1, s2
   125c8: 13 05 04 00  	mv	a0, s0
   125cc: ef f0 df 8a  	jal	0x11e78 <unbin>
   125d0: 6f 00 40 05  	j	0x12624 <malloc+0x2f4>
   125d4: 83 34 84 00  	ld	s1, 8(s0)
   125d8: 93 f4 e4 ff  	andi	s1, s1, -2
   125dc: 33 8a 34 41  	sub	s4, s1, s3
   125e0: 13 05 0a 00  	mv	a0, s4
   125e4: ef f0 8f ea  	jal	0x11c8c <bin_index>
   125e8: e3 1e a9 fc  	bne	s2, a0, 0x125c4 <malloc+0x294>
   125ec: 03 37 84 01  	ld	a4, 24(s0)
   125f0: 83 36 04 01  	ld	a3, 16(s0)
   125f4: b3 07 34 01  	add	a5, s0, s3
   125f8: 23 bc e7 00  	sd	a4, 24(a5)
   125fc: 23 b8 d7 00  	sd	a3, 16(a5)
   12600: 23 38 f7 00  	sd	a5, 16(a4)
   12604: 03 b7 07 01  	ld	a4, 16(a5)
   12608: 93 e9 19 00  	ori	s3, s3, 1
   1260c: b3 04 94 00  	add	s1, s0, s1
   12610: 23 3c f7 00  	sd	a5, 24(a4)
   12614: 23 b0 37 01  	sd	s3, 0(a5)
   12618: 23 b4 47 01  	sd	s4, 8(a5)
   1261c: 23 b0 44 01  	sd	s4, 0(s1)
   12620: 23 34 34 01  	sd	s3, 8(s0)
   12624: 13 85 0b 00  	mv	a0, s7
   12628: ef f0 1f 80  	jal	0x11e28 <unlock>
   1262c: 6f f0 1f f1  	j	0x1253c <malloc+0x20c>
   12630: 13 85 0b 00  	mv	a0, s7
   12634: ef f0 4f ff  	jal	0x11e28 <unlock>
   12638: 6f f0 9f df  	j	0x12430 <malloc+0x100>

000000000001263c <calloc>:
   1263c: 13 01 01 fd  	addi	sp, sp, -48
   12640: 23 34 11 02  	sd	ra, 40(sp)
   12644: 23 30 81 02  	sd	s0, 32(sp)
   12648: 23 3c 91 00  	sd	s1, 24(sp)
   1264c: 63 8a 05 02  	beqz	a1, 0x12680 <calloc+0x44>
   12650: b3 37 b5 02  	<unknown>
   12654: 63 86 07 02  	beqz	a5, 0x12680 <calloc+0x44>
   12658: ef e0 9f fc  	jal	0x11620 <__errno_location>
   1265c: 93 07 c0 00  	li	a5, 12
   12660: 23 20 f5 00  	sw	a5, 0(a0)
   12664: 13 04 00 00  	li	s0, 0
   12668: 83 30 81 02  	ld	ra, 40(sp)
   1266c: 13 05 04 00  	mv	a0, s0
   12670: 03 34 01 02  	ld	s0, 32(sp)
   12674: 83 34 81 01  	ld	s1, 24(sp)
   12678: 13 01 01 03  	addi	sp, sp, 48
   1267c: 67 80 00 00  	ret
   12680: 33 86 a5 02  	<unknown>
   12684: 13 05 06 00  	mv	a0, a2
   12688: 23 34 c1 00  	sd	a2, 8(sp)
   1268c: ef f0 5f ca  	jal	0x12330 <malloc>
   12690: 13 04 05 00  	mv	s0, a0
   12694: e3 0a 05 fc  	beqz	a0, 0x12668 <calloc+0x2c>
   12698: 83 a7 41 9e  	lw	a5, -1564(gp)
   1269c: 03 36 81 00  	ld	a2, 8(sp)
   126a0: 63 9e 07 04  	bnez	a5, 0x126fc <calloc+0xc0>
   126a4: 83 37 85 ff  	ld	a5, -8(a0)
   126a8: 93 f7 17 00  	andi	a5, a5, 1
   126ac: e3 8e 07 fa  	beqz	a5, 0x12668 <calloc+0x2c>
   126b0: 83 b4 01 c0  	ld	s1, -1024(gp)
   126b4: 63 64 96 04  	bltu	a2, s1, 0x126fc <calloc+0xc0>
   126b8: 33 05 c5 00  	add	a0, a0, a2
   126bc: 13 86 f4 ff  	addi	a2, s1, -1
   126c0: 33 76 c5 00  	and	a2, a0, a2
   126c4: 33 05 c5 40  	sub	a0, a0, a2
   126c8: 93 05 00 00  	li	a1, 0
   126cc: ef 10 90 1b  	jal	0x14084 <memset>
   126d0: 33 06 85 40  	sub	a2, a0, s0
   126d4: 63 64 96 02  	bltu	a2, s1, 0x126fc <calloc+0xc0>
   126d8: 13 86 04 00  	mv	a2, s1
   126dc: e3 04 06 fe  	beqz	a2, 0x126c4 <calloc+0x88>
   126e0: 83 37 85 ff  	ld	a5, -8(a0)
   126e4: 03 37 05 ff  	ld	a4, -16(a0)
   126e8: b3 e7 e7 00  	or	a5, a5, a4
   126ec: e3 9c 07 fc  	bnez	a5, 0x126c4 <calloc+0x88>
   126f0: 13 06 06 ff  	addi	a2, a2, -16
   126f4: 13 05 05 ff  	addi	a0, a0, -16
   126f8: 6f f0 5f fe  	j	0x126dc <calloc+0xa0>
   126fc: 13 05 04 00  	mv	a0, s0
   12700: 03 34 01 02  	ld	s0, 32(sp)
   12704: 83 30 81 02  	ld	ra, 40(sp)
   12708: 83 34 81 01  	ld	s1, 24(sp)
   1270c: 93 05 00 00  	li	a1, 0
   12710: 13 01 01 03  	addi	sp, sp, 48
   12714: 6f 10 10 17  	j	0x14084 <memset>

0000000000012718 <free>:
   12718: 93 07 05 00  	mv	a5, a0
   1271c: 63 0e 05 02  	beqz	a0, 0x12758 <free+0x40>
   12720: 83 b5 87 ff  	ld	a1, -8(a5)
   12724: 13 05 05 ff  	addi	a0, a0, -16
   12728: 13 f7 15 00  	andi	a4, a1, 1
   1272c: 63 14 07 02  	bnez	a4, 0x12754 <free+0x3c>
   12730: 83 b7 07 ff  	ld	a5, -16(a5)
   12734: 93 f5 e5 ff  	andi	a1, a1, -2
   12738: 33 05 f5 40  	sub	a0, a0, a5
   1273c: b3 85 f5 00  	add	a1, a1, a5
   12740: 93 f7 17 00  	andi	a5, a5, 1
   12744: 63 86 07 00  	beqz	a5, 0x12750 <free+0x38>
   12748: 23 00 00 00  	sb	zero, 0(zero)
   1274c: 73 00 10 00  	ebreak	
   12750: 6f 00 90 12  	j	0x13078 <munmap>
   12754: 6f f0 df 92  	j	0x12080 <__bin_chunk>
   12758: 67 80 00 00  	ret

000000000001275c <realloc>:
   1275c: 13 01 01 fa  	addi	sp, sp, -96
   12760: 23 3c 11 04  	sd	ra, 88(sp)
   12764: 23 38 81 04  	sd	s0, 80(sp)
   12768: 23 34 91 04  	sd	s1, 72(sp)
   1276c: 23 30 21 05  	sd	s2, 64(sp)
   12770: 23 3c 31 03  	sd	s3, 56(sp)
   12774: 23 38 41 03  	sd	s4, 48(sp)
   12778: 23 34 51 03  	sd	s5, 40(sp)
   1277c: 23 30 61 03  	sd	s6, 32(sp)
   12780: 23 3c 71 01  	sd	s7, 24(sp)
   12784: 23 34 b1 00  	sd	a1, 8(sp)
   12788: 63 10 05 04  	bnez	a0, 0x127c8 <realloc+0x6c>
   1278c: 13 85 05 00  	mv	a0, a1
   12790: ef f0 1f ba  	jal	0x12330 <malloc>
   12794: 13 04 05 00  	mv	s0, a0
   12798: 83 30 81 05  	ld	ra, 88(sp)
   1279c: 13 05 04 00  	mv	a0, s0
   127a0: 03 34 01 05  	ld	s0, 80(sp)
   127a4: 83 34 81 04  	ld	s1, 72(sp)
   127a8: 03 39 01 04  	ld	s2, 64(sp)
   127ac: 83 39 81 03  	ld	s3, 56(sp)
   127b0: 03 3a 01 03  	ld	s4, 48(sp)
   127b4: 83 3a 81 02  	ld	s5, 40(sp)
   127b8: 03 3b 01 02  	ld	s6, 32(sp)
   127bc: 83 3b 81 01  	ld	s7, 24(sp)
   127c0: 13 01 01 06  	addi	sp, sp, 96
   127c4: 67 80 00 00  	ret
   127c8: 13 04 05 00  	mv	s0, a0
   127cc: 13 05 81 00  	addi	a0, sp, 8
   127d0: ef f0 0f d2  	jal	0x11cf0 <adjust_size>
   127d4: 63 56 05 00  	bgez	a0, 0x127e0 <realloc+0x84>
   127d8: 13 04 00 00  	li	s0, 0
   127dc: 6f f0 df fb  	j	0x12798 <realloc+0x3c>
   127e0: 83 37 84 ff  	ld	a5, -8(s0)
   127e4: 13 0b 04 ff  	addi	s6, s0, -16
   127e8: 13 f7 17 00  	andi	a4, a5, 1
   127ec: 93 f9 e7 ff  	andi	s3, a5, -2
   127f0: 63 1a 07 0a  	bnez	a4, 0x128a4 <realloc+0x148>
   127f4: 03 3a 04 ff  	ld	s4, -16(s0)
   127f8: 03 35 81 00  	ld	a0, 8(sp)
   127fc: 93 77 1a 00  	andi	a5, s4, 1
   12800: b3 85 49 01  	add	a1, s3, s4
   12804: b3 0b 45 01  	add	s7, a0, s4
   12808: 63 86 07 00  	beqz	a5, 0x12814 <realloc+0xb8>
   1280c: 23 00 00 00  	sb	zero, 0(zero)
   12810: 73 00 10 00  	ebreak	
   12814: 13 87 81 bc  	addi	a4, gp, -1080
   12818: 03 37 87 03  	ld	a4, 56(a4)
   1281c: 93 8a 81 bc  	addi	s5, gp, -1080
   12820: 63 f0 eb 04  	bgeu	s7, a4, 0x12860 <realloc+0x104>
   12824: 13 05 05 ff  	addi	a0, a0, -16
   12828: 23 30 b1 00  	sd	a1, 0(sp)
   1282c: ef f0 5f b0  	jal	0x12330 <malloc>
   12830: 83 35 01 00  	ld	a1, 0(sp)
   12834: 13 09 05 00  	mv	s2, a0
   12838: 63 04 05 02  	beqz	a0, 0x12860 <realloc+0x104>
   1283c: 83 39 81 00  	ld	s3, 8(sp)
   12840: 93 05 04 00  	mv	a1, s0
   12844: 13 86 09 ff  	addi	a2, s3, -16
   12848: 13 05 09 00  	mv	a0, s2
   1284c: ef 10 40 3f  	jal	0x13c40 <memcpy>
   12850: 13 05 04 00  	mv	a0, s0
   12854: ef f0 5f ec  	jal	0x12718 <free>
   12858: 13 04 09 00  	mv	s0, s2
   1285c: 6f f0 df f3  	j	0x12798 <realloc+0x3c>
   12860: 03 b6 8a 03  	ld	a2, 56(s5)
   12864: 93 04 f6 ff  	addi	s1, a2, -1
   12868: b3 84 74 01  	add	s1, s1, s7
   1286c: 33 06 c0 40  	neg	a2, a2
   12870: b3 74 96 00  	and	s1, a2, s1
   12874: e3 82 95 f2  	beq	a1, s1, 0x12798 <realloc+0x3c>
   12878: 93 06 10 00  	li	a3, 1
   1287c: 13 86 04 00  	mv	a2, s1
   12880: 33 05 4b 41  	sub	a0, s6, s4
   12884: ef 00 40 76  	jal	0x12fe8 <mremap>
   12888: 93 07 f0 ff  	li	a5, -1
   1288c: 63 06 f5 06  	beq	a0, a5, 0x128f8 <realloc+0x19c>
   12890: 33 04 45 01  	add	s0, a0, s4
   12894: b3 84 44 41  	sub	s1, s1, s4
   12898: 23 34 94 00  	sd	s1, 8(s0)
   1289c: 13 04 04 01  	addi	s0, s0, 16
   128a0: 6f f0 9f ef  	j	0x12798 <realloc+0x3c>
   128a4: b3 04 3b 01  	add	s1, s6, s3
   128a8: 03 b7 04 00  	ld	a4, 0(s1)
   128ac: e3 90 e7 f6  	bne	a5, a4, 0x1280c <realloc+0xb0>
   128b0: 83 37 81 00  	ld	a5, 8(sp)
   128b4: 13 89 09 00  	mv	s2, s3
   128b8: 63 f0 f9 02  	bgeu	s3, a5, 0x128d8 <realloc+0x17c>
   128bc: 13 85 04 00  	mv	a0, s1
   128c0: ef f0 cf f1  	jal	0x11fdc <alloc_fwd>
   128c4: 63 0a 05 00  	beqz	a0, 0x128d8 <realloc+0x17c>
   128c8: 83 b7 84 00  	ld	a5, 8(s1)
   128cc: 93 f7 e7 ff  	andi	a5, a5, -2
   128d0: 33 89 37 01  	add	s2, a5, s3
   128d4: b3 84 f4 00  	add	s1, s1, a5
   128d8: 93 67 19 00  	ori	a5, s2, 1
   128dc: 83 35 81 00  	ld	a1, 8(sp)
   128e0: 23 3c f4 fe  	sd	a5, -8(s0)
   128e4: 23 b0 f4 00  	sd	a5, 0(s1)
   128e8: 63 68 b9 00  	bltu	s2, a1, 0x128f8 <realloc+0x19c>
   128ec: 13 05 0b 00  	mv	a0, s6
   128f0: ef f0 1f a0  	jal	0x122f0 <trim>
   128f4: 6f f0 5f ea  	j	0x12798 <realloc+0x3c>
   128f8: 03 35 81 00  	ld	a0, 8(sp)
   128fc: 13 05 05 ff  	addi	a0, a0, -16
   12900: ef f0 1f a3  	jal	0x12330 <malloc>
   12904: 13 09 05 00  	mv	s2, a0
   12908: e3 1c 05 f2  	bnez	a0, 0x12840 <realloc+0xe4>
   1290c: 6f f0 df ec  	j	0x127d8 <realloc+0x7c>

0000000000012910 <__malloc_donate>:
   12910: 93 07 00 ff  	li	a5, -16
   12914: b3 87 a7 40  	sub	a5, a5, a0
   12918: 13 f7 f5 01  	andi	a4, a1, 31
   1291c: 93 f7 f7 01  	andi	a5, a5, 31
   12920: 13 07 07 01  	addi	a4, a4, 16
   12924: b3 86 a5 40  	sub	a3, a1, a0
   12928: 33 07 f7 00  	add	a4, a4, a5
   1292c: 63 7a d7 02  	bgeu	a4, a3, 0x12960 <__malloc_donate+0x50>
   12930: 93 f5 05 fe  	andi	a1, a1, -32
   12934: 93 06 10 00  	li	a3, 1
   12938: 13 87 07 01  	addi	a4, a5, 16
   1293c: 33 07 e5 00  	add	a4, a0, a4
   12940: 23 bc d5 fe  	sd	a3, -8(a1)
   12944: 23 38 d7 fe  	sd	a3, -16(a4)
   12948: b3 86 e5 40  	sub	a3, a1, a4
   1294c: 93 e6 16 00  	ori	a3, a3, 1
   12950: 23 b8 d5 fe  	sd	a3, -16(a1)
   12954: 23 3c d7 fe  	sd	a3, -8(a4)
   12958: 33 05 f5 00  	add	a0, a0, a5
   1295c: 6f f0 4f f2  	j	0x12080 <__bin_chunk>
   12960: 67 80 00 00  	ret

0000000000012964 <copysign>:
   12964: d3 07 05 f2  	<unknown>
   12968: 53 87 05 f2  	<unknown>
   1296c: d3 87 e7 22  	<unknown>
   12970: 53 85 07 e2  	<unknown>
   12974: 67 80 00 00  	ret

0000000000012978 <copysignf>:
   12978: d3 07 05 f0  	fmv.w.x	fa5, a0
   1297c: 53 87 05 f0  	fmv.w.x	fa4, a1
   12980: d3 87 e7 20  	<unknown>
   12984: 53 85 07 e0  	fmv.x.w	a0, fa5
   12988: 67 80 00 00  	ret

000000000001298c <scalbn>:
   1298c: 13 07 f0 3f  	li	a4, 1023
   12990: d3 07 05 f2  	<unknown>
   12994: 63 50 b7 04  	bge	a4, a1, 0x129d4 <scalbn+0x48>
   12998: 07 b7 81 90  	<unknown>
   1299c: 9b 87 15 c0  	addiw	a5, a1, -1023
   129a0: d3 f7 e7 12  	<unknown>
   129a4: 63 5c f7 00  	bge	a4, a5, 0x129bc <scalbn+0x30>
   129a8: 9b 86 25 80  	addiw	a3, a1, -2046
   129ac: d3 f7 e7 12  	<unknown>
   129b0: 93 87 06 00  	mv	a5, a3
   129b4: 63 54 d7 00  	bge	a4, a3, 0x129bc <scalbn+0x30>
   129b8: 93 07 f0 3f  	li	a5, 1023
   129bc: 9b 87 f7 3f  	addiw	a5, a5, 1023
   129c0: 93 97 47 03  	slli	a5, a5, 52
   129c4: 53 87 07 f2  	<unknown>
   129c8: d3 f7 e7 12  	<unknown>
   129cc: 53 85 07 e2  	<unknown>
   129d0: 67 80 00 00  	ret
   129d4: 13 07 20 c0  	li	a4, -1022
   129d8: 93 87 05 00  	mv	a5, a1
   129dc: e3 d0 e5 fe  	bge	a1, a4, 0x129bc <scalbn+0x30>
   129e0: 07 b7 81 92  	<unknown>
   129e4: 9b 87 95 3c  	addiw	a5, a1, 969
   129e8: d3 f7 e7 12  	<unknown>
   129ec: e3 d8 e7 fc  	bge	a5, a4, 0x129bc <scalbn+0x30>
   129f0: 9b 86 25 79  	addiw	a3, a1, 1938
   129f4: d3 f7 e7 12  	<unknown>
   129f8: 93 87 06 00  	mv	a5, a3
   129fc: e3 d0 e6 fc  	bge	a3, a4, 0x129bc <scalbn+0x30>
   12a00: 93 07 20 c0  	li	a5, -1022
   12a04: 6f f0 9f fb  	j	0x129bc <scalbn+0x30>

0000000000012a08 <__getopt_msg>:
   12a08: 13 01 01 fc  	addi	sp, sp, -64
   12a0c: 23 34 51 01  	sd	s5, 8(sp)
   12a10: 93 0a 05 00  	mv	s5, a0
   12a14: 13 85 05 00  	mv	a0, a1
   12a18: 23 38 81 02  	sd	s0, 48(sp)
   12a1c: 23 34 91 02  	sd	s1, 40(sp)
   12a20: 23 30 21 03  	sd	s2, 32(sp)
   12a24: 23 3c 31 01  	sd	s3, 24(sp)
   12a28: 23 38 41 01  	sd	s4, 16(sp)
   12a2c: 23 3c 11 02  	sd	ra, 56(sp)
   12a30: 13 0a 06 00  	mv	s4, a2
   12a34: 13 89 06 00  	mv	s2, a3
   12a38: 37 d4 01 00  	lui	s0, 29
   12a3c: ef e0 5f db  	jal	0x117f0 <__lctrans_cur>
   12a40: 93 07 04 00  	mv	a5, s0
   12a44: 83 a7 c7 08  	lw	a5, 140(a5)
   12a48: 93 09 05 00  	mv	s3, a0
   12a4c: 93 04 00 00  	li	s1, 0
   12a50: 9b 87 07 00  	sext.w	a5, a5
   12a54: 63 c8 07 00  	bltz	a5, 0x12a64 <__getopt_msg+0x5c>
   12a58: 13 05 04 00  	mv	a0, s0
   12a5c: ef 00 10 2a  	jal	0x134fc <__lockfile>
   12a60: 93 04 05 00  	mv	s1, a0
   12a64: 93 05 04 00  	mv	a1, s0
   12a68: 13 85 0a 00  	mv	a0, s5
   12a6c: ef 00 50 3c  	jal	0x13630 <fputs_unlocked>
   12a70: 63 44 05 04  	bltz	a0, 0x12ab8 <__getopt_msg+0xb0>
   12a74: 13 85 09 00  	mv	a0, s3
   12a78: ef 10 c0 7c  	jal	0x14244 <strlen>
   12a7c: 93 05 05 00  	mv	a1, a0
   12a80: 93 06 04 00  	mv	a3, s0
   12a84: 13 06 10 00  	li	a2, 1
   12a88: 13 85 09 00  	mv	a0, s3
   12a8c: ef 00 50 50  	jal	0x13790 <fwrite_unlocked>
   12a90: 63 04 05 02  	beqz	a0, 0x12ab8 <__getopt_msg+0xb0>
   12a94: 93 06 04 00  	mv	a3, s0
   12a98: 13 06 09 00  	mv	a2, s2
   12a9c: 93 05 10 00  	li	a1, 1
   12aa0: 13 05 0a 00  	mv	a0, s4
   12aa4: ef 00 d0 4e  	jal	0x13790 <fwrite_unlocked>
   12aa8: 63 18 25 01  	bne	a0, s2, 0x12ab8 <__getopt_msg+0xb0>
   12aac: 93 05 04 00  	mv	a1, s0
   12ab0: 13 05 a0 00  	li	a0, 10
   12ab4: ef 00 d0 67  	jal	0x13930 <putc>
   12ab8: 63 86 04 02  	beqz	s1, 0x12ae4 <__getopt_msg+0xdc>
   12abc: 13 05 04 00  	mv	a0, s0
   12ac0: 03 34 01 03  	ld	s0, 48(sp)
   12ac4: 83 30 81 03  	ld	ra, 56(sp)
   12ac8: 83 34 81 02  	ld	s1, 40(sp)
   12acc: 03 39 01 02  	ld	s2, 32(sp)
   12ad0: 83 39 81 01  	ld	s3, 24(sp)
   12ad4: 03 3a 01 01  	ld	s4, 16(sp)
   12ad8: 83 3a 81 00  	ld	s5, 8(sp)
   12adc: 13 01 01 04  	addi	sp, sp, 64
   12ae0: 6f 00 10 2f  	j	0x135d0 <__unlockfile>
   12ae4: 83 30 81 03  	ld	ra, 56(sp)
   12ae8: 03 34 01 03  	ld	s0, 48(sp)
   12aec: 83 34 81 02  	ld	s1, 40(sp)
   12af0: 03 39 01 02  	ld	s2, 32(sp)
   12af4: 83 39 81 01  	ld	s3, 24(sp)
   12af8: 03 3a 01 01  	ld	s4, 16(sp)
   12afc: 83 3a 81 00  	ld	s5, 8(sp)
   12b00: 13 01 01 04  	addi	sp, sp, 64
   12b04: 67 80 00 00  	ret

0000000000012b08 <getopt>:
   12b08: 13 01 01 fa  	addi	sp, sp, -96
   12b0c: 23 38 81 04  	sd	s0, 80(sp)
   12b10: 03 a7 c1 98  	lw	a4, -1652(gp)
   12b14: 23 34 91 04  	sd	s1, 72(sp)
   12b18: 23 38 41 03  	sd	s4, 48(sp)
   12b1c: 23 34 51 03  	sd	s5, 40(sp)
   12b20: 23 3c 11 04  	sd	ra, 88(sp)
   12b24: 23 30 21 05  	sd	s2, 64(sp)
   12b28: 23 3c 31 03  	sd	s3, 56(sp)
   12b2c: 23 30 61 03  	sd	s6, 32(sp)
   12b30: 93 0a 05 00  	mv	s5, a0
   12b34: 13 8a 05 00  	mv	s4, a1
   12b38: 93 04 06 00  	mv	s1, a2
   12b3c: 13 84 c1 98  	addi	s0, gp, -1652
   12b40: 93 87 c1 9f  	addi	a5, gp, -1540
   12b44: 63 06 07 00  	beqz	a4, 0x12b50 <getopt+0x48>
   12b48: 03 a7 07 00  	lw	a4, 0(a5)
   12b4c: 63 0a 07 00  	beqz	a4, 0x12b60 <getopt+0x58>
   12b50: 23 a0 07 00  	sw	zero, 0(a5)
   12b54: 23 ac 01 9e  	sw	zero, -1544(gp)
   12b58: 93 07 10 00  	li	a5, 1
   12b5c: 23 20 f4 00  	sw	a5, 0(s0)
   12b60: 83 27 04 00  	lw	a5, 0(s0)
   12b64: 13 05 f0 ff  	li	a0, -1
   12b68: 63 dc 57 03  	bge	a5, s5, 0x12ba0 <getopt+0x98>
   12b6c: 13 97 37 00  	slli	a4, a5, 3
   12b70: 33 07 ea 00  	add	a4, s4, a4
   12b74: 03 37 07 00  	ld	a4, 0(a4)
   12b78: 63 04 07 02  	beqz	a4, 0x12ba0 <getopt+0x98>
   12b7c: 83 46 07 00  	lbu	a3, 0(a4)
   12b80: 13 06 d0 02  	li	a2, 45
   12b84: 63 82 c6 04  	beq	a3, a2, 0x12bc8 <getopt+0xc0>
   12b88: 83 c6 04 00  	lbu	a3, 0(s1)
   12b8c: 63 9a c6 00  	bne	a3, a2, 0x12ba0 <getopt+0x98>
   12b90: 9b 87 17 00  	addiw	a5, a5, 1
   12b94: 23 20 f4 00  	sw	a5, 0(s0)
   12b98: 23 b0 e1 a0  	sd	a4, -1536(gp)
   12b9c: 13 05 10 00  	li	a0, 1
   12ba0: 83 30 81 05  	ld	ra, 88(sp)
   12ba4: 03 34 01 05  	ld	s0, 80(sp)
   12ba8: 83 34 81 04  	ld	s1, 72(sp)
   12bac: 03 39 01 04  	ld	s2, 64(sp)
   12bb0: 83 39 81 03  	ld	s3, 56(sp)
   12bb4: 03 3a 01 03  	ld	s4, 48(sp)
   12bb8: 83 3a 81 02  	ld	s5, 40(sp)
   12bbc: 03 3b 01 02  	ld	s6, 32(sp)
   12bc0: 13 01 01 06  	addi	sp, sp, 96
   12bc4: 67 80 00 00  	ret
   12bc8: 03 46 17 00  	lbu	a2, 1(a4)
   12bcc: 13 05 f0 ff  	li	a0, -1
   12bd0: e3 08 06 fc  	beqz	a2, 0x12ba0 <getopt+0x98>
   12bd4: 63 1c d6 00  	bne	a2, a3, 0x12bec <getopt+0xe4>
   12bd8: 83 46 27 00  	lbu	a3, 2(a4)
   12bdc: 63 98 06 00  	bnez	a3, 0x12bec <getopt+0xe4>
   12be0: 9b 87 17 00  	addiw	a5, a5, 1
   12be4: 23 20 f4 00  	sw	a5, 0(s0)
   12be8: 6f f0 9f fb  	j	0x12ba0 <getopt+0x98>
   12bec: 83 a7 81 9f  	lw	a5, -1544(gp)
   12bf0: 13 89 81 9f  	addi	s2, gp, -1544
   12bf4: 63 96 07 00  	bnez	a5, 0x12c00 <getopt+0xf8>
   12bf8: 93 07 10 00  	li	a5, 1
   12bfc: 23 20 f9 00  	sw	a5, 0(s2)
   12c00: 83 25 09 00  	lw	a1, 0(s2)
   12c04: 13 06 40 00  	li	a2, 4
   12c08: 13 05 81 01  	addi	a0, sp, 24
   12c0c: b3 05 b7 00  	add	a1, a4, a1
   12c10: ef 00 00 4a  	jal	0x130b0 <mbtowc>
   12c14: 93 06 05 00  	mv	a3, a0
   12c18: 63 5a 05 00  	bgez	a0, 0x12c2c <getopt+0x124>
   12c1c: b7 07 01 00  	lui	a5, 16
   12c20: 93 87 d7 ff  	addi	a5, a5, -3
   12c24: 23 2c f1 00  	sw	a5, 24(sp)
   12c28: 93 06 10 00  	li	a3, 1
   12c2c: 03 27 04 00  	lw	a4, 0(s0)
   12c30: 93 17 37 00  	slli	a5, a4, 3
   12c34: b3 07 fa 00  	add	a5, s4, a5
   12c38: 03 b6 07 00  	ld	a2, 0(a5)
   12c3c: 83 27 09 00  	lw	a5, 0(s2)
   12c40: bb 85 d7 00  	addw	a1, a5, a3
   12c44: 33 0b f6 00  	add	s6, a2, a5
   12c48: 23 20 b9 00  	sw	a1, 0(s2)
   12c4c: 33 06 b6 00  	add	a2, a2, a1
   12c50: 83 47 06 00  	lbu	a5, 0(a2)
   12c54: 63 98 07 00  	bnez	a5, 0x12c64 <getopt+0x15c>
   12c58: 1b 07 17 00  	addiw	a4, a4, 1
   12c5c: 23 20 e4 00  	sw	a4, 0(s0)
   12c60: 23 20 09 00  	sw	zero, 0(s2)
   12c64: 83 c7 04 00  	lbu	a5, 0(s1)
   12c68: 9b 87 57 fd  	addiw	a5, a5, -43
   12c6c: 93 f7 d7 0f  	andi	a5, a5, 253
   12c70: 63 94 07 00  	bnez	a5, 0x12c78 <getopt+0x170>
   12c74: 93 84 14 00  	addi	s1, s1, 1
   12c78: 23 2e 01 00  	sw	zero, 28(sp)
   12c7c: 93 09 00 00  	li	s3, 0
   12c80: 13 06 40 00  	li	a2, 4
   12c84: b3 85 34 01  	add	a1, s1, s3
   12c88: 13 05 c1 01  	addi	a0, sp, 28
   12c8c: 23 34 d1 00  	sd	a3, 8(sp)
   12c90: ef 00 00 42  	jal	0x130b0 <mbtowc>
   12c94: 83 27 c1 01  	lw	a5, 28(sp)
   12c98: 83 36 81 00  	ld	a3, 8(sp)
   12c9c: 63 5c a0 00  	blez	a0, 0x12cb4 <getopt+0x1ac>
   12ca0: bb 89 a9 00  	addw	s3, s3, a0
   12ca4: 03 26 81 01  	lw	a2, 24(sp)
   12ca8: 1b 87 07 00  	sext.w	a4, a5
   12cac: e3 1a c7 fc  	bne	a4, a2, 0x12c80 <getopt+0x178>
   12cb0: 6f 00 c0 00  	j	0x12cbc <getopt+0x1b4>
   12cb4: 9b 89 19 00  	addiw	s3, s3, 1
   12cb8: e3 16 05 fe  	bnez	a0, 0x12ca4 <getopt+0x19c>
   12cbc: 03 25 81 01  	lw	a0, 24(sp)
   12cc0: 9b 87 07 00  	sext.w	a5, a5
   12cc4: 63 96 a7 00  	bne	a5, a0, 0x12cd0 <getopt+0x1c8>
   12cc8: 93 07 a0 03  	li	a5, 58
   12ccc: 63 1e f5 02  	bne	a0, a5, 0x12d08 <getopt+0x200>
   12cd0: 23 a4 a1 a0  	sw	a0, -1528(gp)
   12cd4: 03 c7 04 00  	lbu	a4, 0(s1)
   12cd8: 93 07 a0 03  	li	a5, 58
   12cdc: 63 16 f7 00  	bne	a4, a5, 0x12ce8 <getopt+0x1e0>
   12ce0: 13 05 f0 03  	li	a0, 63
   12ce4: 6f f0 df eb  	j	0x12ba0 <getopt+0x98>
   12ce8: 83 a7 81 98  	lw	a5, -1656(gp)
   12cec: e3 8a 07 fe  	beqz	a5, 0x12ce0 <getopt+0x1d8>
   12cf0: b7 b5 01 00  	lui	a1, 27
   12cf4: 13 06 0b 00  	mv	a2, s6
   12cf8: 93 85 85 46  	addi	a1, a1, 1128
   12cfc: 03 35 0a 00  	ld	a0, 0(s4)
   12d00: ef f0 9f d0  	jal	0x12a08 <__getopt_msg>
   12d04: 6f f0 df fd  	j	0x12ce0 <getopt+0x1d8>
   12d08: b3 89 34 01  	add	s3, s1, s3
   12d0c: 83 c5 09 00  	lbu	a1, 0(s3)
   12d10: e3 98 f5 e8  	bne	a1, a5, 0x12ba0 <getopt+0x98>
   12d14: 23 b0 01 a0  	sd	zero, -1536(gp)
   12d18: 03 c8 19 00  	lbu	a6, 1(s3)
   12d1c: 03 26 09 00  	lw	a2, 0(s2)
   12d20: 13 87 01 a0  	addi	a4, gp, -1536
   12d24: 63 14 b8 00  	bne	a6, a1, 0x12d2c <getopt+0x224>
   12d28: 63 04 06 02  	beqz	a2, 0x12d50 <getopt+0x248>
   12d2c: 83 27 04 00  	lw	a5, 0(s0)
   12d30: 9b 85 17 00  	addiw	a1, a5, 1
   12d34: 93 97 37 00  	slli	a5, a5, 3
   12d38: b3 07 fa 00  	add	a5, s4, a5
   12d3c: 83 b7 07 00  	ld	a5, 0(a5)
   12d40: 23 20 b4 00  	sw	a1, 0(s0)
   12d44: 23 20 09 00  	sw	zero, 0(s2)
   12d48: b3 87 c7 00  	add	a5, a5, a2
   12d4c: 23 30 f7 00  	sd	a5, 0(a4)
   12d50: 83 27 04 00  	lw	a5, 0(s0)
   12d54: e3 d6 fa e4  	bge	s5, a5, 0x12ba0 <getopt+0x98>
   12d58: 23 a4 a1 a0  	sw	a0, -1528(gp)
   12d5c: 03 c7 04 00  	lbu	a4, 0(s1)
   12d60: 93 07 a0 03  	li	a5, 58
   12d64: 13 05 a0 03  	li	a0, 58
   12d68: e3 0c f7 e2  	beq	a4, a5, 0x12ba0 <getopt+0x98>
   12d6c: 83 a7 81 98  	lw	a5, -1656(gp)
   12d70: e3 88 07 f6  	beqz	a5, 0x12ce0 <getopt+0x1d8>
   12d74: b7 b5 01 00  	lui	a1, 27
   12d78: 13 06 0b 00  	mv	a2, s6
   12d7c: 93 85 05 48  	addi	a1, a1, 1152
   12d80: 6f f0 df f7  	j	0x12cfc <getopt+0x1f4>

0000000000012d84 <getrlimit64>:
   12d84: 13 01 01 fd  	addi	sp, sp, -48
   12d88: 23 3c 91 00  	sd	s1, 24(sp)
   12d8c: 23 38 21 01  	sd	s2, 16(sp)
   12d90: 93 84 05 00  	mv	s1, a1
   12d94: 13 09 05 00  	mv	s2, a0
   12d98: 23 34 11 02  	sd	ra, 40(sp)
   12d9c: 23 30 81 02  	sd	s0, 32(sp)
   12da0: 93 08 50 10  	li	a7, 261
   12da4: 13 05 00 00  	li	a0, 0
   12da8: 93 05 09 00  	mv	a1, s2
   12dac: 13 06 00 00  	li	a2, 0
   12db0: 93 86 04 00  	mv	a3, s1
   12db4: 73 00 00 00  	ecall	
   12db8: ef e0 5f 9d  	jal	0x1178c <__syscall_ret>
   12dbc: 1b 04 05 00  	sext.w	s0, a0
   12dc0: 63 12 04 02  	bnez	s0, 0x12de4 <getrlimit64+0x60>
   12dc4: 13 04 00 00  	li	s0, 0
   12dc8: 83 30 81 02  	ld	ra, 40(sp)
   12dcc: 13 05 04 00  	mv	a0, s0
   12dd0: 03 34 01 02  	ld	s0, 32(sp)
   12dd4: 83 34 81 01  	ld	s1, 24(sp)
   12dd8: 03 39 01 01  	ld	s2, 16(sp)
   12ddc: 13 01 01 03  	addi	sp, sp, 48
   12de0: 67 80 00 00  	ret
   12de4: ef e0 df 83  	jal	0x11620 <__errno_location>
   12de8: 03 27 05 00  	lw	a4, 0(a0)
   12dec: 93 07 60 02  	li	a5, 38
   12df0: e3 1c f7 fc  	bne	a4, a5, 0x12dc8 <getrlimit64+0x44>
   12df4: 93 08 30 0a  	li	a7, 163
   12df8: 13 05 09 00  	mv	a0, s2
   12dfc: 93 05 01 00  	mv	a1, sp
   12e00: 73 00 00 00  	ecall	
   12e04: ef e0 9f 98  	jal	0x1178c <__syscall_ret>
   12e08: 13 04 f0 ff  	li	s0, -1
   12e0c: e3 4e 05 fa  	bltz	a0, 0x12dc8 <getrlimit64+0x44>
   12e10: 83 37 01 00  	ld	a5, 0(sp)
   12e14: 23 b0 f4 00  	sd	a5, 0(s1)
   12e18: 83 37 81 00  	ld	a5, 8(sp)
   12e1c: 23 b4 f4 00  	sd	a5, 8(s1)
   12e20: 6f f0 5f fa  	j	0x12dc4 <getrlimit64+0x40>

0000000000012e24 <do_setrlimit>:
   12e24: 83 27 c5 00  	lw	a5, 12(a0)
   12e28: 63 48 f0 06  	bgtz	a5, 0x12e98 <do_setrlimit+0x74>
   12e2c: 03 36 05 00  	ld	a2, 0(a0)
   12e30: 83 25 85 00  	lw	a1, 8(a0)
   12e34: 13 07 05 00  	mv	a4, a0
   12e38: 93 08 50 10  	li	a7, 261
   12e3c: 13 05 00 00  	li	a0, 0
   12e40: 93 06 00 00  	li	a3, 0
   12e44: 73 00 00 00  	ecall	
   12e48: 93 06 a0 fd  	li	a3, -38
   12e4c: 9b 07 05 00  	sext.w	a5, a0
   12e50: 63 9e d7 02  	bne	a5, a3, 0x12e8c <do_setrlimit+0x68>
   12e54: 83 37 06 00  	ld	a5, 0(a2)
   12e58: 13 01 01 ff  	addi	sp, sp, -16
   12e5c: 13 85 05 00  	mv	a0, a1
   12e60: 23 30 f1 00  	sd	a5, 0(sp)
   12e64: 83 37 86 00  	ld	a5, 8(a2)
   12e68: 93 08 40 0a  	li	a7, 164
   12e6c: 93 05 01 00  	mv	a1, sp
   12e70: 23 34 f1 00  	sd	a5, 8(sp)
   12e74: 73 00 00 00  	ecall	
   12e78: 9b 07 05 00  	sext.w	a5, a0
   12e7c: bb 07 f0 40  	negw	a5, a5
   12e80: 23 26 f7 00  	sw	a5, 12(a4)
   12e84: 13 01 01 01  	addi	sp, sp, 16
   12e88: 67 80 00 00  	ret
   12e8c: bb 07 f0 40  	negw	a5, a5
   12e90: 23 26 f7 00  	sw	a5, 12(a4)
   12e94: 67 80 00 00  	ret
   12e98: 67 80 00 00  	ret

0000000000012e9c <setrlimit64>:
   12e9c: 13 01 01 fe  	addi	sp, sp, -32
   12ea0: 23 24 a1 00  	sw	a0, 8(sp)
   12ea4: 37 35 01 00  	lui	a0, 19
   12ea8: 23 30 b1 00  	sd	a1, 0(sp)
   12eac: 93 07 f0 ff  	li	a5, -1
   12eb0: 93 05 01 00  	mv	a1, sp
   12eb4: 13 05 45 e2  	addi	a0, a0, -476
   12eb8: 23 38 81 00  	sd	s0, 16(sp)
   12ebc: 23 3c 11 00  	sd	ra, 24(sp)
   12ec0: 23 26 f1 00  	sw	a5, 12(sp)
   12ec4: ef 10 80 7d  	jal	0x1469c <__synccall>
   12ec8: 03 24 c1 00  	lw	s0, 12(sp)
   12ecc: 63 0a 04 00  	beqz	s0, 0x12ee0 <setrlimit64+0x44>
   12ed0: 63 56 80 00  	blez	s0, 0x12edc <setrlimit64+0x40>
   12ed4: ef e0 cf f4  	jal	0x11620 <__errno_location>
   12ed8: 23 20 85 00  	sw	s0, 0(a0)
   12edc: 13 04 f0 ff  	li	s0, -1
   12ee0: 83 30 81 01  	ld	ra, 24(sp)
   12ee4: 13 05 04 00  	mv	a0, s0
   12ee8: 03 34 01 01  	ld	s0, 16(sp)
   12eec: 13 01 01 02  	addi	sp, sp, 32
   12ef0: 67 80 00 00  	ret

0000000000012ef4 <madvise>:
   12ef4: 13 01 01 ff  	addi	sp, sp, -16
   12ef8: 23 34 11 00  	sd	ra, 8(sp)
   12efc: 93 08 90 0e  	li	a7, 233
   12f00: 73 00 00 00  	ecall	
   12f04: ef e0 9f 88  	jal	0x1178c <__syscall_ret>
   12f08: 83 30 81 00  	ld	ra, 8(sp)
   12f0c: 1b 05 05 00  	sext.w	a0, a0
   12f10: 13 01 01 01  	addi	sp, sp, 16
   12f14: 67 80 00 00  	ret

0000000000012f18 <dummy>:
   12f18: 67 80 00 00  	ret

0000000000012f1c <mmap64>:
   12f1c: 13 01 01 fc  	addi	sp, sp, -64
   12f20: 23 38 81 02  	sd	s0, 48(sp)
   12f24: 23 3c 11 02  	sd	ra, 56(sp)
   12f28: 13 84 06 00  	mv	s0, a3
   12f2c: 23 34 91 02  	sd	s1, 40(sp)
   12f30: 93 96 47 03  	slli	a3, a5, 52
   12f34: 63 84 06 02  	beqz	a3, 0x12f5c <mmap64+0x40>
   12f38: ef e0 8f ee  	jal	0x11620 <__errno_location>
   12f3c: 93 07 60 01  	li	a5, 22
   12f40: 83 30 81 03  	ld	ra, 56(sp)
   12f44: 03 34 01 03  	ld	s0, 48(sp)
   12f48: 23 20 f5 00  	sw	a5, 0(a0)
   12f4c: 83 34 81 02  	ld	s1, 40(sp)
   12f50: 13 05 f0 ff  	li	a0, -1
   12f54: 13 01 01 04  	addi	sp, sp, 64
   12f58: 67 80 00 00  	ret
   12f5c: 93 06 d0 ff  	li	a3, -3
   12f60: 93 d6 16 00  	srli	a3, a3, 1
   12f64: 63 f8 b6 00  	bgeu	a3, a1, 0x12f74 <mmap64+0x58>
   12f68: ef e0 8f eb  	jal	0x11620 <__errno_location>
   12f6c: 93 07 c0 00  	li	a5, 12
   12f70: 6f f0 1f fd  	j	0x12f40 <mmap64+0x24>
   12f74: 93 76 04 01  	andi	a3, s0, 16
   12f78: 93 04 05 00  	mv	s1, a0
   12f7c: 63 84 06 02  	beqz	a3, 0x12fa4 <mmap64+0x88>
   12f80: 23 3c f1 00  	sd	a5, 24(sp)
   12f84: 23 38 e1 00  	sd	a4, 16(sp)
   12f88: 23 34 c1 00  	sd	a2, 8(sp)
   12f8c: 23 30 b1 00  	sd	a1, 0(sp)
   12f90: ef f0 9f f8  	jal	0x12f18 <dummy>
   12f94: 83 37 81 01  	ld	a5, 24(sp)
   12f98: 03 37 01 01  	ld	a4, 16(sp)
   12f9c: 03 36 81 00  	ld	a2, 8(sp)
   12fa0: 83 35 01 00  	ld	a1, 0(sp)
   12fa4: 93 08 e0 0d  	li	a7, 222
   12fa8: 13 85 04 00  	mv	a0, s1
   12fac: 93 06 04 00  	mv	a3, s0
   12fb0: 73 00 00 00  	ecall	
   12fb4: 93 07 f0 ff  	li	a5, -1
   12fb8: 63 1c f5 00  	bne	a0, a5, 0x12fd0 <mmap64+0xb4>
   12fbc: 63 9a 04 00  	bnez	s1, 0x12fd0 <mmap64+0xb4>
   12fc0: 13 74 04 03  	andi	s0, s0, 48
   12fc4: 93 07 00 02  	li	a5, 32
   12fc8: 63 14 f4 00  	bne	s0, a5, 0x12fd0 <mmap64+0xb4>
   12fcc: 13 05 40 ff  	li	a0, -12
   12fd0: 03 34 01 03  	ld	s0, 48(sp)
   12fd4: 83 30 81 03  	ld	ra, 56(sp)
   12fd8: 83 34 81 02  	ld	s1, 40(sp)
   12fdc: 13 01 01 04  	addi	sp, sp, 64
   12fe0: 6f e0 cf fa  	j	0x1178c <__syscall_ret>

0000000000012fe4 <dummy>:
   12fe4: 67 80 00 00  	ret

0000000000012fe8 <mremap>:
   12fe8: 13 01 01 fa  	addi	sp, sp, -96
   12fec: 23 34 f1 04  	sd	a5, 72(sp)
   12ff0: 93 07 d0 ff  	li	a5, -3
   12ff4: 23 3c 11 02  	sd	ra, 56(sp)
   12ff8: 23 30 e1 04  	sd	a4, 64(sp)
   12ffc: 23 38 01 05  	sd	a6, 80(sp)
   13000: 23 3c 11 05  	sd	a7, 88(sp)
   13004: 93 d7 17 00  	srli	a5, a5, 1
   13008: 63 f0 c7 02  	bgeu	a5, a2, 0x13028 <mremap+0x40>
   1300c: ef e0 4f e1  	jal	0x11620 <__errno_location>
   13010: 93 07 c0 00  	li	a5, 12
   13014: 23 20 f5 00  	sw	a5, 0(a0)
   13018: 13 05 f0 ff  	li	a0, -1
   1301c: 83 30 81 03  	ld	ra, 56(sp)
   13020: 13 01 01 06  	addi	sp, sp, 96
   13024: 67 80 00 00  	ret
   13028: 93 f7 26 00  	andi	a5, a3, 2
   1302c: 13 07 00 00  	li	a4, 0
   13030: 63 8a 07 02  	beqz	a5, 0x13064 <mremap+0x7c>
   13034: 23 3c d1 00  	sd	a3, 24(sp)
   13038: 23 38 c1 00  	sd	a2, 16(sp)
   1303c: 23 34 b1 00  	sd	a1, 8(sp)
   13040: 23 30 a1 00  	sd	a0, 0(sp)
   13044: ef f0 5f ed  	jal	0x12f18 <dummy>
   13048: 03 37 01 04  	ld	a4, 64(sp)
   1304c: 83 36 81 01  	ld	a3, 24(sp)
   13050: 03 36 01 01  	ld	a2, 16(sp)
   13054: 83 35 81 00  	ld	a1, 8(sp)
   13058: 03 35 01 00  	ld	a0, 0(sp)
   1305c: 93 07 01 04  	addi	a5, sp, 64
   13060: 23 34 f1 02  	sd	a5, 40(sp)
   13064: 93 08 80 0d  	li	a7, 216
   13068: 73 00 00 00  	ecall	
   1306c: ef e0 0f f2  	jal	0x1178c <__syscall_ret>
   13070: 6f f0 df fa  	j	0x1301c <mremap+0x34>

0000000000013074 <dummy>:
   13074: 67 80 00 00  	ret

0000000000013078 <munmap>:
   13078: 13 01 01 fe  	addi	sp, sp, -32
   1307c: 23 3c 11 00  	sd	ra, 24(sp)
   13080: 23 34 a1 00  	sd	a0, 8(sp)
   13084: 23 30 b1 00  	sd	a1, 0(sp)
   13088: ef f0 1f e9  	jal	0x12f18 <dummy>
   1308c: 03 35 81 00  	ld	a0, 8(sp)
   13090: 83 35 01 00  	ld	a1, 0(sp)
   13094: 93 08 70 0d  	li	a7, 215
   13098: 73 00 00 00  	ecall	
   1309c: ef e0 0f ef  	jal	0x1178c <__syscall_ret>
   130a0: 83 30 81 01  	ld	ra, 24(sp)
   130a4: 1b 05 05 00  	sext.w	a0, a0
   130a8: 13 01 01 02  	addi	sp, sp, 32
   130ac: 67 80 00 00  	ret

00000000000130b0 <mbtowc>:
   130b0: 63 8c 05 14  	beqz	a1, 0x13208 <mbtowc+0x158>
   130b4: 13 01 01 fe  	addi	sp, sp, -32
   130b8: 23 3c 11 00  	sd	ra, 24(sp)
   130bc: 63 0c 06 12  	beqz	a2, 0x131f4 <mbtowc+0x144>
   130c0: 63 14 05 00  	bnez	a0, 0x130c8 <mbtowc+0x18>
   130c4: 13 05 c1 00  	addi	a0, sp, 12
   130c8: 83 c7 05 00  	lbu	a5, 0(a1)
   130cc: 1b 97 87 01  	slliw	a4, a5, 24
   130d0: 1b 57 87 41  	sraiw	a4, a4, 24
   130d4: 63 4e 07 00  	bltz	a4, 0x130f0 <mbtowc+0x40>
   130d8: 9b 87 07 00  	sext.w	a5, a5
   130dc: 23 20 f5 00  	sw	a5, 0(a0)
   130e0: 33 35 f0 00  	snez	a0, a5
   130e4: 83 30 81 01  	ld	ra, 24(sp)
   130e8: 13 01 01 02  	addi	sp, sp, 32
   130ec: 67 80 00 00  	ret
   130f0: 93 06 02 00  	mv	a3, tp
   130f4: 83 b6 06 fd  	ld	a3, -48(a3)
   130f8: 83 b6 06 00  	ld	a3, 0(a3)
   130fc: 63 9e 06 00  	bnez	a3, 0x13118 <mbtowc+0x68>
   13100: b7 e7 00 00  	lui	a5, 14
   13104: 93 87 f7 ff  	addi	a5, a5, -1
   13108: 33 77 f7 00  	and	a4, a4, a5
   1310c: 23 20 e5 00  	sw	a4, 0(a0)
   13110: 13 05 10 00  	li	a0, 1
   13114: 6f f0 1f fd  	j	0x130e4 <mbtowc+0x34>
   13118: 9b 87 e7 f3  	addiw	a5, a5, -194
   1311c: 9b 86 07 00  	sext.w	a3, a5
   13120: 13 07 20 03  	li	a4, 50
   13124: 63 68 d7 0c  	bltu	a4, a3, 0x131f4 <mbtowc+0x144>
   13128: 37 b7 01 00  	lui	a4, 27
   1312c: 93 97 07 02  	slli	a5, a5, 32
   13130: 13 07 07 7b  	addi	a4, a4, 1968
   13134: 93 d7 e7 01  	srli	a5, a5, 30
   13138: b3 07 f7 00  	add	a5, a4, a5
   1313c: 03 a7 07 00  	lw	a4, 0(a5)
   13140: 93 07 30 00  	li	a5, 3
   13144: 63 ec c7 00  	bltu	a5, a2, 0x1315c <mbtowc+0xac>
   13148: 93 07 60 00  	li	a5, 6
   1314c: bb 87 c7 02  	<unknown>
   13150: 9b 87 a7 ff  	addiw	a5, a5, -6
   13154: bb 17 f7 00  	sllw	a5, a4, a5
   13158: 63 ce 07 08  	bltz	a5, 0x131f4 <mbtowc+0x144>
   1315c: 83 c7 15 00  	lbu	a5, 1(a1)
   13160: 9b 56 a7 41  	sraiw	a3, a4, 26
   13164: 1b d6 37 00  	srliw	a2, a5, 3
   13168: bb 86 c6 00  	addw	a3, a3, a2
   1316c: 1b 06 06 ff  	addiw	a2, a2, -16
   13170: b3 e6 c6 00  	or	a3, a3, a2
   13174: 93 f6 86 ff  	andi	a3, a3, -8
   13178: 9b 86 06 00  	sext.w	a3, a3
   1317c: 63 9c 06 06  	bnez	a3, 0x131f4 <mbtowc+0x144>
   13180: 9b 16 67 00  	slliw	a3, a4, 6
   13184: 1b 87 07 f8  	addiw	a4, a5, -128
   13188: 33 67 d7 00  	or	a4, a4, a3
   1318c: 9b 06 07 00  	sext.w	a3, a4
   13190: 63 c8 06 00  	bltz	a3, 0x131a0 <mbtowc+0xf0>
   13194: 23 20 d5 00  	sw	a3, 0(a0)
   13198: 13 05 20 00  	li	a0, 2
   1319c: 6f f0 9f f4  	j	0x130e4 <mbtowc+0x34>
   131a0: 83 c7 25 00  	lbu	a5, 2(a1)
   131a4: 13 06 f0 03  	li	a2, 63
   131a8: 9b 87 07 f8  	addiw	a5, a5, -128
   131ac: 1b 87 07 00  	sext.w	a4, a5
   131b0: 63 62 e6 04  	bltu	a2, a4, 0x131f4 <mbtowc+0x144>
   131b4: 1b 97 66 00  	slliw	a4, a3, 6
   131b8: b3 e7 e7 00  	or	a5, a5, a4
   131bc: 1b 87 07 00  	sext.w	a4, a5
   131c0: 63 48 07 00  	bltz	a4, 0x131d0 <mbtowc+0x120>
   131c4: 23 20 e5 00  	sw	a4, 0(a0)
   131c8: 13 05 30 00  	li	a0, 3
   131cc: 6f f0 9f f1  	j	0x130e4 <mbtowc+0x34>
   131d0: 83 c7 35 00  	lbu	a5, 3(a1)
   131d4: 9b 86 07 f8  	addiw	a3, a5, -128
   131d8: 9b 87 06 00  	sext.w	a5, a3
   131dc: 63 6c f6 00  	bltu	a2, a5, 0x131f4 <mbtowc+0x144>
   131e0: 9b 17 67 00  	slliw	a5, a4, 6
   131e4: b3 e7 d7 00  	or	a5, a5, a3
   131e8: 23 20 f5 00  	sw	a5, 0(a0)
   131ec: 13 05 40 00  	li	a0, 4
   131f0: 6f f0 5f ef  	j	0x130e4 <mbtowc+0x34>
   131f4: ef e0 cf c2  	jal	0x11620 <__errno_location>
   131f8: 93 07 40 05  	li	a5, 84
   131fc: 23 20 f5 00  	sw	a5, 0(a0)
   13200: 13 05 f0 ff  	li	a0, -1
   13204: 6f f0 1f ee  	j	0x130e4 <mbtowc+0x34>
   13208: 13 05 00 00  	li	a0, 0
   1320c: 67 80 00 00  	ret

0000000000013210 <execv>:
   13210: 03 b6 01 a3  	ld	a2, -1488(gp)
   13214: 6f 00 40 00  	j	0x13218 <execve>

0000000000013218 <execve>:
   13218: 13 01 01 ff  	addi	sp, sp, -16
   1321c: 23 34 11 00  	sd	ra, 8(sp)
   13220: 93 08 d0 0d  	li	a7, 221
   13224: 73 00 00 00  	ecall	
   13228: ef e0 4f d6  	jal	0x1178c <__syscall_ret>
   1322c: 83 30 81 00  	ld	ra, 8(sp)
   13230: 1b 05 05 00  	sext.w	a0, a0
   13234: 13 01 01 01  	addi	sp, sp, 16
   13238: 67 80 00 00  	ret

000000000001323c <dummy>:
   1323c: 67 80 00 00  	ret

0000000000013240 <fork>:
   13240: 13 01 01 f7  	addi	sp, sp, -144
   13244: 13 05 f0 ff  	li	a0, -1
   13248: 23 34 11 08  	sd	ra, 136(sp)
   1324c: 23 30 81 08  	sd	s0, 128(sp)
   13250: ef f0 df fe  	jal	0x1323c <dummy>
   13254: 13 05 01 00  	mv	a0, sp
   13258: ef 00 40 0b  	jal	0x1330c <__block_all_sigs>
   1325c: 93 08 c0 0d  	li	a7, 220
   13260: 13 05 10 01  	li	a0, 17
   13264: 93 05 00 00  	li	a1, 0
   13268: 73 00 00 00  	ecall	
   1326c: 1b 04 05 00  	sext.w	s0, a0
   13270: 63 1a 04 02  	bnez	s0, 0x132a4 <fork+0x64>
   13274: 93 07 02 00  	mv	a5, tp
   13278: 93 08 20 0b  	li	a7, 178
   1327c: 13 87 07 f2  	addi	a4, a5, -224
   13280: 73 00 00 00  	ecall	
   13284: 23 b0 07 fc  	sd	zero, -64(a5)
   13288: 23 ac a7 f4  	sw	a0, -168(a5)
   1328c: 23 bc 07 fa  	sd	zero, -72(a5)
   13290: 23 b8 e7 f2  	sd	a4, -208(a5)
   13294: 23 bc e7 f2  	sd	a4, -200(a5)
   13298: 23 ac 01 a2  	sw	zero, -1480(gp)
   1329c: 93 87 81 bc  	addi	a5, gp, -1080
   132a0: 23 a6 07 00  	sw	zero, 12(a5)
   132a4: 13 05 01 00  	mv	a0, sp
   132a8: ef 00 c0 09  	jal	0x13344 <__restore_sigs>
   132ac: 13 35 14 00  	seqz	a0, s0
   132b0: ef f0 df f8  	jal	0x1323c <dummy>
   132b4: 13 05 04 00  	mv	a0, s0
   132b8: ef e0 4f cd  	jal	0x1178c <__syscall_ret>
   132bc: 83 30 81 08  	ld	ra, 136(sp)
   132c0: 03 34 01 08  	ld	s0, 128(sp)
   132c4: 1b 05 05 00  	sext.w	a0, a0
   132c8: 13 01 01 09  	addi	sp, sp, 144
   132cc: 67 80 00 00  	ret

00000000000132d0 <waitpid>:
   132d0: 13 01 01 ff  	addi	sp, sp, -16
   132d4: 93 06 06 00  	mv	a3, a2
   132d8: 13 08 00 00  	li	a6, 0
   132dc: 13 86 05 00  	mv	a2, a1
   132e0: 93 07 00 00  	li	a5, 0
   132e4: 93 05 05 00  	mv	a1, a0
   132e8: 13 07 00 00  	li	a4, 0
   132ec: 13 05 40 10  	li	a0, 260
   132f0: 23 34 11 00  	sd	ra, 8(sp)
   132f4: ef 10 c0 1a  	jal	0x144a0 <__syscall_cp>
   132f8: ef e0 4f c9  	jal	0x1178c <__syscall_ret>
   132fc: 83 30 81 00  	ld	ra, 8(sp)
   13300: 1b 05 05 00  	sext.w	a0, a0
   13304: 13 01 01 01  	addi	sp, sp, 16
   13308: 67 80 00 00  	ret

000000000001330c <__block_all_sigs>:
   1330c: 13 06 05 00  	mv	a2, a0
   13310: 93 08 70 08  	li	a7, 135
   13314: 13 05 00 00  	li	a0, 0
   13318: 93 85 01 96  	addi	a1, gp, -1696
   1331c: 93 06 80 00  	li	a3, 8
   13320: 73 00 00 00  	ecall	
   13324: 67 80 00 00  	ret

0000000000013328 <__block_app_sigs>:
   13328: 13 06 05 00  	mv	a2, a0
   1332c: 93 08 70 08  	li	a7, 135
   13330: 13 05 00 00  	li	a0, 0
   13334: 93 85 81 96  	addi	a1, gp, -1688
   13338: 93 06 80 00  	li	a3, 8
   1333c: 73 00 00 00  	ecall	
   13340: 67 80 00 00  	ret

0000000000013344 <__restore_sigs>:
   13344: 93 05 05 00  	mv	a1, a0
   13348: 93 08 70 08  	li	a7, 135
   1334c: 13 05 20 00  	li	a0, 2
   13350: 13 06 00 00  	li	a2, 0
   13354: 93 06 80 00  	li	a3, 8
   13358: 73 00 00 00  	ecall	
   1335c: 67 80 00 00  	ret

0000000000013360 <kill>:
   13360: 13 01 01 ff  	addi	sp, sp, -16
   13364: 23 34 11 00  	sd	ra, 8(sp)
   13368: 93 08 10 08  	li	a7, 129
   1336c: 73 00 00 00  	ecall	
   13370: ef e0 cf c1  	jal	0x1178c <__syscall_ret>
   13374: 83 30 81 00  	ld	ra, 8(sp)
   13378: 1b 05 05 00  	sext.w	a0, a0
   1337c: 13 01 01 01  	addi	sp, sp, 16
   13380: 67 80 00 00  	ret

0000000000013384 <sigaddset>:
   13384: 1b 87 f5 ff  	addiw	a4, a1, -1
   13388: 93 07 f0 03  	li	a5, 63
   1338c: 63 e8 e7 00  	bltu	a5, a4, 0x1339c <sigaddset+0x18>
   13390: 9b 85 05 fe  	addiw	a1, a1, -32
   13394: 93 07 20 00  	li	a5, 2
   13398: 63 e4 b7 02  	bltu	a5, a1, 0x133c0 <sigaddset+0x3c>
   1339c: 13 01 01 ff  	addi	sp, sp, -16
   133a0: 23 34 11 00  	sd	ra, 8(sp)
   133a4: ef e0 cf a7  	jal	0x11620 <__errno_location>
   133a8: 83 30 81 00  	ld	ra, 8(sp)
   133ac: 93 07 60 01  	li	a5, 22
   133b0: 23 20 f5 00  	sw	a5, 0(a0)
   133b4: 13 05 f0 ff  	li	a0, -1
   133b8: 13 01 01 01  	addi	sp, sp, 16
   133bc: 67 80 00 00  	ret
   133c0: 93 07 10 00  	li	a5, 1
   133c4: 33 97 e7 00  	sll	a4, a5, a4
   133c8: 83 37 05 00  	ld	a5, 0(a0)
   133cc: b3 e7 e7 00  	or	a5, a5, a4
   133d0: 23 30 f5 00  	sd	a5, 0(a0)
   133d4: 13 05 00 00  	li	a0, 0
   133d8: 67 80 00 00  	ret

00000000000133dc <sigemptyset>:
   133dc: 23 30 05 00  	sd	zero, 0(a0)
   133e0: 13 05 00 00  	li	a0, 0
   133e4: 67 80 00 00  	ret

00000000000133e8 <signal>:
   133e8: 13 01 01 eb  	addi	sp, sp, -336
   133ec: 23 30 81 14  	sd	s0, 320(sp)
   133f0: 23 3c 91 12  	sd	s1, 312(sp)
   133f4: 13 04 05 00  	mv	s0, a0
   133f8: 93 84 05 00  	mv	s1, a1
   133fc: 13 06 00 09  	li	a2, 144
   13400: 93 05 00 00  	li	a1, 0
   13404: 13 05 01 0a  	addi	a0, sp, 160
   13408: 23 34 11 14  	sd	ra, 328(sp)
   1340c: ef 00 90 47  	jal	0x14084 <memset>
   13410: b7 07 00 10  	lui	a5, 65536
   13414: 13 06 01 00  	mv	a2, sp
   13418: 93 05 81 09  	addi	a1, sp, 152
   1341c: 13 05 04 00  	mv	a0, s0
   13420: 23 3c 91 08  	sd	s1, 152(sp)
   13424: 23 20 f1 12  	sw	a5, 288(sp)
   13428: ef 10 10 6e  	jal	0x15308 <sigaction>
   1342c: 63 4e 05 00  	bltz	a0, 0x13448 <signal+0x60>
   13430: 03 35 01 00  	ld	a0, 0(sp)
   13434: 83 30 81 14  	ld	ra, 328(sp)
   13438: 03 34 01 14  	ld	s0, 320(sp)
   1343c: 83 34 81 13  	ld	s1, 312(sp)
   13440: 13 01 01 15  	addi	sp, sp, 336
   13444: 67 80 00 00  	ret
   13448: 13 05 f0 ff  	li	a0, -1
   1344c: 6f f0 9f fe  	j	0x13434 <signal+0x4c>

0000000000013450 <sigprocmask>:
   13450: 13 01 01 ff  	addi	sp, sp, -16
   13454: 23 30 81 00  	sd	s0, 0(sp)
   13458: 23 34 11 00  	sd	ra, 8(sp)
   1345c: ef 10 40 16  	jal	0x145c0 <pthread_sigmask>
   13460: 13 04 05 00  	mv	s0, a0
   13464: 63 08 05 00  	beqz	a0, 0x13474 <sigprocmask+0x24>
   13468: ef e0 8f 9b  	jal	0x11620 <__errno_location>
   1346c: 23 20 85 00  	sw	s0, 0(a0)
   13470: 13 04 f0 ff  	li	s0, -1
   13474: 83 30 81 00  	ld	ra, 8(sp)
   13478: 13 05 04 00  	mv	a0, s0
   1347c: 03 34 01 00  	ld	s0, 0(sp)
   13480: 13 01 01 01  	addi	sp, sp, 16
   13484: 67 80 00 00  	ret

0000000000013488 <sigtimedwait>:
   13488: 13 01 01 fd  	addi	sp, sp, -48
   1348c: 23 30 81 02  	sd	s0, 32(sp)
   13490: 23 3c 91 00  	sd	s1, 24(sp)
   13494: 23 38 21 01  	sd	s2, 16(sp)
   13498: 23 34 31 01  	sd	s3, 8(sp)
   1349c: 23 34 11 02  	sd	ra, 40(sp)
   134a0: 13 04 05 00  	mv	s0, a0
   134a4: 93 84 05 00  	mv	s1, a1
   134a8: 13 09 06 00  	mv	s2, a2
   134ac: 93 09 c0 ff  	li	s3, -4
   134b0: 13 08 00 00  	li	a6, 0
   134b4: 93 07 00 00  	li	a5, 0
   134b8: 13 07 80 00  	li	a4, 8
   134bc: 93 06 09 00  	mv	a3, s2
   134c0: 13 86 04 00  	mv	a2, s1
   134c4: 93 05 04 00  	mv	a1, s0
   134c8: 13 05 90 08  	li	a0, 137
   134cc: ef 00 50 7d  	jal	0x144a0 <__syscall_cp>
   134d0: 1b 05 05 00  	sext.w	a0, a0
   134d4: e3 0e 35 fd  	beq	a0, s3, 0x134b0 <sigtimedwait+0x28>
   134d8: ef e0 4f ab  	jal	0x1178c <__syscall_ret>
   134dc: 83 30 81 02  	ld	ra, 40(sp)
   134e0: 03 34 01 02  	ld	s0, 32(sp)
   134e4: 83 34 81 01  	ld	s1, 24(sp)
   134e8: 03 39 01 01  	ld	s2, 16(sp)
   134ec: 83 39 81 00  	ld	s3, 8(sp)
   134f0: 1b 05 05 00  	sext.w	a0, a0
   134f4: 13 01 01 03  	addi	sp, sp, 48
   134f8: 67 80 00 00  	ret

00000000000134fc <__lockfile>:
   134fc: 83 27 c5 08  	lw	a5, 140(a0)
   13500: 9b 87 07 00  	sext.w	a5, a5
   13504: 13 07 02 00  	mv	a4, tp
   13508: b7 06 00 c0  	lui	a3, 786432
   1350c: 03 27 87 f5  	lw	a4, -168(a4)
   13510: 93 86 f6 ff  	addi	a3, a3, -1
   13514: b3 f7 d7 00  	and	a5, a5, a3
   13518: 63 88 e7 0a  	beq	a5, a4, 0x135c8 <__lockfile+0xcc>
   1351c: 93 07 c5 08  	addi	a5, a0, 140
   13520: 13 06 00 00  	li	a2, 0
   13524: af a6 07 16  	<unknown>
   13528: 63 96 c6 00  	bne	a3, a2, 0x13534 <__lockfile+0x38>
   1352c: af a5 e7 1e  	<unknown>
   13530: e3 9a 05 fe  	bnez	a1, 0x13524 <__lockfile+0x28>
   13534: 9b 86 06 00  	sext.w	a3, a3
   13538: 63 88 06 02  	beqz	a3, 0x13568 <__lockfile+0x6c>
   1353c: 37 08 00 40  	lui	a6, 262144
   13540: 33 67 07 01  	or	a4, a4, a6
   13544: 13 03 00 00  	li	t1, 0
   13548: 1b 07 07 00  	sext.w	a4, a4
   1354c: 13 0e a0 fd  	li	t3, -38
   13550: af a6 07 16  	<unknown>
   13554: 63 96 66 00  	bne	a3, t1, 0x13560 <__lockfile+0x64>
   13558: 2f a6 e7 1e  	<unknown>
   1355c: e3 1a 06 fe  	bnez	a2, 0x13550 <__lockfile+0x54>
   13560: 9b 86 06 00  	sext.w	a3, a3
   13564: 63 96 06 00  	bnez	a3, 0x13570 <__lockfile+0x74>
   13568: 13 05 10 00  	li	a0, 1
   1356c: 67 80 00 00  	ret
   13570: b3 f5 06 01  	and	a1, a3, a6
   13574: 33 e6 06 01  	or	a2, a3, a6
   13578: 9b 85 05 00  	sext.w	a1, a1
   1357c: 1b 06 06 00  	sext.w	a2, a2
   13580: 63 86 05 02  	beqz	a1, 0x135ac <__lockfile+0xb0>
   13584: 93 08 20 06  	li	a7, 98
   13588: 13 85 07 00  	mv	a0, a5
   1358c: 93 05 00 08  	li	a1, 128
   13590: 93 06 00 00  	li	a3, 0
   13594: 73 00 00 00  	ecall	
   13598: e3 1c c5 fb  	bne	a0, t3, 0x13550 <__lockfile+0x54>
   1359c: 13 85 07 00  	mv	a0, a5
   135a0: 93 05 00 00  	li	a1, 0
   135a4: 73 00 00 00  	ecall	
   135a8: 6f f0 9f fa  	j	0x13550 <__lockfile+0x54>
   135ac: af a5 07 16  	<unknown>
   135b0: 63 96 d5 00  	bne	a1, a3, 0x135bc <__lockfile+0xc0>
   135b4: 2f a5 c7 1e  	<unknown>
   135b8: e3 1a 05 fe  	bnez	a0, 0x135ac <__lockfile+0xb0>
   135bc: 9b 85 05 00  	sext.w	a1, a1
   135c0: e3 98 d5 f8  	bne	a1, a3, 0x13550 <__lockfile+0x54>
   135c4: 6f f0 1f fc  	j	0x13584 <__lockfile+0x88>
   135c8: 13 05 00 00  	li	a0, 0
   135cc: 67 80 00 00  	ret

00000000000135d0 <__unlockfile>:
   135d0: 13 07 c5 08  	addi	a4, a0, 140
   135d4: 13 06 00 00  	li	a2, 0
   135d8: 83 27 c5 08  	lw	a5, 140(a0)
   135dc: 9b 87 07 00  	sext.w	a5, a5
   135e0: af 26 07 16  	<unknown>
   135e4: 63 96 f6 00  	bne	a3, a5, 0x135f0 <__unlockfile+0x20>
   135e8: af 25 c7 1e  	<unknown>
   135ec: e3 9a 05 fe  	bnez	a1, 0x135e0 <__unlockfile+0x10>
   135f0: 9b 86 06 00  	sext.w	a3, a3
   135f4: e3 92 d7 fe  	bne	a5, a3, 0x135d8 <__unlockfile+0x8>
   135f8: 93 d7 e7 01  	srli	a5, a5, 30
   135fc: 93 f7 17 00  	andi	a5, a5, 1
   13600: 63 86 07 02  	beqz	a5, 0x1362c <__unlockfile+0x5c>
   13604: 93 08 20 06  	li	a7, 98
   13608: 13 05 07 00  	mv	a0, a4
   1360c: 93 05 10 08  	li	a1, 129
   13610: 13 06 10 00  	li	a2, 1
   13614: 73 00 00 00  	ecall	
   13618: 93 07 a0 fd  	li	a5, -38
   1361c: 63 18 f5 00  	bne	a0, a5, 0x1362c <__unlockfile+0x5c>
   13620: 13 05 07 00  	mv	a0, a4
   13624: 93 05 10 00  	li	a1, 1
   13628: 73 00 00 00  	ecall	
   1362c: 67 80 00 00  	ret

0000000000013630 <fputs_unlocked>:
   13630: 13 01 01 fd  	addi	sp, sp, -48
   13634: 23 34 11 02  	sd	ra, 40(sp)
   13638: 23 30 81 02  	sd	s0, 32(sp)
   1363c: 23 3c 91 00  	sd	s1, 24(sp)
   13640: 23 34 b1 00  	sd	a1, 8(sp)
   13644: 93 04 05 00  	mv	s1, a0
   13648: ef 00 d0 3f  	jal	0x14244 <strlen>
   1364c: 83 36 81 00  	ld	a3, 8(sp)
   13650: 13 04 05 00  	mv	s0, a0
   13654: 13 06 05 00  	mv	a2, a0
   13658: 93 05 10 00  	li	a1, 1
   1365c: 13 85 04 00  	mv	a0, s1
   13660: ef 00 00 13  	jal	0x13790 <fwrite_unlocked>
   13664: 83 30 81 02  	ld	ra, 40(sp)
   13668: 33 05 85 40  	sub	a0, a0, s0
   1366c: 03 34 01 02  	ld	s0, 32(sp)
   13670: 33 35 a0 00  	snez	a0, a0
   13674: 83 34 81 01  	ld	s1, 24(sp)
   13678: 33 05 a0 40  	neg	a0, a0
   1367c: 13 01 01 03  	addi	sp, sp, 48
   13680: 67 80 00 00  	ret

0000000000013684 <__fwritex>:
   13684: 83 37 06 02  	ld	a5, 32(a2)
   13688: 13 01 01 fd  	addi	sp, sp, -48
   1368c: 23 30 81 02  	sd	s0, 32(sp)
   13690: 23 38 21 01  	sd	s2, 16(sp)
   13694: 23 34 31 01  	sd	s3, 8(sp)
   13698: 23 34 11 02  	sd	ra, 40(sp)
   1369c: 23 3c 91 00  	sd	s1, 24(sp)
   136a0: 93 09 05 00  	mv	s3, a0
   136a4: 13 89 05 00  	mv	s2, a1
   136a8: 13 04 06 00  	mv	s0, a2
   136ac: 63 80 07 04  	beqz	a5, 0x136ec <__fwritex+0x68>
   136b0: 83 37 04 02  	ld	a5, 32(s0)
   136b4: 03 37 84 02  	ld	a4, 40(s0)
   136b8: b3 87 e7 40  	sub	a5, a5, a4
   136bc: 63 f2 27 05  	bgeu	a5, s2, 0x13700 <__fwritex+0x7c>
   136c0: 83 37 84 04  	ld	a5, 72(s0)
   136c4: 13 05 04 00  	mv	a0, s0
   136c8: 03 34 01 02  	ld	s0, 32(sp)
   136cc: 83 30 81 02  	ld	ra, 40(sp)
   136d0: 83 34 81 01  	ld	s1, 24(sp)
   136d4: 13 06 09 00  	mv	a2, s2
   136d8: 93 85 09 00  	mv	a1, s3
   136dc: 03 39 01 01  	ld	s2, 16(sp)
   136e0: 83 39 81 00  	ld	s3, 8(sp)
   136e4: 13 01 01 03  	addi	sp, sp, 48
   136e8: 67 80 07 00  	jr	a5
   136ec: 13 05 06 00  	mv	a0, a2
   136f0: ef 10 90 62  	jal	0x15518 <__towrite>
   136f4: e3 0e 05 fa  	beqz	a0, 0x136b0 <__fwritex+0x2c>
   136f8: 13 05 00 00  	li	a0, 0
   136fc: 6f 00 40 03  	j	0x13730 <__fwritex+0xac>
   13700: 83 27 04 09  	lw	a5, 144(s0)
   13704: 93 04 09 00  	mv	s1, s2
   13708: 13 07 a0 00  	li	a4, 10
   1370c: 63 d2 07 04  	bgez	a5, 0x13750 <__fwritex+0xcc>
   13710: 03 35 84 02  	ld	a0, 40(s0)
   13714: 13 86 04 00  	mv	a2, s1
   13718: 93 85 09 00  	mv	a1, s3
   1371c: ef 00 40 52  	jal	0x13c40 <memcpy>
   13720: 03 36 84 02  	ld	a2, 40(s0)
   13724: 13 05 09 00  	mv	a0, s2
   13728: b3 04 96 00  	add	s1, a2, s1
   1372c: 23 34 94 02  	sd	s1, 40(s0)
   13730: 83 30 81 02  	ld	ra, 40(sp)
   13734: 03 34 01 02  	ld	s0, 32(sp)
   13738: 83 34 81 01  	ld	s1, 24(sp)
   1373c: 03 39 01 01  	ld	s2, 16(sp)
   13740: 83 39 81 00  	ld	s3, 8(sp)
   13744: 13 01 01 03  	addi	sp, sp, 48
   13748: 67 80 00 00  	ret
   1374c: 93 84 07 00  	mv	s1, a5
   13750: 63 8c 04 02  	beqz	s1, 0x13788 <__fwritex+0x104>
   13754: 93 87 f4 ff  	addi	a5, s1, -1
   13758: b3 86 f9 00  	add	a3, s3, a5
   1375c: 83 c6 06 00  	lbu	a3, 0(a3)
   13760: e3 96 e6 fe  	bne	a3, a4, 0x1374c <__fwritex+0xc8>
   13764: 83 37 84 04  	ld	a5, 72(s0)
   13768: 13 86 04 00  	mv	a2, s1
   1376c: 93 85 09 00  	mv	a1, s3
   13770: 13 05 04 00  	mv	a0, s0
   13774: e7 80 07 00  	jalr	a5
   13778: e3 6c 95 fa  	bltu	a0, s1, 0x13730 <__fwritex+0xac>
   1377c: b3 89 99 00  	add	s3, s3, s1
   13780: b3 04 99 40  	sub	s1, s2, s1
   13784: 6f f0 df f8  	j	0x13710 <__fwritex+0x8c>
   13788: 93 04 09 00  	mv	s1, s2
   1378c: 6f f0 5f f8  	j	0x13710 <__fwritex+0x8c>

0000000000013790 <fwrite_unlocked>:
   13790: 13 01 01 fc  	addi	sp, sp, -64
   13794: 23 38 81 02  	sd	s0, 48(sp)
   13798: 23 34 91 02  	sd	s1, 40(sp)
   1379c: 23 30 21 03  	sd	s2, 32(sp)
   137a0: 23 3c 31 01  	sd	s3, 24(sp)
   137a4: 23 34 51 01  	sd	s5, 8(sp)
   137a8: 23 3c 11 02  	sd	ra, 56(sp)
   137ac: 23 38 41 01  	sd	s4, 16(sp)
   137b0: b3 8a c5 02  	<unknown>
   137b4: 93 09 05 00  	mv	s3, a0
   137b8: 13 89 05 00  	mv	s2, a1
   137bc: 93 84 06 00  	mv	s1, a3
   137c0: 13 04 00 00  	li	s0, 0
   137c4: 63 84 05 00  	beqz	a1, 0x137cc <fwrite_unlocked+0x3c>
   137c8: 13 04 06 00  	mv	s0, a2
   137cc: 83 a7 c4 08  	lw	a5, 140(s1)
   137d0: 13 0a 00 00  	li	s4, 0
   137d4: 9b 87 07 00  	sext.w	a5, a5
   137d8: 63 c8 07 00  	bltz	a5, 0x137e8 <fwrite_unlocked+0x58>
   137dc: 13 85 04 00  	mv	a0, s1
   137e0: ef f0 df d1  	jal	0x134fc <__lockfile>
   137e4: 13 0a 05 00  	mv	s4, a0
   137e8: 13 85 09 00  	mv	a0, s3
   137ec: 13 86 04 00  	mv	a2, s1
   137f0: 93 85 0a 00  	mv	a1, s5
   137f4: ef f0 1f e9  	jal	0x13684 <__fwritex>
   137f8: 93 09 05 00  	mv	s3, a0
   137fc: 63 06 0a 00  	beqz	s4, 0x13808 <fwrite_unlocked+0x78>
   13800: 13 85 04 00  	mv	a0, s1
   13804: ef f0 df dc  	jal	0x135d0 <__unlockfile>
   13808: 63 84 3a 01  	beq	s5, s3, 0x13810 <fwrite_unlocked+0x80>
   1380c: 33 d4 29 03  	<unknown>
   13810: 83 30 81 03  	ld	ra, 56(sp)
   13814: 13 05 04 00  	mv	a0, s0
   13818: 03 34 01 03  	ld	s0, 48(sp)
   1381c: 83 34 81 02  	ld	s1, 40(sp)
   13820: 03 39 01 02  	ld	s2, 32(sp)
   13824: 83 39 81 01  	ld	s3, 24(sp)
   13828: 03 3a 01 01  	ld	s4, 16(sp)
   1382c: 83 3a 81 00  	ld	s5, 8(sp)
   13830: 13 01 01 04  	addi	sp, sp, 64
   13834: 67 80 00 00  	ret

0000000000013838 <locking_putc>:
   13838: 13 01 01 fe  	addi	sp, sp, -32
   1383c: b7 07 00 40  	lui	a5, 262144
   13840: 23 38 81 00  	sd	s0, 16(sp)
   13844: 23 34 91 00  	sd	s1, 8(sp)
   13848: 23 30 21 01  	sd	s2, 0(sp)
   1384c: 23 3c 11 00  	sd	ra, 24(sp)
   13850: 13 09 05 00  	mv	s2, a0
   13854: 13 84 05 00  	mv	s0, a1
   13858: 93 84 c5 08  	addi	s1, a1, 140
   1385c: 93 06 00 00  	li	a3, 0
   13860: 93 87 f7 ff  	addi	a5, a5, -1
   13864: 2f a7 04 16  	<unknown>
   13868: 63 16 d7 00  	bne	a4, a3, 0x13874 <locking_putc+0x3c>
   1386c: 2f a6 f4 1e  	<unknown>
   13870: e3 1a 06 fe  	bnez	a2, 0x13864 <locking_putc+0x2c>
   13874: 9b 07 07 00  	sext.w	a5, a4
   13878: 63 86 07 00  	beqz	a5, 0x13884 <locking_putc+0x4c>
   1387c: 13 85 05 00  	mv	a0, a1
   13880: ef f0 df c7  	jal	0x134fc <__lockfile>
   13884: 83 27 04 09  	lw	a5, 144(s0)
   13888: 13 77 f9 0f  	andi	a4, s2, 255
   1388c: 63 88 e7 08  	beq	a5, a4, 0x1391c <locking_putc+0xe4>
   13890: 83 37 84 02  	ld	a5, 40(s0)
   13894: 83 36 04 02  	ld	a3, 32(s0)
   13898: 63 82 d7 08  	beq	a5, a3, 0x1391c <locking_putc+0xe4>
   1389c: 93 86 17 00  	addi	a3, a5, 1
   138a0: 23 34 d4 02  	sd	a3, 40(s0)
   138a4: 23 80 27 01  	sb	s2, 0(a5)
   138a8: 13 06 00 00  	li	a2, 0
   138ac: 83 27 c4 08  	lw	a5, 140(s0)
   138b0: 9b 87 07 00  	sext.w	a5, a5
   138b4: af a6 04 16  	<unknown>
   138b8: 63 96 f6 00  	bne	a3, a5, 0x138c4 <locking_putc+0x8c>
   138bc: af a5 c4 1e  	<unknown>
   138c0: e3 9a 05 fe  	bnez	a1, 0x138b4 <locking_putc+0x7c>
   138c4: 9b 86 06 00  	sext.w	a3, a3
   138c8: e3 92 d7 fe  	bne	a5, a3, 0x138ac <locking_putc+0x74>
   138cc: 93 d7 e7 01  	srli	a5, a5, 30
   138d0: 93 f7 17 00  	andi	a5, a5, 1
   138d4: 63 86 07 02  	beqz	a5, 0x13900 <locking_putc+0xc8>
   138d8: 93 08 20 06  	li	a7, 98
   138dc: 13 85 04 00  	mv	a0, s1
   138e0: 93 05 10 08  	li	a1, 129
   138e4: 13 06 10 00  	li	a2, 1
   138e8: 73 00 00 00  	ecall	
   138ec: 93 07 a0 fd  	li	a5, -38
   138f0: 63 18 f5 00  	bne	a0, a5, 0x13900 <locking_putc+0xc8>
   138f4: 13 85 04 00  	mv	a0, s1
   138f8: 93 05 10 00  	li	a1, 1
   138fc: 73 00 00 00  	ecall	
   13900: 83 30 81 01  	ld	ra, 24(sp)
   13904: 03 34 01 01  	ld	s0, 16(sp)
   13908: 83 34 81 00  	ld	s1, 8(sp)
   1390c: 03 39 01 00  	ld	s2, 0(sp)
   13910: 13 05 07 00  	mv	a0, a4
   13914: 13 01 01 02  	addi	sp, sp, 32
   13918: 67 80 00 00  	ret
   1391c: 93 05 07 00  	mv	a1, a4
   13920: 13 05 04 00  	mv	a0, s0
   13924: ef 10 50 22  	jal	0x15348 <__overflow>
   13928: 13 07 05 00  	mv	a4, a0
   1392c: 6f f0 df f7  	j	0x138a8 <locking_putc+0x70>

0000000000013930 <putc>:
   13930: 03 a7 c5 08  	lw	a4, 140(a1)
   13934: 93 87 05 00  	mv	a5, a1
   13938: 1b 07 07 00  	sext.w	a4, a4
   1393c: 63 40 07 02  	bltz	a4, 0x1395c <putc+0x2c>
   13940: 63 0e 07 02  	beqz	a4, 0x1397c <putc+0x4c>
   13944: 93 06 02 00  	mv	a3, tp
   13948: 03 a6 86 f5  	lw	a2, -168(a3)
   1394c: b7 06 00 c0  	lui	a3, 786432
   13950: 93 86 f6 ff  	addi	a3, a3, -1
   13954: 33 77 d7 00  	and	a4, a4, a3
   13958: 63 12 e6 02  	bne	a2, a4, 0x1397c <putc+0x4c>
   1395c: 03 a7 07 09  	lw	a4, 144(a5)
   13960: 93 75 f5 0f  	andi	a1, a0, 255
   13964: 63 08 b7 00  	beq	a4, a1, 0x13974 <putc+0x44>
   13968: 03 b7 87 02  	ld	a4, 40(a5)
   1396c: 83 b6 07 02  	ld	a3, 32(a5)
   13970: 63 1a d7 00  	bne	a4, a3, 0x13984 <putc+0x54>
   13974: 13 85 07 00  	mv	a0, a5
   13978: 6f 10 10 1d  	j	0x15348 <__overflow>
   1397c: 93 85 07 00  	mv	a1, a5
   13980: 6f f0 9f eb  	j	0x13838 <locking_putc>
   13984: 93 06 17 00  	addi	a3, a4, 1
   13988: 23 b4 d7 02  	sd	a3, 40(a5)
   1398c: 23 00 a7 00  	sb	a0, 0(a4)
   13990: 13 85 05 00  	mv	a0, a1
   13994: 67 80 00 00  	ret

0000000000013998 <snprintf>:
   13998: 13 01 01 fb  	addi	sp, sp, -80
   1399c: 23 34 d1 02  	sd	a3, 40(sp)
   139a0: 93 06 81 02  	addi	a3, sp, 40
   139a4: 23 3c 11 00  	sd	ra, 24(sp)
   139a8: 23 38 e1 02  	sd	a4, 48(sp)
   139ac: 23 3c f1 02  	sd	a5, 56(sp)
   139b0: 23 30 01 05  	sd	a6, 64(sp)
   139b4: 23 34 11 05  	sd	a7, 72(sp)
   139b8: 23 34 d1 00  	sd	a3, 8(sp)
   139bc: ef 00 40 12  	jal	0x13ae0 <vsnprintf>
   139c0: 83 30 81 01  	ld	ra, 24(sp)
   139c4: 13 01 01 05  	addi	sp, sp, 80
   139c8: 67 80 00 00  	ret

00000000000139cc <sprintf>:
   139cc: 13 01 01 fb  	addi	sp, sp, -80
   139d0: 23 30 c1 02  	sd	a2, 32(sp)
   139d4: 13 06 01 02  	addi	a2, sp, 32
   139d8: 23 3c 11 00  	sd	ra, 24(sp)
   139dc: 23 34 d1 02  	sd	a3, 40(sp)
   139e0: 23 38 e1 02  	sd	a4, 48(sp)
   139e4: 23 3c f1 02  	sd	a5, 56(sp)
   139e8: 23 30 01 05  	sd	a6, 64(sp)
   139ec: 23 34 11 05  	sd	a7, 72(sp)
   139f0: 23 34 c1 00  	sd	a2, 8(sp)
   139f4: ef 00 80 1b  	jal	0x13bac <vsprintf>
   139f8: 83 30 81 01  	ld	ra, 24(sp)
   139fc: 13 01 01 05  	addi	sp, sp, 80
   13a00: 67 80 00 00  	ret

0000000000013a04 <sn_write>:
   13a04: 13 01 01 fd  	addi	sp, sp, -48
   13a08: 23 30 81 02  	sd	s0, 32(sp)
   13a0c: 03 34 85 09  	ld	s0, 152(a0)
   13a10: 23 38 21 01  	sd	s2, 16(sp)
   13a14: 23 30 41 01  	sd	s4, 0(sp)
   13a18: 03 39 85 02  	ld	s2, 40(a0)
   13a1c: 13 8a 05 00  	mv	s4, a1
   13a20: 83 35 85 03  	ld	a1, 56(a0)
   13a24: 83 37 84 00  	ld	a5, 8(s0)
   13a28: 23 3c 91 00  	sd	s1, 24(sp)
   13a2c: 23 34 31 01  	sd	s3, 8(sp)
   13a30: 23 34 11 02  	sd	ra, 40(sp)
   13a34: 33 09 b9 40  	sub	s2, s2, a1
   13a38: 93 04 05 00  	mv	s1, a0
   13a3c: 93 09 06 00  	mv	s3, a2
   13a40: 63 f4 27 01  	bgeu	a5, s2, 0x13a48 <sn_write+0x44>
   13a44: 13 89 07 00  	mv	s2, a5
   13a48: 63 04 09 02  	beqz	s2, 0x13a70 <sn_write+0x6c>
   13a4c: 03 35 04 00  	ld	a0, 0(s0)
   13a50: 13 06 09 00  	mv	a2, s2
   13a54: ef 00 c0 1e  	jal	0x13c40 <memcpy>
   13a58: 83 37 04 00  	ld	a5, 0(s0)
   13a5c: b3 87 27 01  	add	a5, a5, s2
   13a60: 23 30 f4 00  	sd	a5, 0(s0)
   13a64: 83 37 84 00  	ld	a5, 8(s0)
   13a68: b3 87 27 41  	sub	a5, a5, s2
   13a6c: 23 34 f4 00  	sd	a5, 8(s0)
   13a70: 03 39 84 00  	ld	s2, 8(s0)
   13a74: 63 f4 29 01  	bgeu	s3, s2, 0x13a7c <sn_write+0x78>
   13a78: 13 89 09 00  	mv	s2, s3
   13a7c: 63 06 09 02  	beqz	s2, 0x13aa8 <sn_write+0xa4>
   13a80: 03 35 04 00  	ld	a0, 0(s0)
   13a84: 13 06 09 00  	mv	a2, s2
   13a88: 93 05 0a 00  	mv	a1, s4
   13a8c: ef 00 40 1b  	jal	0x13c40 <memcpy>
   13a90: 83 37 04 00  	ld	a5, 0(s0)
   13a94: b3 87 27 01  	add	a5, a5, s2
   13a98: 23 30 f4 00  	sd	a5, 0(s0)
   13a9c: 83 37 84 00  	ld	a5, 8(s0)
   13aa0: b3 87 27 41  	sub	a5, a5, s2
   13aa4: 23 34 f4 00  	sd	a5, 8(s0)
   13aa8: 83 37 04 00  	ld	a5, 0(s0)
   13aac: 13 85 09 00  	mv	a0, s3
   13ab0: 23 80 07 00  	sb	zero, 0(a5)
   13ab4: 83 b7 84 05  	ld	a5, 88(s1)
   13ab8: 83 30 81 02  	ld	ra, 40(sp)
   13abc: 03 34 01 02  	ld	s0, 32(sp)
   13ac0: 23 bc f4 02  	sd	a5, 56(s1)
   13ac4: 23 b4 f4 02  	sd	a5, 40(s1)
   13ac8: 03 39 01 01  	ld	s2, 16(sp)
   13acc: 83 34 81 01  	ld	s1, 24(sp)
   13ad0: 83 39 81 00  	ld	s3, 8(sp)
   13ad4: 03 3a 01 00  	ld	s4, 0(sp)
   13ad8: 13 01 01 03  	addi	sp, sp, 48
   13adc: 67 80 00 00  	ret

0000000000013ae0 <vsnprintf>:
   13ae0: 13 01 01 ec  	addi	sp, sp, -320
   13ae4: 23 38 81 12  	sd	s0, 304(sp)
   13ae8: 23 34 91 12  	sd	s1, 296(sp)
   13aec: 23 30 21 13  	sd	s2, 288(sp)
   13af0: 23 3c 31 11  	sd	s3, 280(sp)
   13af4: 23 3c 11 12  	sd	ra, 312(sp)
   13af8: 13 84 05 00  	mv	s0, a1
   13afc: 13 09 06 00  	mv	s2, a2
   13b00: 93 89 06 00  	mv	s3, a3
   13b04: 93 04 01 01  	addi	s1, sp, 16
   13b08: 63 84 05 00  	beqz	a1, 0x13b10 <vsnprintf+0x30>
   13b0c: 93 04 05 00  	mv	s1, a0
   13b10: 23 3c 91 00  	sd	s1, 24(sp)
   13b14: 93 07 00 00  	li	a5, 0
   13b18: 63 04 04 00  	beqz	s0, 0x13b20 <vsnprintf+0x40>
   13b1c: 93 07 f4 ff  	addi	a5, s0, -1
   13b20: 13 06 80 0e  	li	a2, 232
   13b24: 93 05 00 00  	li	a1, 0
   13b28: 13 05 81 02  	addi	a0, sp, 40
   13b2c: 23 30 f1 02  	sd	a5, 32(sp)
   13b30: ef 00 40 55  	jal	0x14084 <memset>
   13b34: b7 47 01 00  	lui	a5, 20
   13b38: 93 87 47 a0  	addi	a5, a5, -1532
   13b3c: 23 38 f1 06  	sd	a5, 112(sp)
   13b40: 93 07 81 00  	addi	a5, sp, 8
   13b44: 23 30 f1 08  	sd	a5, 128(sp)
   13b48: 93 07 f0 ff  	li	a5, -1
   13b4c: 23 2a f1 0a  	sw	a5, 180(sp)
   13b50: 23 2c f1 0a  	sw	a5, 184(sp)
   13b54: 93 07 81 01  	addi	a5, sp, 24
   13b58: 23 30 f1 0c  	sd	a5, 192(sp)
   13b5c: b7 07 00 80  	lui	a5, 524288
   13b60: 93 c7 f7 ff  	not	a5, a5
   13b64: 63 f8 87 02  	bgeu	a5, s0, 0x13b94 <vsnprintf+0xb4>
   13b68: ef d0 9f ab  	jal	0x11620 <__errno_location>
   13b6c: 93 07 b0 04  	li	a5, 75
   13b70: 23 20 f5 00  	sw	a5, 0(a0)
   13b74: 13 05 f0 ff  	li	a0, -1
   13b78: 83 30 81 13  	ld	ra, 312(sp)
   13b7c: 03 34 01 13  	ld	s0, 304(sp)
   13b80: 83 34 81 12  	ld	s1, 296(sp)
   13b84: 03 39 01 12  	ld	s2, 288(sp)
   13b88: 83 39 81 11  	ld	s3, 280(sp)
   13b8c: 13 01 01 14  	addi	sp, sp, 320
   13b90: 67 80 00 00  	ret
   13b94: 23 80 04 00  	sb	zero, 0(s1)
   13b98: 13 86 09 00  	mv	a2, s3
   13b9c: 93 05 09 00  	mv	a1, s2
   13ba0: 13 05 81 02  	addi	a0, sp, 40
   13ba4: ef 30 40 5f  	jal	0x17198 <vfprintf>
   13ba8: 6f f0 1f fd  	j	0x13b78 <vsnprintf+0x98>

0000000000013bac <vsprintf>:
   13bac: 93 06 06 00  	mv	a3, a2
   13bb0: 13 86 05 00  	mv	a2, a1
   13bb4: b7 05 00 80  	lui	a1, 524288
   13bb8: 93 c5 f5 ff  	not	a1, a1
   13bbc: 6f f0 5f f2  	j	0x13ae0 <vsnprintf>

0000000000013bc0 <atoi>:
   13bc0: 93 07 05 00  	mv	a5, a0
   13bc4: 93 05 00 02  	li	a1, 32
   13bc8: 93 06 40 00  	li	a3, 4
   13bcc: 03 c7 07 00  	lbu	a4, 0(a5)
   13bd0: 63 0c b7 02  	beq	a4, a1, 0x13c08 <atoi+0x48>
   13bd4: 1b 06 77 ff  	addiw	a2, a4, -9
   13bd8: 63 f8 c6 02  	bgeu	a3, a2, 0x13c08 <atoi+0x48>
   13bdc: 93 06 b0 02  	li	a3, 43
   13be0: 63 08 d7 02  	beq	a4, a3, 0x13c10 <atoi+0x50>
   13be4: 13 06 d0 02  	li	a2, 45
   13be8: 93 06 00 00  	li	a3, 0
   13bec: 63 16 c7 00  	bne	a4, a2, 0x13bf8 <atoi+0x38>
   13bf0: 93 06 10 00  	li	a3, 1
   13bf4: 93 87 17 00  	addi	a5, a5, 1
   13bf8: 13 05 00 00  	li	a0, 0
   13bfc: 13 06 90 00  	li	a2, 9
   13c00: 13 08 a0 00  	li	a6, 10
   13c04: 6f 00 00 02  	j	0x13c24 <atoi+0x64>
   13c08: 93 87 17 00  	addi	a5, a5, 1
   13c0c: 6f f0 1f fc  	j	0x13bcc <atoi+0xc>
   13c10: 93 06 00 00  	li	a3, 0
   13c14: 6f f0 1f fe  	j	0x13bf4 <atoi+0x34>
   13c18: 3b 05 a8 02  	<unknown>
   13c1c: 93 87 17 00  	addi	a5, a5, 1
   13c20: 3b 05 e5 40  	subw	a0, a0, a4
   13c24: 03 c7 07 00  	lbu	a4, 0(a5)
   13c28: 9b 05 07 fd  	addiw	a1, a4, -48
   13c2c: 13 87 05 00  	mv	a4, a1
   13c30: e3 74 b6 fe  	bgeu	a2, a1, 0x13c18 <atoi+0x58>
   13c34: 63 94 06 00  	bnez	a3, 0x13c3c <atoi+0x7c>
   13c38: 3b 05 a0 40  	negw	a0, a0
   13c3c: 67 80 00 00  	ret

0000000000013c40 <memcpy>:
   13c40: 93 07 05 00  	mv	a5, a0
   13c44: 13 f7 35 00  	andi	a4, a1, 3
   13c48: 63 04 07 00  	beqz	a4, 0x13c50 <memcpy+0x10>
   13c4c: 63 10 06 02  	bnez	a2, 0x13c6c <memcpy+0x2c>
   13c50: 93 f6 37 00  	andi	a3, a5, 3
   13c54: 63 94 06 0e  	bnez	a3, 0x13d3c <memcpy+0xfc>
   13c58: 13 87 05 00  	mv	a4, a1
   13c5c: 93 86 07 00  	mv	a3, a5
   13c60: 33 83 c5 00  	add	t1, a1, a2
   13c64: 13 08 f0 00  	li	a6, 15
   13c68: 6f 00 40 04  	j	0x13cac <memcpy+0x6c>
   13c6c: 03 c7 05 00  	lbu	a4, 0(a1)
   13c70: 93 85 15 00  	addi	a1, a1, 1
   13c74: 93 87 17 00  	addi	a5, a5, 1
   13c78: 13 06 f6 ff  	addi	a2, a2, -1
   13c7c: a3 8f e7 fe  	sb	a4, -1(a5)
   13c80: 6f f0 5f fc  	j	0x13c44 <memcpy+0x4>
   13c84: 83 28 07 00  	lw	a7, 0(a4)
   13c88: 93 86 06 01  	addi	a3, a3, 16
   13c8c: 13 07 07 01  	addi	a4, a4, 16
   13c90: 23 a8 16 ff  	sw	a7, -16(a3)
   13c94: 83 28 47 ff  	lw	a7, -12(a4)
   13c98: 23 aa 16 ff  	sw	a7, -12(a3)
   13c9c: 83 28 87 ff  	lw	a7, -8(a4)
   13ca0: 23 ac 16 ff  	sw	a7, -8(a3)
   13ca4: 83 28 c7 ff  	lw	a7, -4(a4)
   13ca8: 23 ae 16 ff  	sw	a7, -4(a3)
   13cac: b3 08 e3 40  	sub	a7, t1, a4
   13cb0: e3 6a 18 fd  	bltu	a6, a7, 0x13c84 <memcpy+0x44>
   13cb4: 13 57 46 00  	srli	a4, a2, 4
   13cb8: 93 06 00 ff  	li	a3, -16
   13cbc: b3 06 d7 02  	<unknown>
   13cc0: 13 17 47 00  	slli	a4, a4, 4
   13cc4: b3 87 e7 00  	add	a5, a5, a4
   13cc8: b3 85 e5 00  	add	a1, a1, a4
   13ccc: b3 86 c6 00  	add	a3, a3, a2
   13cd0: 13 76 86 00  	andi	a2, a2, 8
   13cd4: 63 0e 06 00  	beqz	a2, 0x13cf0 <memcpy+0xb0>
   13cd8: 03 a7 05 00  	lw	a4, 0(a1)
   13cdc: 93 87 87 00  	addi	a5, a5, 8
   13ce0: 93 85 85 00  	addi	a1, a1, 8
   13ce4: 23 ac e7 fe  	sw	a4, -8(a5)
   13ce8: 03 a7 c5 ff  	lw	a4, -4(a1)
   13cec: 23 ae e7 fe  	sw	a4, -4(a5)
   13cf0: 13 f7 46 00  	andi	a4, a3, 4
   13cf4: 63 0a 07 00  	beqz	a4, 0x13d08 <memcpy+0xc8>
   13cf8: 03 a7 05 00  	lw	a4, 0(a1)
   13cfc: 93 87 47 00  	addi	a5, a5, 4
   13d00: 93 85 45 00  	addi	a1, a1, 4
   13d04: 23 ae e7 fe  	sw	a4, -4(a5)
   13d08: 13 f7 26 00  	andi	a4, a3, 2
   13d0c: 63 0e 07 00  	beqz	a4, 0x13d28 <memcpy+0xe8>
   13d10: 03 c7 05 00  	lbu	a4, 0(a1)
   13d14: 93 87 27 00  	addi	a5, a5, 2
   13d18: 93 85 25 00  	addi	a1, a1, 2
   13d1c: 23 8f e7 fe  	sb	a4, -2(a5)
   13d20: 03 c7 f5 ff  	lbu	a4, -1(a1)
   13d24: a3 8f e7 fe  	sb	a4, -1(a5)
   13d28: 93 f6 16 00  	andi	a3, a3, 1
   13d2c: 63 8e 06 20  	beqz	a3, 0x13f48 <memcpy+0x308>
   13d30: 03 c7 05 00  	lbu	a4, 0(a1)
   13d34: 23 80 e7 00  	sb	a4, 0(a5)
   13d38: 6f 00 00 21  	j	0x13f48 <memcpy+0x308>
   13d3c: 13 07 f0 01  	li	a4, 31
   13d40: 63 78 c7 0c  	bgeu	a4, a2, 0x13e10 <memcpy+0x1d0>
   13d44: 13 03 20 00  	li	t1, 2
   13d48: 03 c7 05 00  	lbu	a4, 0(a1)
   13d4c: 03 a8 05 00  	lw	a6, 0(a1)
   13d50: b3 88 c7 00  	add	a7, a5, a2
   13d54: 63 8c 66 1e  	beq	a3, t1, 0x13f4c <memcpy+0x30c>
   13d58: 13 03 30 00  	li	t1, 3
   13d5c: 63 88 66 28  	beq	a3, t1, 0x13fec <memcpy+0x3ac>
   13d60: 23 80 e7 00  	sb	a4, 0(a5)
   13d64: 03 c7 15 00  	lbu	a4, 1(a1)
   13d68: 13 8e 35 00  	addi	t3, a1, 3
   13d6c: 13 83 37 00  	addi	t1, a5, 3
   13d70: a3 80 e7 00  	sb	a4, 1(a5)
   13d74: 03 c7 25 00  	lbu	a4, 2(a1)
   13d78: 93 0e 00 01  	li	t4, 16
   13d7c: 23 81 e7 00  	sb	a4, 2(a5)
   13d80: 13 07 0e 00  	mv	a4, t3
   13d84: 93 07 03 00  	mv	a5, t1
   13d88: 83 26 17 00  	lw	a3, 1(a4)
   13d8c: 1b 58 88 01  	srliw	a6, a6, 24
   13d90: 93 87 07 01  	addi	a5, a5, 16
   13d94: 9b 95 86 00  	slliw	a1, a3, 8
   13d98: 33 68 b8 00  	or	a6, a6, a1
   13d9c: 83 25 57 00  	lw	a1, 5(a4)
   13da0: 23 a8 07 ff  	sw	a6, -16(a5)
   13da4: 9b d6 86 01  	srliw	a3, a3, 24
   13da8: 1b 98 85 00  	slliw	a6, a1, 8
   13dac: b3 e6 06 01  	or	a3, a3, a6
   13db0: 23 aa d7 fe  	sw	a3, -12(a5)
   13db4: 83 26 97 00  	lw	a3, 9(a4)
   13db8: 9b d5 85 01  	srliw	a1, a1, 24
   13dbc: 13 07 07 01  	addi	a4, a4, 16
   13dc0: 1b 98 86 00  	slliw	a6, a3, 8
   13dc4: b3 e5 05 01  	or	a1, a1, a6
   13dc8: 03 28 d7 ff  	lw	a6, -3(a4)
   13dcc: 23 ac b7 fe  	sw	a1, -8(a5)
   13dd0: 9b d6 86 01  	srliw	a3, a3, 24
   13dd4: 9b 15 88 00  	slliw	a1, a6, 8
   13dd8: b3 e6 b6 00  	or	a3, a3, a1
   13ddc: 23 ae d7 fe  	sw	a3, -4(a5)
   13de0: b3 86 f8 40  	sub	a3, a7, a5
   13de4: e3 e2 de fa  	bltu	t4, a3, 0x13d88 <memcpy+0x148>
   13de8: 13 07 c6 fe  	addi	a4, a2, -20
   13dec: 13 57 47 00  	srli	a4, a4, 4
   13df0: 93 07 17 00  	addi	a5, a4, 1
   13df4: 93 97 47 00  	slli	a5, a5, 4
   13df8: b3 05 fe 00  	add	a1, t3, a5
   13dfc: 13 06 d6 fe  	addi	a2, a2, -19
   13e00: b3 07 f3 00  	add	a5, t1, a5
   13e04: 93 06 00 ff  	li	a3, -16
   13e08: 33 07 d7 02  	<unknown>
   13e0c: 33 06 c7 00  	add	a2, a4, a2
   13e10: 13 77 06 01  	andi	a4, a2, 16
   13e14: 63 06 07 08  	beqz	a4, 0x13ea0 <memcpy+0x260>
   13e18: 03 c7 05 00  	lbu	a4, 0(a1)
   13e1c: 93 87 07 01  	addi	a5, a5, 16
   13e20: 93 85 05 01  	addi	a1, a1, 16
   13e24: 23 88 e7 fe  	sb	a4, -16(a5)
   13e28: 03 c7 15 ff  	lbu	a4, -15(a1)
   13e2c: a3 88 e7 fe  	sb	a4, -15(a5)
   13e30: 03 c7 25 ff  	lbu	a4, -14(a1)
   13e34: 23 89 e7 fe  	sb	a4, -14(a5)
   13e38: 03 c7 35 ff  	lbu	a4, -13(a1)
   13e3c: a3 89 e7 fe  	sb	a4, -13(a5)
   13e40: 03 c7 45 ff  	lbu	a4, -12(a1)
   13e44: 23 8a e7 fe  	sb	a4, -12(a5)
   13e48: 03 c7 55 ff  	lbu	a4, -11(a1)
   13e4c: a3 8a e7 fe  	sb	a4, -11(a5)
   13e50: 03 c7 65 ff  	lbu	a4, -10(a1)
   13e54: 23 8b e7 fe  	sb	a4, -10(a5)
   13e58: 03 c7 75 ff  	lbu	a4, -9(a1)
   13e5c: a3 8b e7 fe  	sb	a4, -9(a5)
   13e60: 03 c7 85 ff  	lbu	a4, -8(a1)
   13e64: 23 8c e7 fe  	sb	a4, -8(a5)
   13e68: 03 c7 95 ff  	lbu	a4, -7(a1)
   13e6c: a3 8c e7 fe  	sb	a4, -7(a5)
   13e70: 03 c7 a5 ff  	lbu	a4, -6(a1)
   13e74: 23 8d e7 fe  	sb	a4, -6(a5)
   13e78: 03 c7 b5 ff  	lbu	a4, -5(a1)
   13e7c: a3 8d e7 fe  	sb	a4, -5(a5)
   13e80: 03 c7 c5 ff  	lbu	a4, -4(a1)
   13e84: 23 8e e7 fe  	sb	a4, -4(a5)
   13e88: 03 c7 d5 ff  	lbu	a4, -3(a1)
   13e8c: a3 8e e7 fe  	sb	a4, -3(a5)
   13e90: 03 c7 e5 ff  	lbu	a4, -2(a1)
   13e94: 23 8f e7 fe  	sb	a4, -2(a5)
   13e98: 03 c7 f5 ff  	lbu	a4, -1(a1)
   13e9c: a3 8f e7 fe  	sb	a4, -1(a5)
   13ea0: 13 77 86 00  	andi	a4, a2, 8
   13ea4: 63 06 07 04  	beqz	a4, 0x13ef0 <memcpy+0x2b0>
   13ea8: 03 c7 05 00  	lbu	a4, 0(a1)
   13eac: 93 87 87 00  	addi	a5, a5, 8
   13eb0: 93 85 85 00  	addi	a1, a1, 8
   13eb4: 23 8c e7 fe  	sb	a4, -8(a5)
   13eb8: 03 c7 95 ff  	lbu	a4, -7(a1)
   13ebc: a3 8c e7 fe  	sb	a4, -7(a5)
   13ec0: 03 c7 a5 ff  	lbu	a4, -6(a1)
   13ec4: 23 8d e7 fe  	sb	a4, -6(a5)
   13ec8: 03 c7 b5 ff  	lbu	a4, -5(a1)
   13ecc: a3 8d e7 fe  	sb	a4, -5(a5)
   13ed0: 03 c7 c5 ff  	lbu	a4, -4(a1)
   13ed4: 23 8e e7 fe  	sb	a4, -4(a5)
   13ed8: 03 c7 d5 ff  	lbu	a4, -3(a1)
   13edc: a3 8e e7 fe  	sb	a4, -3(a5)
   13ee0: 03 c7 e5 ff  	lbu	a4, -2(a1)
   13ee4: 23 8f e7 fe  	sb	a4, -2(a5)
   13ee8: 03 c7 f5 ff  	lbu	a4, -1(a1)
   13eec: a3 8f e7 fe  	sb	a4, -1(a5)
   13ef0: 13 77 46 00  	andi	a4, a2, 4
   13ef4: 63 06 07 02  	beqz	a4, 0x13f20 <memcpy+0x2e0>
   13ef8: 03 c7 05 00  	lbu	a4, 0(a1)
   13efc: 93 87 47 00  	addi	a5, a5, 4
   13f00: 93 85 45 00  	addi	a1, a1, 4
   13f04: 23 8e e7 fe  	sb	a4, -4(a5)
   13f08: 03 c7 d5 ff  	lbu	a4, -3(a1)
   13f0c: a3 8e e7 fe  	sb	a4, -3(a5)
   13f10: 03 c7 e5 ff  	lbu	a4, -2(a1)
   13f14: 23 8f e7 fe  	sb	a4, -2(a5)
   13f18: 03 c7 f5 ff  	lbu	a4, -1(a1)
   13f1c: a3 8f e7 fe  	sb	a4, -1(a5)
   13f20: 13 77 26 00  	andi	a4, a2, 2
   13f24: 63 0e 07 00  	beqz	a4, 0x13f40 <memcpy+0x300>
   13f28: 03 c7 05 00  	lbu	a4, 0(a1)
   13f2c: 93 87 27 00  	addi	a5, a5, 2
   13f30: 93 85 25 00  	addi	a1, a1, 2
   13f34: 23 8f e7 fe  	sb	a4, -2(a5)
   13f38: 03 c7 f5 ff  	lbu	a4, -1(a1)
   13f3c: a3 8f e7 fe  	sb	a4, -1(a5)
   13f40: 13 76 16 00  	andi	a2, a2, 1
   13f44: e3 16 06 de  	bnez	a2, 0x13d30 <memcpy+0xf0>
   13f48: 67 80 00 00  	ret
   13f4c: 23 80 e7 00  	sb	a4, 0(a5)
   13f50: 03 c7 15 00  	lbu	a4, 1(a1)
   13f54: 13 8e 25 00  	addi	t3, a1, 2
   13f58: 13 83 27 00  	addi	t1, a5, 2
   13f5c: a3 80 e7 00  	sb	a4, 1(a5)
   13f60: 93 0e 10 01  	li	t4, 17
   13f64: 13 07 0e 00  	mv	a4, t3
   13f68: 93 07 03 00  	mv	a5, t1
   13f6c: 83 26 27 00  	lw	a3, 2(a4)
   13f70: 1b 58 08 01  	srliw	a6, a6, 16
   13f74: 93 87 07 01  	addi	a5, a5, 16
   13f78: 9b 95 06 01  	slliw	a1, a3, 16
   13f7c: 33 68 b8 00  	or	a6, a6, a1
   13f80: 83 25 67 00  	lw	a1, 6(a4)
   13f84: 23 a8 07 ff  	sw	a6, -16(a5)
   13f88: 9b d6 06 01  	srliw	a3, a3, 16
   13f8c: 1b 98 05 01  	slliw	a6, a1, 16
   13f90: b3 e6 06 01  	or	a3, a3, a6
   13f94: 23 aa d7 fe  	sw	a3, -12(a5)
   13f98: 83 26 a7 00  	lw	a3, 10(a4)
   13f9c: 9b d5 05 01  	srliw	a1, a1, 16
   13fa0: 13 07 07 01  	addi	a4, a4, 16
   13fa4: 1b 98 06 01  	slliw	a6, a3, 16
   13fa8: b3 e5 05 01  	or	a1, a1, a6
   13fac: 03 28 e7 ff  	lw	a6, -2(a4)
   13fb0: 23 ac b7 fe  	sw	a1, -8(a5)
   13fb4: 9b d6 06 01  	srliw	a3, a3, 16
   13fb8: 9b 15 08 01  	slliw	a1, a6, 16
   13fbc: b3 e6 b6 00  	or	a3, a3, a1
   13fc0: 23 ae d7 fe  	sw	a3, -4(a5)
   13fc4: b3 86 f8 40  	sub	a3, a7, a5
   13fc8: e3 e2 de fa  	bltu	t4, a3, 0x13f6c <memcpy+0x32c>
   13fcc: 13 07 c6 fe  	addi	a4, a2, -20
   13fd0: 13 57 47 00  	srli	a4, a4, 4
   13fd4: 93 07 17 00  	addi	a5, a4, 1
   13fd8: 93 97 47 00  	slli	a5, a5, 4
   13fdc: b3 05 fe 00  	add	a1, t3, a5
   13fe0: 13 06 e6 fe  	addi	a2, a2, -18
   13fe4: b3 07 f3 00  	add	a5, t1, a5
   13fe8: 6f f0 df e1  	j	0x13e04 <memcpy+0x1c4>
   13fec: 93 85 15 00  	addi	a1, a1, 1
   13ff0: 13 83 17 00  	addi	t1, a5, 1
   13ff4: 23 80 e7 00  	sb	a4, 0(a5)
   13ff8: 13 0e 20 01  	li	t3, 18
   13ffc: 13 87 05 00  	mv	a4, a1
   14000: 93 07 03 00  	mv	a5, t1
   14004: 83 26 37 00  	lw	a3, 3(a4)
   14008: 1b 58 88 00  	srliw	a6, a6, 8
   1400c: 93 87 07 01  	addi	a5, a5, 16
   14010: 9b 9e 86 01  	slliw	t4, a3, 24
   14014: 33 68 d8 01  	or	a6, a6, t4
   14018: 23 a8 07 ff  	sw	a6, -16(a5)
   1401c: 03 28 77 00  	lw	a6, 7(a4)
   14020: 9b d6 86 00  	srliw	a3, a3, 8
   14024: 13 07 07 01  	addi	a4, a4, 16
   14028: 9b 1e 88 01  	slliw	t4, a6, 24
   1402c: b3 e6 d6 01  	or	a3, a3, t4
   14030: 23 aa d7 fe  	sw	a3, -12(a5)
   14034: 83 26 b7 ff  	lw	a3, -5(a4)
   14038: 1b 58 88 00  	srliw	a6, a6, 8
   1403c: 9b 9e 86 01  	slliw	t4, a3, 24
   14040: 33 68 d8 01  	or	a6, a6, t4
   14044: 23 ac 07 ff  	sw	a6, -8(a5)
   14048: 03 28 f7 ff  	lw	a6, -1(a4)
   1404c: 9b d6 86 00  	srliw	a3, a3, 8
   14050: 9b 1e 88 01  	slliw	t4, a6, 24
   14054: b3 e6 d6 01  	or	a3, a3, t4
   14058: 23 ae d7 fe  	sw	a3, -4(a5)
   1405c: b3 86 f8 40  	sub	a3, a7, a5
   14060: e3 62 de fa  	bltu	t3, a3, 0x14004 <memcpy+0x3c4>
   14064: 13 07 c6 fe  	addi	a4, a2, -20
   14068: 13 57 47 00  	srli	a4, a4, 4
   1406c: 93 07 17 00  	addi	a5, a4, 1
   14070: 93 97 47 00  	slli	a5, a5, 4
   14074: b3 85 f5 00  	add	a1, a1, a5
   14078: 13 06 f6 fe  	addi	a2, a2, -17
   1407c: b3 07 f3 00  	add	a5, t1, a5
   14080: 6f f0 5f d8  	j	0x13e04 <memcpy+0x1c4>

0000000000014084 <memset>:
   14084: 63 0e 06 0c  	beqz	a2, 0x14160 <memset+0xdc>
   14088: 93 f7 f5 0f  	andi	a5, a1, 255
   1408c: 23 00 f5 00  	sb	a5, 0(a0)
   14090: 33 07 c5 00  	add	a4, a0, a2
   14094: a3 0f f7 fe  	sb	a5, -1(a4)
   14098: 93 06 20 00  	li	a3, 2
   1409c: 63 f2 c6 0c  	bgeu	a3, a2, 0x14160 <memset+0xdc>
   140a0: a3 00 f5 00  	sb	a5, 1(a0)
   140a4: 23 01 f5 00  	sb	a5, 2(a0)
   140a8: 23 0f f7 fe  	sb	a5, -2(a4)
   140ac: a3 0e f7 fe  	sb	a5, -3(a4)
   140b0: 93 06 60 00  	li	a3, 6
   140b4: 63 f6 c6 0a  	bgeu	a3, a2, 0x14160 <memset+0xdc>
   140b8: a3 01 f5 00  	sb	a5, 3(a0)
   140bc: 23 0e f7 fe  	sb	a5, -4(a4)
   140c0: 93 06 80 00  	li	a3, 8
   140c4: 63 fe c6 08  	bgeu	a3, a2, 0x14160 <memset+0xdc>
   140c8: 33 07 a0 40  	neg	a4, a0
   140cc: 13 77 37 00  	andi	a4, a4, 3
   140d0: b3 07 e5 00  	add	a5, a0, a4
   140d4: 33 06 e6 40  	sub	a2, a2, a4
   140d8: 37 07 01 01  	lui	a4, 4112
   140dc: 1b 07 17 10  	addiw	a4, a4, 257
   140e0: 93 f5 f5 0f  	andi	a1, a1, 255
   140e4: bb 85 e5 02  	<unknown>
   140e8: 13 76 c6 ff  	andi	a2, a2, -4
   140ec: 33 87 c7 00  	add	a4, a5, a2
   140f0: 23 a0 b7 00  	sw	a1, 0(a5)
   140f4: 23 2e b7 fe  	sw	a1, -4(a4)
   140f8: 63 f4 c6 06  	bgeu	a3, a2, 0x14160 <memset+0xdc>
   140fc: 23 a2 b7 00  	sw	a1, 4(a5)
   14100: 23 a4 b7 00  	sw	a1, 8(a5)
   14104: 23 2a b7 fe  	sw	a1, -12(a4)
   14108: 23 2c b7 fe  	sw	a1, -8(a4)
   1410c: 93 06 80 01  	li	a3, 24
   14110: 63 f8 c6 04  	bgeu	a3, a2, 0x14160 <memset+0xdc>
   14114: 23 a6 b7 00  	sw	a1, 12(a5)
   14118: 23 a8 b7 00  	sw	a1, 16(a5)
   1411c: 23 aa b7 00  	sw	a1, 20(a5)
   14120: 23 ac b7 00  	sw	a1, 24(a5)
   14124: 23 22 b7 fe  	sw	a1, -28(a4)
   14128: 23 24 b7 fe  	sw	a1, -24(a4)
   1412c: 23 26 b7 fe  	sw	a1, -20(a4)
   14130: 23 28 b7 fe  	sw	a1, -16(a4)
   14134: 93 96 05 02  	slli	a3, a1, 32
   14138: 13 f7 47 00  	andi	a4, a5, 4
   1413c: 13 07 87 01  	addi	a4, a4, 24
   14140: 93 d6 06 02  	srli	a3, a3, 32
   14144: 93 95 05 02  	slli	a1, a1, 32
   14148: 33 87 e7 00  	add	a4, a5, a4
   1414c: 33 86 c7 00  	add	a2, a5, a2
   14150: b3 e5 d5 00  	or	a1, a1, a3
   14154: 93 07 f0 01  	li	a5, 31
   14158: b3 06 e6 40  	sub	a3, a2, a4
   1415c: 63 e4 d7 00  	bltu	a5, a3, 0x14164 <memset+0xe0>
   14160: 67 80 00 00  	ret
   14164: 23 30 b7 00  	sd	a1, 0(a4)
   14168: 23 34 b7 00  	sd	a1, 8(a4)
   1416c: 23 38 b7 00  	sd	a1, 16(a4)
   14170: 23 3c b7 00  	sd	a1, 24(a4)
   14174: 13 07 07 02  	addi	a4, a4, 32
   14178: 6f f0 1f fe  	j	0x14158 <memset+0xd4>

000000000001417c <strchrnul>:
   1417c: 13 01 01 ff  	addi	sp, sp, -16
   14180: 23 30 81 00  	sd	s0, 0(sp)
   14184: 23 34 11 00  	sd	ra, 8(sp)
   14188: 93 f5 f5 0f  	andi	a1, a1, 255
   1418c: 13 04 05 00  	mv	s0, a0
   14190: 63 98 05 02  	bnez	a1, 0x141c0 <strchrnul+0x44>
   14194: ef 00 00 0b  	jal	0x14244 <strlen>
   14198: 33 04 a4 00  	add	s0, s0, a0
   1419c: 83 30 81 00  	ld	ra, 8(sp)
   141a0: 13 05 04 00  	mv	a0, s0
   141a4: 03 34 01 00  	ld	s0, 0(sp)
   141a8: 13 01 01 01  	addi	sp, sp, 16
   141ac: 67 80 00 00  	ret
   141b0: 83 47 04 00  	lbu	a5, 0(s0)
   141b4: e3 84 07 fe  	beqz	a5, 0x1419c <strchrnul+0x20>
   141b8: e3 82 b7 fe  	beq	a5, a1, 0x1419c <strchrnul+0x20>
   141bc: 13 04 14 00  	addi	s0, s0, 1
   141c0: 93 77 74 00  	andi	a5, s0, 7
   141c4: e3 96 07 fe  	bnez	a5, 0x141b0 <strchrnul+0x34>
   141c8: 03 b6 01 93  	ld	a2, -1744(gp)
   141cc: 03 b5 81 93  	ld	a0, -1736(gp)
   141d0: 33 86 c5 02  	<unknown>
   141d4: 03 b8 01 94  	ld	a6, -1728(gp)
   141d8: 03 37 04 00  	ld	a4, 0(s0)
   141dc: b3 46 c7 00  	xor	a3, a4, a2
   141e0: b3 07 a7 00  	add	a5, a4, a0
   141e4: 13 47 f7 ff  	not	a4, a4
   141e8: b3 f7 e7 00  	and	a5, a5, a4
   141ec: 33 87 a6 00  	add	a4, a3, a0
   141f0: 93 c6 f6 ff  	not	a3, a3
   141f4: b3 76 d7 00  	and	a3, a4, a3
   141f8: b3 e7 d7 00  	or	a5, a5, a3
   141fc: b3 f7 07 01  	and	a5, a5, a6
   14200: 63 8c 07 00  	beqz	a5, 0x14218 <strchrnul+0x9c>
   14204: 83 47 04 00  	lbu	a5, 0(s0)
   14208: e3 8a 07 f8  	beqz	a5, 0x1419c <strchrnul+0x20>
   1420c: e3 88 b7 f8  	beq	a5, a1, 0x1419c <strchrnul+0x20>
   14210: 13 04 14 00  	addi	s0, s0, 1
   14214: 6f f0 1f ff  	j	0x14204 <strchrnul+0x88>
   14218: 13 04 84 00  	addi	s0, s0, 8
   1421c: 6f f0 df fb  	j	0x141d8 <strchrnul+0x5c>

0000000000014220 <strcmp>:
   14220: 83 47 05 00  	lbu	a5, 0(a0)
   14224: 03 c7 05 00  	lbu	a4, 0(a1)
   14228: 63 94 e7 00  	bne	a5, a4, 0x14230 <strcmp+0x10>
   1422c: 63 96 07 00  	bnez	a5, 0x14238 <strcmp+0x18>
   14230: 3b 85 e7 40  	subw	a0, a5, a4
   14234: 67 80 00 00  	ret
   14238: 13 05 15 00  	addi	a0, a0, 1
   1423c: 93 85 15 00  	addi	a1, a1, 1
   14240: 6f f0 1f fe  	j	0x14220 <strcmp>

0000000000014244 <strlen>:
   14244: 93 07 05 00  	mv	a5, a0
   14248: 13 f7 77 00  	andi	a4, a5, 7
   1424c: 63 1a 07 02  	bnez	a4, 0x14280 <strlen+0x3c>
   14250: 83 b5 81 93  	ld	a1, -1736(gp)
   14254: 03 b6 01 94  	ld	a2, -1728(gp)
   14258: 83 b6 07 00  	ld	a3, 0(a5)
   1425c: 33 87 b6 00  	add	a4, a3, a1
   14260: 93 c6 f6 ff  	not	a3, a3
   14264: 33 77 d7 00  	and	a4, a4, a3
   14268: 33 77 c7 00  	and	a4, a4, a2
   1426c: 63 06 07 02  	beqz	a4, 0x14298 <strlen+0x54>
   14270: 03 c7 07 00  	lbu	a4, 0(a5)
   14274: 63 0a 07 00  	beqz	a4, 0x14288 <strlen+0x44>
   14278: 93 87 17 00  	addi	a5, a5, 1
   1427c: 6f f0 5f ff  	j	0x14270 <strlen+0x2c>
   14280: 03 c7 07 00  	lbu	a4, 0(a5)
   14284: 63 16 07 00  	bnez	a4, 0x14290 <strlen+0x4c>
   14288: 33 85 a7 40  	sub	a0, a5, a0
   1428c: 67 80 00 00  	ret
   14290: 93 87 17 00  	addi	a5, a5, 1
   14294: 6f f0 5f fb  	j	0x14248 <strlen+0x4>
   14298: 93 87 87 00  	addi	a5, a5, 8
   1429c: 6f f0 df fb  	j	0x14258 <strlen+0x14>

00000000000142a0 <strrchr>:
   142a0: 13 01 01 fe  	addi	sp, sp, -32
   142a4: 23 38 81 00  	sd	s0, 16(sp)
   142a8: 23 3c 11 00  	sd	ra, 24(sp)
   142ac: 13 04 05 00  	mv	s0, a0
   142b0: 23 34 b1 00  	sd	a1, 8(sp)
   142b4: ef f0 1f f9  	jal	0x14244 <strlen>
   142b8: 13 06 15 00  	addi	a2, a0, 1
   142bc: 13 05 04 00  	mv	a0, s0
   142c0: 03 34 01 01  	ld	s0, 16(sp)
   142c4: 83 35 81 00  	ld	a1, 8(sp)
   142c8: 83 30 81 01  	ld	ra, 24(sp)
   142cc: 13 01 01 02  	addi	sp, sp, 32
   142d0: 6f 30 00 04  	j	0x17310 <memrchr>

00000000000142d4 <strsignal>:
   142d4: 9b 06 f5 ff  	addiw	a3, a0, -1
   142d8: 13 07 f0 03  	li	a4, 63
   142dc: 93 07 05 00  	mv	a5, a0
   142e0: 63 74 d7 00  	bgeu	a4, a3, 0x142e8 <strsignal+0x14>
   142e4: 93 07 00 00  	li	a5, 0
   142e8: 37 b5 01 00  	lui	a0, 27
   142ec: 13 05 05 4a  	addi	a0, a0, 1184
   142f0: 13 07 f0 ff  	li	a4, -1
   142f4: 9b 87 f7 ff  	addiw	a5, a5, -1
   142f8: 63 94 e7 00  	bne	a5, a4, 0x14300 <strsignal+0x2c>
   142fc: 6f d0 4f cf  	j	0x117f0 <__lctrans_cur>
   14300: 83 46 05 00  	lbu	a3, 0(a0)
   14304: 13 05 15 00  	addi	a0, a0, 1
   14308: e3 9c 06 fe  	bnez	a3, 0x14300 <strsignal+0x2c>
   1430c: 6f f0 9f fe  	j	0x142f4 <strsignal+0x20>

0000000000014310 <__lock>:
   14310: 93 87 81 bc  	addi	a5, gp, -1080
   14314: 83 a7 c7 00  	lw	a5, 12(a5)
   14318: 13 07 05 00  	mv	a4, a0
   1431c: 9b 87 07 00  	sext.w	a5, a5
   14320: 63 82 07 0e  	beqz	a5, 0x14404 <__lock+0xf4>
   14324: b7 06 00 80  	lui	a3, 524288
   14328: 93 86 16 00  	addi	a3, a3, 1
   1432c: 13 06 00 00  	li	a2, 0
   14330: af 27 05 16  	<unknown>
   14334: 63 96 c7 00  	bne	a5, a2, 0x14340 <__lock+0x30>
   14338: af 25 d5 1e  	<unknown>
   1433c: e3 9a 05 fe  	bnez	a1, 0x14330 <__lock+0x20>
   14340: 9b 87 07 00  	sext.w	a5, a5
   14344: 63 80 07 0c  	beqz	a5, 0x14404 <__lock+0xf4>
   14348: 37 05 00 80  	lui	a0, 524288
   1434c: 93 05 a0 00  	li	a1, 10
   14350: 13 45 f5 ff  	not	a0, a0
   14354: 13 86 07 00  	mv	a2, a5
   14358: 63 d4 07 00  	bgez	a5, 0x14360 <__lock+0x50>
   1435c: 3b 06 f5 00  	addw	a2, a0, a5
   14360: 3b 88 c6 00  	addw	a6, a3, a2
   14364: af 27 07 16  	<unknown>
   14368: 63 96 c7 00  	bne	a5, a2, 0x14374 <__lock+0x64>
   1436c: af 28 07 1f  	<unknown>
   14370: e3 9a 08 fe  	bnez	a7, 0x14364 <__lock+0x54>
   14374: 9b 87 07 00  	sext.w	a5, a5
   14378: 63 06 f6 08  	beq	a2, a5, 0x14404 <__lock+0xf4>
   1437c: 9b 85 f5 ff  	addiw	a1, a1, -1
   14380: e3 9a 05 fc  	bnez	a1, 0x14354 <__lock+0x44>
   14384: 83 27 07 00  	lw	a5, 0(a4)
   14388: 1b 86 07 00  	sext.w	a2, a5
   1438c: 9b 87 17 00  	addiw	a5, a5, 1
   14390: af 26 07 16  	<unknown>
   14394: 63 96 c6 00  	bne	a3, a2, 0x143a0 <__lock+0x90>
   14398: af 25 f7 1e  	<unknown>
   1439c: e3 9a 05 fe  	bnez	a1, 0x14390 <__lock+0x80>
   143a0: 9b 86 06 00  	sext.w	a3, a3
   143a4: e3 10 d6 fe  	bne	a2, a3, 0x14384 <__lock+0x74>
   143a8: 37 08 00 80  	lui	a6, 524288
   143ac: 13 03 a0 fd  	li	t1, -38
   143b0: 13 4e f8 ff  	not	t3, a6
   143b4: 93 86 07 00  	mv	a3, a5
   143b8: 63 d8 07 02  	bgez	a5, 0x143e8 <__lock+0xd8>
   143bc: 93 08 20 06  	li	a7, 98
   143c0: 13 05 07 00  	mv	a0, a4
   143c4: 93 05 00 08  	li	a1, 128
   143c8: 13 86 07 00  	mv	a2, a5
   143cc: 93 06 00 00  	li	a3, 0
   143d0: 73 00 00 00  	ecall	
   143d4: 63 18 65 00  	bne	a0, t1, 0x143e4 <__lock+0xd4>
   143d8: 13 05 07 00  	mv	a0, a4
   143dc: 93 05 00 00  	li	a1, 0
   143e0: 73 00 00 00  	ecall	
   143e4: bb 06 fe 00  	addw	a3, t3, a5
   143e8: 3b 06 d8 00  	addw	a2, a6, a3
   143ec: af 27 07 16  	<unknown>
   143f0: 63 96 d7 00  	bne	a5, a3, 0x143fc <__lock+0xec>
   143f4: af 25 c7 1e  	<unknown>
   143f8: e3 9a 05 fe  	bnez	a1, 0x143ec <__lock+0xdc>
   143fc: 9b 87 07 00  	sext.w	a5, a5
   14400: e3 9a f6 fa  	bne	a3, a5, 0x143b4 <__lock+0xa4>
   14404: 67 80 00 00  	ret

0000000000014408 <__unlock>:
   14408: 03 27 05 00  	lw	a4, 0(a0)
   1440c: 93 07 05 00  	mv	a5, a0
   14410: 1b 07 07 00  	sext.w	a4, a4
   14414: 63 52 07 06  	bgez	a4, 0x14478 <__unlock+0x70>
   14418: b7 05 00 80  	lui	a1, 524288
   1441c: 93 c5 f5 ff  	not	a1, a1
   14420: 03 a7 07 00  	lw	a4, 0(a5)
   14424: 9b 06 07 00  	sext.w	a3, a4
   14428: 3b 07 b7 00  	addw	a4, a4, a1
   1442c: 2f a6 07 16  	<unknown>
   14430: 63 16 d6 00  	bne	a2, a3, 0x1443c <__unlock+0x34>
   14434: 2f a5 e7 1e  	<unknown>
   14438: e3 1a 05 fe  	bnez	a0, 0x1442c <__unlock+0x24>
   1443c: 1b 07 06 00  	sext.w	a4, a2
   14440: e3 90 e6 fe  	bne	a3, a4, 0x14420 <__unlock+0x18>
   14444: 37 07 00 80  	lui	a4, 524288
   14448: 13 07 17 00  	addi	a4, a4, 1
   1444c: 63 86 e6 02  	beq	a3, a4, 0x14478 <__unlock+0x70>
   14450: 93 08 20 06  	li	a7, 98
   14454: 13 85 07 00  	mv	a0, a5
   14458: 93 05 10 08  	li	a1, 129
   1445c: 13 06 10 00  	li	a2, 1
   14460: 73 00 00 00  	ecall	
   14464: 13 07 a0 fd  	li	a4, -38
   14468: 63 18 e5 00  	bne	a0, a4, 0x14478 <__unlock+0x70>
   1446c: 13 85 07 00  	mv	a0, a5
   14470: 93 05 10 00  	li	a1, 1
   14474: 73 00 00 00  	ecall	
   14478: 67 80 00 00  	ret

000000000001447c <sccp>:
   1447c: 93 08 05 00  	mv	a7, a0
   14480: 13 85 05 00  	mv	a0, a1
   14484: 93 05 06 00  	mv	a1, a2
   14488: 13 86 06 00  	mv	a2, a3
   1448c: 93 06 07 00  	mv	a3, a4
   14490: 13 87 07 00  	mv	a4, a5
   14494: 93 07 08 00  	mv	a5, a6
   14498: 73 00 00 00  	ecall	
   1449c: 67 80 00 00  	ret

00000000000144a0 <__syscall_cp>:
   144a0: 6f f0 df fd  	j	0x1447c <sccp>

00000000000144a4 <a_fetch_add.isra.0>:
   144a4: 83 27 05 00  	lw	a5, 0(a0)
   144a8: 9b 86 07 00  	sext.w	a3, a5
   144ac: bb 87 b7 00  	addw	a5, a5, a1
   144b0: 2f 27 05 16  	<unknown>
   144b4: 63 16 d7 00  	bne	a4, a3, 0x144c0 <a_fetch_add.isra.0+0x1c>
   144b8: 2f 26 f5 1e  	<unknown>
   144bc: e3 1a 06 fe  	bnez	a2, 0x144b0 <a_fetch_add.isra.0+0xc>
   144c0: 9b 07 07 00  	sext.w	a5, a4
   144c4: e3 90 f6 fe  	bne	a3, a5, 0x144a4 <a_fetch_add.isra.0>
   144c8: 67 80 00 00  	ret

00000000000144cc <__wait>:
   144cc: 13 01 01 fd  	addi	sp, sp, -48
   144d0: 23 30 81 02  	sd	s0, 32(sp)
   144d4: 23 3c 91 00  	sd	s1, 24(sp)
   144d8: 23 38 21 01  	sd	s2, 16(sp)
   144dc: 23 34 31 01  	sd	s3, 8(sp)
   144e0: 23 34 11 02  	sd	ra, 40(sp)
   144e4: 93 04 05 00  	mv	s1, a0
   144e8: 13 84 05 00  	mv	s0, a1
   144ec: 13 09 06 00  	mv	s2, a2
   144f0: 93 89 06 00  	mv	s3, a3
   144f4: 63 84 06 00  	beqz	a3, 0x144fc <__wait+0x30>
   144f8: 93 09 00 08  	li	s3, 128
   144fc: 13 07 50 06  	li	a4, 101
   14500: 6f 00 40 01  	j	0x14514 <__wait+0x48>
   14504: 83 a7 04 00  	lw	a5, 0(s1)
   14508: 9b 87 07 00  	sext.w	a5, a5
   1450c: 63 9c 27 09  	bne	a5, s2, 0x145a4 <__wait+0xd8>
   14510: 0f 00 30 03  	fence	rw, rw
   14514: 1b 07 f7 ff  	addiw	a4, a4, -1
   14518: 63 02 07 02  	beqz	a4, 0x1453c <__wait+0x70>
   1451c: e3 04 04 fe  	beqz	s0, 0x14504 <__wait+0x38>
   14520: 83 27 04 00  	lw	a5, 0(s0)
   14524: 9b 87 07 00  	sext.w	a5, a5
   14528: e3 8e 07 fc  	beqz	a5, 0x14504 <__wait+0x38>
   1452c: 93 05 10 00  	li	a1, 1
   14530: 13 05 04 00  	mv	a0, s0
   14534: ef f0 1f f7  	jal	0x144a4 <a_fetch_add.isra.0>
   14538: 6f 00 80 00  	j	0x14540 <__wait+0x74>
   1453c: e3 18 04 fe  	bnez	s0, 0x1452c <__wait+0x60>
   14540: 13 07 a0 fd  	li	a4, -38
   14544: 83 a7 04 00  	lw	a5, 0(s1)
   14548: 9b 87 07 00  	sext.w	a5, a5
   1454c: 63 86 27 03  	beq	a5, s2, 0x14578 <__wait+0xac>
   14550: 63 0a 04 04  	beqz	s0, 0x145a4 <__wait+0xd8>
   14554: 13 05 04 00  	mv	a0, s0
   14558: 03 34 01 02  	ld	s0, 32(sp)
   1455c: 83 30 81 02  	ld	ra, 40(sp)
   14560: 83 34 81 01  	ld	s1, 24(sp)
   14564: 03 39 01 01  	ld	s2, 16(sp)
   14568: 83 39 81 00  	ld	s3, 8(sp)
   1456c: 93 05 f0 ff  	li	a1, -1
   14570: 13 01 01 03  	addi	sp, sp, 48
   14574: 6f f0 1f f3  	j	0x144a4 <a_fetch_add.isra.0>
   14578: 93 08 20 06  	li	a7, 98
   1457c: 13 85 04 00  	mv	a0, s1
   14580: 93 85 09 00  	mv	a1, s3
   14584: 13 06 09 00  	mv	a2, s2
   14588: 93 06 00 00  	li	a3, 0
   1458c: 73 00 00 00  	ecall	
   14590: e3 1a e5 fa  	bne	a0, a4, 0x14544 <__wait+0x78>
   14594: 13 85 04 00  	mv	a0, s1
   14598: 93 05 00 00  	li	a1, 0
   1459c: 73 00 00 00  	ecall	
   145a0: 6f f0 5f fa  	j	0x14544 <__wait+0x78>
   145a4: 83 30 81 02  	ld	ra, 40(sp)
   145a8: 03 34 01 02  	ld	s0, 32(sp)
   145ac: 83 34 81 01  	ld	s1, 24(sp)
   145b0: 03 39 01 01  	ld	s2, 16(sp)
   145b4: 83 39 81 00  	ld	s3, 8(sp)
   145b8: 13 01 01 03  	addi	sp, sp, 48
   145bc: 67 80 00 00  	ret

00000000000145c0 <pthread_sigmask>:
   145c0: 63 88 05 00  	beqz	a1, 0x145d0 <pthread_sigmask+0x10>
   145c4: 13 07 20 00  	li	a4, 2
   145c8: 93 07 60 01  	li	a5, 22
   145cc: 63 6a a7 02  	bltu	a4, a0, 0x14600 <pthread_sigmask+0x40>
   145d0: 93 08 70 08  	li	a7, 135
   145d4: 93 06 80 00  	li	a3, 8
   145d8: 73 00 00 00  	ecall	
   145dc: bb 07 a0 40  	negw	a5, a0
   145e0: 63 90 07 02  	bnez	a5, 0x14600 <pthread_sigmask+0x40>
   145e4: 63 0e 06 00  	beqz	a2, 0x14600 <pthread_sigmask+0x40>
   145e8: 83 36 06 00  	ld	a3, 0(a2)
   145ec: 13 07 90 ff  	li	a4, -7
   145f0: 13 17 f7 01  	slli	a4, a4, 31
   145f4: 13 07 f7 ff  	addi	a4, a4, -1
   145f8: 33 f7 e6 00  	and	a4, a3, a4
   145fc: 23 30 e6 00  	sd	a4, 0(a2)
   14600: 13 85 07 00  	mv	a0, a5
   14604: 67 80 00 00  	ret

0000000000014608 <dummy>:
   14608: 67 80 00 00  	ret

000000000001460c <handler>:
   1460c: 93 07 02 00  	mv	a5, tp
   14610: 03 a7 87 f5  	lw	a4, -168(a5)
   14614: 83 a7 81 a2  	lw	a5, -1496(gp)
   14618: 63 1e f7 06  	bne	a4, a5, 0x14694 <handler+0x88>
   1461c: 13 01 01 fd  	addi	sp, sp, -48
   14620: 23 34 11 02  	sd	ra, 40(sp)
   14624: 23 30 81 02  	sd	s0, 32(sp)
   14628: 23 3c 91 00  	sd	s1, 24(sp)
   1462c: 23 38 21 01  	sd	s2, 16(sp)
   14630: 23 34 31 01  	sd	s3, 8(sp)
   14634: ef c0 df fe  	jal	0x11620 <__errno_location>
   14638: 83 29 05 00  	lw	s3, 0(a0)
   1463c: 13 04 05 00  	mv	s0, a0
   14640: 13 85 81 2d  	addi	a0, gp, 728
   14644: ef 20 d0 5c  	jal	0x17410 <sem_post>
   14648: 13 85 81 2f  	addi	a0, gp, 760
   1464c: ef 20 90 67  	jal	0x174c4 <sem_wait>
   14650: 03 b5 01 a2  	ld	a0, -1504(gp)
   14654: 83 b7 81 a1  	ld	a5, -1512(gp)
   14658: e7 80 07 00  	jalr	a5
   1465c: 13 85 81 2d  	addi	a0, gp, 728
   14660: ef 20 10 5b  	jal	0x17410 <sem_post>
   14664: 13 85 81 2f  	addi	a0, gp, 760
   14668: ef 20 d0 65  	jal	0x174c4 <sem_wait>
   1466c: 13 85 81 2d  	addi	a0, gp, 728
   14670: ef 20 10 5a  	jal	0x17410 <sem_post>
   14674: 83 30 81 02  	ld	ra, 40(sp)
   14678: 23 20 34 01  	sw	s3, 0(s0)
   1467c: 03 34 01 02  	ld	s0, 32(sp)
   14680: 83 34 81 01  	ld	s1, 24(sp)
   14684: 03 39 01 01  	ld	s2, 16(sp)
   14688: 83 39 81 00  	ld	s3, 8(sp)
   1468c: 13 01 01 03  	addi	sp, sp, 48
   14690: 67 80 00 00  	ret
   14694: 67 80 00 00  	ret

0000000000014698 <dummy_0>:
   14698: 67 80 00 00  	ret

000000000001469c <__synccall>:
   1469c: 13 01 01 e8  	addi	sp, sp, -384
   146a0: 23 34 91 16  	sd	s1, 360(sp)
   146a4: 23 34 51 15  	sd	s5, 328(sp)
   146a8: 93 04 05 00  	mv	s1, a0
   146ac: 93 8a 05 00  	mv	s5, a1
   146b0: 13 06 00 09  	li	a2, 144
   146b4: 93 05 00 00  	li	a1, 0
   146b8: 13 05 01 09  	addi	a0, sp, 144
   146bc: 23 3c 11 16  	sd	ra, 376(sp)
   146c0: 23 38 81 16  	sd	s0, 368(sp)
   146c4: 23 30 21 17  	sd	s2, 352(sp)
   146c8: 23 3c 31 15  	sd	s3, 344(sp)
   146cc: 23 38 41 15  	sd	s4, 336(sp)
   146d0: 23 30 61 15  	sd	s6, 320(sp)
   146d4: 23 3c 71 13  	sd	s7, 312(sp)
   146d8: 23 38 81 13  	sd	s8, 304(sp)
   146dc: 23 34 91 13  	sd	s9, 296(sp)
   146e0: ef f0 5f 9a  	jal	0x14084 <memset>
   146e4: b7 47 01 00  	lui	a5, 20
   146e8: 93 87 c7 60  	addi	a5, a5, 1548
   146ec: 23 34 f1 08  	sd	a5, 136(sp)
   146f0: b7 07 00 10  	lui	a5, 65536
   146f4: 23 28 f1 10  	sw	a5, 272(sp)
   146f8: 13 0a 02 00  	mv	s4, tp
   146fc: 13 05 81 00  	addi	a0, sp, 8
   14700: ef e0 9f c2  	jal	0x13328 <__block_app_sigs>
   14704: ef f0 5f f9  	jal	0x14698 <dummy_0>
   14708: 13 05 00 00  	li	a0, 0
   1470c: ef e0 1f c0  	jal	0x1330c <__block_all_sigs>
   14710: 93 05 41 00  	addi	a1, sp, 4
   14714: 13 05 10 00  	li	a0, 1
   14718: ef 20 d0 46  	jal	0x17384 <pthread_setcancelstate>
   1471c: 13 06 00 00  	li	a2, 0
   14720: 93 05 00 00  	li	a1, 0
   14724: 13 85 81 2f  	addi	a0, gp, 760
   14728: ef 20 50 4a  	jal	0x173cc <sem_init>
   1472c: 13 06 00 00  	li	a2, 0
   14730: 93 05 00 00  	li	a1, 0
   14734: 13 85 81 2d  	addi	a0, gp, 728
   14738: ef 20 50 49  	jal	0x173cc <sem_init>
   1473c: 93 87 81 bc  	addi	a5, gp, -1080
   14740: 03 a4 c7 00  	lw	s0, 12(a5)
   14744: 1b 04 04 00  	sext.w	s0, s0
   14748: 63 00 04 0a  	beqz	s0, 0x147e8 <__synccall+0x14c>
   1474c: 13 06 00 08  	li	a2, 128
   14750: 93 05 f0 ff  	li	a1, -1
   14754: 13 05 01 09  	addi	a0, sp, 144
   14758: 23 bc 91 a0  	sd	s1, -1512(gp)
   1475c: 23 b0 51 a3  	sd	s5, -1504(gp)
   14760: ef f0 5f 92  	jal	0x14084 <memset>
   14764: 13 06 00 00  	li	a2, 0
   14768: 93 05 81 08  	addi	a1, sp, 136
   1476c: 13 05 20 02  	li	a0, 34
   14770: 93 0b 0a f2  	addi	s7, s4, -224
   14774: ef 00 10 1b  	jal	0x15124 <__libc_sigaction>
   14778: 03 3a 8a f3  	ld	s4, -200(s4)
   1477c: 13 04 00 00  	li	s0, 0
   14780: 13 8b 81 a1  	addi	s6, gp, -1512
   14784: 93 0c b0 00  	li	s9, 11
   14788: 93 87 81 a2  	addi	a5, gp, -1496
   1478c: 63 0c 7a 03  	beq	s4, s7, 0x147c4 <__synccall+0x128>
   14790: 03 27 8a 03  	lw	a4, 56(s4)
   14794: 23 a0 e7 00  	sw	a4, 0(a5)
   14798: 03 25 8a 03  	lw	a0, 56(s4)
   1479c: 93 08 20 08  	li	a7, 130
   147a0: 93 05 20 02  	li	a1, 34
   147a4: 73 00 00 00  	ecall	
   147a8: 3b 05 a0 40  	negw	a0, a0
   147ac: e3 06 95 ff  	beq	a0, s9, 0x14798 <__synccall+0xfc>
   147b0: 63 06 05 0a  	beqz	a0, 0x1485c <__synccall+0x1c0>
   147b4: b7 44 01 00  	lui	s1, 20
   147b8: 13 87 84 60  	addi	a4, s1, 1544
   147bc: 23 30 eb 00  	sd	a4, 0(s6)
   147c0: 93 84 84 60  	addi	s1, s1, 1544
   147c4: 23 a0 07 00  	sw	zero, 0(a5)
   147c8: 13 0a 00 00  	li	s4, 0
   147cc: 63 12 8a 0a  	bne	s4, s0, 0x14870 <__synccall+0x1d4>
   147d0: 93 07 10 00  	li	a5, 1
   147d4: 13 06 00 00  	li	a2, 0
   147d8: 93 05 81 08  	addi	a1, sp, 136
   147dc: 13 05 20 02  	li	a0, 34
   147e0: 23 34 f1 08  	sd	a5, 136(sp)
   147e4: ef 00 10 14  	jal	0x15124 <__libc_sigaction>
   147e8: 13 85 0a 00  	mv	a0, s5
   147ec: e7 80 04 00  	jalr	s1
   147f0: 93 04 00 00  	li	s1, 0
   147f4: 63 9a 84 08  	bne	s1, s0, 0x14888 <__synccall+0x1ec>
   147f8: 93 04 00 00  	li	s1, 0
   147fc: 13 85 81 2d  	addi	a0, gp, 728
   14800: 63 9c 84 08  	bne	s1, s0, 0x14898 <__synccall+0x1fc>
   14804: ef 20 10 3c  	jal	0x173c4 <sem_destroy>
   14808: 13 85 81 2f  	addi	a0, gp, 760
   1480c: ef 20 90 3b  	jal	0x173c4 <sem_destroy>
   14810: 03 25 41 00  	lw	a0, 4(sp)
   14814: 93 05 00 00  	li	a1, 0
   14818: ef 20 d0 36  	jal	0x17384 <pthread_setcancelstate>
   1481c: ef f0 df e7  	jal	0x14698 <dummy_0>
   14820: 13 05 81 00  	addi	a0, sp, 8
   14824: ef e0 1f b2  	jal	0x13344 <__restore_sigs>
   14828: 83 30 81 17  	ld	ra, 376(sp)
   1482c: 03 34 01 17  	ld	s0, 368(sp)
   14830: 83 34 81 16  	ld	s1, 360(sp)
   14834: 03 39 01 16  	ld	s2, 352(sp)
   14838: 83 39 81 15  	ld	s3, 344(sp)
   1483c: 03 3a 01 15  	ld	s4, 336(sp)
   14840: 83 3a 81 14  	ld	s5, 328(sp)
   14844: 03 3b 01 14  	ld	s6, 320(sp)
   14848: 83 3b 81 13  	ld	s7, 312(sp)
   1484c: 03 3c 01 13  	ld	s8, 304(sp)
   14850: 83 3c 81 12  	ld	s9, 296(sp)
   14854: 13 01 01 18  	addi	sp, sp, 384
   14858: 67 80 00 00  	ret
   1485c: 13 85 81 2d  	addi	a0, gp, 728
   14860: ef 20 50 46  	jal	0x174c4 <sem_wait>
   14864: 1b 04 14 00  	addiw	s0, s0, 1
   14868: 03 3a 8a 01  	ld	s4, 24(s4)
   1486c: 6f f0 df f1  	j	0x14788 <__synccall+0xec>
   14870: 13 85 81 2f  	addi	a0, gp, 760
   14874: ef 20 d0 39  	jal	0x17410 <sem_post>
   14878: 13 85 81 2d  	addi	a0, gp, 728
   1487c: ef 20 90 44  	jal	0x174c4 <sem_wait>
   14880: 1b 0a 1a 00  	addiw	s4, s4, 1
   14884: 6f f0 9f f4  	j	0x147cc <__synccall+0x130>
   14888: 13 85 81 2f  	addi	a0, gp, 760
   1488c: ef 20 50 38  	jal	0x17410 <sem_post>
   14890: 9b 84 14 00  	addiw	s1, s1, 1
   14894: 6f f0 1f f6  	j	0x147f4 <__synccall+0x158>
   14898: ef 20 d0 42  	jal	0x174c4 <sem_wait>
   1489c: 9b 84 14 00  	addiw	s1, s1, 1
   148a0: 6f f0 df f5  	j	0x147fc <__synccall+0x160>

00000000000148a4 <dup>:
   148a4: 13 01 01 ff  	addi	sp, sp, -16
   148a8: 23 34 11 00  	sd	ra, 8(sp)
   148ac: 93 08 70 01  	li	a7, 23
   148b0: 73 00 00 00  	ecall	
   148b4: ef c0 9f ed  	jal	0x1178c <__syscall_ret>
   148b8: 83 30 81 00  	ld	ra, 8(sp)
   148bc: 1b 05 05 00  	sext.w	a0, a0
   148c0: 13 01 01 01  	addi	sp, sp, 16
   148c4: 67 80 00 00  	ret

00000000000148c8 <write>:
   148c8: 13 01 01 ff  	addi	sp, sp, -16
   148cc: 93 06 06 00  	mv	a3, a2
   148d0: 13 08 00 00  	li	a6, 0
   148d4: 13 86 05 00  	mv	a2, a1
   148d8: 93 07 00 00  	li	a5, 0
   148dc: 93 05 05 00  	mv	a1, a0
   148e0: 13 07 00 00  	li	a4, 0
   148e4: 13 05 00 04  	li	a0, 64
   148e8: 23 34 11 00  	sd	ra, 8(sp)
   148ec: ef f0 5f bb  	jal	0x144a0 <__syscall_cp>
   148f0: 83 30 81 00  	ld	ra, 8(sp)
   148f4: 13 01 01 01  	addi	sp, sp, 16
   148f8: 6f c0 5f e9  	j	0x1178c <__syscall_ret>

00000000000148fc <__init_tp>:
   148fc: 13 01 01 ff  	addi	sp, sp, -16
   14900: 23 30 81 00  	sd	s0, 0(sp)
   14904: 23 34 11 00  	sd	ra, 8(sp)
   14908: 13 04 05 00  	mv	s0, a0
   1490c: 23 30 a5 00  	sd	a0, 0(a0)
   14910: 13 05 05 0e  	addi	a0, a0, 224
   14914: ef 20 50 2a  	jal	0x173b8 <__set_thread_area>
   14918: 63 4e 05 04  	bltz	a0, 0x14974 <__init_tp+0x78>
   1491c: 63 16 05 00  	bnez	a0, 0x14928 <__init_tp+0x2c>
   14920: 13 07 10 00  	li	a4, 1
   14924: 23 a4 e1 bc  	sw	a4, -1080(gp)
   14928: 93 07 10 00  	li	a5, 1
   1492c: 23 20 f4 04  	sw	a5, 64(s0)
   14930: 93 08 00 06  	li	a7, 96
   14934: 13 85 81 a3  	addi	a0, gp, -1480
   14938: 73 00 00 00  	ecall	
   1493c: 93 87 81 c0  	addi	a5, gp, -1016
   14940: 23 38 f4 0a  	sd	a5, 176(s0)
   14944: 93 07 04 09  	addi	a5, s0, 144
   14948: 23 38 f4 08  	sd	a5, 144(s0)
   1494c: 83 b7 81 9a  	ld	a5, -1624(gp)
   14950: 23 2c a4 02  	sw	a0, 56(s0)
   14954: 23 38 84 00  	sd	s0, 16(s0)
   14958: 23 30 f4 02  	sd	a5, 32(s0)
   1495c: 23 3c 84 00  	sd	s0, 24(s0)
   14960: 13 05 00 00  	li	a0, 0
   14964: 83 30 81 00  	ld	ra, 8(sp)
   14968: 03 34 01 00  	ld	s0, 0(sp)
   1496c: 13 01 01 01  	addi	sp, sp, 16
   14970: 67 80 00 00  	ret
   14974: 13 05 f0 ff  	li	a0, -1
   14978: 6f f0 df fe  	j	0x14964 <__init_tp+0x68>

000000000001497c <__copy_tls>:
   1497c: 13 01 01 fc  	addi	sp, sp, -64
   14980: 13 87 81 bc  	addi	a4, gp, -1080
   14984: 83 36 07 03  	ld	a3, 48(a4)
   14988: 23 34 91 02  	sd	s1, 40(sp)
   1498c: 83 34 07 02  	ld	s1, 32(a4)
   14990: 23 38 81 02  	sd	s0, 48(sp)
   14994: 03 34 87 02  	ld	s0, 40(a4)
   14998: 93 96 36 00  	slli	a3, a3, 3
   1499c: 93 84 84 ff  	addi	s1, s1, -8
   149a0: b3 84 d4 40  	sub	s1, s1, a3
   149a4: 93 06 00 f2  	li	a3, -224
   149a8: 13 04 f4 ff  	addi	s0, s0, -1
   149ac: b3 86 a6 40  	sub	a3, a3, a0
   149b0: 23 30 21 03  	sd	s2, 32(sp)
   149b4: 33 74 d4 00  	and	s0, s0, a3
   149b8: 03 39 87 01  	ld	s2, 24(a4)
   149bc: 23 34 51 01  	sd	s5, 8(sp)
   149c0: b3 04 95 00  	add	s1, a0, s1
   149c4: 33 04 85 00  	add	s0, a0, s0
   149c8: b7 1a 00 00  	lui	s5, 1
   149cc: 23 3c 31 01  	sd	s3, 24(sp)
   149d0: 23 38 41 01  	sd	s4, 16(sp)
   149d4: 23 30 61 01  	sd	s6, 0(sp)
   149d8: 23 3c 11 02  	sd	ra, 56(sp)
   149dc: 13 0b 04 0e  	addi	s6, s0, 224
   149e0: 13 8a 84 00  	addi	s4, s1, 8
   149e4: 93 89 81 bc  	addi	s3, gp, -1080
   149e8: 93 8a 0a 80  	addi	s5, s5, -2048
   149ec: 63 10 09 04  	bnez	s2, 0x14a2c <__copy_tls+0xb0>
   149f0: 83 b7 09 03  	ld	a5, 48(s3)
   149f4: 83 30 81 03  	ld	ra, 56(sp)
   149f8: 13 05 04 00  	mv	a0, s0
   149fc: 23 b0 f4 00  	sd	a5, 0(s1)
   14a00: 23 3c 94 0c  	sd	s1, 216(s0)
   14a04: 23 34 94 00  	sd	s1, 8(s0)
   14a08: 03 34 01 03  	ld	s0, 48(sp)
   14a0c: 83 34 81 02  	ld	s1, 40(sp)
   14a10: 03 39 01 02  	ld	s2, 32(sp)
   14a14: 83 39 81 01  	ld	s3, 24(sp)
   14a18: 03 3a 01 01  	ld	s4, 16(sp)
   14a1c: 83 3a 81 00  	ld	s5, 8(sp)
   14a20: 03 3b 01 00  	ld	s6, 0(sp)
   14a24: 13 01 01 04  	addi	sp, sp, 64
   14a28: 67 80 00 00  	ret
   14a2c: 83 37 89 02  	ld	a5, 40(s2)
   14a30: 83 35 89 00  	ld	a1, 8(s2)
   14a34: 13 0a 8a 00  	addi	s4, s4, 8
   14a38: b3 07 fb 00  	add	a5, s6, a5
   14a3c: b3 87 57 01  	add	a5, a5, s5
   14a40: 23 3c fa fe  	sd	a5, -8(s4)
   14a44: 03 35 89 02  	ld	a0, 40(s2)
   14a48: 03 36 09 01  	ld	a2, 16(s2)
   14a4c: 33 05 ab 00  	add	a0, s6, a0
   14a50: ef f0 0f 9f  	jal	0x13c40 <memcpy>
   14a54: 03 39 09 00  	ld	s2, 0(s2)
   14a58: 6f f0 5f f9  	j	0x149ec <__copy_tls+0x70>

0000000000014a5c <static_init_tls>:
   14a5c: 83 3f 85 01  	ld	t6, 24(a0)
   14a60: 03 3e 85 02  	ld	t3, 40(a0)
   14a64: 03 a3 c1 99  	lw	t1, -1636(gp)
   14a68: 13 01 01 ff  	addi	sp, sp, -16
   14a6c: b7 ee 74 64  	lui	t4, 411470
   14a70: 23 34 11 00  	sd	ra, 8(sp)
   14a74: 23 30 81 00  	sd	s0, 0(sp)
   14a78: 93 87 0f 00  	mv	a5, t6
   14a7c: 13 0f 00 00  	li	t5, 0
   14a80: 13 07 00 00  	li	a4, 0
   14a84: 13 06 00 00  	li	a2, 0
   14a88: 93 02 60 00  	li	t0, 6
   14a8c: 93 03 20 00  	li	t2, 2
   14a90: 13 08 00 00  	li	a6, 0
   14a94: 93 00 70 00  	li	ra, 7
   14a98: 93 8e 1e 55  	addi	t4, t4, 1361
   14a9c: 37 04 80 00  	lui	s0, 2048
   14aa0: 63 1c 0e 0c  	bnez	t3, 0x14b78 <static_init_tls+0x11c>
   14aa4: 63 04 0f 00  	beqz	t5, 0x14aac <static_init_tls+0x50>
   14aa8: 23 ae 61 98  	sw	t1, -1636(gp)
   14aac: 93 87 01 48  	addi	a5, gp, 1152
   14ab0: 93 86 81 bc  	addi	a3, gp, -1080
   14ab4: 63 0a 06 02  	beqz	a2, 0x14ae8 <static_init_tls+0x8c>
   14ab8: 83 35 06 01  	ld	a1, 16(a2)
   14abc: 23 bc f6 00  	sd	a5, 24(a3)
   14ac0: 33 87 e5 00  	add	a4, a1, a4
   14ac4: 23 b4 e7 00  	sd	a4, 8(a5)
   14ac8: 03 37 06 02  	ld	a4, 32(a2)
   14acc: 23 b8 e7 00  	sd	a4, 16(a5)
   14ad0: 03 37 86 02  	ld	a4, 40(a2)
   14ad4: 23 bc e7 00  	sd	a4, 24(a5)
   14ad8: 03 37 06 03  	ld	a4, 48(a2)
   14adc: 23 b0 e7 02  	sd	a4, 32(a5)
   14ae0: 13 07 10 00  	li	a4, 1
   14ae4: 23 b8 e6 02  	sd	a4, 48(a3)
   14ae8: 03 b8 87 01  	ld	a6, 24(a5)
   14aec: 83 b5 87 00  	ld	a1, 8(a5)
   14af0: 03 b5 07 02  	ld	a0, 32(a5)
   14af4: 33 07 b8 00  	add	a4, a6, a1
   14af8: 13 06 f5 ff  	addi	a2, a0, -1
   14afc: 33 07 e0 40  	neg	a4, a4
   14b00: 33 77 c7 00  	and	a4, a4, a2
   14b04: 33 07 07 01  	add	a4, a4, a6
   14b08: 33 f6 c5 00  	and	a2, a1, a2
   14b0c: 23 bc e7 00  	sd	a4, 24(a5)
   14b10: 23 b4 c7 02  	sd	a2, 40(a5)
   14b14: 93 05 70 00  	li	a1, 7
   14b18: 63 e6 a5 00  	bltu	a1, a0, 0x14b24 <static_init_tls+0xc8>
   14b1c: 93 05 80 00  	li	a1, 8
   14b20: 23 b0 b7 02  	sd	a1, 32(a5)
   14b24: 83 b7 07 02  	ld	a5, 32(a5)
   14b28: 93 85 77 0f  	addi	a1, a5, 247
   14b2c: b3 85 c5 00  	add	a1, a1, a2
   14b30: b3 85 e5 00  	add	a1, a1, a4
   14b34: 93 f5 85 ff  	andi	a1, a1, -8
   14b38: 23 b4 f6 02  	sd	a5, 40(a3)
   14b3c: 23 b0 b6 02  	sd	a1, 32(a3)
   14b40: 93 07 80 16  	li	a5, 360
   14b44: 63 fe b7 08  	bgeu	a5, a1, 0x14be0 <static_init_tls+0x184>
   14b48: 93 08 e0 0d  	li	a7, 222
   14b4c: 13 05 00 00  	li	a0, 0
   14b50: 13 06 30 00  	li	a2, 3
   14b54: 93 06 20 02  	li	a3, 34
   14b58: 13 07 f0 ff  	li	a4, -1
   14b5c: 93 07 00 00  	li	a5, 0
   14b60: 73 00 00 00  	ecall	
   14b64: ef f0 9f e1  	jal	0x1497c <__copy_tls>
   14b68: ef f0 5f d9  	jal	0x148fc <__init_tp>
   14b6c: 63 5e 05 06  	bgez	a0, 0x14be8 <static_init_tls+0x18c>
   14b70: 23 00 00 00  	sb	zero, 0(zero)
   14b74: 73 00 10 00  	ebreak	
   14b78: 83 a8 07 00  	lw	a7, 0(a5)
   14b7c: 63 9e 58 00  	bne	a7, t0, 0x14b98 <static_init_tls+0x13c>
   14b80: 03 b7 07 01  	ld	a4, 16(a5)
   14b84: 33 87 ef 40  	sub	a4, t6, a4
   14b88: 83 36 05 02  	ld	a3, 32(a0)
   14b8c: 13 0e fe ff  	addi	t3, t3, -1
   14b90: b3 87 d7 00  	add	a5, a5, a3
   14b94: 6f f0 df f0  	j	0x14aa0 <static_init_tls+0x44>
   14b98: 63 88 78 02  	beq	a7, t2, 0x14bc8 <static_init_tls+0x16c>
   14b9c: 63 8e 18 02  	beq	a7, ra, 0x14bd8 <static_init_tls+0x17c>
   14ba0: e3 94 d8 ff  	bne	a7, t4, 0x14b88 <static_init_tls+0x12c>
   14ba4: 83 b6 87 02  	ld	a3, 40(a5)
   14ba8: 93 18 03 02  	slli	a7, t1, 32
   14bac: 93 d8 08 02  	srli	a7, a7, 32
   14bb0: e3 fc d8 fc  	bgeu	a7, a3, 0x14b88 <static_init_tls+0x12c>
   14bb4: 63 74 d4 00  	bgeu	s0, a3, 0x14bbc <static_init_tls+0x160>
   14bb8: b7 06 80 00  	lui	a3, 2048
   14bbc: 1b 83 06 00  	sext.w	t1, a3
   14bc0: 13 0f 10 00  	li	t5, 1
   14bc4: 6f f0 5f fc  	j	0x14b88 <static_init_tls+0x12c>
   14bc8: e3 00 08 fc  	beqz	a6, 0x14b88 <static_init_tls+0x12c>
   14bcc: 03 b7 07 01  	ld	a4, 16(a5)
   14bd0: 33 07 e8 40  	sub	a4, a6, a4
   14bd4: 6f f0 5f fb  	j	0x14b88 <static_init_tls+0x12c>
   14bd8: 13 86 07 00  	mv	a2, a5
   14bdc: 6f f0 df fa  	j	0x14b88 <static_init_tls+0x12c>
   14be0: 13 85 81 31  	addi	a0, gp, 792
   14be4: 6f f0 1f f8  	j	0x14b64 <static_init_tls+0x108>
   14be8: 83 30 81 00  	ld	ra, 8(sp)
   14bec: 03 34 01 00  	ld	s0, 0(sp)
   14bf0: 13 01 01 01  	addi	sp, sp, 16
   14bf4: 67 80 00 00  	ret

0000000000014bf8 <_Exit>:
   14bf8: 93 07 05 00  	mv	a5, a0
   14bfc: 93 08 e0 05  	li	a7, 94
   14c00: 73 00 00 00  	ecall	
   14c04: 93 08 d0 05  	li	a7, 93
   14c08: 13 85 07 00  	mv	a0, a5
   14c0c: 6f f0 5f ff  	j	0x14c00 <_Exit+0x8>

0000000000014c10 <__lctrans_impl>:
   14c10: 13 01 01 ff  	addi	sp, sp, -16
   14c14: 23 30 81 00  	sd	s0, 0(sp)
   14c18: 23 34 11 00  	sd	ra, 8(sp)
   14c1c: 13 04 05 00  	mv	s0, a0
   14c20: 63 9c 05 00  	bnez	a1, 0x14c38 <__lctrans_impl+0x28>
   14c24: 13 05 04 00  	mv	a0, s0
   14c28: 83 30 81 00  	ld	ra, 8(sp)
   14c2c: 03 34 01 00  	ld	s0, 0(sp)
   14c30: 13 01 01 01  	addi	sp, sp, 16
   14c34: 67 80 00 00  	ret
   14c38: 93 87 05 00  	mv	a5, a1
   14c3c: 13 06 05 00  	mv	a2, a0
   14c40: 83 b5 85 00  	ld	a1, 8(a1)
   14c44: 03 b5 07 00  	ld	a0, 0(a5)
   14c48: ef 20 90 21  	jal	0x17660 <__mo_lookup>
   14c4c: e3 1e 05 fc  	bnez	a0, 0x14c28 <__lctrans_impl+0x18>
   14c50: 6f f0 5f fd  	j	0x14c24 <__lctrans_impl+0x14>

0000000000014c54 <__get_locale>:
   14c54: 13 01 01 e9  	addi	sp, sp, -368
   14c58: 23 30 81 16  	sd	s0, 352(sp)
   14c5c: 23 3c 51 13  	sd	s5, 312(sp)
   14c60: 23 34 11 16  	sd	ra, 360(sp)
   14c64: 23 3c 91 14  	sd	s1, 344(sp)
   14c68: 23 38 21 15  	sd	s2, 336(sp)
   14c6c: 23 34 31 15  	sd	s3, 328(sp)
   14c70: 23 30 41 15  	sd	s4, 320(sp)
   14c74: 23 38 61 13  	sd	s6, 304(sp)
   14c78: 23 34 71 13  	sd	s7, 296(sp)
   14c7c: 23 30 81 13  	sd	s8, 288(sp)
   14c80: 23 3c 91 11  	sd	s9, 280(sp)
   14c84: 23 38 a1 11  	sd	s10, 272(sp)
   14c88: 83 c7 05 00  	lbu	a5, 0(a1)
   14c8c: 93 0a 05 00  	mv	s5, a0
   14c90: 13 84 05 00  	mv	s0, a1
   14c94: 63 92 07 06  	bnez	a5, 0x14cf8 <__get_locale+0xa4>
   14c98: 37 b5 01 00  	lui	a0, 27
   14c9c: 13 05 05 74  	addi	a0, a0, 1856
   14ca0: ef 20 90 0e  	jal	0x17588 <getenv>
   14ca4: 13 04 05 00  	mv	s0, a0
   14ca8: 63 06 05 00  	beqz	a0, 0x14cb4 <__get_locale+0x60>
   14cac: 83 47 05 00  	lbu	a5, 0(a0)
   14cb0: 63 94 07 04  	bnez	a5, 0x14cf8 <__get_locale+0xa4>
   14cb4: 93 07 c0 00  	li	a5, 12
   14cb8: b3 87 fa 02  	<unknown>
   14cbc: 37 b5 01 00  	lui	a0, 27
   14cc0: 13 05 85 76  	addi	a0, a0, 1896
   14cc4: 33 05 f5 00  	add	a0, a0, a5
   14cc8: ef 20 10 0c  	jal	0x17588 <getenv>
   14ccc: 13 04 05 00  	mv	s0, a0
   14cd0: 63 06 05 00  	beqz	a0, 0x14cdc <__get_locale+0x88>
   14cd4: 83 47 05 00  	lbu	a5, 0(a0)
   14cd8: 63 90 07 02  	bnez	a5, 0x14cf8 <__get_locale+0xa4>
   14cdc: 37 b5 01 00  	lui	a0, 27
   14ce0: 13 05 85 74  	addi	a0, a0, 1864
   14ce4: ef 20 50 0a  	jal	0x17588 <getenv>
   14ce8: 13 04 05 00  	mv	s0, a0
   14cec: 63 08 05 0a  	beqz	a0, 0x14d9c <__get_locale+0x148>
   14cf0: 83 47 05 00  	lbu	a5, 0(a0)
   14cf4: 63 84 07 0a  	beqz	a5, 0x14d9c <__get_locale+0x148>
   14cf8: 13 09 00 00  	li	s2, 0
   14cfc: 13 07 f0 02  	li	a4, 47
   14d00: 93 06 70 01  	li	a3, 23
   14d04: b3 07 24 01  	add	a5, s0, s2
   14d08: 83 c7 07 00  	lbu	a5, 0(a5)
   14d0c: 63 88 07 00  	beqz	a5, 0x14d1c <__get_locale+0xc8>
   14d10: 63 86 e7 00  	beq	a5, a4, 0x14d1c <__get_locale+0xc8>
   14d14: 13 09 19 00  	addi	s2, s2, 1
   14d18: e3 16 d9 fe  	bne	s2, a3, 0x14d04 <__get_locale+0xb0>
   14d1c: 83 47 04 00  	lbu	a5, 0(s0)
   14d20: 13 07 e0 02  	li	a4, 46
   14d24: 63 82 e7 08  	beq	a5, a4, 0x14da8 <__get_locale+0x154>
   14d28: 33 07 24 01  	add	a4, s0, s2
   14d2c: 03 47 07 00  	lbu	a4, 0(a4)
   14d30: 63 1c 07 06  	bnez	a4, 0x14da8 <__get_locale+0x154>
   14d34: 13 07 30 04  	li	a4, 67
   14d38: 63 96 e7 00  	bne	a5, a4, 0x14d44 <__get_locale+0xf0>
   14d3c: 83 47 14 00  	lbu	a5, 1(s0)
   14d40: 63 8e 07 00  	beqz	a5, 0x14d5c <__get_locale+0x108>
   14d44: b7 b5 01 00  	lui	a1, 27
   14d48: 93 85 85 82  	addi	a1, a1, -2008
   14d4c: 13 05 04 00  	mv	a0, s0
   14d50: ef f0 0f cd  	jal	0x14220 <strcmp>
   14d54: 63 10 05 06  	bnez	a0, 0x14db4 <__get_locale+0x160>
   14d58: 63 8e 0a 0e  	beqz	s5, 0x14e54 <__get_locale+0x200>
   14d5c: 93 04 00 00  	li	s1, 0
   14d60: 83 30 81 16  	ld	ra, 360(sp)
   14d64: 03 34 01 16  	ld	s0, 352(sp)
   14d68: 03 39 01 15  	ld	s2, 336(sp)
   14d6c: 83 39 81 14  	ld	s3, 328(sp)
   14d70: 03 3a 01 14  	ld	s4, 320(sp)
   14d74: 83 3a 81 13  	ld	s5, 312(sp)
   14d78: 03 3b 01 13  	ld	s6, 304(sp)
   14d7c: 83 3b 81 12  	ld	s7, 296(sp)
   14d80: 03 3c 01 12  	ld	s8, 288(sp)
   14d84: 83 3c 81 11  	ld	s9, 280(sp)
   14d88: 03 3d 01 11  	ld	s10, 272(sp)
   14d8c: 13 85 04 00  	mv	a0, s1
   14d90: 83 34 81 15  	ld	s1, 344(sp)
   14d94: 13 01 01 17  	addi	sp, sp, 368
   14d98: 67 80 00 00  	ret
   14d9c: 37 b4 01 00  	lui	s0, 27
   14da0: 13 04 84 82  	addi	s0, s0, -2008
   14da4: 6f f0 5f f5  	j	0x14cf8 <__get_locale+0xa4>
   14da8: 37 b4 01 00  	lui	s0, 27
   14dac: 13 04 84 82  	addi	s0, s0, -2008
   14db0: 6f f0 df f8  	j	0x14d3c <__get_locale+0xe8>
   14db4: b7 b5 01 00  	lui	a1, 27
   14db8: 93 85 05 75  	addi	a1, a1, 1872
   14dbc: 13 05 04 00  	mv	a0, s0
   14dc0: ef f0 0f c6  	jal	0x14220 <strcmp>
   14dc4: e3 0a 05 f8  	beqz	a0, 0x14d58 <__get_locale+0x104>
   14dc8: 93 87 01 a4  	addi	a5, gp, -1472
   14dcc: 83 b4 07 00  	ld	s1, 0(a5)
   14dd0: 13 8a 01 a4  	addi	s4, gp, -1472
   14dd4: 63 9c 04 08  	bnez	s1, 0x14e6c <__get_locale+0x218>
   14dd8: 13 85 81 a4  	addi	a0, gp, -1464
   14ddc: ef f0 4f d3  	jal	0x14310 <__lock>
   14de0: 83 34 0a 00  	ld	s1, 0(s4)
   14de4: 63 90 04 0a  	bnez	s1, 0x14e84 <__get_locale+0x230>
   14de8: 83 a7 01 bd  	lw	a5, -1072(gp)
   14dec: 63 94 07 12  	bnez	a5, 0x14f14 <__get_locale+0x2c0>
   14df0: 37 b5 01 00  	lui	a0, 27
   14df4: 13 05 85 75  	addi	a0, a0, 1880
   14df8: ef 20 00 79  	jal	0x17588 <getenv>
   14dfc: 93 04 05 00  	mv	s1, a0
   14e00: 63 0a 05 10  	beqz	a0, 0x14f14 <__get_locale+0x2c0>
   14e04: 93 0b e0 0f  	li	s7, 254
   14e08: 93 07 01 11  	addi	a5, sp, 272
   14e0c: b3 8b 2b 41  	sub	s7, s7, s2
   14e10: 13 0c f0 02  	li	s8, 47
   14e14: b3 8c 27 01  	add	s9, a5, s2
   14e18: 83 c7 04 00  	lbu	a5, 0(s1)
   14e1c: 63 8c 07 0e  	beqz	a5, 0x14f14 <__get_locale+0x2c0>
   14e20: 93 05 a0 03  	li	a1, 58
   14e24: 13 85 04 00  	mv	a0, s1
   14e28: ef f0 4f b5  	jal	0x1417c <strchrnul>
   14e2c: 83 47 05 00  	lbu	a5, 0(a0)
   14e30: 33 0b 95 40  	sub	s6, a0, s1
   14e34: 13 0d 05 00  	mv	s10, a0
   14e38: b3 37 f0 00  	snez	a5, a5
   14e3c: 33 0b fb 40  	sub	s6, s6, a5
   14e40: 63 64 7b 07  	bltu	s6, s7, 0x14ea8 <__get_locale+0x254>
   14e44: 83 44 0d 00  	lbu	s1, 0(s10)
   14e48: b3 34 90 00  	snez	s1, s1
   14e4c: b3 04 9d 00  	add	s1, s10, s1
   14e50: 6f f0 9f fc  	j	0x14e18 <__get_locale+0x1c4>
   14e54: 03 47 14 00  	lbu	a4, 1(s0)
   14e58: 93 07 e0 02  	li	a5, 46
   14e5c: e3 10 f7 f0  	bne	a4, a5, 0x14d5c <__get_locale+0x108>
   14e60: b7 c4 01 00  	lui	s1, 28
   14e64: 93 84 04 c8  	addi	s1, s1, -896
   14e68: 6f f0 9f ef  	j	0x14d60 <__get_locale+0x10c>
   14e6c: 93 85 04 01  	addi	a1, s1, 16
   14e70: 13 05 04 00  	mv	a0, s0
   14e74: ef f0 cf ba  	jal	0x14220 <strcmp>
   14e78: e3 04 05 ee  	beqz	a0, 0x14d60 <__get_locale+0x10c>
   14e7c: 83 b4 84 02  	ld	s1, 40(s1)
   14e80: 6f f0 5f f5  	j	0x14dd4 <__get_locale+0x180>
   14e84: 93 85 04 01  	addi	a1, s1, 16
   14e88: 13 05 04 00  	mv	a0, s0
   14e8c: ef f0 4f b9  	jal	0x14220 <strcmp>
   14e90: 63 18 05 00  	bnez	a0, 0x14ea0 <__get_locale+0x24c>
   14e94: 13 85 81 a4  	addi	a0, gp, -1464
   14e98: ef f0 0f d7  	jal	0x14408 <__unlock>
   14e9c: 6f f0 5f ec  	j	0x14d60 <__get_locale+0x10c>
   14ea0: 83 b4 84 02  	ld	s1, 40(s1)
   14ea4: 6f f0 1f f4  	j	0x14de4 <__get_locale+0x190>
   14ea8: 13 06 0b 00  	mv	a2, s6
   14eac: 93 85 04 00  	mv	a1, s1
   14eb0: 13 05 01 01  	addi	a0, sp, 16
   14eb4: ef e0 df d8  	jal	0x13c40 <memcpy>
   14eb8: 93 07 01 11  	addi	a5, sp, 272
   14ebc: b3 87 67 01  	add	a5, a5, s6
   14ec0: 23 80 87 f1  	sb	s8, -256(a5)
   14ec4: 13 05 1b 00  	addi	a0, s6, 1
   14ec8: 93 07 01 01  	addi	a5, sp, 16
   14ecc: 13 06 09 00  	mv	a2, s2
   14ed0: 93 05 04 00  	mv	a1, s0
   14ed4: 33 85 a7 00  	add	a0, a5, a0
   14ed8: ef e0 9f d6  	jal	0x13c40 <memcpy>
   14edc: 33 8b 6c 01  	add	s6, s9, s6
   14ee0: a3 00 0b f0  	sb	zero, -255(s6)
   14ee4: 93 05 81 00  	addi	a1, sp, 8
   14ee8: 13 05 01 01  	addi	a0, sp, 16
   14eec: ef 20 00 5e  	jal	0x174cc <__map_file>
   14ef0: 13 0b 05 00  	mv	s6, a0
   14ef4: e3 08 05 f4  	beqz	a0, 0x14e44 <__get_locale+0x1f0>
   14ef8: 13 05 00 03  	li	a0, 48
   14efc: ef d0 4f c3  	jal	0x12330 <malloc>
   14f00: 83 35 81 00  	ld	a1, 8(sp)
   14f04: 93 04 05 00  	mv	s1, a0
   14f08: 63 1c 05 02  	bnez	a0, 0x14f40 <__get_locale+0x2ec>
   14f0c: 13 05 0b 00  	mv	a0, s6
   14f10: ef e0 8f 96  	jal	0x13078 <munmap>
   14f14: 13 05 00 03  	li	a0, 48
   14f18: ef d0 8f c1  	jal	0x12330 <malloc>
   14f1c: 93 04 05 00  	mv	s1, a0
   14f20: 63 08 05 04  	beqz	a0, 0x14f70 <__get_locale+0x31c>
   14f24: b7 c7 01 00  	lui	a5, 28
   14f28: 93 87 07 c8  	addi	a5, a5, -896
   14f2c: 03 b7 07 00  	ld	a4, 0(a5)
   14f30: 83 b7 87 00  	ld	a5, 8(a5)
   14f34: 23 30 e5 00  	sd	a4, 0(a0)
   14f38: 23 34 f5 00  	sd	a5, 8(a0)
   14f3c: 6f 00 c0 00  	j	0x14f48 <__get_locale+0x2f4>
   14f40: 23 30 65 01  	sd	s6, 0(a0)
   14f44: 23 34 b5 00  	sd	a1, 8(a0)
   14f48: 13 06 09 00  	mv	a2, s2
   14f4c: 93 05 04 00  	mv	a1, s0
   14f50: 13 85 04 01  	addi	a0, s1, 16
   14f54: 33 89 24 01  	add	s2, s1, s2
   14f58: ef e0 9f ce  	jal	0x13c40 <memcpy>
   14f5c: 23 08 09 00  	sb	zero, 16(s2)
   14f60: 83 37 0a 00  	ld	a5, 0(s4)
   14f64: 23 b4 f4 02  	sd	a5, 40(s1)
   14f68: 23 30 9a 00  	sd	s1, 0(s4)
   14f6c: 6f f0 9f f2  	j	0x14e94 <__get_locale+0x240>
   14f70: e3 92 0a f2  	bnez	s5, 0x14e94 <__get_locale+0x240>
   14f74: b7 c4 01 00  	lui	s1, 28
   14f78: 93 84 04 c8  	addi	s1, s1, -896
   14f7c: 6f f0 9f f1  	j	0x14e94 <__get_locale+0x240>

0000000000014f80 <__expand_heap>:
   14f80: 93 87 81 bc  	addi	a5, gp, -1080
   14f84: 83 b6 87 03  	ld	a3, 56(a5)
   14f88: 13 07 f0 ff  	li	a4, -1
   14f8c: 83 35 05 00  	ld	a1, 0(a0)
   14f90: 13 01 01 fd  	addi	sp, sp, -48
   14f94: 13 57 17 00  	srli	a4, a4, 1
   14f98: 23 34 11 02  	sd	ra, 40(sp)
   14f9c: 23 30 81 02  	sd	s0, 32(sp)
   14fa0: 23 3c 91 00  	sd	s1, 24(sp)
   14fa4: 23 38 21 01  	sd	s2, 16(sp)
   14fa8: 33 07 d7 40  	sub	a4, a4, a3
   14fac: 63 7c b7 00  	bgeu	a4, a1, 0x14fc4 <__expand_heap+0x44>
   14fb0: ef c0 0f e7  	jal	0x11620 <__errno_location>
   14fb4: 93 07 c0 00  	li	a5, 12
   14fb8: 23 20 f5 00  	sw	a5, 0(a0)
   14fbc: 13 05 00 00  	li	a0, 0
   14fc0: 6f 00 40 0c  	j	0x15084 <__expand_heap+0x104>
   14fc4: b3 07 b0 40  	neg	a5, a1
   14fc8: 93 86 f6 ff  	addi	a3, a3, -1
   14fcc: b3 f6 d7 00  	and	a3, a5, a3
   14fd0: b3 87 b6 00  	add	a5, a3, a1
   14fd4: 83 b6 01 a5  	ld	a3, -1456(gp)
   14fd8: 13 09 05 00  	mv	s2, a0
   14fdc: 13 86 81 bc  	addi	a2, gp, -1080
   14fe0: 13 87 01 a5  	addi	a4, gp, -1456
   14fe4: 63 94 06 02  	bnez	a3, 0x1500c <__expand_heap+0x8c>
   14fe8: 93 08 60 0d  	li	a7, 214
   14fec: 13 05 00 00  	li	a0, 0
   14ff0: 73 00 00 00  	ecall	
   14ff4: 83 36 86 03  	ld	a3, 56(a2)
   14ff8: b3 05 a0 40  	neg	a1, a0
   14ffc: 93 86 f6 ff  	addi	a3, a3, -1
   15000: b3 f6 b6 00  	and	a3, a3, a1
   15004: b3 86 a6 00  	add	a3, a3, a0
   15008: 23 30 d7 00  	sd	a3, 0(a4)
   1500c: 83 36 07 00  	ld	a3, 0(a4)
   15010: 93 c5 f6 ff  	not	a1, a3
   15014: 63 f4 b7 08  	bgeu	a5, a1, 0x1509c <__expand_heap+0x11c>
   15018: 03 38 06 01  	ld	a6, 16(a2)
   1501c: b7 08 80 00  	lui	a7, 2048
   15020: 33 85 f6 00  	add	a0, a3, a5
   15024: 93 05 08 00  	mv	a1, a6
   15028: 63 74 18 01  	bgeu	a6, a7, 0x15030 <__expand_heap+0xb0>
   1502c: b7 05 80 00  	lui	a1, 2048
   15030: b7 08 80 ff  	lui	a7, 1046528
   15034: b3 85 15 01  	add	a1, a1, a7
   15038: 63 f4 a5 00  	bgeu	a1, a0, 0x15040 <__expand_heap+0xc0>
   1503c: 63 e0 06 07  	bltu	a3, a6, 0x1509c <__expand_heap+0x11c>
   15040: 13 08 81 00  	addi	a6, sp, 8
   15044: b7 08 80 00  	lui	a7, 2048
   15048: 93 05 08 00  	mv	a1, a6
   1504c: 63 74 18 01  	bgeu	a6, a7, 0x15054 <__expand_heap+0xd4>
   15050: b7 05 80 00  	lui	a1, 2048
   15054: b7 08 80 ff  	lui	a7, 1046528
   15058: b3 85 15 01  	add	a1, a1, a7
   1505c: 63 f4 a5 00  	bgeu	a1, a0, 0x15064 <__expand_heap+0xe4>
   15060: 63 ee 06 03  	bltu	a3, a6, 0x1509c <__expand_heap+0x11c>
   15064: 93 08 60 0d  	li	a7, 214
   15068: 73 00 00 00  	ecall	
   1506c: 93 06 05 00  	mv	a3, a0
   15070: 03 35 07 00  	ld	a0, 0(a4)
   15074: b3 05 f5 00  	add	a1, a0, a5
   15078: 63 92 b6 02  	bne	a3, a1, 0x1509c <__expand_heap+0x11c>
   1507c: 23 30 f9 00  	sd	a5, 0(s2)
   15080: 23 30 d7 00  	sd	a3, 0(a4)
   15084: 83 30 81 02  	ld	ra, 40(sp)
   15088: 03 34 01 02  	ld	s0, 32(sp)
   1508c: 83 34 81 01  	ld	s1, 24(sp)
   15090: 03 39 01 01  	ld	s2, 16(sp)
   15094: 13 01 01 03  	addi	sp, sp, 48
   15098: 67 80 00 00  	ret
   1509c: 83 a5 81 a5  	lw	a1, -1448(gp)
   150a0: 03 34 86 03  	ld	s0, 56(a2)
   150a4: 93 84 81 a5  	addi	s1, gp, -1448
   150a8: 9b d5 15 00  	srliw	a1, a1, 1
   150ac: 33 14 b4 00  	sll	s0, s0, a1
   150b0: 63 74 f4 00  	bgeu	s0, a5, 0x150b8 <__expand_heap+0x138>
   150b4: 13 84 07 00  	mv	s0, a5
   150b8: 93 07 00 00  	li	a5, 0
   150bc: 13 07 f0 ff  	li	a4, -1
   150c0: 93 06 20 02  	li	a3, 34
   150c4: 13 06 30 00  	li	a2, 3
   150c8: 93 05 04 00  	mv	a1, s0
   150cc: 13 05 00 00  	li	a0, 0
   150d0: ef d0 df e4  	jal	0x12f1c <mmap64>
   150d4: 93 07 f0 ff  	li	a5, -1
   150d8: e3 02 f5 ee  	beq	a0, a5, 0x14fbc <__expand_heap+0x3c>
   150dc: 83 a7 04 00  	lw	a5, 0(s1)
   150e0: 23 30 89 00  	sd	s0, 0(s2)
   150e4: 9b 87 17 00  	addiw	a5, a5, 1
   150e8: 23 a0 f4 00  	sw	a5, 0(s1)
   150ec: 6f f0 9f f9  	j	0x15084 <__expand_heap+0x104>

00000000000150f0 <a_fetch_or.isra.0>:
   150f0: 83 27 05 00  	lw	a5, 0(a0)
   150f4: 9b 87 07 00  	sext.w	a5, a5
   150f8: b3 e6 b7 00  	or	a3, a5, a1
   150fc: 2f 27 05 16  	<unknown>
   15100: 63 16 f7 00  	bne	a4, a5, 0x1510c <a_fetch_or.isra.0+0x1c>
   15104: 2f 26 d5 1e  	<unknown>
   15108: e3 1a 06 fe  	bnez	a2, 0x150fc <a_fetch_or.isra.0+0xc>
   1510c: 1b 07 07 00  	sext.w	a4, a4
   15110: e3 90 e7 fe  	bne	a5, a4, 0x150f0 <a_fetch_or.isra.0>
   15114: 67 80 00 00  	ret

0000000000015118 <__get_handler_set>:
   15118: 13 06 80 00  	li	a2, 8
   1511c: 93 85 81 a6  	addi	a1, gp, -1432
   15120: 6f e0 1f b2  	j	0x13c40 <memcpy>

0000000000015124 <__libc_sigaction>:
   15124: 13 01 01 f8  	addi	sp, sp, -128
   15128: 23 38 81 06  	sd	s0, 112(sp)
   1512c: 23 30 21 07  	sd	s2, 96(sp)
   15130: 23 3c 31 05  	sd	s3, 88(sp)
   15134: 23 3c 11 06  	sd	ra, 120(sp)
   15138: 23 34 91 06  	sd	s1, 104(sp)
   1513c: 23 38 41 05  	sd	s4, 80(sp)
   15140: 93 09 05 00  	mv	s3, a0
   15144: 13 84 05 00  	mv	s0, a1
   15148: 13 09 06 00  	mv	s2, a2
   1514c: 63 8a 05 10  	beqz	a1, 0x15260 <__libc_sigaction+0x13c>
   15150: 83 b7 05 00  	ld	a5, 0(a1)
   15154: 93 04 10 00  	li	s1, 1
   15158: 63 f2 f4 0a  	bgeu	s1, a5, 0x151fc <__libc_sigaction+0xd8>
   1515c: 1b 05 f5 ff  	addiw	a0, a0, -1
   15160: 93 05 05 00  	mv	a1, a0
   15164: 13 55 65 00  	srli	a0, a0, 6
   15168: b3 94 b4 00  	sll	s1, s1, a1
   1516c: 13 15 35 00  	slli	a0, a0, 3
   15170: 13 8a 81 a6  	addi	s4, gp, -1432
   15174: 9b 85 04 00  	sext.w	a1, s1
   15178: 33 0a aa 00  	add	s4, s4, a0
   1517c: 63 86 05 00  	beqz	a1, 0x15188 <__libc_sigaction+0x64>
   15180: 13 05 0a 00  	mv	a0, s4
   15184: ef f0 df f6  	jal	0x150f0 <a_fetch_or.isra.0>
   15188: 93 d5 04 42  	srai	a1, s1, 32
   1518c: 63 86 05 00  	beqz	a1, 0x15198 <__libc_sigaction+0x74>
   15190: 13 05 4a 00  	addi	a0, s4, 4
   15194: ef f0 df f5  	jal	0x150f0 <a_fetch_or.isra.0>
   15198: 13 87 01 a7  	addi	a4, gp, -1424
   1519c: 83 a7 c1 bc  	lw	a5, -1076(gp)
   151a0: 83 26 07 00  	lw	a3, 0(a4)
   151a4: b3 e7 d7 00  	or	a5, a5, a3
   151a8: 9b 87 07 00  	sext.w	a5, a5
   151ac: 63 98 07 02  	bnez	a5, 0x151dc <__libc_sigaction+0xb8>
   151b0: 93 07 30 00  	li	a5, 3
   151b4: 93 97 07 02  	slli	a5, a5, 32
   151b8: 23 38 f1 02  	sd	a5, 48(sp)
   151bc: 93 08 70 08  	li	a7, 135
   151c0: 13 05 10 00  	li	a0, 1
   151c4: 93 05 01 03  	addi	a1, sp, 48
   151c8: 13 06 00 00  	li	a2, 0
   151cc: 93 06 80 00  	li	a3, 8
   151d0: 73 00 00 00  	ecall	
   151d4: 93 07 10 00  	li	a5, 1
   151d8: 23 20 f7 00  	sw	a5, 0(a4)
   151dc: 83 27 84 08  	lw	a5, 136(s0)
   151e0: 37 07 00 10  	lui	a4, 65536
   151e4: b3 f7 e7 00  	and	a5, a5, a4
   151e8: 63 9a 07 00  	bnez	a5, 0x151fc <__libc_sigaction+0xd8>
   151ec: 0f 00 30 03  	fence	rw, rw
   151f0: 13 07 10 00  	li	a4, 1
   151f4: 23 ae e1 a4  	sw	a4, -1444(gp)
   151f8: 0f 00 30 03  	fence	rw, rw
   151fc: 83 37 04 00  	ld	a5, 0(s0)
   15200: 63 8e 07 00  	beqz	a5, 0x1521c <__libc_sigaction+0xf8>
   15204: 93 07 60 00  	li	a5, 6
   15208: 63 9a f9 00  	bne	s3, a5, 0x1521c <__libc_sigaction+0xf8>
   1520c: 13 05 81 00  	addi	a0, sp, 8
   15210: ef e0 cf 8f  	jal	0x1330c <__block_all_sigs>
   15214: 13 85 01 a6  	addi	a0, gp, -1440
   15218: ef f0 8f 8f  	jal	0x14310 <__lock>
   1521c: 83 37 04 00  	ld	a5, 0(s0)
   15220: 37 07 00 04  	lui	a4, 16384
   15224: 23 38 f1 00  	sd	a5, 16(sp)
   15228: 83 27 84 08  	lw	a5, 136(s0)
   1522c: 33 e7 e7 00  	or	a4, a5, a4
   15230: 23 3c e1 00  	sd	a4, 24(sp)
   15234: 93 f7 47 00  	andi	a5, a5, 4
   15238: 63 92 07 0c  	bnez	a5, 0x152fc <__libc_sigaction+0x1d8>
   1523c: b7 87 01 00  	lui	a5, 24
   15240: 93 87 87 9f  	addi	a5, a5, -1544
   15244: 93 05 84 00  	addi	a1, s0, 8
   15248: 13 06 80 00  	li	a2, 8
   1524c: 13 05 81 02  	addi	a0, sp, 40
   15250: 23 30 f1 02  	sd	a5, 32(sp)
   15254: ef e0 df 9e  	jal	0x13c40 <memcpy>
   15258: 93 05 01 01  	addi	a1, sp, 16
   1525c: 63 14 04 00  	bnez	s0, 0x15264 <__libc_sigaction+0x140>
   15260: 93 05 00 00  	li	a1, 0
   15264: 13 06 00 00  	li	a2, 0
   15268: 63 04 09 00  	beqz	s2, 0x15270 <__libc_sigaction+0x14c>
   1526c: 13 06 01 03  	addi	a2, sp, 48
   15270: 93 08 60 08  	li	a7, 134
   15274: 13 85 09 00  	mv	a0, s3
   15278: 93 06 80 00  	li	a3, 8
   1527c: 73 00 00 00  	ecall	
   15280: 93 07 60 00  	li	a5, 6
   15284: 9b 04 05 00  	sext.w	s1, a0
   15288: 63 90 f9 02  	bne	s3, a5, 0x152a8 <__libc_sigaction+0x184>
   1528c: 63 0e 04 00  	beqz	s0, 0x152a8 <__libc_sigaction+0x184>
   15290: 83 37 04 00  	ld	a5, 0(s0)
   15294: 63 8a 07 00  	beqz	a5, 0x152a8 <__libc_sigaction+0x184>
   15298: 13 85 01 a6  	addi	a0, gp, -1440
   1529c: ef f0 cf 96  	jal	0x14408 <__unlock>
   152a0: 13 05 81 00  	addi	a0, sp, 8
   152a4: ef e0 0f 8a  	jal	0x13344 <__restore_sigs>
   152a8: 63 04 09 02  	beqz	s2, 0x152d0 <__libc_sigaction+0x1ac>
   152ac: 63 92 04 02  	bnez	s1, 0x152d0 <__libc_sigaction+0x1ac>
   152b0: 83 37 01 03  	ld	a5, 48(sp)
   152b4: 13 06 80 00  	li	a2, 8
   152b8: 93 05 81 04  	addi	a1, sp, 72
   152bc: 23 30 f9 00  	sd	a5, 0(s2)
   152c0: 83 37 81 03  	ld	a5, 56(sp)
   152c4: 13 05 89 00  	addi	a0, s2, 8
   152c8: 23 24 f9 08  	sw	a5, 136(s2)
   152cc: ef e0 5f 97  	jal	0x13c40 <memcpy>
   152d0: 13 85 04 00  	mv	a0, s1
   152d4: ef c0 8f cb  	jal	0x1178c <__syscall_ret>
   152d8: 83 30 81 07  	ld	ra, 120(sp)
   152dc: 03 34 01 07  	ld	s0, 112(sp)
   152e0: 83 34 81 06  	ld	s1, 104(sp)
   152e4: 03 39 01 06  	ld	s2, 96(sp)
   152e8: 83 39 81 05  	ld	s3, 88(sp)
   152ec: 03 3a 01 05  	ld	s4, 80(sp)
   152f0: 1b 05 05 00  	sext.w	a0, a0
   152f4: 13 01 01 08  	addi	sp, sp, 128
   152f8: 67 80 00 00  	ret
   152fc: b7 87 01 00  	lui	a5, 24
   15300: 93 87 87 9f  	addi	a5, a5, -1544
   15304: 6f f0 1f f4  	j	0x15244 <__libc_sigaction+0x120>

0000000000015308 <sigaction>:
   15308: 9b 06 05 fe  	addiw	a3, a0, -32
   1530c: 13 07 20 00  	li	a4, 2
   15310: 63 7a d7 00  	bgeu	a4, a3, 0x15324 <sigaction+0x1c>
   15314: 9b 07 f5 ff  	addiw	a5, a0, -1
   15318: 13 07 f0 03  	li	a4, 63
   1531c: 63 64 f7 00  	bltu	a4, a5, 0x15324 <sigaction+0x1c>
   15320: 6f f0 5f e0  	j	0x15124 <__libc_sigaction>
   15324: 13 01 01 ff  	addi	sp, sp, -16
   15328: 23 34 11 00  	sd	ra, 8(sp)
   1532c: ef c0 4f af  	jal	0x11620 <__errno_location>
   15330: 83 30 81 00  	ld	ra, 8(sp)
   15334: 93 07 60 01  	li	a5, 22
   15338: 23 20 f5 00  	sw	a5, 0(a0)
   1533c: 13 05 f0 ff  	li	a0, -1
   15340: 13 01 01 01  	addi	sp, sp, 16
   15344: 67 80 00 00  	ret

0000000000015348 <__overflow>:
   15348: 83 37 05 02  	ld	a5, 32(a0)
   1534c: 13 01 01 fe  	addi	sp, sp, -32
   15350: 23 38 81 00  	sd	s0, 16(sp)
   15354: 23 3c 11 00  	sd	ra, 24(sp)
   15358: a3 07 b1 00  	sb	a1, 15(sp)
   1535c: 13 04 05 00  	mv	s0, a0
   15360: 63 8a 07 02  	beqz	a5, 0x15394 <__overflow+0x4c>
   15364: 83 37 84 02  	ld	a5, 40(s0)
   15368: 03 37 04 02  	ld	a4, 32(s0)
   1536c: 63 92 e7 04  	bne	a5, a4, 0x153b0 <__overflow+0x68>
   15370: 83 37 84 04  	ld	a5, 72(s0)
   15374: 13 06 10 00  	li	a2, 1
   15378: 93 05 f1 00  	addi	a1, sp, 15
   1537c: 13 05 04 00  	mv	a0, s0
   15380: e7 80 07 00  	jalr	a5
   15384: 93 07 10 00  	li	a5, 1
   15388: 63 1a f5 00  	bne	a0, a5, 0x1539c <__overflow+0x54>
   1538c: 03 45 f1 00  	lbu	a0, 15(sp)
   15390: 6f 00 00 01  	j	0x153a0 <__overflow+0x58>
   15394: ef 00 40 18  	jal	0x15518 <__towrite>
   15398: e3 06 05 fc  	beqz	a0, 0x15364 <__overflow+0x1c>
   1539c: 13 05 f0 ff  	li	a0, -1
   153a0: 83 30 81 01  	ld	ra, 24(sp)
   153a4: 03 34 01 01  	ld	s0, 16(sp)
   153a8: 13 01 01 02  	addi	sp, sp, 32
   153ac: 67 80 00 00  	ret
   153b0: 03 47 f1 00  	lbu	a4, 15(sp)
   153b4: 83 26 04 09  	lw	a3, 144(s0)
   153b8: 1b 05 07 00  	sext.w	a0, a4
   153bc: e3 8a e6 fa  	beq	a3, a4, 0x15370 <__overflow+0x28>
   153c0: 93 86 17 00  	addi	a3, a5, 1
   153c4: 23 34 d4 02  	sd	a3, 40(s0)
   153c8: 23 80 e7 00  	sb	a4, 0(a5)
   153cc: 6f f0 5f fd  	j	0x153a0 <__overflow+0x58>

00000000000153d0 <dummy>:
   153d0: 67 80 00 00  	ret

00000000000153d4 <__stdio_close>:
   153d4: 03 25 85 07  	lw	a0, 120(a0)
   153d8: 13 01 01 ff  	addi	sp, sp, -16
   153dc: 23 34 11 00  	sd	ra, 8(sp)
   153e0: ef f0 1f ff  	jal	0x153d0 <dummy>
   153e4: 93 08 90 03  	li	a7, 57
   153e8: 73 00 00 00  	ecall	
   153ec: ef c0 0f ba  	jal	0x1178c <__syscall_ret>
   153f0: 83 30 81 00  	ld	ra, 8(sp)
   153f4: 1b 05 05 00  	sext.w	a0, a0
   153f8: 13 01 01 01  	addi	sp, sp, 16
   153fc: 67 80 00 00  	ret

0000000000015400 <__stdio_seek>:
   15400: 03 25 85 07  	lw	a0, 120(a0)
   15404: 6f 20 80 17  	j	0x1757c <lseek64>

0000000000015408 <__stdio_write>:
   15408: 13 01 01 fb  	addi	sp, sp, -80
   1540c: 83 37 85 03  	ld	a5, 56(a0)
   15410: 23 34 31 03  	sd	s3, 40(sp)
   15414: 83 39 85 02  	ld	s3, 40(a0)
   15418: 23 30 81 04  	sd	s0, 64(sp)
   1541c: 23 3c 91 02  	sd	s1, 56(sp)
   15420: b3 89 f9 40  	sub	s3, s3, a5
   15424: 23 38 21 03  	sd	s2, 48(sp)
   15428: 23 30 41 03  	sd	s4, 32(sp)
   1542c: 23 34 31 01  	sd	s3, 8(sp)
   15430: 23 34 11 04  	sd	ra, 72(sp)
   15434: 13 04 05 00  	mv	s0, a0
   15438: 13 09 06 00  	mv	s2, a2
   1543c: 23 30 f1 00  	sd	a5, 0(sp)
   15440: 23 38 b1 00  	sd	a1, 16(sp)
   15444: 23 3c c1 00  	sd	a2, 24(sp)
   15448: b3 89 c9 00  	add	s3, s3, a2
   1544c: 13 0a 20 00  	li	s4, 2
   15450: 93 04 01 00  	mv	s1, sp
   15454: 03 25 84 07  	lw	a0, 120(s0)
   15458: 93 08 20 04  	li	a7, 66
   1545c: 93 85 04 00  	mv	a1, s1
   15460: 13 06 0a 00  	mv	a2, s4
   15464: 73 00 00 00  	ecall	
   15468: ef c0 4f b2  	jal	0x1178c <__syscall_ret>
   1546c: 63 90 a9 04  	bne	s3, a0, 0x154ac <__stdio_write+0xa4>
   15470: 83 37 84 05  	ld	a5, 88(s0)
   15474: 03 37 04 06  	ld	a4, 96(s0)
   15478: 23 3c f4 02  	sd	a5, 56(s0)
   1547c: 33 87 e7 00  	add	a4, a5, a4
   15480: 23 30 e4 02  	sd	a4, 32(s0)
   15484: 23 34 f4 02  	sd	a5, 40(s0)
   15488: 83 30 81 04  	ld	ra, 72(sp)
   1548c: 03 34 01 04  	ld	s0, 64(sp)
   15490: 83 34 81 03  	ld	s1, 56(sp)
   15494: 83 39 81 02  	ld	s3, 40(sp)
   15498: 03 3a 01 02  	ld	s4, 32(sp)
   1549c: 13 05 09 00  	mv	a0, s2
   154a0: 03 39 01 03  	ld	s2, 48(sp)
   154a4: 13 01 01 05  	addi	sp, sp, 80
   154a8: 67 80 00 00  	ret
   154ac: 63 58 05 02  	bgez	a0, 0x154dc <__stdio_write+0xd4>
   154b0: 83 27 04 00  	lw	a5, 0(s0)
   154b4: 23 30 04 02  	sd	zero, 32(s0)
   154b8: 23 3c 04 02  	sd	zero, 56(s0)
   154bc: 93 e7 07 02  	ori	a5, a5, 32
   154c0: 23 20 f4 00  	sw	a5, 0(s0)
   154c4: 23 34 04 02  	sd	zero, 40(s0)
   154c8: 93 07 20 00  	li	a5, 2
   154cc: 63 02 fa 04  	beq	s4, a5, 0x15510 <__stdio_write+0x108>
   154d0: 83 b7 84 00  	ld	a5, 8(s1)
   154d4: 33 09 f9 40  	sub	s2, s2, a5
   154d8: 6f f0 1f fb  	j	0x15488 <__stdio_write+0x80>
   154dc: 83 b7 84 00  	ld	a5, 8(s1)
   154e0: b3 89 a9 40  	sub	s3, s3, a0
   154e4: 63 f8 a7 00  	bgeu	a5, a0, 0x154f4 <__stdio_write+0xec>
   154e8: 33 05 f5 40  	sub	a0, a0, a5
   154ec: 93 84 04 01  	addi	s1, s1, 16
   154f0: 1b 0a fa ff  	addiw	s4, s4, -1
   154f4: 83 b7 04 00  	ld	a5, 0(s1)
   154f8: b3 87 a7 00  	add	a5, a5, a0
   154fc: 23 b0 f4 00  	sd	a5, 0(s1)
   15500: 83 b7 84 00  	ld	a5, 8(s1)
   15504: 33 85 a7 40  	sub	a0, a5, a0
   15508: 23 b4 a4 00  	sd	a0, 8(s1)
   1550c: 6f f0 9f f4  	j	0x15454 <__stdio_write+0x4c>
   15510: 13 09 00 00  	li	s2, 0
   15514: 6f f0 5f f7  	j	0x15488 <__stdio_write+0x80>

0000000000015518 <__towrite>:
   15518: 83 27 85 08  	lw	a5, 136(a0)
   1551c: 1b 87 f7 ff  	addiw	a4, a5, -1
   15520: b3 e7 e7 00  	or	a5, a5, a4
   15524: 23 24 f5 08  	sw	a5, 136(a0)
   15528: 83 27 05 00  	lw	a5, 0(a0)
   1552c: 13 f7 87 00  	andi	a4, a5, 8
   15530: 63 0a 07 00  	beqz	a4, 0x15544 <__towrite+0x2c>
   15534: 93 e7 07 02  	ori	a5, a5, 32
   15538: 23 20 f5 00  	sw	a5, 0(a0)
   1553c: 13 05 f0 ff  	li	a0, -1
   15540: 67 80 00 00  	ret
   15544: 83 37 85 05  	ld	a5, 88(a0)
   15548: 03 37 05 06  	ld	a4, 96(a0)
   1554c: 23 38 05 00  	sd	zero, 16(a0)
   15550: 23 3c f5 02  	sd	a5, 56(a0)
   15554: 23 34 f5 02  	sd	a5, 40(a0)
   15558: b3 87 e7 00  	add	a5, a5, a4
   1555c: 23 34 05 00  	sd	zero, 8(a0)
   15560: 23 30 f5 02  	sd	a5, 32(a0)
   15564: 13 05 00 00  	li	a0, 0
   15568: 67 80 00 00  	ret

000000000001556c <__towrite_needs_stdio_exit>:
   1556c: 6f 20 80 51  	j	0x17a84 <__stdio_exit_needed>

0000000000015570 <pop_arg>:
   15570: 9b 85 75 ff  	addiw	a1, a1, -9
   15574: 1b 87 05 00  	sext.w	a4, a1
   15578: 93 07 10 01  	li	a5, 17
   1557c: 63 ea e7 0e  	bltu	a5, a4, 0x15670 <pop_arg+0x100>
   15580: 93 95 05 02  	slli	a1, a1, 32
   15584: b7 c7 01 00  	lui	a5, 28
   15588: 93 87 c7 87  	addi	a5, a5, -1924
   1558c: 93 d5 e5 01  	srli	a1, a1, 30
   15590: b3 85 f5 00  	add	a1, a1, a5
   15594: 03 a7 05 00  	lw	a4, 0(a1)
   15598: 13 01 01 ff  	addi	sp, sp, -16
   1559c: 23 30 81 00  	sd	s0, 0(sp)
   155a0: 83 37 06 00  	ld	a5, 0(a2)
   155a4: 23 34 11 00  	sd	ra, 8(sp)
   155a8: 13 04 05 00  	mv	s0, a0
   155ac: 67 00 07 00  	jr	a4
   155b0: 13 87 87 00  	addi	a4, a5, 8
   155b4: 83 a7 07 00  	lw	a5, 0(a5)
   155b8: 23 30 e6 00  	sd	a4, 0(a2)
   155bc: 23 30 f4 00  	sd	a5, 0(s0)
   155c0: 83 30 81 00  	ld	ra, 8(sp)
   155c4: 03 34 01 00  	ld	s0, 0(sp)
   155c8: 13 01 01 01  	addi	sp, sp, 16
   155cc: 67 80 00 00  	ret
   155d0: 13 87 87 00  	addi	a4, a5, 8
   155d4: 23 30 e6 00  	sd	a4, 0(a2)
   155d8: 83 e7 07 00  	lwu	a5, 0(a5)
   155dc: 6f f0 1f fe  	j	0x155bc <pop_arg+0x4c>
   155e0: 13 87 87 00  	addi	a4, a5, 8
   155e4: 23 30 e6 00  	sd	a4, 0(a2)
   155e8: 83 97 07 00  	lh	a5, 0(a5)
   155ec: 6f f0 1f fd  	j	0x155bc <pop_arg+0x4c>
   155f0: 13 87 87 00  	addi	a4, a5, 8
   155f4: 23 30 e6 00  	sd	a4, 0(a2)
   155f8: 83 d7 07 00  	lhu	a5, 0(a5)
   155fc: 6f f0 1f fc  	j	0x155bc <pop_arg+0x4c>
   15600: 13 87 87 00  	addi	a4, a5, 8
   15604: 23 30 e6 00  	sd	a4, 0(a2)
   15608: 83 87 07 00  	lb	a5, 0(a5)
   1560c: 6f f0 1f fb  	j	0x155bc <pop_arg+0x4c>
   15610: 13 87 87 00  	addi	a4, a5, 8
   15614: 23 30 e6 00  	sd	a4, 0(a2)
   15618: 83 c7 07 00  	lbu	a5, 0(a5)
   1561c: 6f f0 1f fa  	j	0x155bc <pop_arg+0x4c>
   15620: 13 87 87 00  	addi	a4, a5, 8
   15624: 23 30 e6 00  	sd	a4, 0(a2)
   15628: 83 b7 07 00  	ld	a5, 0(a5)
   1562c: 6f f0 1f f9  	j	0x155bc <pop_arg+0x4c>
   15630: 03 b5 07 00  	ld	a0, 0(a5)
   15634: 13 87 87 00  	addi	a4, a5, 8
   15638: 23 30 e6 00  	sd	a4, 0(a2)
   1563c: ef 40 d0 4b  	jal	0x1a2f8 <__extenddftf2>
   15640: 23 30 a4 00  	sd	a0, 0(s0)
   15644: 23 34 b4 00  	sd	a1, 8(s0)
   15648: 6f f0 9f f7  	j	0x155c0 <pop_arg+0x50>
   1564c: 93 87 f7 00  	addi	a5, a5, 15
   15650: 93 f7 07 ff  	andi	a5, a5, -16
   15654: 13 87 07 01  	addi	a4, a5, 16
   15658: 23 30 e6 00  	sd	a4, 0(a2)
   1565c: 03 b7 07 00  	ld	a4, 0(a5)
   15660: 83 b7 87 00  	ld	a5, 8(a5)
   15664: 23 30 e5 00  	sd	a4, 0(a0)
   15668: 23 34 f5 00  	sd	a5, 8(a0)
   1566c: 6f f0 5f f5  	j	0x155c0 <pop_arg+0x50>
   15670: 67 80 00 00  	ret

0000000000015674 <fmt_u>:
   15674: 93 07 05 00  	mv	a5, a0
   15678: 93 06 a0 00  	li	a3, 10
   1567c: 13 85 05 00  	mv	a0, a1
   15680: 63 94 07 00  	bnez	a5, 0x15688 <fmt_u+0x14>
   15684: 67 80 00 00  	ret
   15688: 33 f7 d7 02  	<unknown>
   1568c: 13 05 f5 ff  	addi	a0, a0, -1
   15690: 1b 07 07 03  	addiw	a4, a4, 48
   15694: b3 d7 d7 02  	<unknown>
   15698: 23 00 e5 00  	sb	a4, 0(a0)
   1569c: 6f f0 5f fe  	j	0x15680 <fmt_u+0xc>

00000000000156a0 <getint>:
   156a0: 37 d6 cc 0c  	lui	a2, 52429
   156a4: b7 05 00 80  	lui	a1, 524288
   156a8: 93 06 05 00  	mv	a3, a0
   156ac: 13 03 90 00  	li	t1, 9
   156b0: 13 05 00 00  	li	a0, 0
   156b4: 13 06 c6 cc  	addi	a2, a2, -820
   156b8: 13 0e 60 ff  	li	t3, -10
   156bc: 93 c5 f5 ff  	not	a1, a1
   156c0: 93 0e a0 00  	li	t4, 10
   156c4: 03 b7 06 00  	ld	a4, 0(a3)
   156c8: 83 47 07 00  	lbu	a5, 0(a4)
   156cc: 9b 88 07 fd  	addiw	a7, a5, -48
   156d0: 93 87 08 00  	mv	a5, a7
   156d4: 63 74 13 01  	bgeu	t1, a7, 0x156dc <getint+0x3c>
   156d8: 67 80 00 00  	ret
   156dc: 63 62 a6 02  	bltu	a2, a0, 0x15700 <getint+0x60>
   156e0: 3b 08 ae 02  	<unknown>
   156e4: 3b 08 b8 00  	addw	a6, a6, a1
   156e8: 63 4c 18 01  	blt	a6, a7, 0x15700 <getint+0x60>
   156ec: 3b 85 ae 02  	<unknown>
   156f0: 3b 85 a7 00  	addw	a0, a5, a0
   156f4: 13 07 17 00  	addi	a4, a4, 1
   156f8: 23 b0 e6 00  	sd	a4, 0(a3)
   156fc: 6f f0 9f fc  	j	0x156c4 <getint+0x24>
   15700: 13 05 f0 ff  	li	a0, -1
   15704: 6f f0 1f ff  	j	0x156f4 <getint+0x54>

0000000000015708 <out>:
   15708: 93 07 05 00  	mv	a5, a0
   1570c: 03 a7 07 00  	lw	a4, 0(a5)
   15710: 13 85 05 00  	mv	a0, a1
   15714: 93 05 06 00  	mv	a1, a2
   15718: 13 77 07 02  	andi	a4, a4, 32
   1571c: 63 16 07 00  	bnez	a4, 0x15728 <out+0x20>
   15720: 13 86 07 00  	mv	a2, a5
   15724: 6f d0 1f f6  	j	0x13684 <__fwritex>
   15728: 67 80 00 00  	ret

000000000001572c <pad>:
   1572c: b7 27 01 00  	lui	a5, 18
   15730: 33 77 f7 00  	and	a4, a4, a5
   15734: 63 1e 07 08  	bnez	a4, 0x157d0 <pad+0xa4>
   15738: 63 dc c6 08  	bge	a3, a2, 0x157d0 <pad+0xa4>
   1573c: 13 01 01 ed  	addi	sp, sp, -304
   15740: 23 30 81 12  	sd	s0, 288(sp)
   15744: 23 3c 91 10  	sd	s1, 280(sp)
   15748: 23 38 21 11  	sd	s2, 272(sp)
   1574c: bb 04 d6 40  	subw	s1, a2, a3
   15750: 23 34 11 12  	sd	ra, 296(sp)
   15754: 23 34 31 11  	sd	s3, 264(sp)
   15758: 93 07 00 10  	li	a5, 256
   1575c: 13 09 05 00  	mv	s2, a0
   15760: 13 84 04 00  	mv	s0, s1
   15764: 1b 86 04 00  	sext.w	a2, s1
   15768: 63 d4 97 00  	bge	a5, s1, 0x15770 <pad+0x44>
   1576c: 13 06 00 10  	li	a2, 256
   15770: 13 05 01 00  	mv	a0, sp
   15774: ef e0 1f 91  	jal	0x14084 <memset>
   15778: 93 09 f0 0f  	li	s3, 255
   1577c: 63 ce 99 02  	blt	s3, s1, 0x157b8 <pad+0x8c>
   15780: 1b 56 84 00  	srliw	a2, s0, 8
   15784: 93 07 00 f0  	li	a5, -256
   15788: 3b 06 f6 02  	<unknown>
   1578c: 93 05 01 00  	mv	a1, sp
   15790: 13 05 09 00  	mv	a0, s2
   15794: 3b 06 86 00  	addw	a2, a2, s0
   15798: ef f0 1f f7  	jal	0x15708 <out>
   1579c: 83 30 81 12  	ld	ra, 296(sp)
   157a0: 03 34 01 12  	ld	s0, 288(sp)
   157a4: 83 34 81 11  	ld	s1, 280(sp)
   157a8: 03 39 01 11  	ld	s2, 272(sp)
   157ac: 83 39 81 10  	ld	s3, 264(sp)
   157b0: 13 01 01 13  	addi	sp, sp, 304
   157b4: 67 80 00 00  	ret
   157b8: 13 06 00 10  	li	a2, 256
   157bc: 93 05 01 00  	mv	a1, sp
   157c0: 13 05 09 00  	mv	a0, s2
   157c4: ef f0 5f f4  	jal	0x15708 <out>
   157c8: 9b 84 04 f0  	addiw	s1, s1, -256
   157cc: 6f f0 1f fb  	j	0x1577c <pad+0x50>
   157d0: 67 80 00 00  	ret

00000000000157d4 <fmt_fp>:
   157d4: 37 f3 ff ff  	lui	t1, 1048575
   157d8: 13 01 01 81  	addi	sp, sp, -2032
   157dc: 13 03 03 a3  	addi	t1, t1, -1488
   157e0: 23 30 81 7e  	sd	s0, 2016(sp)
   157e4: 23 3c 91 7c  	sd	s1, 2008(sp)
   157e8: 23 34 31 7d  	sd	s3, 1992(sp)
   157ec: 23 30 41 7d  	sd	s4, 1984(sp)
   157f0: 23 38 61 7b  	sd	s6, 1968(sp)
   157f4: 23 30 81 7b  	sd	s8, 1952(sp)
   157f8: 23 3c 91 79  	sd	s9, 1944(sp)
   157fc: 23 34 11 7e  	sd	ra, 2024(sp)
   15800: 23 38 21 7d  	sd	s2, 2000(sp)
   15804: 23 3c 51 7b  	sd	s5, 1976(sp)
   15808: 23 34 71 7b  	sd	s7, 1960(sp)
   1580c: 23 38 a1 79  	sd	s10, 1936(sp)
   15810: 23 34 b1 79  	sd	s11, 1928(sp)
   15814: 13 04 07 00  	mv	s0, a4
   15818: 33 01 61 00  	add	sp, sp, t1
   1581c: 37 27 00 00  	lui	a4, 2
   15820: 93 89 06 00  	mv	s3, a3
   15824: 13 07 07 d1  	addi	a4, a4, -752
   15828: 93 06 01 04  	addi	a3, sp, 64
   1582c: 13 8a 07 00  	mv	s4, a5
   15830: 33 07 d7 00  	add	a4, a4, a3
   15834: b7 e7 ff ff  	lui	a5, 1048574
   15838: b3 07 f7 00  	add	a5, a4, a5
   1583c: 93 04 05 00  	mv	s1, a0
   15840: 93 8c 05 00  	mv	s9, a1
   15844: 13 85 05 00  	mv	a0, a1
   15848: 93 05 06 00  	mv	a1, a2
   1584c: 13 0c 06 00  	mv	s8, a2
   15850: 13 0b 08 00  	mv	s6, a6
   15854: 23 30 f1 00  	sd	a5, 0(sp)
   15858: 23 ae 07 2e  	sw	zero, 764(a5)
   1585c: ef 20 c0 08  	jal	0x178e8 <__signbitl>
   15860: 63 0e 05 10  	beqz	a0, 0x1597c <fmt_fp+0x1a8>
   15864: 93 07 f0 ff  	li	a5, -1
   15868: 93 97 f7 03  	slli	a5, a5, 63
   1586c: 37 c9 01 00  	lui	s2, 28
   15870: 33 4c fc 00  	xor	s8, s8, a5
   15874: 93 0a 10 00  	li	s5, 1
   15878: 13 09 89 8c  	addi	s2, s2, -1848
   1587c: 13 85 0c 00  	mv	a0, s9
   15880: 93 05 0c 00  	mv	a1, s8
   15884: ef 20 00 02  	jal	0x178a4 <__fpclassifyl>
   15888: 93 07 10 00  	li	a5, 1
   1588c: 63 c8 a7 14  	blt	a5, a0, 0x159dc <fmt_fp+0x208>
   15890: 13 7b 0b 02  	andi	s6, s6, 32
   15894: 63 18 0b 12  	bnez	s6, 0x159c4 <fmt_fp+0x1f0>
   15898: b7 cb 01 00  	lui	s7, 28
   1589c: 93 8b 8b 8e  	addi	s7, s7, -1816
   158a0: 13 86 0c 00  	mv	a2, s9
   158a4: 93 06 0c 00  	mv	a3, s8
   158a8: 13 85 0c 00  	mv	a0, s9
   158ac: 93 05 0c 00  	mv	a1, s8
   158b0: ef 30 c0 38  	jal	0x18c3c <__netf2>
   158b4: 63 08 05 00  	beqz	a0, 0x158c4 <fmt_fp+0xf0>
   158b8: 63 1c 0b 10  	bnez	s6, 0x159d0 <fmt_fp+0x1fc>
   158bc: b7 cb 01 00  	lui	s7, 28
   158c0: 93 8b 8b 8f  	addi	s7, s7, -1800
   158c4: 37 07 ff ff  	lui	a4, 1048560
   158c8: 1b 8b 3a 00  	addiw	s6, s5, 3
   158cc: 13 07 f7 ff  	addi	a4, a4, -1
   158d0: 33 77 ea 00  	and	a4, s4, a4
   158d4: 93 06 0b 00  	mv	a3, s6
   158d8: 13 86 09 00  	mv	a2, s3
   158dc: 93 05 00 02  	li	a1, 32
   158e0: 13 85 04 00  	mv	a0, s1
   158e4: ef f0 9f e4  	jal	0x1572c <pad>
   158e8: 13 86 0a 00  	mv	a2, s5
   158ec: 93 05 09 00  	mv	a1, s2
   158f0: 13 85 04 00  	mv	a0, s1
   158f4: ef f0 5f e1  	jal	0x15708 <out>
   158f8: 13 06 30 00  	li	a2, 3
   158fc: 93 85 0b 00  	mv	a1, s7
   15900: 13 85 04 00  	mv	a0, s1
   15904: ef f0 5f e0  	jal	0x15708 <out>
   15908: 37 27 00 00  	lui	a4, 2
   1590c: 33 47 ea 00  	xor	a4, s4, a4
   15910: 93 06 0b 00  	mv	a3, s6
   15914: 13 86 09 00  	mv	a2, s3
   15918: 93 05 00 02  	li	a1, 32
   1591c: 13 85 04 00  	mv	a0, s1
   15920: 13 04 0b 00  	mv	s0, s6
   15924: ef f0 9f e0  	jal	0x1572c <pad>
   15928: 63 54 3b 01  	bge	s6, s3, 0x15930 <fmt_fp+0x15c>
   1592c: 13 84 09 00  	mv	s0, s3
   15930: 1b 05 04 00  	sext.w	a0, s0
   15934: 37 13 00 00  	lui	t1, 1
   15938: 13 03 03 5d  	addi	t1, t1, 1488
   1593c: 33 01 61 00  	add	sp, sp, t1
   15940: 83 30 81 7e  	ld	ra, 2024(sp)
   15944: 03 34 01 7e  	ld	s0, 2016(sp)
   15948: 83 34 81 7d  	ld	s1, 2008(sp)
   1594c: 03 39 01 7d  	ld	s2, 2000(sp)
   15950: 83 39 81 7c  	ld	s3, 1992(sp)
   15954: 03 3a 01 7c  	ld	s4, 1984(sp)
   15958: 83 3a 81 7b  	ld	s5, 1976(sp)
   1595c: 03 3b 01 7b  	ld	s6, 1968(sp)
   15960: 83 3b 81 7a  	ld	s7, 1960(sp)
   15964: 03 3c 01 7a  	ld	s8, 1952(sp)
   15968: 83 3c 81 79  	ld	s9, 1944(sp)
   1596c: 03 3d 01 79  	ld	s10, 1936(sp)
   15970: 83 3d 81 78  	ld	s11, 1928(sp)
   15974: 13 01 01 7f  	addi	sp, sp, 2032
   15978: 67 80 00 00  	ret
   1597c: 13 57 ba 00  	srli	a4, s4, 11
   15980: 13 77 17 00  	andi	a4, a4, 1
   15984: 9b 07 0a 00  	sext.w	a5, s4
   15988: 63 1e 07 00  	bnez	a4, 0x159a4 <fmt_fp+0x1d0>
   1598c: 93 f7 17 00  	andi	a5, a5, 1
   15990: 63 92 07 02  	bnez	a5, 0x159b4 <fmt_fp+0x1e0>
   15994: 37 c9 01 00  	lui	s2, 28
   15998: 93 0a 05 00  	mv	s5, a0
   1599c: 13 09 99 8c  	addi	s2, s2, -1847
   159a0: 6f f0 df ed  	j	0x1587c <fmt_fp+0xa8>
   159a4: 37 c9 01 00  	lui	s2, 28
   159a8: 93 0a 10 00  	li	s5, 1
   159ac: 13 09 b9 8c  	addi	s2, s2, -1845
   159b0: 6f f0 df ec  	j	0x1587c <fmt_fp+0xa8>
   159b4: 37 c9 01 00  	lui	s2, 28
   159b8: 93 0a 10 00  	li	s5, 1
   159bc: 13 09 e9 8c  	addi	s2, s2, -1842
   159c0: 6f f0 df eb  	j	0x1587c <fmt_fp+0xa8>
   159c4: b7 cb 01 00  	lui	s7, 28
   159c8: 93 8b 0b 8e  	addi	s7, s7, -1824
   159cc: 6f f0 5f ed  	j	0x158a0 <fmt_fp+0xcc>
   159d0: b7 cb 01 00  	lui	s7, 28
   159d4: 93 8b 0b 8f  	addi	s7, s7, -1808
   159d8: 6f f0 df ee  	j	0x158c4 <fmt_fp+0xf0>
   159dc: b7 2b 00 00  	lui	s7, 2
   159e0: 13 07 01 04  	addi	a4, sp, 64
   159e4: 37 ed ff ff  	lui	s10, 1048574
   159e8: 93 87 0b d1  	addi	a5, s7, -752
   159ec: b3 87 e7 00  	add	a5, a5, a4
   159f0: 13 06 cd 2f  	addi	a2, s10, 764
   159f4: 33 86 c7 00  	add	a2, a5, a2
   159f8: 13 85 0c 00  	mv	a0, s9
   159fc: 93 05 0c 00  	mv	a1, s8
   15a00: ef 10 10 6f  	jal	0x178f0 <frexpl>
   15a04: 13 06 05 00  	mv	a2, a0
   15a08: 93 86 05 00  	mv	a3, a1
   15a0c: ef 20 80 73  	jal	0x18144 <__addtf3>
   15a10: 13 06 00 00  	li	a2, 0
   15a14: 93 06 00 00  	li	a3, 0
   15a18: 93 0c 05 00  	mv	s9, a0
   15a1c: 93 8d 05 00  	mv	s11, a1
   15a20: 23 30 a1 00  	sd	a0, 0(sp)
   15a24: 13 8c 05 00  	mv	s8, a1
   15a28: ef 30 40 21  	jal	0x18c3c <__netf2>
   15a2c: 13 87 0c 00  	mv	a4, s9
   15a30: 63 02 05 02  	beqz	a0, 0x15a54 <fmt_fp+0x280>
   15a34: 93 06 01 04  	addi	a3, sp, 64
   15a38: 93 87 0b d1  	addi	a5, s7, -752
   15a3c: b3 87 d7 00  	add	a5, a5, a3
   15a40: b3 87 a7 01  	add	a5, a5, s10
   15a44: 83 a6 c7 2f  	lw	a3, 764(a5)
   15a48: 23 30 f1 00  	sd	a5, 0(sp)
   15a4c: 9b 86 f6 ff  	addiw	a3, a3, -1
   15a50: 23 ae d7 2e  	sw	a3, 764(a5)
   15a54: 93 67 0b 02  	ori	a5, s6, 32
   15a58: 23 30 f1 00  	sd	a5, 0(sp)
   15a5c: 93 06 10 06  	li	a3, 97
   15a60: 63 9a d7 3c  	bne	a5, a3, 0x15e34 <fmt_fp+0x660>
   15a64: 93 77 0b 02  	andi	a5, s6, 32
   15a68: 23 3c f1 00  	sd	a5, 24(sp)
   15a6c: 63 84 07 00  	beqz	a5, 0x15a74 <fmt_fp+0x2a0>
   15a70: 13 09 99 00  	addi	s2, s2, 9
   15a74: 9b 87 2a 00  	addiw	a5, s5, 2
   15a78: 93 8a 07 00  	mv	s5, a5
   15a7c: 23 30 f1 00  	sd	a5, 0(sp)
   15a80: 9b 07 04 00  	sext.w	a5, s0
   15a84: 23 38 f1 00  	sd	a5, 16(sp)
   15a88: 93 06 a0 01  	li	a3, 26
   15a8c: 37 cd 01 00  	lui	s10, 28
   15a90: 63 e2 86 06  	bltu	a3, s0, 0x15af4 <fmt_fp+0x320>
   15a94: 83 3b 8d a2  	ld	s7, -1496(s10)
   15a98: 13 0c b0 01  	li	s8, 27
   15a9c: 3b 0c 8c 40  	subw	s8, s8, s0
   15aa0: 93 0c 00 00  	li	s9, 0
   15aa4: 13 08 f0 ff  	li	a6, -1
   15aa8: 93 86 0b 00  	mv	a3, s7
   15aac: 1b 0c fc ff  	addiw	s8, s8, -1
   15ab0: 63 18 0c 21  	bne	s8, a6, 0x15cc0 <fmt_fp+0x4ec>
   15ab4: 03 46 09 00  	lbu	a2, 0(s2)
   15ab8: 93 06 d0 02  	li	a3, 45
   15abc: 63 1a d6 22  	bne	a2, a3, 0x15cf0 <fmt_fp+0x51c>
   15ac0: 13 1c fc 03  	slli	s8, s8, 63
   15ac4: 13 86 0c 00  	mv	a2, s9
   15ac8: 93 86 0b 00  	mv	a3, s7
   15acc: 13 05 07 00  	mv	a0, a4
   15ad0: b3 c5 8d 01  	xor	a1, s11, s8
   15ad4: ef 30 10 2b  	jal	0x19584 <__subtf3>
   15ad8: 13 06 05 00  	mv	a2, a0
   15adc: 93 86 05 00  	mv	a3, a1
   15ae0: 13 85 0c 00  	mv	a0, s9
   15ae4: 93 85 0b 00  	mv	a1, s7
   15ae8: ef 20 c0 65  	jal	0x18144 <__addtf3>
   15aec: 93 0c 05 00  	mv	s9, a0
   15af0: 33 cc 85 01  	xor	s8, a1, s8
   15af4: b7 26 00 00  	lui	a3, 2
   15af8: b7 e7 ff ff  	lui	a5, 1048574
   15afc: 13 06 01 04  	addi	a2, sp, 64
   15b00: 13 87 06 d1  	addi	a4, a3, -752
   15b04: 93 8b 07 30  	addi	s7, a5, 768
   15b08: 33 07 c7 00  	add	a4, a4, a2
   15b0c: b3 0b 77 01  	add	s7, a4, s7
   15b10: 13 87 06 d1  	addi	a4, a3, -752
   15b14: 33 07 c7 00  	add	a4, a4, a2
   15b18: b3 07 f7 00  	add	a5, a4, a5
   15b1c: 23 34 f1 00  	sd	a5, 8(sp)
   15b20: 83 a7 c7 2f  	lw	a5, 764(a5)
   15b24: 93 8d cb 00  	addi	s11, s7, 12
   15b28: 93 85 0d 00  	mv	a1, s11
   15b2c: 1b d5 f7 41  	sraiw	a0, a5, 31
   15b30: b3 47 f5 00  	xor	a5, a0, a5
   15b34: 3b 85 a7 40  	subw	a0, a5, a0
   15b38: ef f0 df b3  	jal	0x15674 <fmt_u>
   15b3c: 63 1a b5 01  	bne	a0, s11, 0x15b50 <fmt_fp+0x37c>
   15b40: 03 37 81 00  	ld	a4, 8(sp)
   15b44: 93 07 00 03  	li	a5, 48
   15b48: 13 85 bb 00  	addi	a0, s7, 11
   15b4c: a3 05 f7 30  	sb	a5, 779(a4)
   15b50: 37 27 00 00  	lui	a4, 2
   15b54: 13 07 07 d1  	addi	a4, a4, -752
   15b58: 93 06 01 04  	addi	a3, sp, 64
   15b5c: 33 07 d7 00  	add	a4, a4, a3
   15b60: b7 e7 ff ff  	lui	a5, 1048574
   15b64: b3 07 f7 00  	add	a5, a4, a5
   15b68: 03 a7 c7 2f  	lw	a4, 764(a5)
   15b6c: 23 34 f1 00  	sd	a5, 8(sp)
   15b70: 93 07 d0 02  	li	a5, 45
   15b74: 63 44 07 00  	bltz	a4, 0x15b7c <fmt_fp+0x3a8>
   15b78: 93 07 b0 02  	li	a5, 43
   15b7c: 37 27 00 00  	lui	a4, 2
   15b80: a3 0f f5 fe  	sb	a5, -1(a0)
   15b84: 13 07 07 d1  	addi	a4, a4, -752
   15b88: b7 e7 ff ff  	lui	a5, 1048574
   15b8c: 93 06 01 04  	addi	a3, sp, 64
   15b90: 93 87 07 31  	addi	a5, a5, 784
   15b94: 33 07 d7 00  	add	a4, a4, a3
   15b98: b3 0d f7 00  	add	s11, a4, a5
   15b9c: 37 c7 01 00  	lui	a4, 28
   15ba0: 93 07 07 c7  	addi	a5, a4, -912
   15ba4: 23 34 f1 00  	sd	a5, 8(sp)
   15ba8: 83 37 8d a2  	ld	a5, -1496(s10)
   15bac: 1b 0b fb 00  	addiw	s6, s6, 15
   15bb0: 93 0b e5 ff  	addi	s7, a0, -2
   15bb4: 23 0f 65 ff  	sb	s6, -2(a0)
   15bb8: 23 34 f1 02  	sd	a5, 40(sp)
   15bbc: 23 30 b1 03  	sd	s11, 32(sp)
   15bc0: 13 7d 8a 00  	andi	s10, s4, 8
   15bc4: 93 05 0c 00  	mv	a1, s8
   15bc8: 13 85 0c 00  	mv	a0, s9
   15bcc: ef 40 80 4b  	jal	0x1a084 <__fixtfsi>
   15bd0: 83 37 81 00  	ld	a5, 8(sp)
   15bd4: 1b 05 05 00  	sext.w	a0, a0
   15bd8: 13 8b 1d 00  	addi	s6, s11, 1
   15bdc: 33 87 a7 00  	add	a4, a5, a0
   15be0: 03 47 07 00  	lbu	a4, 0(a4)
   15be4: 83 37 81 01  	ld	a5, 24(sp)
   15be8: 33 e7 e7 00  	or	a4, a5, a4
   15bec: 23 80 ed 00  	sb	a4, 0(s11)
   15bf0: ef 40 c0 61  	jal	0x1a20c <__floatsitf>
   15bf4: 13 06 05 00  	mv	a2, a0
   15bf8: 93 86 05 00  	mv	a3, a1
   15bfc: 13 85 0c 00  	mv	a0, s9
   15c00: 93 05 0c 00  	mv	a1, s8
   15c04: ef 30 10 18  	jal	0x19584 <__subtf3>
   15c08: 83 36 81 02  	ld	a3, 40(sp)
   15c0c: 13 06 00 00  	li	a2, 0
   15c10: ef 30 c0 0f  	jal	0x18d0c <__multf3>
   15c14: 83 37 01 02  	ld	a5, 32(sp)
   15c18: 13 08 05 00  	mv	a6, a0
   15c1c: 13 87 05 00  	mv	a4, a1
   15c20: b3 06 fb 40  	sub	a3, s6, a5
   15c24: 93 07 10 00  	li	a5, 1
   15c28: 93 0c 05 00  	mv	s9, a0
   15c2c: 13 8c 05 00  	mv	s8, a1
   15c30: 63 9c f6 02  	bne	a3, a5, 0x15c68 <fmt_fp+0x494>
   15c34: 13 06 00 00  	li	a2, 0
   15c38: 93 06 00 00  	li	a3, 0
   15c3c: 23 3c b1 02  	sd	a1, 56(sp)
   15c40: 23 38 a1 02  	sd	a0, 48(sp)
   15c44: ef 20 90 7f  	jal	0x18c3c <__netf2>
   15c48: 13 88 0c 00  	mv	a6, s9
   15c4c: 13 07 0c 00  	mv	a4, s8
   15c50: 63 16 05 00  	bnez	a0, 0x15c5c <fmt_fp+0x488>
   15c54: 63 44 80 00  	bgtz	s0, 0x15c5c <fmt_fp+0x488>
   15c58: 63 04 0d 02  	beqz	s10, 0x15c80 <fmt_fp+0x4ac>
   15c5c: 93 07 e0 02  	li	a5, 46
   15c60: 13 8b 2d 00  	addi	s6, s11, 2
   15c64: a3 80 fd 00  	sb	a5, 1(s11)
   15c68: 13 06 00 00  	li	a2, 0
   15c6c: 93 06 00 00  	li	a3, 0
   15c70: 13 05 08 00  	mv	a0, a6
   15c74: 93 05 07 00  	mv	a1, a4
   15c78: ef 20 50 7c  	jal	0x18c3c <__netf2>
   15c7c: 63 10 05 0a  	bnez	a0, 0x15d1c <fmt_fp+0x548>
   15c80: b7 27 00 00  	lui	a5, 2
   15c84: 93 06 01 04  	addi	a3, sp, 64
   15c88: 93 87 07 d1  	addi	a5, a5, -752
   15c8c: b3 87 d7 00  	add	a5, a5, a3
   15c90: 37 e7 ff ff  	lui	a4, 1048574
   15c94: 33 8c e7 00  	add	s8, a5, a4
   15c98: 83 36 01 00  	ld	a3, 0(sp)
   15c9c: 13 0c cc 30  	addi	s8, s8, 780
   15ca0: b7 07 00 80  	lui	a5, 524288
   15ca4: 33 0c 7c 41  	sub	s8, s8, s7
   15ca8: 93 c7 d7 ff  	xori	a5, a5, -3
   15cac: b3 87 87 41  	sub	a5, a5, s8
   15cb0: b3 87 d7 40  	sub	a5, a5, a3
   15cb4: 63 d8 87 06  	bge	a5, s0, 0x15d24 <fmt_fp+0x550>
   15cb8: 13 05 f0 ff  	li	a0, -1
   15cbc: 6f f0 9f c7  	j	0x15934 <fmt_fp+0x160>
   15cc0: 13 85 0c 00  	mv	a0, s9
   15cc4: 93 85 0b 00  	mv	a1, s7
   15cc8: 13 06 00 00  	li	a2, 0
   15ccc: 23 34 e1 00  	sd	a4, 8(sp)
   15cd0: ef 30 c0 03  	jal	0x18d0c <__multf3>
   15cd4: b7 37 00 04  	lui	a5, 16387
   15cd8: 03 37 81 00  	ld	a4, 8(sp)
   15cdc: 93 0c 05 00  	mv	s9, a0
   15ce0: 93 8b 05 00  	mv	s7, a1
   15ce4: 13 08 f0 ff  	li	a6, -1
   15ce8: 93 96 47 02  	slli	a3, a5, 36
   15cec: 6f f0 1f dc  	j	0x15aac <fmt_fp+0x2d8>
   15cf0: 13 06 07 00  	mv	a2, a4
   15cf4: 93 86 0d 00  	mv	a3, s11
   15cf8: 13 85 0c 00  	mv	a0, s9
   15cfc: 93 85 0b 00  	mv	a1, s7
   15d00: ef 20 40 44  	jal	0x18144 <__addtf3>
   15d04: 13 86 0c 00  	mv	a2, s9
   15d08: 93 86 0b 00  	mv	a3, s7
   15d0c: ef 30 90 07  	jal	0x19584 <__subtf3>
   15d10: 93 0c 05 00  	mv	s9, a0
   15d14: 13 8c 05 00  	mv	s8, a1
   15d18: 6f f0 df dd  	j	0x15af4 <fmt_fp+0x320>
   15d1c: 93 0d 0b 00  	mv	s11, s6
   15d20: 6f f0 5f ea  	j	0x15bc4 <fmt_fp+0x3f0>
   15d24: b7 27 00 00  	lui	a5, 2
   15d28: 93 87 07 d1  	addi	a5, a5, -752
   15d2c: 93 06 01 04  	addi	a3, sp, 64
   15d30: b3 87 d7 00  	add	a5, a5, a3
   15d34: 13 07 07 31  	addi	a4, a4, 784
   15d38: 33 87 e7 00  	add	a4, a5, a4
   15d3c: 33 0b eb 40  	sub	s6, s6, a4
   15d40: 9b 07 0c 00  	sext.w	a5, s8
   15d44: bb 0d 6c 01  	addw	s11, s8, s6
   15d48: 63 02 04 0e  	beqz	s0, 0x15e2c <fmt_fp+0x658>
   15d4c: 13 07 fb ff  	addi	a4, s6, -1
   15d50: 63 4e e4 0c  	blt	s0, a4, 0x15e2c <fmt_fp+0x658>
   15d54: 03 37 01 01  	ld	a4, 16(sp)
   15d58: 1b 04 27 00  	addiw	s0, a4, 2
   15d5c: 3b 04 f4 00  	addw	s0, s0, a5
   15d60: bb 0c 54 01  	addw	s9, s0, s5
   15d64: 13 07 0a 00  	mv	a4, s4
   15d68: 93 86 0c 00  	mv	a3, s9
   15d6c: 13 86 09 00  	mv	a2, s3
   15d70: 93 05 00 02  	li	a1, 32
   15d74: 13 85 04 00  	mv	a0, s1
   15d78: ef f0 5f 9b  	jal	0x1572c <pad>
   15d7c: 03 36 01 00  	ld	a2, 0(sp)
   15d80: 93 05 09 00  	mv	a1, s2
   15d84: 13 85 04 00  	mv	a0, s1
   15d88: ef f0 1f 98  	jal	0x15708 <out>
   15d8c: 37 07 01 00  	lui	a4, 16
   15d90: 93 86 0c 00  	mv	a3, s9
   15d94: 33 47 ea 00  	xor	a4, s4, a4
   15d98: 13 86 09 00  	mv	a2, s3
   15d9c: 93 05 00 03  	li	a1, 48
   15da0: 13 85 04 00  	mv	a0, s1
   15da4: ef f0 9f 98  	jal	0x1572c <pad>
   15da8: b7 27 00 00  	lui	a5, 2
   15dac: 13 07 01 04  	addi	a4, sp, 64
   15db0: b7 e5 ff ff  	lui	a1, 1048574
   15db4: 93 87 07 d1  	addi	a5, a5, -752
   15db8: b3 87 e7 00  	add	a5, a5, a4
   15dbc: 93 85 05 31  	addi	a1, a1, 784
   15dc0: b3 85 b7 00  	add	a1, a5, a1
   15dc4: 13 06 0b 00  	mv	a2, s6
   15dc8: 13 85 04 00  	mv	a0, s1
   15dcc: ef f0 df 93  	jal	0x15708 <out>
   15dd0: 13 07 00 00  	li	a4, 0
   15dd4: 93 06 00 00  	li	a3, 0
   15dd8: 3b 06 b4 41  	subw	a2, s0, s11
   15ddc: 93 05 00 03  	li	a1, 48
   15de0: 13 85 04 00  	mv	a0, s1
   15de4: ef f0 9f 94  	jal	0x1572c <pad>
   15de8: 13 06 0c 00  	mv	a2, s8
   15dec: 93 85 0b 00  	mv	a1, s7
   15df0: 13 85 04 00  	mv	a0, s1
   15df4: ef f0 5f 91  	jal	0x15708 <out>
   15df8: 1b 09 0a 00  	sext.w	s2, s4
   15dfc: 37 27 00 00  	lui	a4, 2
   15e00: 33 47 e9 00  	xor	a4, s2, a4
   15e04: 93 86 0c 00  	mv	a3, s9
   15e08: 13 86 09 00  	mv	a2, s3
   15e0c: 93 05 00 02  	li	a1, 32
   15e10: 13 85 04 00  	mv	a0, s1
   15e14: 93 8a 0c 00  	mv	s5, s9
   15e18: ef f0 5f 91  	jal	0x1572c <pad>
   15e1c: 63 d4 3c 01  	bge	s9, s3, 0x15e24 <fmt_fp+0x650>
   15e20: 93 8a 09 00  	mv	s5, s3
   15e24: 1b 85 0a 00  	sext.w	a0, s5
   15e28: 6f f0 df b0  	j	0x15934 <fmt_fp+0x160>
   15e2c: 1b 84 0d 00  	sext.w	s0, s11
   15e30: 6f f0 1f f3  	j	0x15d60 <fmt_fp+0x58c>
   15e34: 63 54 04 00  	bgez	s0, 0x15e3c <fmt_fp+0x668>
   15e38: 13 04 60 00  	li	s0, 6
   15e3c: 13 06 00 00  	li	a2, 0
   15e40: 93 06 00 00  	li	a3, 0
   15e44: 13 05 07 00  	mv	a0, a4
   15e48: 93 85 0d 00  	mv	a1, s11
   15e4c: 23 38 e1 00  	sd	a4, 16(sp)
   15e50: ef 20 d0 5e  	jal	0x18c3c <__netf2>
   15e54: 63 0a 05 04  	beqz	a0, 0x15ea8 <fmt_fp+0x6d4>
   15e58: 03 37 01 01  	ld	a4, 16(sp)
   15e5c: b7 c6 01 00  	lui	a3, 28
   15e60: 83 b6 86 a8  	ld	a3, -1400(a3)
   15e64: 13 05 07 00  	mv	a0, a4
   15e68: 13 06 00 00  	li	a2, 0
   15e6c: 93 85 0d 00  	mv	a1, s11
   15e70: ef 20 d0 69  	jal	0x18d0c <__multf3>
   15e74: 37 27 00 00  	lui	a4, 2
   15e78: 13 07 07 d1  	addi	a4, a4, -752
   15e7c: 93 06 01 04  	addi	a3, sp, 64
   15e80: 33 07 d7 00  	add	a4, a4, a3
   15e84: b7 e7 ff ff  	lui	a5, 1048574
   15e88: b3 07 f7 00  	add	a5, a4, a5
   15e8c: 23 38 f1 00  	sd	a5, 16(sp)
   15e90: 83 a7 c7 2f  	lw	a5, 764(a5)
   15e94: 03 37 01 01  	ld	a4, 16(sp)
   15e98: 93 0c 05 00  	mv	s9, a0
   15e9c: 9b 87 47 fe  	addiw	a5, a5, -28
   15ea0: 13 8c 05 00  	mv	s8, a1
   15ea4: 23 2e f7 2e  	sw	a5, 764(a4)
   15ea8: 03 23 c1 04  	lw	t1, 76(sp)
   15eac: 37 27 00 00  	lui	a4, 2
   15eb0: 93 06 87 b4  	addi	a3, a4, -1208
   15eb4: 13 06 01 04  	addi	a2, sp, 64
   15eb8: b7 e7 ff ff  	lui	a5, 1048574
   15ebc: b3 08 d6 00  	add	a7, a2, a3
   15ec0: 63 5a 03 00  	bgez	t1, 0x15ed4 <fmt_fp+0x700>
   15ec4: 13 07 07 d1  	addi	a4, a4, -752
   15ec8: 93 87 87 33  	addi	a5, a5, 824
   15ecc: 33 07 c7 00  	add	a4, a4, a2
   15ed0: b3 08 f7 00  	add	a7, a4, a5
   15ed4: 37 c7 01 00  	lui	a4, 28
   15ed8: 83 3d 87 a9  	ld	s11, -1384(a4)
   15edc: 13 8d 08 00  	mv	s10, a7
   15ee0: 93 05 0c 00  	mv	a1, s8
   15ee4: 13 85 0c 00  	mv	a0, s9
   15ee8: 23 3c 11 01  	sd	a7, 24(sp)
   15eec: 23 38 61 00  	sd	t1, 16(sp)
   15ef0: ef 40 80 26  	jal	0x1a158 <__fixunstfsi>
   15ef4: 23 20 ad 00  	sw	a0, 0(s10)
   15ef8: 1b 05 05 00  	sext.w	a0, a0
   15efc: ef 40 80 39  	jal	0x1a294 <__floatunsitf>
   15f00: 13 06 05 00  	mv	a2, a0
   15f04: 93 86 05 00  	mv	a3, a1
   15f08: 13 85 0c 00  	mv	a0, s9
   15f0c: 93 05 0c 00  	mv	a1, s8
   15f10: ef 30 40 67  	jal	0x19584 <__subtf3>
   15f14: 13 06 00 00  	li	a2, 0
   15f18: 93 86 0d 00  	mv	a3, s11
   15f1c: ef 20 10 5f  	jal	0x18d0c <__multf3>
   15f20: 13 06 00 00  	li	a2, 0
   15f24: 93 06 00 00  	li	a3, 0
   15f28: 93 0c 05 00  	mv	s9, a0
   15f2c: 13 8c 05 00  	mv	s8, a1
   15f30: ef 20 d0 50  	jal	0x18c3c <__netf2>
   15f34: 03 33 01 01  	ld	t1, 16(sp)
   15f38: 83 38 81 01  	ld	a7, 24(sp)
   15f3c: 13 0d 4d 00  	addi	s10, s10, 4
   15f40: e3 10 05 fa  	bnez	a0, 0x15ee0 <fmt_fp+0x70c>
   15f44: 37 d5 9a 3b  	lui	a0, 244141
   15f48: 93 8b 08 00  	mv	s7, a7
   15f4c: 13 07 00 00  	li	a4, 0
   15f50: 13 0e d0 01  	li	t3, 29
   15f54: 13 05 05 a0  	addi	a0, a0, -1536
   15f58: 63 4c 60 1a  	bgtz	t1, 0x16110 <fmt_fp+0x93c>
   15f5c: 63 02 07 02  	beqz	a4, 0x15f80 <fmt_fp+0x7ac>
   15f60: b7 27 00 00  	lui	a5, 2
   15f64: 93 87 07 d1  	addi	a5, a5, -752
   15f68: 93 06 01 04  	addi	a3, sp, 64
   15f6c: 37 e7 ff ff  	lui	a4, 1048574
   15f70: b3 87 d7 00  	add	a5, a5, a3
   15f74: b3 87 e7 00  	add	a5, a5, a4
   15f78: 23 38 f1 00  	sd	a5, 16(sp)
   15f7c: 23 ae 67 2e  	sw	t1, 764(a5)
   15f80: 93 06 90 00  	li	a3, 9
   15f84: 1b 07 d4 02  	addiw	a4, s0, 45
   15f88: 3b 57 d7 02  	<unknown>
   15f8c: b7 27 00 00  	lui	a5, 2
   15f90: 13 06 01 04  	addi	a2, sp, 64
   15f94: 93 87 07 d1  	addi	a5, a5, -752
   15f98: b7 e6 ff ff  	lui	a3, 1048574
   15f9c: b3 87 c7 00  	add	a5, a5, a2
   15fa0: b3 87 d7 00  	add	a5, a5, a3
   15fa4: 83 a6 c7 2f  	lw	a3, 764(a5)
   15fa8: 37 de 9a 3b  	lui	t3, 244141
   15fac: 23 38 f1 00  	sd	a5, 16(sp)
   15fb0: 13 06 00 00  	li	a2, 0
   15fb4: 13 0f 70 ff  	li	t5, -9
   15fb8: 93 0f 10 00  	li	t6, 1
   15fbc: 1b 0e 0e a0  	addiw	t3, t3, -1536
   15fc0: 93 02 60 06  	li	t0, 102
   15fc4: 1b 07 17 00  	addiw	a4, a4, 1
   15fc8: 13 17 07 02  	slli	a4, a4, 32
   15fcc: 13 57 07 02  	srli	a4, a4, 32
   15fd0: 93 1e 27 00  	slli	t4, a4, 2
   15fd4: 63 c6 06 1a  	bltz	a3, 0x16180 <fmt_fp+0x9ac>
   15fd8: 63 02 06 02  	beqz	a2, 0x15ffc <fmt_fp+0x828>
   15fdc: b7 27 00 00  	lui	a5, 2
   15fe0: 93 87 07 d1  	addi	a5, a5, -752
   15fe4: 13 06 01 04  	addi	a2, sp, 64
   15fe8: 37 e7 ff ff  	lui	a4, 1048574
   15fec: b3 87 c7 00  	add	a5, a5, a2
   15ff0: b3 87 e7 00  	add	a5, a5, a4
   15ff4: 23 38 f1 00  	sd	a5, 16(sp)
   15ff8: 23 ae d7 2e  	sw	a3, 764(a5)
   15ffc: 13 03 00 00  	li	t1, 0
   16000: 63 f2 ab 03  	bgeu	s7, s10, 0x16024 <fmt_fp+0x850>
   16004: 33 83 78 41  	sub	t1, a7, s7
   16008: 83 a6 0b 00  	lw	a3, 0(s7)
   1600c: 13 57 23 40  	srai	a4, t1, 2
   16010: 13 03 90 00  	li	t1, 9
   16014: 3b 03 e3 02  	<unknown>
   16018: 13 06 a0 00  	li	a2, 10
   1601c: 13 07 a0 00  	li	a4, 10
   16020: 63 f4 e6 1e  	bgeu	a3, a4, 0x16208 <fmt_fp+0xa34>
   16024: 83 37 01 00  	ld	a5, 0(sp)
   16028: 13 06 70 06  	li	a2, 103
   1602c: 93 06 00 00  	li	a3, 0
   16030: 13 87 a7 f9  	addi	a4, a5, -102
   16034: 33 37 e0 00  	snez	a4, a4
   16038: 3b 07 67 02  	<unknown>
   1603c: 3b 07 e4 40  	subw	a4, s0, a4
   16040: 63 94 c7 00  	bne	a5, a2, 0x16048 <fmt_fp+0x874>
   16044: b3 36 80 00  	snez	a3, s0
   16048: 3b 06 d7 40  	subw	a2, a4, a3
   1604c: 33 07 1d 41  	sub	a4, s10, a7
   16050: 13 57 27 40  	srai	a4, a4, 2
   16054: 13 07 f7 ff  	addi	a4, a4, -1
   16058: 93 05 90 00  	li	a1, 9
   1605c: 33 07 b7 02  	<unknown>
   16060: 63 56 e6 24  	bge	a2, a4, 0x162ac <fmt_fp+0xad8>
   16064: 37 47 02 00  	lui	a4, 36
   16068: 3b 07 c7 00  	addw	a4, a4, a2
   1606c: 13 06 90 00  	li	a2, 9
   16070: 3b 4c c7 02  	<unknown>
   16074: b7 06 ff ff  	lui	a3, 1048560
   16078: 93 86 46 00  	addi	a3, a3, 4
   1607c: 93 05 a0 00  	li	a1, 10
   16080: 3b 67 c7 02  	<unknown>
   16084: 13 1c 2c 00  	slli	s8, s8, 2
   16088: 33 0c dc 00  	add	s8, s8, a3
   1608c: 33 8c 88 01  	add	s8, a7, s8
   16090: 93 06 a0 00  	li	a3, 10
   16094: 13 06 90 00  	li	a2, 9
   16098: 1b 07 17 00  	addiw	a4, a4, 1
   1609c: 63 1c c7 16  	bne	a4, a2, 0x16214 <fmt_fp+0xa40>
   160a0: 83 2d 0c 00  	lw	s11, 0(s8)
   160a4: 1b 8e 06 00  	sext.w	t3, a3
   160a8: 3b f6 dd 02  	<unknown>
   160ac: 93 05 06 00  	mv	a1, a2
   160b0: 63 16 06 00  	bnez	a2, 0x160bc <fmt_fp+0x8e8>
   160b4: 13 07 4c 00  	addi	a4, s8, 4
   160b8: 63 04 ed 1e  	beq	s10, a4, 0x162a0 <fmt_fp+0xacc>
   160bc: 3b d7 cd 03  	<unknown>
   160c0: 13 77 17 00  	andi	a4, a4, 1
   160c4: 63 10 07 02  	bnez	a4, 0x160e4 <fmt_fp+0x910>
   160c8: 37 d7 9a 3b  	lui	a4, 244141
   160cc: 13 07 07 a0  	addi	a4, a4, -1536
   160d0: 63 98 e6 14  	bne	a3, a4, 0x16220 <fmt_fp+0xa4c>
   160d4: 63 f6 8b 15  	bgeu	s7, s8, 0x16220 <fmt_fp+0xa4c>
   160d8: 03 27 cc ff  	lw	a4, -4(s8)
   160dc: 13 77 17 00  	andi	a4, a4, 1
   160e0: 63 00 07 14  	beqz	a4, 0x16220 <fmt_fp+0xa4c>
   160e4: 37 c5 01 00  	lui	a0, 28
   160e8: 83 3c 85 a4  	ld	s9, -1464(a0)
   160ec: 13 07 10 00  	li	a4, 1
   160f0: 93 d6 16 40  	srai	a3, a3, 1
   160f4: 63 6e d6 12  	bltu	a2, a3, 0x16230 <fmt_fp+0xa5c>
   160f8: 63 96 c6 00  	bne	a3, a2, 0x16104 <fmt_fp+0x930>
   160fc: 93 06 4c 00  	addi	a3, s8, 4
   16100: 63 0e dd 38  	beq	s10, a3, 0x1649c <fmt_fp+0xcc8>
   16104: b7 c6 01 00  	lui	a3, 28
   16108: 83 b6 86 a5  	ld	a3, -1448(a3)
   1610c: 6f 00 c0 12  	j	0x16238 <fmt_fp+0xa64>
   16110: 1b 06 03 00  	sext.w	a2, t1
   16114: 63 54 6e 00  	bge	t3, t1, 0x1611c <fmt_fp+0x948>
   16118: 13 06 d0 01  	li	a2, 29
   1611c: 93 05 cd ff  	addi	a1, s10, -4
   16120: 13 07 00 00  	li	a4, 0
   16124: 63 f4 75 03  	bgeu	a1, s7, 0x1614c <fmt_fp+0x978>
   16128: 63 06 07 00  	beqz	a4, 0x16134 <fmt_fp+0x960>
   1612c: 23 ae eb fe  	sw	a4, -4(s7)
   16130: 93 8b cb ff  	addi	s7, s7, -4
   16134: 63 f6 ab 01  	bgeu	s7, s10, 0x16140 <fmt_fp+0x96c>
   16138: 03 27 cd ff  	lw	a4, -4(s10)
   1613c: 63 0e 07 02  	beqz	a4, 0x16178 <fmt_fp+0x9a4>
   16140: 3b 03 c3 40  	subw	t1, t1, a2
   16144: 13 07 10 00  	li	a4, 1
   16148: 6f f0 1f e1  	j	0x15f58 <fmt_fp+0x784>
   1614c: 83 e6 05 00  	lwu	a3, 0(a1)
   16150: 13 17 07 02  	slli	a4, a4, 32
   16154: 13 57 07 02  	srli	a4, a4, 32
   16158: b3 96 c6 00  	sll	a3, a3, a2
   1615c: 33 87 e6 00  	add	a4, a3, a4
   16160: b3 76 a7 02  	<unknown>
   16164: 93 85 c5 ff  	addi	a1, a1, -4
   16168: 33 57 a7 02  	<unknown>
   1616c: 23 a2 d5 00  	sw	a3, 4(a1)
   16170: 1b 07 07 00  	sext.w	a4, a4
   16174: 6f f0 1f fb  	j	0x16124 <fmt_fp+0x950>
   16178: 13 0d cd ff  	addi	s10, s10, -4
   1617c: 6f f0 9f fb  	j	0x16134 <fmt_fp+0x960>
   16180: 93 05 90 00  	li	a1, 9
   16184: 63 c4 e6 01  	blt	a3, t5, 0x1618c <fmt_fp+0x9b8>
   16188: bb 05 d0 40  	negw	a1, a3
   1618c: bb 93 bf 00  	sllw	t2, t6, a1
   16190: 9b 83 f3 ff  	addiw	t2, t2, -1
   16194: 3b 5c be 40  	sraw	s8, t3, a1
   16198: 13 86 0b 00  	mv	a2, s7
   1619c: 13 05 00 00  	li	a0, 0
   161a0: 63 64 a6 05  	bltu	a2, s10, 0x161e8 <fmt_fp+0xa14>
   161a4: 03 a6 0b 00  	lw	a2, 0(s7)
   161a8: 63 14 06 00  	bnez	a2, 0x161b0 <fmt_fp+0x9dc>
   161ac: 93 8b 4b 00  	addi	s7, s7, 4
   161b0: 63 06 05 00  	beqz	a0, 0x161bc <fmt_fp+0x9e8>
   161b4: 23 20 ad 00  	sw	a0, 0(s10)
   161b8: 13 0d 4d 00  	addi	s10, s10, 4
   161bc: 83 37 01 00  	ld	a5, 0(sp)
   161c0: 13 86 08 00  	mv	a2, a7
   161c4: 63 84 57 00  	beq	a5, t0, 0x161cc <fmt_fp+0x9f8>
   161c8: 13 86 0b 00  	mv	a2, s7
   161cc: 33 05 cd 40  	sub	a0, s10, a2
   161d0: 13 55 25 40  	srai	a0, a0, 2
   161d4: 63 54 a7 00  	bge	a4, a0, 0x161dc <fmt_fp+0xa08>
   161d8: 33 0d d6 01  	add	s10, a2, t4
   161dc: bb 86 b6 00  	addw	a3, a3, a1
   161e0: 13 06 10 00  	li	a2, 1
   161e4: 6f f0 1f df  	j	0x15fd4 <fmt_fp+0x800>
   161e8: 03 23 06 00  	lw	t1, 0(a2)
   161ec: 13 06 46 00  	addi	a2, a2, 4
   161f0: bb 5c b3 00  	srlw	s9, t1, a1
   161f4: 3b 85 ac 00  	addw	a0, s9, a0
   161f8: 23 2e a6 fe  	sw	a0, -4(a2)
   161fc: 33 75 73 00  	and	a0, t1, t2
   16200: 3b 05 85 03  	<unknown>
   16204: 6f f0 df f9  	j	0x161a0 <fmt_fp+0x9cc>
   16208: 3b 07 e6 02  	<unknown>
   1620c: 1b 03 13 00  	addiw	t1, t1, 1
   16210: 6f f0 1f e1  	j	0x16020 <fmt_fp+0x84c>
   16214: bb 86 d5 02  	<unknown>
   16218: 1b 07 17 00  	addiw	a4, a4, 1
   1621c: 6f f0 1f e8  	j	0x1609c <fmt_fp+0x8c8>
   16220: 37 c5 01 00  	lui	a0, 28
   16224: 83 3c 85 a3  	ld	s9, -1480(a0)
   16228: 13 07 00 00  	li	a4, 0
   1622c: 6f f0 5f ec  	j	0x160f0 <fmt_fp+0x91c>
   16230: b7 c6 01 00  	lui	a3, 28
   16234: 83 b6 86 a7  	ld	a3, -1416(a3)
   16238: 63 80 0a 02  	beqz	s5, 0x16258 <fmt_fp+0xa84>
   1623c: 03 45 09 00  	lbu	a0, 0(s2)
   16240: 13 06 d0 02  	li	a2, 45
   16244: 63 1a c5 00  	bne	a0, a2, 0x16258 <fmt_fp+0xa84>
   16248: 13 06 f0 ff  	li	a2, -1
   1624c: 13 16 f6 03  	slli	a2, a2, 63
   16250: b3 cc cc 00  	xor	s9, s9, a2
   16254: b3 c6 c6 00  	xor	a3, a3, a2
   16258: 13 06 00 00  	li	a2, 0
   1625c: 13 05 07 00  	mv	a0, a4
   16260: bb 8d bd 40  	subw	s11, s11, a1
   16264: 93 85 0c 00  	mv	a1, s9
   16268: 23 34 11 03  	sd	a7, 40(sp)
   1626c: 23 3c c1 01  	sd	t3, 24(sp)
   16270: 23 30 61 02  	sd	t1, 32(sp)
   16274: 23 38 e1 00  	sd	a4, 16(sp)
   16278: ef 10 d0 6c  	jal	0x18144 <__addtf3>
   1627c: 03 37 01 01  	ld	a4, 16(sp)
   16280: 93 86 0c 00  	mv	a3, s9
   16284: 13 06 07 00  	mv	a2, a4
   16288: ef 20 50 1b  	jal	0x18c3c <__netf2>
   1628c: 03 3e 81 01  	ld	t3, 24(sp)
   16290: 83 38 81 02  	ld	a7, 40(sp)
   16294: 63 1a 05 20  	bnez	a0, 0x164a8 <fmt_fp+0xcd4>
   16298: 03 33 01 02  	ld	t1, 32(sp)
   1629c: 23 20 bc 01  	sw	s11, 0(s8)
   162a0: 13 0c 4c 00  	addi	s8, s8, 4
   162a4: 63 74 ac 01  	bgeu	s8, s10, 0x162ac <fmt_fp+0xad8>
   162a8: 13 0d 0c 00  	mv	s10, s8
   162ac: 63 f6 ab 01  	bgeu	s7, s10, 0x162b8 <fmt_fp+0xae4>
   162b0: 03 27 cd ff  	lw	a4, -4(s10)
   162b4: 63 0e 07 24  	beqz	a4, 0x16510 <fmt_fp+0xd3c>
   162b8: 83 37 01 00  	ld	a5, 0(sp)
   162bc: 13 07 70 06  	li	a4, 103
   162c0: 63 9a e7 06  	bne	a5, a4, 0x16334 <fmt_fp+0xb60>
   162c4: 63 14 04 00  	bnez	s0, 0x162cc <fmt_fp+0xaf8>
   162c8: 13 04 10 00  	li	s0, 1
   162cc: 63 56 83 24  	bge	t1, s0, 0x16518 <fmt_fp+0xd44>
   162d0: 13 07 c0 ff  	li	a4, -4
   162d4: 63 42 e3 24  	blt	t1, a4, 0x16518 <fmt_fp+0xd44>
   162d8: 1b 07 13 00  	addiw	a4, t1, 1
   162dc: 1b 0b fb ff  	addiw	s6, s6, -1
   162e0: 3b 04 e4 40  	subw	s0, s0, a4
   162e4: 13 77 8a 00  	andi	a4, s4, 8
   162e8: 63 16 07 04  	bnez	a4, 0x16334 <fmt_fp+0xb60>
   162ec: 93 06 90 00  	li	a3, 9
   162f0: 63 f6 ab 01  	bgeu	s7, s10, 0x162fc <fmt_fp+0xb28>
   162f4: 03 26 cd ff  	lw	a2, -4(s10)
   162f8: 63 10 06 24  	bnez	a2, 0x16538 <fmt_fp+0xd64>
   162fc: 33 07 1d 41  	sub	a4, s10, a7
   16300: 13 57 27 40  	srai	a4, a4, 2
   16304: 13 06 90 00  	li	a2, 9
   16308: 13 07 f7 ff  	addi	a4, a4, -1
   1630c: 33 07 c7 02  	<unknown>
   16310: 93 05 60 06  	li	a1, 102
   16314: 13 66 0b 02  	ori	a2, s6, 32
   16318: 63 18 b6 22  	bne	a2, a1, 0x16548 <fmt_fp+0xd74>
   1631c: 33 07 d7 40  	sub	a4, a4, a3
   16320: 63 54 07 00  	bgez	a4, 0x16328 <fmt_fp+0xb54>
   16324: 13 07 00 00  	li	a4, 0
   16328: 63 54 e4 00  	bge	s0, a4, 0x16330 <fmt_fp+0xb5c>
   1632c: 13 07 04 00  	mv	a4, s0
   16330: 1b 04 07 00  	sext.w	s0, a4
   16334: 37 07 00 80  	lui	a4, 524288
   16338: 13 47 d7 ff  	xori	a4, a4, -3
   1633c: e3 4e 87 96  	blt	a4, s0, 0x15cb8 <fmt_fp+0x4e4>
   16340: 93 7c 8a 00  	andi	s9, s4, 8
   16344: 33 6c 94 01  	or	s8, s0, s9
   16348: b3 36 80 01  	snez	a3, s8
   1634c: 1b 07 14 00  	addiw	a4, s0, 1
   16350: 3b 85 e6 00  	addw	a0, a3, a4
   16354: 9b 07 0a 00  	sext.w	a5, s4
   16358: b7 06 00 80  	lui	a3, 524288
   1635c: 93 c6 f6 ff  	not	a3, a3
   16360: 23 30 f1 00  	sd	a5, 0(sp)
   16364: 93 6d 0b 02  	ori	s11, s6, 32
   16368: 13 06 60 06  	li	a2, 102
   1636c: bb 86 a6 40  	subw	a3, a3, a0
   16370: 63 90 cd 1e  	bne	s11, a2, 0x16550 <fmt_fp+0xd7c>
   16374: e3 c2 66 94  	blt	a3, t1, 0x15cb8 <fmt_fp+0x4e4>
   16378: 63 54 60 00  	blez	t1, 0x16380 <fmt_fp+0xbac>
   1637c: 3b 05 65 00  	addw	a0, a0, t1
   16380: 37 07 00 80  	lui	a4, 524288
   16384: 63 96 0a 28  	bnez	s5, 0x16610 <fmt_fp+0xe3c>
   16388: 13 47 f7 ff  	not	a4, a4
   1638c: 23 3c 11 01  	sd	a7, 24(sp)
   16390: 1b 07 07 00  	sext.w	a4, a4
   16394: e3 42 a7 92  	blt	a4, a0, 0x15cb8 <fmt_fp+0x4e4>
   16398: 3b 0b 55 01  	addw	s6, a0, s5
   1639c: 13 07 0a 00  	mv	a4, s4
   163a0: 93 06 0b 00  	mv	a3, s6
   163a4: 13 86 09 00  	mv	a2, s3
   163a8: 93 05 00 02  	li	a1, 32
   163ac: 13 85 04 00  	mv	a0, s1
   163b0: 23 28 61 01  	sw	s6, 16(sp)
   163b4: ef f0 8f b7  	jal	0x1572c <pad>
   163b8: 13 86 0a 00  	mv	a2, s5
   163bc: 93 05 09 00  	mv	a1, s2
   163c0: 13 85 04 00  	mv	a0, s1
   163c4: ef f0 4f b4  	jal	0x15708 <out>
   163c8: 83 37 01 00  	ld	a5, 0(sp)
   163cc: 37 07 01 00  	lui	a4, 16
   163d0: 93 06 0b 00  	mv	a3, s6
   163d4: 33 c7 e7 00  	xor	a4, a5, a4
   163d8: 13 86 09 00  	mv	a2, s3
   163dc: 93 05 00 03  	li	a1, 48
   163e0: 13 85 04 00  	mv	a0, s1
   163e4: ef f0 8f b4  	jal	0x1572c <pad>
   163e8: 13 07 60 06  	li	a4, 102
   163ec: 83 38 81 01  	ld	a7, 24(sp)
   163f0: 63 9c ed 32  	bne	s11, a4, 0x16728 <fmt_fp+0xf54>
   163f4: 13 89 08 00  	mv	s2, a7
   163f8: 63 f4 1b 01  	bgeu	s7, a7, 0x16400 <fmt_fp+0xc2c>
   163fc: 13 89 0b 00  	mv	s2, s7
   16400: 37 27 00 00  	lui	a4, 2
   16404: 37 ea ff ff  	lui	s4, 1048574
   16408: 93 06 01 04  	addi	a3, sp, 64
   1640c: 93 07 07 d1  	addi	a5, a4, -752
   16410: 93 0b 0a 31  	addi	s7, s4, 784
   16414: b3 87 d7 00  	add	a5, a5, a3
   16418: b3 8b 77 01  	add	s7, a5, s7
   1641c: 93 07 07 d1  	addi	a5, a4, -752
   16420: b3 87 d7 00  	add	a5, a5, a3
   16424: 93 0c 09 00  	mv	s9, s2
   16428: 93 8d 9b 00  	addi	s11, s7, 9
   1642c: 93 0a 00 03  	li	s5, 48
   16430: 33 8a 47 01  	add	s4, a5, s4
   16434: 63 f2 98 1f  	bgeu	a7, s9, 0x16618 <fmt_fp+0xe44>
   16438: 93 86 18 00  	addi	a3, a7, 1
   1643c: 13 07 d9 ff  	addi	a4, s2, -3
   16440: 13 06 00 00  	li	a2, 0
   16444: 63 e8 e6 00  	bltu	a3, a4, 0x16454 <fmt_fp+0xc80>
   16448: 93 88 48 00  	addi	a7, a7, 4
   1644c: b3 88 28 41  	sub	a7, a7, s2
   16450: 13 f6 c8 ff  	andi	a2, a7, -4
   16454: 33 09 c9 00  	add	s2, s2, a2
   16458: 63 04 0c 2c  	beqz	s8, 0x16720 <fmt_fp+0xf4c>
   1645c: b7 c5 01 00  	lui	a1, 28
   16460: 13 06 10 00  	li	a2, 1
   16464: 93 85 05 90  	addi	a1, a1, -1792
   16468: 13 85 04 00  	mv	a0, s1
   1646c: ef f0 cf a9  	jal	0x15708 <out>
   16470: b7 27 00 00  	lui	a5, 2
   16474: 37 ea ff ff  	lui	s4, 1048574
   16478: 93 87 07 d1  	addi	a5, a5, -752
   1647c: 13 07 01 04  	addi	a4, sp, 64
   16480: 13 0a 0a 31  	addi	s4, s4, 784
   16484: b3 87 e7 00  	add	a5, a5, a4
   16488: 33 8a 47 01  	add	s4, a5, s4
   1648c: 93 0a 9a 00  	addi	s5, s4, 9
   16490: 93 0b 00 03  	li	s7, 48
   16494: 93 0c 90 00  	li	s9, 9
   16498: 6f 00 80 22  	j	0x166c0 <fmt_fp+0xeec>
   1649c: b7 c6 01 00  	lui	a3, 28
   164a0: 83 b6 86 a6  	ld	a3, -1432(a3)
   164a4: 6f f0 5f d9  	j	0x16238 <fmt_fp+0xa64>
   164a8: 3b 0e be 01  	addw	t3, t3, s11
   164ac: 37 d7 9a 3b  	lui	a4, 244141
   164b0: 23 20 cc 01  	sw	t3, 0(s8)
   164b4: 13 07 f7 9f  	addi	a4, a4, -1537
   164b8: 83 26 0c 00  	lw	a3, 0(s8)
   164bc: 63 68 d7 02  	bltu	a4, a3, 0x164ec <fmt_fp+0xd18>
   164c0: 33 83 78 41  	sub	t1, a7, s7
   164c4: 83 a6 0b 00  	lw	a3, 0(s7)
   164c8: 13 57 23 40  	srai	a4, t1, 2
   164cc: 13 03 90 00  	li	t1, 9
   164d0: 3b 03 e3 02  	<unknown>
   164d4: 13 06 a0 00  	li	a2, 10
   164d8: 13 07 a0 00  	li	a4, 10
   164dc: e3 e2 e6 dc  	bltu	a3, a4, 0x162a0 <fmt_fp+0xacc>
   164e0: 1b 03 13 00  	addiw	t1, t1, 1
   164e4: 3b 07 e6 02  	<unknown>
   164e8: 6f f0 5f ff  	j	0x164dc <fmt_fp+0xd08>
   164ec: 13 0c cc ff  	addi	s8, s8, -4
   164f0: 23 22 0c 00  	sw	zero, 4(s8)
   164f4: 63 76 7c 01  	bgeu	s8, s7, 0x16500 <fmt_fp+0xd2c>
   164f8: 23 ae 0b fe  	sw	zero, -4(s7)
   164fc: 93 8b cb ff  	addi	s7, s7, -4
   16500: 83 26 0c 00  	lw	a3, 0(s8)
   16504: 9b 86 16 00  	addiw	a3, a3, 1
   16508: 23 20 dc 00  	sw	a3, 0(s8)
   1650c: 6f f0 df fa  	j	0x164b8 <fmt_fp+0xce4>
   16510: 13 0d cd ff  	addi	s10, s10, -4
   16514: 6f f0 9f d9  	j	0x162ac <fmt_fp+0xad8>
   16518: 1b 0b eb ff  	addiw	s6, s6, -2
   1651c: 1b 04 f4 ff  	addiw	s0, s0, -1
   16520: 6f f0 5f dc  	j	0x162e4 <fmt_fp+0xb10>
   16524: 3b 07 e5 02  	<unknown>
   16528: 9b 86 16 00  	addiw	a3, a3, 1
   1652c: bb 75 e6 02  	<unknown>
   16530: e3 8a 05 fe  	beqz	a1, 0x16524 <fmt_fp+0xd50>
   16534: 6f f0 9f dc  	j	0x162fc <fmt_fp+0xb28>
   16538: 93 06 00 00  	li	a3, 0
   1653c: 13 07 a0 00  	li	a4, 10
   16540: 13 05 a0 00  	li	a0, 10
   16544: 6f f0 9f fe  	j	0x1652c <fmt_fp+0xd58>
   16548: 33 07 e3 00  	add	a4, t1, a4
   1654c: 6f f0 1f dd  	j	0x1631c <fmt_fp+0xb48>
   16550: 37 27 00 00  	lui	a4, 2
   16554: 23 30 d1 02  	sd	a3, 32(sp)
   16558: 13 07 07 d1  	addi	a4, a4, -752
   1655c: 93 06 01 04  	addi	a3, sp, 64
   16560: 33 07 d7 00  	add	a4, a4, a3
   16564: b7 e7 ff ff  	lui	a5, 1048574
   16568: 1b 56 f3 41  	sraiw	a2, t1, 31
   1656c: b3 07 f7 00  	add	a5, a4, a5
   16570: 93 87 c7 30  	addi	a5, a5, 780
   16574: 23 24 a1 02  	sw	a0, 40(sp)
   16578: 33 45 c3 00  	xor	a0, t1, a2
   1657c: 93 85 07 00  	mv	a1, a5
   16580: 3b 05 c5 40  	subw	a0, a0, a2
   16584: 23 3c 11 01  	sd	a7, 24(sp)
   16588: 23 38 61 00  	sd	t1, 16(sp)
   1658c: 23 34 f1 00  	sd	a5, 8(sp)
   16590: ef f0 4f 8e  	jal	0x15674 <fmt_u>
   16594: 83 37 81 00  	ld	a5, 8(sp)
   16598: 03 33 01 01  	ld	t1, 16(sp)
   1659c: 83 38 81 01  	ld	a7, 24(sp)
   165a0: 83 36 01 02  	ld	a3, 32(sp)
   165a4: 03 27 81 02  	lw	a4, 40(sp)
   165a8: 13 06 10 00  	li	a2, 1
   165ac: 13 0e 00 03  	li	t3, 48
   165b0: b3 85 a7 40  	sub	a1, a5, a0
   165b4: 63 58 b6 04  	bge	a2, a1, 0x16604 <fmt_fp+0xe30>
   165b8: 13 06 d0 02  	li	a2, 45
   165bc: 63 44 03 00  	bltz	t1, 0x165c4 <fmt_fp+0xdf0>
   165c0: 13 06 b0 02  	li	a2, 43
   165c4: 93 07 e5 ff  	addi	a5, a0, -2
   165c8: 23 34 f1 00  	sd	a5, 8(sp)
   165cc: b7 27 00 00  	lui	a5, 2
   165d0: a3 0f c5 fe  	sb	a2, -1(a0)
   165d4: 93 87 07 d1  	addi	a5, a5, -752
   165d8: 13 06 01 04  	addi	a2, sp, 64
   165dc: b3 87 c7 00  	add	a5, a5, a2
   165e0: 23 0f 65 ff  	sb	s6, -2(a0)
   165e4: 37 e5 ff ff  	lui	a0, 1048574
   165e8: 33 85 a7 00  	add	a0, a5, a0
   165ec: 83 37 81 00  	ld	a5, 8(sp)
   165f0: 13 05 c5 30  	addi	a0, a0, 780
   165f4: 33 05 f5 40  	sub	a0, a0, a5
   165f8: 63 c0 a6 ec  	blt	a3, a0, 0x15cb8 <fmt_fp+0x4e4>
   165fc: 3b 05 a7 00  	addw	a0, a4, a0
   16600: 6f f0 1f d8  	j	0x16380 <fmt_fp+0xbac>
   16604: 13 05 f5 ff  	addi	a0, a0, -1
   16608: 23 00 c5 01  	sb	t3, 0(a0)
   1660c: 6f f0 5f fa  	j	0x165b0 <fmt_fp+0xddc>
   16610: 13 47 e7 ff  	xori	a4, a4, -2
   16614: 6f f0 9f d7  	j	0x1638c <fmt_fp+0xbb8>
   16618: 03 e5 0c 00  	lwu	a0, 0(s9)
   1661c: 93 85 0d 00  	mv	a1, s11
   16620: 23 34 11 01  	sd	a7, 8(sp)
   16624: ef f0 0f 85  	jal	0x15674 <fmt_u>
   16628: 83 38 81 00  	ld	a7, 8(sp)
   1662c: 93 05 05 00  	mv	a1, a0
   16630: 13 07 05 00  	mv	a4, a0
   16634: 63 9e 2c 01  	bne	s9, s2, 0x16650 <fmt_fp+0xe7c>
   16638: 63 16 b5 03  	bne	a0, s11, 0x16664 <fmt_fp+0xe90>
   1663c: 23 0c 5a 31  	sb	s5, 792(s4)
   16640: 93 85 8b 00  	addi	a1, s7, 8
   16644: 6f 00 00 02  	j	0x16664 <fmt_fp+0xe90>
   16648: 13 07 f7 ff  	addi	a4, a4, -1
   1664c: 23 00 57 01  	sb	s5, 0(a4)
   16650: e3 ec eb fe  	bltu	s7, a4, 0x16648 <fmt_fp+0xe74>
   16654: 13 07 00 00  	li	a4, 0
   16658: 63 e4 75 01  	bltu	a1, s7, 0x16660 <fmt_fp+0xe8c>
   1665c: 33 87 bb 40  	sub	a4, s7, a1
   16660: b3 85 e5 00  	add	a1, a1, a4
   16664: 33 86 bd 40  	sub	a2, s11, a1
   16668: 13 85 04 00  	mv	a0, s1
   1666c: 23 34 11 01  	sd	a7, 8(sp)
   16670: ef f0 8f 89  	jal	0x15708 <out>
   16674: 83 38 81 00  	ld	a7, 8(sp)
   16678: 93 8c 4c 00  	addi	s9, s9, 4
   1667c: 6f f0 9f db  	j	0x16434 <fmt_fp+0xc60>
   16680: 03 65 09 00  	lwu	a0, 0(s2)
   16684: 93 85 0a 00  	mv	a1, s5
   16688: ef e0 df fe  	jal	0x15674 <fmt_u>
   1668c: 13 07 05 00  	mv	a4, a0
   16690: 63 62 ea 08  	bltu	s4, a4, 0x16714 <fmt_fp+0xf40>
   16694: 93 05 00 00  	li	a1, 0
   16698: 63 64 45 01  	bltu	a0, s4, 0x166a0 <fmt_fp+0xecc>
   1669c: b3 05 aa 40  	sub	a1, s4, a0
   166a0: 1b 06 04 00  	sext.w	a2, s0
   166a4: 63 d4 8c 00  	bge	s9, s0, 0x166ac <fmt_fp+0xed8>
   166a8: 13 06 90 00  	li	a2, 9
   166ac: b3 05 b5 00  	add	a1, a0, a1
   166b0: 13 85 04 00  	mv	a0, s1
   166b4: ef f0 4f 85  	jal	0x15708 <out>
   166b8: 13 09 49 00  	addi	s2, s2, 4
   166bc: 1b 04 74 ff  	addiw	s0, s0, -9
   166c0: 63 74 a9 01  	bgeu	s2, s10, 0x166c8 <fmt_fp+0xef4>
   166c4: e3 4e 80 fa  	bgtz	s0, 0x16680 <fmt_fp+0xeac>
   166c8: 13 07 00 00  	li	a4, 0
   166cc: 93 06 90 00  	li	a3, 9
   166d0: 1b 06 94 00  	addiw	a2, s0, 9
   166d4: 93 05 00 03  	li	a1, 48
   166d8: 13 85 04 00  	mv	a0, s1
   166dc: ef f0 0f 85  	jal	0x1572c <pad>
   166e0: 83 37 01 00  	ld	a5, 0(sp)
   166e4: 37 27 00 00  	lui	a4, 2
   166e8: 13 85 04 00  	mv	a0, s1
   166ec: 33 c7 e7 00  	xor	a4, a5, a4
   166f0: 93 06 0b 00  	mv	a3, s6
   166f4: 13 86 09 00  	mv	a2, s3
   166f8: 93 05 00 02  	li	a1, 32
   166fc: ef f0 0f 83  	jal	0x1572c <pad>
   16700: 03 25 01 01  	lw	a0, 16(sp)
   16704: 63 54 3b 01  	bge	s6, s3, 0x1670c <fmt_fp+0xf38>
   16708: 13 85 09 00  	mv	a0, s3
   1670c: 1b 05 05 00  	sext.w	a0, a0
   16710: 6f f0 4f a2  	j	0x15934 <fmt_fp+0x160>
   16714: 13 07 f7 ff  	addi	a4, a4, -1
   16718: 23 00 77 01  	sb	s7, 0(a4)
   1671c: 6f f0 5f f7  	j	0x16690 <fmt_fp+0xebc>
   16720: 13 04 00 00  	li	s0, 0
   16724: 6f f0 df d4  	j	0x16470 <fmt_fp+0xc9c>
   16728: 63 e4 ab 01  	bltu	s7, s10, 0x16730 <fmt_fp+0xf5c>
   1672c: 13 8d 4b 00  	addi	s10, s7, 4
   16730: b7 26 00 00  	lui	a3, 2
   16734: 37 e7 ff ff  	lui	a4, 1048574
   16738: 13 06 01 04  	addi	a2, sp, 64
   1673c: 93 87 06 d1  	addi	a5, a3, -752
   16740: b3 87 c7 00  	add	a5, a5, a2
   16744: 13 09 07 31  	addi	s2, a4, 784
   16748: 33 89 27 01  	add	s2, a5, s2
   1674c: 93 87 06 d1  	addi	a5, a3, -752
   16750: b3 87 c7 00  	add	a5, a5, a2
   16754: b3 87 e7 00  	add	a5, a5, a4
   16758: 23 3c f1 00  	sd	a5, 24(sp)
   1675c: 93 07 89 00  	addi	a5, s2, 8
   16760: 13 8a 0b 00  	mv	s4, s7
   16764: 93 0a 99 00  	addi	s5, s2, 9
   16768: 23 30 f1 02  	sd	a5, 32(sp)
   1676c: 63 74 aa 01  	bgeu	s4, s10, 0x16774 <fmt_fp+0xfa0>
   16770: 63 58 04 04  	bgez	s0, 0x167c0 <fmt_fp+0xfec>
   16774: 1b 06 24 01  	addiw	a2, s0, 18
   16778: 13 85 04 00  	mv	a0, s1
   1677c: 13 07 00 00  	li	a4, 0
   16780: 93 06 20 01  	li	a3, 18
   16784: 93 05 00 03  	li	a1, 48
   16788: ef e0 5f fa  	jal	0x1572c <pad>
   1678c: b7 27 00 00  	lui	a5, 2
   16790: 13 07 01 04  	addi	a4, sp, 64
   16794: 93 87 07 d1  	addi	a5, a5, -752
   16798: b3 87 e7 00  	add	a5, a5, a4
   1679c: 37 e6 ff ff  	lui	a2, 1048574
   167a0: 33 86 c7 00  	add	a2, a5, a2
   167a4: 83 37 81 00  	ld	a5, 8(sp)
   167a8: 13 06 c6 30  	addi	a2, a2, 780
   167ac: 13 85 04 00  	mv	a0, s1
   167b0: 33 06 f6 40  	sub	a2, a2, a5
   167b4: 93 85 07 00  	mv	a1, a5
   167b8: ef e0 1f f5  	jal	0x15708 <out>
   167bc: 6f f0 5f f2  	j	0x166e0 <fmt_fp+0xf0c>
   167c0: 03 65 0a 00  	lwu	a0, 0(s4)
   167c4: 93 85 0a 00  	mv	a1, s5
   167c8: ef e0 df ea  	jal	0x15674 <fmt_u>
   167cc: 93 05 05 00  	mv	a1, a0
   167d0: 63 1a 55 01  	bne	a0, s5, 0x167e4 <fmt_fp+0x1010>
   167d4: 83 37 81 01  	ld	a5, 24(sp)
   167d8: 83 35 01 02  	ld	a1, 32(sp)
   167dc: 13 07 00 03  	li	a4, 48
   167e0: 23 8c e7 30  	sb	a4, 792(a5)
   167e4: 9b 0d 04 00  	sext.w	s11, s0
   167e8: 13 87 05 00  	mv	a4, a1
   167ec: 63 10 7a 05  	bne	s4, s7, 0x1682c <fmt_fp+0x1058>
   167f0: 13 06 10 00  	li	a2, 1
   167f4: 13 85 04 00  	mv	a0, s1
   167f8: 13 8c 15 00  	addi	s8, a1, 1
   167fc: ef e0 df f0  	jal	0x15708 <out>
   16800: 33 e7 bc 01  	or	a4, s9, s11
   16804: 63 0e 07 02  	beqz	a4, 0x16840 <fmt_fp+0x106c>
   16808: b7 c7 01 00  	lui	a5, 28
   1680c: 13 06 10 00  	li	a2, 1
   16810: 93 85 07 90  	addi	a1, a5, -1792
   16814: 13 85 04 00  	mv	a0, s1
   16818: ef e0 1f ef  	jal	0x15708 <out>
   1681c: 6f 00 40 02  	j	0x16840 <fmt_fp+0x106c>
   16820: 13 07 f7 ff  	addi	a4, a4, -1
   16824: 93 07 00 03  	li	a5, 48
   16828: 23 00 f7 00  	sb	a5, 0(a4)
   1682c: e3 6a e9 fe  	bltu	s2, a4, 0x16820 <fmt_fp+0x104c>
   16830: 93 06 00 00  	li	a3, 0
   16834: 63 e4 25 01  	bltu	a1, s2, 0x1683c <fmt_fp+0x1068>
   16838: b3 06 b9 40  	sub	a3, s2, a1
   1683c: 33 8c d5 00  	add	s8, a1, a3
   16840: b3 88 8a 41  	sub	a7, s5, s8
   16844: 13 06 04 00  	mv	a2, s0
   16848: 63 d4 88 00  	bge	a7, s0, 0x16850 <fmt_fp+0x107c>
   1684c: 13 86 08 00  	mv	a2, a7
   16850: 93 05 0c 00  	mv	a1, s8
   16854: 13 85 04 00  	mv	a0, s1
   16858: 23 34 11 03  	sd	a7, 40(sp)
   1685c: ef e0 df ea  	jal	0x15708 <out>
   16860: 83 38 81 02  	ld	a7, 40(sp)
   16864: 13 0a 4a 00  	addi	s4, s4, 4
   16868: 3b 84 1d 41  	subw	s0, s11, a7
   1686c: 6f f0 1f f0  	j	0x1676c <fmt_fp+0xf98>

0000000000016870 <printf_core>:
   16870: 13 01 01 ef  	addi	sp, sp, -272
   16874: b7 c7 01 00  	lui	a5, 28
   16878: 93 87 07 aa  	addi	a5, a5, -1376
   1687c: 23 38 a1 0b  	sd	s10, 176(sp)
   16880: 37 cd 01 00  	lui	s10, 28
   16884: 23 34 31 0f  	sd	s3, 232(sp)
   16888: 23 38 f1 00  	sd	a5, 16(sp)
   1688c: b7 c9 01 00  	lui	s3, 28
   16890: 93 07 0d 92  	addi	a5, s10, -1760
   16894: 23 30 81 10  	sd	s0, 256(sp)
   16898: 23 38 21 0f  	sd	s2, 240(sp)
   1689c: 23 30 41 0f  	sd	s4, 224(sp)
   168a0: 23 38 61 0d  	sd	s6, 208(sp)
   168a4: 23 30 81 0d  	sd	s8, 192(sp)
   168a8: 23 3c 91 0b  	sd	s9, 184(sp)
   168ac: 23 34 11 10  	sd	ra, 264(sp)
   168b0: 23 3c 91 0e  	sd	s1, 248(sp)
   168b4: 23 3c 51 0d  	sd	s5, 216(sp)
   168b8: 23 34 71 0d  	sd	s7, 200(sp)
   168bc: 23 34 b1 0b  	sd	s11, 168(sp)
   168c0: 13 04 05 00  	mv	s0, a0
   168c4: 13 0a 06 00  	mv	s4, a2
   168c8: 23 30 d1 00  	sd	a3, 0(sp)
   168cc: 13 0b 07 00  	mv	s6, a4
   168d0: 23 30 b1 04  	sd	a1, 64(sp)
   168d4: 93 0c 00 00  	li	s9, 0
   168d8: 13 09 00 00  	li	s2, 0
   168dc: 13 0c 00 00  	li	s8, 0
   168e0: 93 89 89 90  	addi	s3, s3, -1784
   168e4: 23 3c f1 00  	sd	a5, 24(sp)
   168e8: 83 3b 01 04  	ld	s7, 64(sp)
   168ec: 3b 89 2c 01  	addw	s2, s9, s2
   168f0: 93 0d 09 00  	mv	s11, s2
   168f4: 83 c7 0b 00  	lbu	a5, 0(s7)
   168f8: e3 8e 07 02  	beqz	a5, 0x17134 <printf_core+0x8c4>
   168fc: 13 07 50 02  	li	a4, 37
   16900: 03 33 01 04  	ld	t1, 64(sp)
   16904: 83 47 03 00  	lbu	a5, 0(t1)
   16908: 63 84 07 00  	beqz	a5, 0x16910 <printf_core+0xa0>
   1690c: 63 96 e7 00  	bne	a5, a4, 0x16918 <printf_core+0xa8>
   16910: 13 07 50 02  	li	a4, 37
   16914: 6f 00 c0 01  	j	0x16930 <printf_core+0xc0>
   16918: 13 03 13 00  	addi	t1, t1, 1
   1691c: 23 30 61 04  	sd	t1, 64(sp)
   16920: 6f f0 1f fe  	j	0x16900 <printf_core+0x90>
   16924: 93 87 27 00  	addi	a5, a5, 2
   16928: 13 03 13 00  	addi	t1, t1, 1
   1692c: 23 30 f1 04  	sd	a5, 64(sp)
   16930: 83 37 01 04  	ld	a5, 64(sp)
   16934: 83 c6 07 00  	lbu	a3, 0(a5)
   16938: 63 96 e6 00  	bne	a3, a4, 0x16944 <printf_core+0xd4>
   1693c: 83 c6 17 00  	lbu	a3, 1(a5)
   16940: e3 82 e6 fe  	beq	a3, a4, 0x16924 <printf_core+0xb4>
   16944: b7 0a 00 80  	lui	s5, 524288
   16948: 93 ca fa ff  	not	s5, s5
   1694c: bb 87 ba 41  	subw	a5, s5, s11
   16950: 33 03 73 41  	sub	t1, t1, s7
   16954: 23 34 f1 00  	sd	a5, 8(sp)
   16958: 63 ca 67 74  	blt	a5, t1, 0x170ac <printf_core+0x83c>
   1695c: 9b 0c 03 00  	sext.w	s9, t1
   16960: 63 0a 04 00  	beqz	s0, 0x16974 <printf_core+0x104>
   16964: 13 86 0c 00  	mv	a2, s9
   16968: 93 85 0b 00  	mv	a1, s7
   1696c: 13 05 04 00  	mv	a0, s0
   16970: ef e0 9f d9  	jal	0x15708 <out>
   16974: 63 98 0c 72  	bnez	s9, 0x170a4 <printf_core+0x834>
   16978: 83 37 01 04  	ld	a5, 64(sp)
   1697c: 13 07 90 00  	li	a4, 9
   16980: 83 c6 17 00  	lbu	a3, 1(a5)
   16984: 9b 86 06 fd  	addiw	a3, a3, -48
   16988: 63 66 d7 18  	bltu	a4, a3, 0x16b14 <printf_core+0x2a4>
   1698c: 03 c6 27 00  	lbu	a2, 2(a5)
   16990: 13 07 40 02  	li	a4, 36
   16994: 63 10 e6 18  	bne	a2, a4, 0x16b14 <printf_core+0x2a4>
   16998: 93 87 37 00  	addi	a5, a5, 3
   1699c: 13 0c 10 00  	li	s8, 1
   169a0: 37 35 01 00  	lui	a0, 19
   169a4: 23 30 f1 04  	sd	a5, 64(sp)
   169a8: 13 0d 00 00  	li	s10, 0
   169ac: 93 08 f0 01  	li	a7, 31
   169b0: 1b 05 95 88  	addiw	a0, a0, -1911
   169b4: 93 0e 10 00  	li	t4, 1
   169b8: 03 37 01 04  	ld	a4, 64(sp)
   169bc: 03 48 07 00  	lbu	a6, 0(a4)
   169c0: 1b 06 08 fe  	addiw	a2, a6, -32
   169c4: 63 e8 c8 00  	bltu	a7, a2, 0x169d4 <printf_core+0x164>
   169c8: bb 55 c5 00  	srlw	a1, a0, a2
   169cc: 93 f5 15 00  	andi	a1, a1, 1
   169d0: 63 98 05 14  	bnez	a1, 0x16b20 <printf_core+0x2b0>
   169d4: 13 06 a0 02  	li	a2, 42
   169d8: 63 1e c8 18  	bne	a6, a2, 0x16b74 <printf_core+0x304>
   169dc: 03 46 17 00  	lbu	a2, 1(a4)
   169e0: 93 05 90 00  	li	a1, 9
   169e4: 1b 05 06 fd  	addiw	a0, a2, -48
   169e8: 63 e8 a5 14  	bltu	a1, a0, 0x16b38 <printf_core+0x2c8>
   169ec: 03 45 27 00  	lbu	a0, 2(a4)
   169f0: 93 05 40 02  	li	a1, 36
   169f4: 63 12 b5 14  	bne	a0, a1, 0x16b38 <printf_core+0x2c8>
   169f8: 13 16 26 00  	slli	a2, a2, 2
   169fc: 33 06 cb 00  	add	a2, s6, a2
   16a00: 93 05 a0 00  	li	a1, 10
   16a04: 23 20 b6 f4  	sw	a1, -192(a2)
   16a08: 03 46 17 00  	lbu	a2, 1(a4)
   16a0c: 83 37 01 00  	ld	a5, 0(sp)
   16a10: 13 07 37 00  	addi	a4, a4, 3
   16a14: 13 16 46 00  	slli	a2, a2, 4
   16a18: 33 86 c7 00  	add	a2, a5, a2
   16a1c: 83 24 06 d0  	lw	s1, -768(a2)
   16a20: 23 30 e1 04  	sd	a4, 64(sp)
   16a24: 13 0c 10 00  	li	s8, 1
   16a28: 63 d8 04 00  	bgez	s1, 0x16a38 <printf_core+0x1c8>
   16a2c: 37 27 00 00  	lui	a4, 2
   16a30: 33 6d ed 00  	or	s10, s10, a4
   16a34: bb 04 90 40  	negw	s1, s1
   16a38: 03 37 01 04  	ld	a4, 64(sp)
   16a3c: 13 06 e0 02  	li	a2, 46
   16a40: 83 45 07 00  	lbu	a1, 0(a4)
   16a44: 63 9a c5 18  	bne	a1, a2, 0x16bd8 <printf_core+0x368>
   16a48: 83 45 17 00  	lbu	a1, 1(a4)
   16a4c: 13 06 a0 02  	li	a2, 42
   16a50: 63 92 c5 16  	bne	a1, a2, 0x16bb4 <printf_core+0x344>
   16a54: 03 46 27 00  	lbu	a2, 2(a4)
   16a58: 93 05 90 00  	li	a1, 9
   16a5c: 1b 05 06 fd  	addiw	a0, a2, -48
   16a60: 63 e8 a5 12  	bltu	a1, a0, 0x16b90 <printf_core+0x320>
   16a64: 03 45 37 00  	lbu	a0, 3(a4)
   16a68: 93 05 40 02  	li	a1, 36
   16a6c: 63 12 b5 12  	bne	a0, a1, 0x16b90 <printf_core+0x320>
   16a70: 13 16 26 00  	slli	a2, a2, 2
   16a74: 33 06 cb 00  	add	a2, s6, a2
   16a78: 93 05 a0 00  	li	a1, 10
   16a7c: 23 20 b6 f4  	sw	a1, -192(a2)
   16a80: 03 46 27 00  	lbu	a2, 2(a4)
   16a84: 83 37 01 00  	ld	a5, 0(sp)
   16a88: 13 07 47 00  	addi	a4, a4, 4
   16a8c: 13 16 46 00  	slli	a2, a2, 4
   16a90: 33 86 c7 00  	add	a2, a5, a2
   16a94: 83 2a 06 d0  	lw	s5, -768(a2)
   16a98: 13 cf fa ff  	not	t5, s5
   16a9c: 23 30 e1 04  	sd	a4, 64(sp)
   16aa0: 1b 5f ff 01  	srliw	t5, t5, 31
   16aa4: 13 07 00 00  	li	a4, 0
   16aa8: 93 0e 90 03  	li	t4, 57
   16aac: 13 08 a0 03  	li	a6, 58
   16ab0: 13 05 70 00  	li	a0, 7
   16ab4: 03 36 01 04  	ld	a2, 64(sp)
   16ab8: 83 45 06 00  	lbu	a1, 0(a2)
   16abc: 9b 85 f5 fb  	addiw	a1, a1, -65
   16ac0: 63 ee be 06  	bltu	t4, a1, 0x16b3c <printf_core+0x2cc>
   16ac4: 93 05 16 00  	addi	a1, a2, 1
   16ac8: 23 30 b1 04  	sd	a1, 64(sp)
   16acc: 03 46 06 00  	lbu	a2, 0(a2)
   16ad0: 83 37 01 01  	ld	a5, 16(sp)
   16ad4: 9b 05 f6 fb  	addiw	a1, a2, -65
   16ad8: 13 16 07 02  	slli	a2, a4, 32
   16adc: 13 56 06 02  	srli	a2, a2, 32
   16ae0: 33 06 06 03  	<unknown>
   16ae4: 33 86 c7 00  	add	a2, a5, a2
   16ae8: 33 06 b6 00  	add	a2, a2, a1
   16aec: 83 4f 06 00  	lbu	t6, 0(a2)
   16af0: 1b 86 ff ff  	addiw	a2, t6, -1
   16af4: 9b 85 0f 00  	sext.w	a1, t6
   16af8: 63 76 c5 0e  	bgeu	a0, a2, 0x16be4 <printf_core+0x374>
   16afc: 63 80 05 04  	beqz	a1, 0x16b3c <printf_core+0x2cc>
   16b00: 13 06 b0 01  	li	a2, 27
   16b04: 63 94 c5 0e  	bne	a1, a2, 0x16bec <printf_core+0x37c>
   16b08: 63 da 06 02  	bgez	a3, 0x16b3c <printf_core+0x2cc>
   16b0c: 63 1a 04 16  	bnez	s0, 0x16c80 <printf_core+0x410>
   16b10: 6f f0 9f dd  	j	0x168e8 <printf_core+0x78>
   16b14: 93 87 17 00  	addi	a5, a5, 1
   16b18: 93 06 f0 ff  	li	a3, -1
   16b1c: 6f f0 5f e8  	j	0x169a0 <printf_core+0x130>
   16b20: 3b 96 ce 00  	sllw	a2, t4, a2
   16b24: b3 67 cd 00  	or	a5, s10, a2
   16b28: 13 07 17 00  	addi	a4, a4, 1
   16b2c: 1b 8d 07 00  	sext.w	s10, a5
   16b30: 23 30 e1 04  	sd	a4, 64(sp)
   16b34: 6f f0 5f e8  	j	0x169b8 <printf_core+0x148>
   16b38: 63 0c 0c 00  	beqz	s8, 0x16b50 <printf_core+0x2e0>
   16b3c: ef a0 5f ae  	jal	0x11620 <__errno_location>
   16b40: 93 07 60 01  	li	a5, 22
   16b44: 23 20 f5 00  	sw	a5, 0(a0)
   16b48: 13 09 f0 ff  	li	s2, -1
   16b4c: 6f 00 80 0d  	j	0x16c24 <printf_core+0x3b4>
   16b50: 93 04 00 00  	li	s1, 0
   16b54: 63 0a 04 00  	beqz	s0, 0x16b68 <printf_core+0x2f8>
   16b58: 03 36 0a 00  	ld	a2, 0(s4)
   16b5c: 83 24 06 00  	lw	s1, 0(a2)
   16b60: 93 05 86 00  	addi	a1, a2, 8
   16b64: 23 30 ba 00  	sd	a1, 0(s4)
   16b68: 13 07 17 00  	addi	a4, a4, 1
   16b6c: 23 30 e1 04  	sd	a4, 64(sp)
   16b70: 6f f0 9f eb  	j	0x16a28 <printf_core+0x1b8>
   16b74: 13 05 01 04  	addi	a0, sp, 64
   16b78: 23 30 d1 02  	sd	a3, 32(sp)
   16b7c: ef e0 5f b2  	jal	0x156a0 <getint>
   16b80: 83 36 01 02  	ld	a3, 32(sp)
   16b84: 93 04 05 00  	mv	s1, a0
   16b88: e3 58 05 ea  	bgez	a0, 0x16a38 <printf_core+0x1c8>
   16b8c: 6f 00 00 52  	j	0x170ac <printf_core+0x83c>
   16b90: e3 16 0c fa  	bnez	s8, 0x16b3c <printf_core+0x2cc>
   16b94: 93 0a 00 00  	li	s5, 0
   16b98: 63 0a 04 00  	beqz	s0, 0x16bac <printf_core+0x33c>
   16b9c: 03 36 0a 00  	ld	a2, 0(s4)
   16ba0: 83 2a 06 00  	lw	s5, 0(a2)
   16ba4: 93 05 86 00  	addi	a1, a2, 8
   16ba8: 23 30 ba 00  	sd	a1, 0(s4)
   16bac: 13 07 27 00  	addi	a4, a4, 2
   16bb0: 6f f0 9f ee  	j	0x16a98 <printf_core+0x228>
   16bb4: 13 07 17 00  	addi	a4, a4, 1
   16bb8: 13 05 01 04  	addi	a0, sp, 64
   16bbc: 23 30 d1 02  	sd	a3, 32(sp)
   16bc0: 23 30 e1 04  	sd	a4, 64(sp)
   16bc4: ef e0 df ad  	jal	0x156a0 <getint>
   16bc8: 83 36 01 02  	ld	a3, 32(sp)
   16bcc: 93 0a 05 00  	mv	s5, a0
   16bd0: 13 0f 10 00  	li	t5, 1
   16bd4: 6f f0 1f ed  	j	0x16aa4 <printf_core+0x234>
   16bd8: 13 0f 00 00  	li	t5, 0
   16bdc: 93 0a f0 ff  	li	s5, -1
   16be0: 6f f0 5f ec  	j	0x16aa4 <printf_core+0x234>
   16be4: 13 87 05 00  	mv	a4, a1
   16be8: 6f f0 df ec  	j	0x16ab4 <printf_core+0x244>
   16bec: 63 c8 06 02  	bltz	a3, 0x16c1c <printf_core+0x3ac>
   16bf0: 83 37 01 00  	ld	a5, 0(sp)
   16bf4: 13 96 26 00  	slli	a2, a3, 2
   16bf8: 93 96 46 00  	slli	a3, a3, 4
   16bfc: 33 06 cb 00  	add	a2, s6, a2
   16c00: b3 86 d7 00  	add	a3, a5, a3
   16c04: 23 20 f6 01  	sw	t6, 0(a2)
   16c08: 03 b6 06 00  	ld	a2, 0(a3)
   16c0c: 83 b6 86 00  	ld	a3, 8(a3)
   16c10: 23 38 c1 04  	sd	a2, 80(sp)
   16c14: 23 3c d1 04  	sd	a3, 88(sp)
   16c18: 6f f0 5f ef  	j	0x16b0c <printf_core+0x29c>
   16c1c: 63 14 04 04  	bnez	s0, 0x16c64 <printf_core+0x3f4>
   16c20: 13 09 00 00  	li	s2, 0
   16c24: 83 30 81 10  	ld	ra, 264(sp)
   16c28: 03 34 01 10  	ld	s0, 256(sp)
   16c2c: 83 34 81 0f  	ld	s1, 248(sp)
   16c30: 83 39 81 0e  	ld	s3, 232(sp)
   16c34: 03 3a 01 0e  	ld	s4, 224(sp)
   16c38: 83 3a 81 0d  	ld	s5, 216(sp)
   16c3c: 03 3b 01 0d  	ld	s6, 208(sp)
   16c40: 83 3b 81 0c  	ld	s7, 200(sp)
   16c44: 03 3c 01 0c  	ld	s8, 192(sp)
   16c48: 83 3c 81 0b  	ld	s9, 184(sp)
   16c4c: 03 3d 01 0b  	ld	s10, 176(sp)
   16c50: 83 3d 81 0a  	ld	s11, 168(sp)
   16c54: 13 05 09 00  	mv	a0, s2
   16c58: 03 39 01 0f  	ld	s2, 240(sp)
   16c5c: 13 01 01 11  	addi	sp, sp, 272
   16c60: 67 80 00 00  	ret
   16c64: 13 06 0a 00  	mv	a2, s4
   16c68: 13 05 01 05  	addi	a0, sp, 80
   16c6c: 23 34 e1 02  	sd	a4, 40(sp)
   16c70: 23 30 e1 03  	sd	t5, 32(sp)
   16c74: ef e0 df 8f  	jal	0x15570 <pop_arg>
   16c78: 03 3f 01 02  	ld	t5, 32(sp)
   16c7c: 03 37 81 02  	ld	a4, 40(sp)
   16c80: 83 36 01 04  	ld	a3, 64(sp)
   16c84: 83 c6 f6 ff  	lbu	a3, -1(a3)
   16c88: 1b 88 06 00  	sext.w	a6, a3
   16c8c: 63 0a 07 00  	beqz	a4, 0x16ca0 <printf_core+0x430>
   16c90: 93 f6 f6 00  	andi	a3, a3, 15
   16c94: 13 06 30 00  	li	a2, 3
   16c98: 63 94 c6 00  	bne	a3, a2, 0x16ca0 <printf_core+0x430>
   16c9c: 13 78 f8 0d  	andi	a6, a6, 223
   16ca0: 93 56 dd 00  	srli	a3, s10, 13
   16ca4: 93 f6 16 00  	andi	a3, a3, 1
   16ca8: 63 88 06 00  	beqz	a3, 0x16cb8 <printf_core+0x448>
   16cac: b7 06 ff ff  	lui	a3, 1048560
   16cb0: 93 86 f6 ff  	addi	a3, a3, -1
   16cb4: 33 7d dd 00  	and	s10, s10, a3
   16cb8: 9b 06 f8 fb  	addiw	a3, a6, -65
   16cbc: 9b 85 06 00  	sext.w	a1, a3
   16cc0: 13 06 70 03  	li	a2, 55
   16cc4: 63 6e b6 44  	bltu	a2, a1, 0x17120 <printf_core+0x8b0>
   16cc8: 83 37 81 01  	ld	a5, 24(sp)
   16ccc: 93 96 06 02  	slli	a3, a3, 32
   16cd0: 93 d6 e6 01  	srli	a3, a3, 30
   16cd4: b3 86 f6 00  	add	a3, a3, a5
   16cd8: 83 a6 06 00  	lw	a3, 0(a3)
   16cdc: 67 80 06 00  	jr	a3
   16ce0: 93 07 70 00  	li	a5, 7
   16ce4: 63 e0 e7 3c  	bltu	a5, a4, 0x170a4 <printf_core+0x834>
   16ce8: 93 17 27 00  	slli	a5, a4, 2
   16cec: 37 c7 01 00  	lui	a4, 28
   16cf0: 13 07 07 a0  	addi	a4, a4, -1536
   16cf4: b3 87 e7 00  	add	a5, a5, a4
   16cf8: 83 a7 07 00  	lw	a5, 0(a5)
   16cfc: 67 80 07 00  	jr	a5
   16d00: 83 37 01 05  	ld	a5, 80(sp)
   16d04: 23 a0 b7 01  	sw	s11, 0(a5)
   16d08: 6f f0 1f be  	j	0x168e8 <printf_core+0x78>
   16d0c: 83 37 01 05  	ld	a5, 80(sp)
   16d10: 23 90 27 01  	sh	s2, 0(a5)
   16d14: 6f f0 5f bd  	j	0x168e8 <printf_core+0x78>
   16d18: 83 37 01 05  	ld	a5, 80(sp)
   16d1c: 23 80 27 01  	sb	s2, 0(a5)
   16d20: 6f f0 9f bc  	j	0x168e8 <printf_core+0x78>
   16d24: 83 37 01 05  	ld	a5, 80(sp)
   16d28: 23 b0 27 01  	sd	s2, 0(a5)
   16d2c: 6f f0 df bb  	j	0x168e8 <printf_core+0x78>
   16d30: 9b 88 0a 00  	sext.w	a7, s5
   16d34: 93 06 00 01  	li	a3, 16
   16d38: 13 87 0a 00  	mv	a4, s5
   16d3c: 63 f4 d8 00  	bgeu	a7, a3, 0x16d44 <printf_core+0x4d4>
   16d40: 13 07 00 01  	li	a4, 16
   16d44: 9b 0a 07 00  	sext.w	s5, a4
   16d48: 13 6d 8d 00  	ori	s10, s10, 8
   16d4c: 13 08 80 07  	li	a6, 120
   16d50: 83 35 01 05  	ld	a1, 80(sp)
   16d54: b7 c6 01 00  	lui	a3, 28
   16d58: 13 75 08 02  	andi	a0, a6, 32
   16d5c: 13 87 05 00  	mv	a4, a1
   16d60: 93 0b f1 09  	addi	s7, sp, 159
   16d64: 93 86 06 c7  	addi	a3, a3, -912
   16d68: 63 1c 07 12  	bnez	a4, 0x16ea0 <printf_core+0x630>
   16d6c: 93 8e 09 00  	mv	t4, s3
   16d70: 63 8c 05 00  	beqz	a1, 0x16d88 <printf_core+0x518>
   16d74: 13 77 8d 00  	andi	a4, s10, 8
   16d78: 63 08 07 00  	beqz	a4, 0x16d88 <printf_core+0x518>
   16d7c: 13 58 48 00  	srli	a6, a6, 4
   16d80: b3 8e 09 01  	add	t4, s3, a6
   16d84: 93 0c 20 00  	li	s9, 2
   16d88: 63 0a 0f 00  	beqz	t5, 0x16d9c <printf_core+0x52c>
   16d8c: 63 c0 0a 32  	bltz	s5, 0x170ac <printf_core+0x83c>
   16d90: 37 07 ff ff  	lui	a4, 1048560
   16d94: 13 07 f7 ff  	addi	a4, a4, -1
   16d98: 33 7d ed 00  	and	s10, s10, a4
   16d9c: 83 36 01 05  	ld	a3, 80(sp)
   16da0: 13 06 f1 09  	addi	a2, sp, 159
   16da4: 63 94 06 00  	bnez	a3, 0x16dac <printf_core+0x53c>
   16da8: 63 82 0a 38  	beqz	s5, 0x1712c <printf_core+0x8bc>
   16dac: 33 07 76 41  	sub	a4, a2, s7
   16db0: 93 b6 16 00  	seqz	a3, a3
   16db4: 33 07 d7 00  	add	a4, a4, a3
   16db8: 63 54 57 01  	bge	a4, s5, 0x16dc0 <printf_core+0x550>
   16dbc: 13 87 0a 00  	mv	a4, s5
   16dc0: 9b 0a 07 00  	sext.w	s5, a4
   16dc4: b3 0d 76 41  	sub	s11, a2, s7
   16dc8: 63 d4 ba 01  	bge	s5, s11, 0x16dd0 <printf_core+0x560>
   16dcc: 9b 8a 0d 00  	sext.w	s5, s11
   16dd0: 37 07 00 80  	lui	a4, 524288
   16dd4: 13 47 f7 ff  	not	a4, a4
   16dd8: 3b 07 97 41  	subw	a4, a4, s9
   16ddc: 63 48 57 2d  	blt	a4, s5, 0x170ac <printf_core+0x83c>
   16de0: 3b 88 9a 01  	addw	a6, s5, s9
   16de4: 13 07 08 00  	mv	a4, a6
   16de8: 63 54 98 00  	bge	a6, s1, 0x16df0 <printf_core+0x580>
   16dec: 13 87 04 00  	mv	a4, s1
   16df0: 83 37 81 00  	ld	a5, 8(sp)
   16df4: 23 30 d1 03  	sd	t4, 32(sp)
   16df8: 9b 04 07 00  	sext.w	s1, a4
   16dfc: 63 c8 97 2a  	blt	a5, s1, 0x170ac <printf_core+0x83c>
   16e00: 93 06 08 00  	mv	a3, a6
   16e04: 13 07 0d 00  	mv	a4, s10
   16e08: 13 86 04 00  	mv	a2, s1
   16e0c: 93 05 00 02  	li	a1, 32
   16e10: 13 05 04 00  	mv	a0, s0
   16e14: 23 34 01 01  	sd	a6, 8(sp)
   16e18: ef e0 5f 91  	jal	0x1572c <pad>
   16e1c: 83 3e 01 02  	ld	t4, 32(sp)
   16e20: 13 86 0c 00  	mv	a2, s9
   16e24: 13 05 04 00  	mv	a0, s0
   16e28: 93 85 0e 00  	mv	a1, t4
   16e2c: ef e0 df 8d  	jal	0x15708 <out>
   16e30: 03 38 81 00  	ld	a6, 8(sp)
   16e34: 37 07 01 00  	lui	a4, 16
   16e38: 33 47 ed 00  	xor	a4, s10, a4
   16e3c: 93 06 08 00  	mv	a3, a6
   16e40: 13 86 04 00  	mv	a2, s1
   16e44: 93 05 00 03  	li	a1, 48
   16e48: 13 05 04 00  	mv	a0, s0
   16e4c: ef e0 1f 8e  	jal	0x1572c <pad>
   16e50: 13 07 00 00  	li	a4, 0
   16e54: 9b 86 0d 00  	sext.w	a3, s11
   16e58: 13 86 0a 00  	mv	a2, s5
   16e5c: 93 05 00 03  	li	a1, 48
   16e60: 13 05 04 00  	mv	a0, s0
   16e64: ef e0 9f 8c  	jal	0x1572c <pad>
   16e68: 13 86 0d 00  	mv	a2, s11
   16e6c: 93 85 0b 00  	mv	a1, s7
   16e70: 13 05 04 00  	mv	a0, s0
   16e74: ef e0 5f 89  	jal	0x15708 <out>
   16e78: 03 38 81 00  	ld	a6, 8(sp)
   16e7c: 37 27 00 00  	lui	a4, 2
   16e80: 33 47 ed 00  	xor	a4, s10, a4
   16e84: 93 06 08 00  	mv	a3, a6
   16e88: 13 86 04 00  	mv	a2, s1
   16e8c: 93 05 00 02  	li	a1, 32
   16e90: 13 05 04 00  	mv	a0, s0
   16e94: ef e0 9f 89  	jal	0x1572c <pad>
   16e98: 93 8c 04 00  	mv	s9, s1
   16e9c: 6f f0 df a4  	j	0x168e8 <printf_core+0x78>
   16ea0: 13 76 f7 00  	andi	a2, a4, 15
   16ea4: 33 86 c6 00  	add	a2, a3, a2
   16ea8: 03 46 06 00  	lbu	a2, 0(a2)
   16eac: 93 8b fb ff  	addi	s7, s7, -1
   16eb0: 13 57 47 00  	srli	a4, a4, 4
   16eb4: 33 66 c5 00  	or	a2, a0, a2
   16eb8: 23 80 cb 00  	sb	a2, 0(s7)
   16ebc: 6f f0 df ea  	j	0x16d68 <printf_core+0x4f8>
   16ec0: 83 36 01 05  	ld	a3, 80(sp)
   16ec4: 93 0b f1 09  	addi	s7, sp, 159
   16ec8: 13 87 0b 00  	mv	a4, s7
   16ecc: 63 90 06 02  	bnez	a3, 0x16eec <printf_core+0x67c>
   16ed0: 93 76 8d 00  	andi	a3, s10, 8
   16ed4: 93 8e 09 00  	mv	t4, s3
   16ed8: e3 88 06 ea  	beqz	a3, 0x16d88 <printf_core+0x518>
   16edc: 33 07 77 41  	sub	a4, a4, s7
   16ee0: e3 44 57 eb  	blt	a4, s5, 0x16d88 <printf_core+0x518>
   16ee4: 9b 0a 17 00  	addiw	s5, a4, 1
   16ee8: 6f f0 1f ea  	j	0x16d88 <printf_core+0x518>
   16eec: 13 f6 76 00  	andi	a2, a3, 7
   16ef0: 93 8b fb ff  	addi	s7, s7, -1
   16ef4: 1b 06 06 03  	addiw	a2, a2, 48
   16ef8: 23 80 cb 00  	sb	a2, 0(s7)
   16efc: 93 d6 36 00  	srli	a3, a3, 3
   16f00: 6f f0 df fc  	j	0x16ecc <printf_core+0x65c>
   16f04: 03 37 01 05  	ld	a4, 80(sp)
   16f08: 63 5c 07 02  	bgez	a4, 0x16f40 <printf_core+0x6d0>
   16f0c: 33 07 e0 40  	neg	a4, a4
   16f10: 23 38 e1 04  	sd	a4, 80(sp)
   16f14: 93 0c 10 00  	li	s9, 1
   16f18: 93 8e 09 00  	mv	t4, s3
   16f1c: 03 35 01 05  	ld	a0, 80(sp)
   16f20: 93 05 f1 09  	addi	a1, sp, 159
   16f24: 23 34 d1 03  	sd	t4, 40(sp)
   16f28: 23 30 e1 03  	sd	t5, 32(sp)
   16f2c: ef e0 8f f4  	jal	0x15674 <fmt_u>
   16f30: 83 3e 81 02  	ld	t4, 40(sp)
   16f34: 03 3f 01 02  	ld	t5, 32(sp)
   16f38: 93 0b 05 00  	mv	s7, a0
   16f3c: 6f f0 df e4  	j	0x16d88 <printf_core+0x518>
   16f40: 13 57 bd 00  	srli	a4, s10, 11
   16f44: 13 77 17 00  	andi	a4, a4, 1
   16f48: 63 1e 07 00  	bnez	a4, 0x16f64 <printf_core+0x6f4>
   16f4c: 13 77 1d 00  	andi	a4, s10, 1
   16f50: e3 04 07 fc  	beqz	a4, 0x16f18 <printf_core+0x6a8>
   16f54: b7 ce 01 00  	lui	t4, 28
   16f58: 93 0c 10 00  	li	s9, 1
   16f5c: 93 8e ae 90  	addi	t4, t4, -1782
   16f60: 6f f0 df fb  	j	0x16f1c <printf_core+0x6ac>
   16f64: b7 ce 01 00  	lui	t4, 28
   16f68: 93 0c 10 00  	li	s9, 1
   16f6c: 93 8e 9e 90  	addi	t4, t4, -1783
   16f70: 6f f0 df fa  	j	0x16f1c <printf_core+0x6ac>
   16f74: 03 37 01 05  	ld	a4, 80(sp)
   16f78: 93 8e 09 00  	mv	t4, s3
   16f7c: 93 0a 10 00  	li	s5, 1
   16f80: 23 0f e1 08  	sb	a4, 158(sp)
   16f84: 37 07 ff ff  	lui	a4, 1048560
   16f88: 13 07 f7 ff  	addi	a4, a4, -1
   16f8c: 33 7d ed 00  	and	s10, s10, a4
   16f90: 13 06 f1 09  	addi	a2, sp, 159
   16f94: 93 0b e1 09  	addi	s7, sp, 158
   16f98: 6f f0 df e2  	j	0x16dc4 <printf_core+0x554>
   16f9c: ef a0 4f e8  	jal	0x11620 <__errno_location>
   16fa0: 03 25 05 00  	lw	a0, 0(a0)
   16fa4: ef a0 4f ed  	jal	0x11678 <strerror>
   16fa8: 93 0b 05 00  	mv	s7, a0
   16fac: 93 85 0a 00  	mv	a1, s5
   16fb0: 63 d6 0a 00  	bgez	s5, 0x16fbc <printf_core+0x74c>
   16fb4: b7 05 00 80  	lui	a1, 524288
   16fb8: 93 c5 f5 ff  	not	a1, a1
   16fbc: 13 85 0b 00  	mv	a0, s7
   16fc0: ef 00 00 38  	jal	0x17340 <strnlen>
   16fc4: 33 86 ab 00  	add	a2, s7, a0
   16fc8: 63 d6 0a 00  	bgez	s5, 0x16fd4 <printf_core+0x764>
   16fcc: 03 47 06 00  	lbu	a4, 0(a2)
   16fd0: 63 1e 07 0c  	bnez	a4, 0x170ac <printf_core+0x83c>
   16fd4: 37 07 ff ff  	lui	a4, 1048560
   16fd8: 13 07 f7 ff  	addi	a4, a4, -1
   16fdc: 9b 0a 05 00  	sext.w	s5, a0
   16fe0: 33 7d ed 00  	and	s10, s10, a4
   16fe4: 93 8e 09 00  	mv	t4, s3
   16fe8: 6f f0 df dd  	j	0x16dc4 <printf_core+0x554>
   16fec: 83 3b 01 05  	ld	s7, 80(sp)
   16ff0: e3 9e 0b fa  	bnez	s7, 0x16fac <printf_core+0x73c>
   16ff4: 37 ce 01 00  	lui	t3, 28
   16ff8: 93 0b 8e 91  	addi	s7, t3, -1768
   16ffc: 6f f0 1f fb  	j	0x16fac <printf_core+0x73c>
   17000: 03 37 01 05  	ld	a4, 80(sp)
   17004: 23 26 01 04  	sw	zero, 76(sp)
   17008: 93 0a f0 ff  	li	s5, -1
   1700c: 23 24 e1 04  	sw	a4, 72(sp)
   17010: 13 07 81 04  	addi	a4, sp, 72
   17014: 23 38 e1 04  	sd	a4, 80(sp)
   17018: 83 3d 01 05  	ld	s11, 80(sp)
   1701c: 93 0c 00 00  	li	s9, 0
   17020: 63 f2 5c 03  	bgeu	s9, s5, 0x17044 <printf_core+0x7d4>
   17024: 83 a5 0d 00  	lw	a1, 0(s11)
   17028: 63 8e 05 00  	beqz	a1, 0x17044 <printf_core+0x7d4>
   1702c: 13 05 81 03  	addi	a0, sp, 56
   17030: 93 8d 4d 00  	addi	s11, s11, 4
   17034: ef 00 90 19  	jal	0x179cc <wctomb>
   17038: e3 48 05 b0  	bltz	a0, 0x16b48 <printf_core+0x2d8>
   1703c: 33 87 9a 41  	sub	a4, s5, s9
   17040: 63 7c a7 06  	bgeu	a4, a0, 0x170b8 <printf_core+0x848>
   17044: 37 07 00 80  	lui	a4, 524288
   17048: 13 47 f7 ff  	not	a4, a4
   1704c: 63 60 97 07  	bltu	a4, s9, 0x170ac <printf_core+0x83c>
   17050: 9b 8d 0c 00  	sext.w	s11, s9
   17054: 13 07 0d 00  	mv	a4, s10
   17058: 93 86 0d 00  	mv	a3, s11
   1705c: 13 86 04 00  	mv	a2, s1
   17060: 93 05 00 02  	li	a1, 32
   17064: 13 05 04 00  	mv	a0, s0
   17068: ef e0 4f ec  	jal	0x1572c <pad>
   1706c: 83 3b 01 05  	ld	s7, 80(sp)
   17070: 93 0a 00 00  	li	s5, 0
   17074: 63 e6 9a 05  	bltu	s5, s9, 0x170c0 <printf_core+0x850>
   17078: 37 27 00 00  	lui	a4, 2
   1707c: 33 47 ed 00  	xor	a4, s10, a4
   17080: 93 86 0d 00  	mv	a3, s11
   17084: 13 86 04 00  	mv	a2, s1
   17088: 93 05 00 02  	li	a1, 32
   1708c: 13 05 04 00  	mv	a0, s0
   17090: ef e0 cf e9  	jal	0x1572c <pad>
   17094: 13 83 04 00  	mv	t1, s1
   17098: 63 d4 b4 01  	bge	s1, s11, 0x170a0 <printf_core+0x830>
   1709c: 13 83 0d 00  	mv	t1, s11
   170a0: 9b 0c 03 00  	sext.w	s9, t1
   170a4: 83 37 81 00  	ld	a5, 8(sp)
   170a8: e3 d0 97 85  	bge	a5, s9, 0x168e8 <printf_core+0x78>
   170ac: ef a0 4f d7  	jal	0x11620 <__errno_location>
   170b0: 93 07 b0 04  	li	a5, 75
   170b4: 6f f0 1f a9  	j	0x16b44 <printf_core+0x2d4>
   170b8: b3 8c ac 00  	add	s9, s9, a0
   170bc: 6f f0 5f f6  	j	0x17020 <printf_core+0x7b0>
   170c0: 83 a5 0b 00  	lw	a1, 0(s7)
   170c4: e3 8a 05 fa  	beqz	a1, 0x17078 <printf_core+0x808>
   170c8: 13 05 81 03  	addi	a0, sp, 56
   170cc: ef 00 10 10  	jal	0x179cc <wctomb>
   170d0: b3 8a aa 00  	add	s5, s5, a0
   170d4: 93 8b 4b 00  	addi	s7, s7, 4
   170d8: 13 06 05 00  	mv	a2, a0
   170dc: e3 ee 5c f9  	bltu	s9, s5, 0x17078 <printf_core+0x808>
   170e0: 93 05 81 03  	addi	a1, sp, 56
   170e4: 13 05 04 00  	mv	a0, s0
   170e8: ef e0 0f e2  	jal	0x15708 <out>
   170ec: 6f f0 9f f8  	j	0x17074 <printf_core+0x804>
   170f0: 63 04 0f 00  	beqz	t5, 0x170f8 <printf_core+0x888>
   170f4: e3 cc 0a fa  	bltz	s5, 0x170ac <printf_core+0x83c>
   170f8: 83 35 01 05  	ld	a1, 80(sp)
   170fc: 03 36 81 05  	ld	a2, 88(sp)
   17100: 93 07 0d 00  	mv	a5, s10
   17104: 13 87 0a 00  	mv	a4, s5
   17108: 93 86 04 00  	mv	a3, s1
   1710c: 13 05 04 00  	mv	a0, s0
   17110: ef e0 4f ec  	jal	0x157d4 <fmt_fp>
   17114: 93 0c 05 00  	mv	s9, a0
   17118: e3 56 05 f8  	bgez	a0, 0x170a4 <printf_core+0x834>
   1711c: 6f f0 1f f9  	j	0x170ac <printf_core+0x83c>
   17120: 93 8e 09 00  	mv	t4, s3
   17124: 13 06 f1 09  	addi	a2, sp, 159
   17128: 6f f0 df c9  	j	0x16dc4 <printf_core+0x554>
   1712c: 93 0b 06 00  	mv	s7, a2
   17130: 6f f0 5f c9  	j	0x16dc4 <printf_core+0x554>
   17134: e3 18 04 ae  	bnez	s0, 0x16c24 <printf_core+0x3b4>
   17138: e3 04 0c ae  	beqz	s8, 0x16c20 <printf_core+0x3b0>
   1713c: 13 04 10 00  	li	s0, 1
   17140: 93 04 a0 00  	li	s1, 10
   17144: 93 17 24 00  	slli	a5, s0, 2
   17148: b3 07 fb 00  	add	a5, s6, a5
   1714c: 83 a5 07 00  	lw	a1, 0(a5)
   17150: 63 92 05 02  	bnez	a1, 0x17174 <printf_core+0x904>
   17154: 13 07 a0 00  	li	a4, 10
   17158: 93 17 24 00  	slli	a5, s0, 2
   1715c: b3 07 fb 00  	add	a5, s6, a5
   17160: 83 a7 07 00  	lw	a5, 0(a5)
   17164: e3 9c 07 9c  	bnez	a5, 0x16b3c <printf_core+0x2cc>
   17168: 13 04 14 00  	addi	s0, s0, 1
   1716c: e3 16 e4 fe  	bne	s0, a4, 0x17158 <printf_core+0x8e8>
   17170: 6f 00 00 02  	j	0x17190 <printf_core+0x920>
   17174: 83 37 01 00  	ld	a5, 0(sp)
   17178: 13 15 44 00  	slli	a0, s0, 4
   1717c: 13 06 0a 00  	mv	a2, s4
   17180: 33 85 a7 00  	add	a0, a5, a0
   17184: 13 04 14 00  	addi	s0, s0, 1
   17188: ef e0 8f be  	jal	0x15570 <pop_arg>
   1718c: e3 1c 94 fa  	bne	s0, s1, 0x17144 <printf_core+0x8d4>
   17190: 13 09 10 00  	li	s2, 1
   17194: 6f f0 1f a9  	j	0x16c24 <printf_core+0x3b4>

0000000000017198 <vfprintf>:
   17198: 13 01 01 ea  	addi	sp, sp, -352
   1719c: 23 38 81 14  	sd	s0, 336(sp)
   171a0: 23 30 c1 00  	sd	a2, 0(sp)
   171a4: 13 04 05 00  	mv	s0, a0
   171a8: 13 07 81 00  	addi	a4, sp, 8
   171ac: 93 06 01 08  	addi	a3, sp, 128
   171b0: 13 06 01 00  	mv	a2, sp
   171b4: 13 05 00 00  	li	a0, 0
   171b8: 23 34 91 14  	sd	s1, 328(sp)
   171bc: 23 34 51 13  	sd	s5, 296(sp)
   171c0: 23 3c 11 14  	sd	ra, 344(sp)
   171c4: 23 30 21 15  	sd	s2, 320(sp)
   171c8: 23 3c 31 13  	sd	s3, 312(sp)
   171cc: 23 38 41 13  	sd	s4, 304(sp)
   171d0: 93 8a 05 00  	mv	s5, a1
   171d4: 23 34 01 00  	sd	zero, 8(sp)
   171d8: 23 38 01 00  	sd	zero, 16(sp)
   171dc: 23 3c 01 00  	sd	zero, 24(sp)
   171e0: 23 30 01 02  	sd	zero, 32(sp)
   171e4: 23 34 01 02  	sd	zero, 40(sp)
   171e8: ef f0 8f e8  	jal	0x16870 <printf_core>
   171ec: 93 04 f0 ff  	li	s1, -1
   171f0: 63 44 05 0e  	bltz	a0, 0x172d8 <vfprintf+0x140>
   171f4: 83 27 c4 08  	lw	a5, 140(s0)
   171f8: 93 09 00 00  	li	s3, 0
   171fc: 9b 87 07 00  	sext.w	a5, a5
   17200: 63 c8 07 00  	bltz	a5, 0x17210 <vfprintf+0x78>
   17204: 13 05 04 00  	mv	a0, s0
   17208: ef c0 4f af  	jal	0x134fc <__lockfile>
   1720c: 93 09 05 00  	mv	s3, a0
   17210: 83 27 04 00  	lw	a5, 0(s0)
   17214: 03 27 84 08  	lw	a4, 136(s0)
   17218: 13 fa 07 02  	andi	s4, a5, 32
   1721c: 63 46 e0 00  	bgtz	a4, 0x17228 <vfprintf+0x90>
   17220: 93 f7 f7 fd  	andi	a5, a5, -33
   17224: 23 20 f4 00  	sw	a5, 0(s0)
   17228: 83 37 04 06  	ld	a5, 96(s0)
   1722c: 63 9a 07 0c  	bnez	a5, 0x17300 <vfprintf+0x168>
   17230: 93 07 01 03  	addi	a5, sp, 48
   17234: 03 39 84 05  	ld	s2, 88(s0)
   17238: 23 3c f4 04  	sd	a5, 88(s0)
   1723c: 93 07 00 05  	li	a5, 80
   17240: 23 30 f4 06  	sd	a5, 96(s0)
   17244: 23 30 04 02  	sd	zero, 32(s0)
   17248: 23 3c 04 02  	sd	zero, 56(s0)
   1724c: 23 34 04 02  	sd	zero, 40(s0)
   17250: 13 05 04 00  	mv	a0, s0
   17254: ef e0 4f ac  	jal	0x15518 <__towrite>
   17258: 93 04 f0 ff  	li	s1, -1
   1725c: 63 10 05 02  	bnez	a0, 0x1727c <vfprintf+0xe4>
   17260: 13 07 81 00  	addi	a4, sp, 8
   17264: 93 06 01 08  	addi	a3, sp, 128
   17268: 13 06 01 00  	mv	a2, sp
   1726c: 93 85 0a 00  	mv	a1, s5
   17270: 13 05 04 00  	mv	a0, s0
   17274: ef f0 cf df  	jal	0x16870 <printf_core>
   17278: 93 04 05 00  	mv	s1, a0
   1727c: 63 0c 09 02  	beqz	s2, 0x172b4 <vfprintf+0x11c>
   17280: 83 37 84 04  	ld	a5, 72(s0)
   17284: 13 06 00 00  	li	a2, 0
   17288: 93 05 00 00  	li	a1, 0
   1728c: 13 05 04 00  	mv	a0, s0
   17290: e7 80 07 00  	jalr	a5
   17294: 83 37 84 02  	ld	a5, 40(s0)
   17298: 63 94 07 00  	bnez	a5, 0x172a0 <vfprintf+0x108>
   1729c: 93 04 f0 ff  	li	s1, -1
   172a0: 23 3c 24 05  	sd	s2, 88(s0)
   172a4: 23 30 04 06  	sd	zero, 96(s0)
   172a8: 23 30 04 02  	sd	zero, 32(s0)
   172ac: 23 3c 04 02  	sd	zero, 56(s0)
   172b0: 23 34 04 02  	sd	zero, 40(s0)
   172b4: 83 27 04 00  	lw	a5, 0(s0)
   172b8: 13 f7 07 02  	andi	a4, a5, 32
   172bc: 63 04 07 00  	beqz	a4, 0x172c4 <vfprintf+0x12c>
   172c0: 93 04 f0 ff  	li	s1, -1
   172c4: 33 6a fa 00  	or	s4, s4, a5
   172c8: 23 20 44 01  	sw	s4, 0(s0)
   172cc: 63 86 09 00  	beqz	s3, 0x172d8 <vfprintf+0x140>
   172d0: 13 05 04 00  	mv	a0, s0
   172d4: ef c0 cf af  	jal	0x135d0 <__unlockfile>
   172d8: 83 30 81 15  	ld	ra, 344(sp)
   172dc: 03 34 01 15  	ld	s0, 336(sp)
   172e0: 03 39 01 14  	ld	s2, 320(sp)
   172e4: 83 39 81 13  	ld	s3, 312(sp)
   172e8: 03 3a 01 13  	ld	s4, 304(sp)
   172ec: 83 3a 81 12  	ld	s5, 296(sp)
   172f0: 13 85 04 00  	mv	a0, s1
   172f4: 83 34 81 14  	ld	s1, 328(sp)
   172f8: 13 01 01 16  	addi	sp, sp, 352
   172fc: 67 80 00 00  	ret
   17300: 03 39 04 02  	ld	s2, 32(s0)
   17304: e3 06 09 f4  	beqz	s2, 0x17250 <vfprintf+0xb8>
   17308: 13 09 00 00  	li	s2, 0
   1730c: 6f f0 5f f5  	j	0x17260 <vfprintf+0xc8>

0000000000017310 <memrchr>:
   17310: 93 07 05 00  	mv	a5, a0
   17314: 93 f5 f5 0f  	andi	a1, a1, 255
   17318: 33 06 c5 00  	add	a2, a0, a2
   1731c: 63 96 c7 00  	bne	a5, a2, 0x17328 <memrchr+0x18>
   17320: 13 05 00 00  	li	a0, 0
   17324: 67 80 00 00  	ret
   17328: 83 46 f6 ff  	lbu	a3, -1(a2)
   1732c: 13 07 f6 ff  	addi	a4, a2, -1
   17330: 13 05 07 00  	mv	a0, a4
   17334: e3 88 b6 fe  	beq	a3, a1, 0x17324 <memrchr+0x14>
   17338: 13 06 07 00  	mv	a2, a4
   1733c: 6f f0 1f fe  	j	0x1731c <memrchr+0xc>

0000000000017340 <strnlen>:
   17340: 13 01 01 fe  	addi	sp, sp, -32
   17344: 23 38 81 00  	sd	s0, 16(sp)
   17348: 13 86 05 00  	mv	a2, a1
   1734c: 13 84 05 00  	mv	s0, a1
   17350: 93 05 00 00  	li	a1, 0
   17354: 23 34 91 00  	sd	s1, 8(sp)
   17358: 23 3c 11 00  	sd	ra, 24(sp)
   1735c: 93 04 05 00  	mv	s1, a0
   17360: ef 00 80 79  	jal	0x17af8 <memchr>
   17364: 63 04 05 00  	beqz	a0, 0x1736c <strnlen+0x2c>
   17368: 33 04 95 40  	sub	s0, a0, s1
   1736c: 83 30 81 01  	ld	ra, 24(sp)
   17370: 13 05 04 00  	mv	a0, s0
   17374: 03 34 01 01  	ld	s0, 16(sp)
   17378: 83 34 81 00  	ld	s1, 8(sp)
   1737c: 13 01 01 02  	addi	sp, sp, 32
   17380: 67 80 00 00  	ret

0000000000017384 <pthread_setcancelstate>:
   17384: 93 07 20 00  	li	a5, 2
   17388: 63 e4 a7 02  	bltu	a5, a0, 0x173b0 <pthread_setcancelstate+0x2c>
   1738c: 13 07 02 00  	mv	a4, tp
   17390: 63 88 05 00  	beqz	a1, 0x173a0 <pthread_setcancelstate+0x1c>
   17394: 83 47 87 f6  	lbu	a5, -152(a4)
   17398: 93 f7 f7 0f  	andi	a5, a5, 255
   1739c: 23 a0 f5 00  	sw	a5, 0(a1)
   173a0: 13 75 f5 0f  	andi	a0, a0, 255
   173a4: 23 04 a7 f6  	sb	a0, -152(a4)
   173a8: 13 05 00 00  	li	a0, 0
   173ac: 67 80 00 00  	ret
   173b0: 13 05 60 01  	li	a0, 22
   173b4: 67 80 00 00  	ret

00000000000173b8 <__set_thread_area>:
   173b8: 13 02 05 00  	mv	tp, a0
   173bc: 13 05 00 00  	li	a0, 0
   173c0: 67 80 00 00  	ret

00000000000173c4 <sem_destroy>:
   173c4: 13 05 00 00  	li	a0, 0
   173c8: 67 80 00 00  	ret

00000000000173cc <sem_init>:
   173cc: 63 54 06 02  	bgez	a2, 0x173f4 <sem_init+0x28>
   173d0: 13 01 01 ff  	addi	sp, sp, -16
   173d4: 23 34 11 00  	sd	ra, 8(sp)
   173d8: ef a0 8f a4  	jal	0x11620 <__errno_location>
   173dc: 83 30 81 00  	ld	ra, 8(sp)
   173e0: 93 07 60 01  	li	a5, 22
   173e4: 23 20 f5 00  	sw	a5, 0(a0)
   173e8: 13 05 f0 ff  	li	a0, -1
   173ec: 13 01 01 01  	addi	sp, sp, 16
   173f0: 67 80 00 00  	ret
   173f4: 23 20 c5 00  	sw	a2, 0(a0)
   173f8: 93 b5 15 00  	seqz	a1, a1
   173fc: 23 22 05 00  	sw	zero, 4(a0)
   17400: 93 95 75 00  	slli	a1, a1, 7
   17404: 23 24 b5 00  	sw	a1, 8(a0)
   17408: 13 05 00 00  	li	a0, 0
   1740c: 67 80 00 00  	ret

0000000000017410 <sem_post>:
   17410: 83 25 85 00  	lw	a1, 8(a0)
   17414: 37 08 00 80  	lui	a6, 524288
   17418: 93 07 05 00  	mv	a5, a0
   1741c: 9b 85 05 00  	sext.w	a1, a1
   17420: 13 48 f8 ff  	not	a6, a6
   17424: 03 a7 07 00  	lw	a4, 0(a5)
   17428: 03 a6 47 00  	lw	a2, 4(a5)
   1742c: 1b 07 07 00  	sext.w	a4, a4
   17430: 1b 06 06 00  	sext.w	a2, a2
   17434: 63 14 07 03  	bne	a4, a6, 0x1745c <sem_post+0x4c>
   17438: 13 01 01 ff  	addi	sp, sp, -16
   1743c: 23 34 11 00  	sd	ra, 8(sp)
   17440: ef a0 0f 9e  	jal	0x11620 <__errno_location>
   17444: 83 30 81 00  	ld	ra, 8(sp)
   17448: 93 07 b0 04  	li	a5, 75
   1744c: 23 20 f5 00  	sw	a5, 0(a0)
   17450: 13 05 f0 ff  	li	a0, -1
   17454: 13 01 01 01  	addi	sp, sp, 16
   17458: 67 80 00 00  	ret
   1745c: 9b 06 17 00  	addiw	a3, a4, 1
   17460: 1b 55 f7 01  	srliw	a0, a4, 31
   17464: bb 86 a6 00  	addw	a3, a3, a0
   17468: 2f a5 07 16  	<unknown>
   1746c: 63 16 e5 00  	bne	a0, a4, 0x17478 <sem_post+0x68>
   17470: af a8 d7 1e  	<unknown>
   17474: e3 9a 08 fe  	bnez	a7, 0x17468 <sem_post+0x58>
   17478: 9b 06 05 00  	sext.w	a3, a0
   1747c: e3 14 d7 fa  	bne	a4, a3, 0x17424 <sem_post+0x14>
   17480: 63 48 07 00  	bltz	a4, 0x17490 <sem_post+0x80>
   17484: 63 16 06 00  	bnez	a2, 0x17490 <sem_post+0x80>
   17488: 13 05 00 00  	li	a0, 0
   1748c: 67 80 00 00  	ret
   17490: 63 84 05 00  	beqz	a1, 0x17498 <sem_post+0x88>
   17494: 93 05 00 08  	li	a1, 128
   17498: 93 08 20 06  	li	a7, 98
   1749c: 13 85 07 00  	mv	a0, a5
   174a0: 93 e5 15 00  	ori	a1, a1, 1
   174a4: 13 06 10 00  	li	a2, 1
   174a8: 73 00 00 00  	ecall	
   174ac: 13 07 a0 fd  	li	a4, -38
   174b0: e3 1c e5 fc  	bne	a0, a4, 0x17488 <sem_post+0x78>
   174b4: 13 85 07 00  	mv	a0, a5
   174b8: 93 05 10 00  	li	a1, 1
   174bc: 73 00 00 00  	ecall	
   174c0: 6f f0 9f fc  	j	0x17488 <sem_post+0x78>

00000000000174c4 <sem_wait>:
   174c4: 93 05 00 00  	li	a1, 0
   174c8: 6f 00 40 73  	j	0x17bfc <sem_timedwait>

00000000000174cc <__map_file>:
   174cc: 13 01 01 f6  	addi	sp, sp, -160
   174d0: 93 07 05 00  	mv	a5, a0
   174d4: 37 96 08 00  	lui	a2, 137
   174d8: 23 34 91 08  	sd	s1, 136(sp)
   174dc: 23 3c 11 08  	sd	ra, 152(sp)
   174e0: 93 84 05 00  	mv	s1, a1
   174e4: 23 38 81 08  	sd	s0, 144(sp)
   174e8: 93 08 80 03  	li	a7, 56
   174ec: 13 05 c0 f9  	li	a0, -100
   174f0: 93 85 07 00  	mv	a1, a5
   174f4: 13 06 06 80  	addi	a2, a2, -2048
   174f8: 73 00 00 00  	ecall	
   174fc: ef a0 0f a9  	jal	0x1178c <__syscall_ret>
   17500: 1b 04 05 00  	sext.w	s0, a0
   17504: 63 50 04 02  	bgez	s0, 0x17524 <__map_file+0x58>
   17508: 93 07 00 00  	li	a5, 0
   1750c: 83 30 81 09  	ld	ra, 152(sp)
   17510: 03 34 01 09  	ld	s0, 144(sp)
   17514: 83 34 81 08  	ld	s1, 136(sp)
   17518: 13 85 07 00  	mv	a0, a5
   1751c: 13 01 01 0a  	addi	sp, sp, 160
   17520: 67 80 00 00  	ret
   17524: 93 08 00 05  	li	a7, 80
   17528: 13 05 04 00  	mv	a0, s0
   1752c: 93 05 01 00  	mv	a1, sp
   17530: 73 00 00 00  	ecall	
   17534: ef a0 8f a5  	jal	0x1178c <__syscall_ret>
   17538: 93 07 f0 ff  	li	a5, -1
   1753c: 63 14 05 02  	bnez	a0, 0x17564 <__map_file+0x98>
   17540: 83 35 01 03  	ld	a1, 48(sp)
   17544: 93 07 00 00  	li	a5, 0
   17548: 13 07 04 00  	mv	a4, s0
   1754c: 93 06 10 00  	li	a3, 1
   17550: 13 06 10 00  	li	a2, 1
   17554: ef b0 9f 9c  	jal	0x12f1c <mmap64>
   17558: 03 37 01 03  	ld	a4, 48(sp)
   1755c: 93 07 05 00  	mv	a5, a0
   17560: 23 b0 e4 00  	sd	a4, 0(s1)
   17564: 93 08 90 03  	li	a7, 57
   17568: 13 05 04 00  	mv	a0, s0
   1756c: 73 00 00 00  	ecall	
   17570: 13 07 f0 ff  	li	a4, -1
   17574: e3 9c e7 f8  	bne	a5, a4, 0x1750c <__map_file+0x40>
   17578: 6f f0 1f f9  	j	0x17508 <__map_file+0x3c>

000000000001757c <lseek64>:
   1757c: 93 08 e0 03  	li	a7, 62
   17580: 73 00 00 00  	ecall	
   17584: 6f a0 8f a0  	j	0x1178c <__syscall_ret>

0000000000017588 <getenv>:
   17588: 13 01 01 fd  	addi	sp, sp, -48
   1758c: 93 05 d0 03  	li	a1, 61
   17590: 23 3c 91 00  	sd	s1, 24(sp)
   17594: 23 38 21 01  	sd	s2, 16(sp)
   17598: 23 34 11 02  	sd	ra, 40(sp)
   1759c: 13 09 05 00  	mv	s2, a0
   175a0: 23 30 81 02  	sd	s0, 32(sp)
   175a4: 23 34 31 01  	sd	s3, 8(sp)
   175a8: ef c0 5f bd  	jal	0x1417c <strchrnul>
   175ac: b3 04 25 41  	sub	s1, a0, s2
   175b0: 63 12 25 03  	bne	a0, s2, 0x175d4 <getenv+0x4c>
   175b4: 13 05 00 00  	li	a0, 0
   175b8: 83 30 81 02  	ld	ra, 40(sp)
   175bc: 03 34 01 02  	ld	s0, 32(sp)
   175c0: 83 34 81 01  	ld	s1, 24(sp)
   175c4: 03 39 01 01  	ld	s2, 16(sp)
   175c8: 83 39 81 00  	ld	s3, 8(sp)
   175cc: 13 01 01 03  	addi	sp, sp, 48
   175d0: 67 80 00 00  	ret
   175d4: 83 47 05 00  	lbu	a5, 0(a0)
   175d8: e3 9e 07 fc  	bnez	a5, 0x175b4 <getenv+0x2c>
   175dc: 03 b4 01 a3  	ld	s0, -1488(gp)
   175e0: 93 09 d0 03  	li	s3, 61
   175e4: e3 08 04 fc  	beqz	s0, 0x175b4 <getenv+0x2c>
   175e8: 83 35 04 00  	ld	a1, 0(s0)
   175ec: e3 84 05 fc  	beqz	a1, 0x175b4 <getenv+0x2c>
   175f0: 13 86 04 00  	mv	a2, s1
   175f4: 13 05 09 00  	mv	a0, s2
   175f8: ef 00 40 59  	jal	0x17b8c <strncmp>
   175fc: 63 10 05 02  	bnez	a0, 0x1761c <getenv+0x94>
   17600: 83 37 04 00  	ld	a5, 0(s0)
   17604: 33 87 97 00  	add	a4, a5, s1
   17608: 03 47 07 00  	lbu	a4, 0(a4)
   1760c: 63 18 37 01  	bne	a4, s3, 0x1761c <getenv+0x94>
   17610: 13 85 14 00  	addi	a0, s1, 1
   17614: 33 85 a7 00  	add	a0, a5, a0
   17618: 6f f0 1f fa  	j	0x175b8 <getenv+0x30>
   1761c: 13 04 84 00  	addi	s0, s0, 8
   17620: 6f f0 9f fc  	j	0x175e8 <getenv+0x60>

0000000000017624 <swapc>:
   17624: 63 8c 05 02  	beqz	a1, 0x1765c <swapc+0x38>
   17628: 1b 17 85 01  	slliw	a4, a0, 24
   1762c: 9b 57 85 01  	srliw	a5, a0, 24
   17630: b7 06 01 00  	lui	a3, 16
   17634: b3 e7 e7 00  	or	a5, a5, a4
   17638: 93 86 06 f0  	addi	a3, a3, -256
   1763c: 1b 57 85 00  	srliw	a4, a0, 8
   17640: 33 77 d7 00  	and	a4, a4, a3
   17644: b3 e7 e7 00  	or	a5, a5, a4
   17648: 1b 15 85 00  	slliw	a0, a0, 8
   1764c: 37 07 ff 00  	lui	a4, 4080
   17650: 33 75 e5 00  	and	a0, a0, a4
   17654: 33 e5 a7 00  	or	a0, a5, a0
   17658: 1b 05 05 00  	sext.w	a0, a0
   1765c: 67 80 00 00  	ret

0000000000017660 <__mo_lookup>:
   17660: 13 01 01 f7  	addi	sp, sp, -144
   17664: 23 30 41 07  	sd	s4, 96(sp)
   17668: 03 2a 05 00  	lw	s4, 0(a0)
   1766c: b7 f7 fb 6a  	lui	a5, 438207
   17670: 9b 87 27 d2  	addiw	a5, a5, -734
   17674: 23 30 81 08  	sd	s0, 128(sp)
   17678: 13 04 05 00  	mv	s0, a0
   1767c: 03 25 85 00  	lw	a0, 8(a0)
   17680: 3b 0a fa 00  	addw	s4, s4, a5
   17684: 23 34 31 07  	sd	s3, 104(sp)
   17688: 93 89 05 00  	mv	s3, a1
   1768c: 93 05 0a 00  	mv	a1, s4
   17690: 23 34 11 08  	sd	ra, 136(sp)
   17694: 23 3c 91 03  	sd	s9, 56(sp)
   17698: 23 38 c1 00  	sd	a2, 16(sp)
   1769c: 23 3c 91 06  	sd	s1, 120(sp)
   176a0: 23 38 21 07  	sd	s2, 112(sp)
   176a4: 23 3c 51 05  	sd	s5, 88(sp)
   176a8: 23 38 61 05  	sd	s6, 80(sp)
   176ac: 23 34 71 05  	sd	s7, 72(sp)
   176b0: 23 30 81 05  	sd	s8, 64(sp)
   176b4: 23 38 a1 03  	sd	s10, 48(sp)
   176b8: 23 34 b1 03  	sd	s11, 40(sp)
   176bc: ef f0 9f f6  	jal	0x17624 <swapc>
   176c0: 9b 0c 05 00  	sext.w	s9, a0
   176c4: 03 25 c4 00  	lw	a0, 12(s0)
   176c8: 93 05 0a 00  	mv	a1, s4
   176cc: ef f0 9f f5  	jal	0x17624 <swapc>
   176d0: 93 96 0c 02  	slli	a3, s9, 32
   176d4: 93 d6 06 02  	srli	a3, a3, 32
   176d8: 93 d7 29 00  	srli	a5, s3, 2
   176dc: 63 f8 f6 16  	bgeu	a3, a5, 0x1784c <__mo_lookup+0x1ec>
   176e0: 9b 94 2c 00  	slliw	s1, s9, 2
   176e4: 9b 0a 05 00  	sext.w	s5, a0
   176e8: 93 94 04 02  	slli	s1, s1, 32
   176ec: 93 d4 04 02  	srli	s1, s1, 32
   176f0: 93 97 0a 02  	slli	a5, s5, 32
   176f4: b3 84 99 40  	sub	s1, s3, s1
   176f8: 93 d7 07 02  	srli	a5, a5, 32
   176fc: 63 f8 97 14  	bgeu	a5, s1, 0x1784c <__mo_lookup+0x1ec>
   17700: 03 25 04 01  	lw	a0, 16(s0)
   17704: 93 05 0a 00  	mv	a1, s4
   17708: ef f0 df f1  	jal	0x17624 <swapc>
   1770c: 1b 09 05 00  	sext.w	s2, a0
   17710: 13 15 05 02  	slli	a0, a0, 32
   17714: 13 55 05 02  	srli	a0, a0, 32
   17718: 63 7a 95 12  	bgeu	a0, s1, 0x1784c <__mo_lookup+0x1ec>
   1771c: b3 e6 2a 01  	or	a3, s5, s2
   17720: 13 fb 36 00  	andi	s6, a3, 3
   17724: 63 14 0b 12  	bnez	s6, 0x1784c <__mo_lookup+0x1ec>
   17728: 9b da 2a 00  	srliw	s5, s5, 2
   1772c: 13 0d 10 00  	li	s10, 1
   17730: 1b dc 1c 00  	srliw	s8, s9, 1
   17734: bb 07 6c 01  	addw	a5, s8, s6
   17738: 9b 9d 17 00  	slliw	s11, a5, 1
   1773c: bb 84 5d 01  	addw	s1, s11, s5
   17740: 23 34 f1 00  	sd	a5, 8(sp)
   17744: 93 97 04 02  	slli	a5, s1, 32
   17748: 93 d7 e7 01  	srli	a5, a5, 30
   1774c: b3 07 f4 00  	add	a5, s0, a5
   17750: 03 a5 07 00  	lw	a0, 0(a5)
   17754: 9b 84 14 00  	addiw	s1, s1, 1
   17758: 93 94 04 02  	slli	s1, s1, 32
   1775c: 93 05 0a 00  	mv	a1, s4
   17760: 93 d4 e4 01  	srli	s1, s1, 30
   17764: ef f0 1f ec  	jal	0x17624 <swapc>
   17768: b3 04 94 00  	add	s1, s0, s1
   1776c: 9b 07 05 00  	sext.w	a5, a0
   17770: 03 a5 04 00  	lw	a0, 0(s1)
   17774: 93 05 0a 00  	mv	a1, s4
   17778: 23 3c f1 00  	sd	a5, 24(sp)
   1777c: ef f0 9f ea  	jal	0x17624 <swapc>
   17780: 93 15 05 02  	slli	a1, a0, 32
   17784: 93 d5 05 02  	srli	a1, a1, 32
   17788: 9b db 1c 00  	srliw	s7, s9, 1
   1778c: 1b 08 05 00  	sext.w	a6, a0
   17790: 63 fe 35 0b  	bgeu	a1, s3, 0x1784c <__mo_lookup+0x1ec>
   17794: 83 37 81 01  	ld	a5, 24(sp)
   17798: 33 85 b9 40  	sub	a0, s3, a1
   1779c: 13 96 07 02  	slli	a2, a5, 32
   177a0: 13 56 06 02  	srli	a2, a2, 32
   177a4: 63 74 a6 0a  	bgeu	a2, a0, 0x1784c <__mo_lookup+0x1ec>
   177a8: bb 87 07 01  	addw	a5, a5, a6
   177ac: 93 97 07 02  	slli	a5, a5, 32
   177b0: 93 d7 07 02  	srli	a5, a5, 32
   177b4: b3 07 f4 00  	add	a5, s0, a5
   177b8: 83 c7 07 00  	lbu	a5, 0(a5)
   177bc: 63 98 07 08  	bnez	a5, 0x1784c <__mo_lookup+0x1ec>
   177c0: 03 35 01 01  	ld	a0, 16(sp)
   177c4: b3 05 b4 00  	add	a1, s0, a1
   177c8: ef c0 9f a5  	jal	0x14220 <strcmp>
   177cc: 63 10 05 0c  	bnez	a0, 0x1788c <__mo_lookup+0x22c>
   177d0: 1b 59 29 00  	srliw	s2, s2, 2
   177d4: bb 0d b9 01  	addw	s11, s2, s11
   177d8: 93 97 0d 02  	slli	a5, s11, 32
   177dc: 93 d7 e7 01  	srli	a5, a5, 30
   177e0: b3 07 f4 00  	add	a5, s0, a5
   177e4: 03 a5 07 00  	lw	a0, 0(a5)
   177e8: 9b 8d 1d 00  	addiw	s11, s11, 1
   177ec: 93 9d 0d 02  	slli	s11, s11, 32
   177f0: 93 05 0a 00  	mv	a1, s4
   177f4: 93 dd ed 01  	srli	s11, s11, 30
   177f8: ef f0 df e2  	jal	0x17624 <swapc>
   177fc: b3 0d b4 01  	add	s11, s0, s11
   17800: 9b 04 05 00  	sext.w	s1, a0
   17804: 03 a5 0d 00  	lw	a0, 0(s11)
   17808: 93 05 0a 00  	mv	a1, s4
   1780c: ef f0 9f e1  	jal	0x17624 <swapc>
   17810: 1b 07 05 00  	sext.w	a4, a0
   17814: 13 15 05 02  	slli	a0, a0, 32
   17818: 13 55 05 02  	srli	a0, a0, 32
   1781c: 63 78 35 03  	bgeu	a0, s3, 0x1784c <__mo_lookup+0x1ec>
   17820: 93 97 04 02  	slli	a5, s1, 32
   17824: 93 d7 07 02  	srli	a5, a5, 32
   17828: b3 89 a9 40  	sub	s3, s3, a0
   1782c: 63 f0 37 03  	bgeu	a5, s3, 0x1784c <__mo_lookup+0x1ec>
   17830: bb 84 e4 00  	addw	s1, s1, a4
   17834: 93 94 04 02  	slli	s1, s1, 32
   17838: 93 d4 04 02  	srli	s1, s1, 32
   1783c: b3 04 94 00  	add	s1, s0, s1
   17840: 83 c7 04 00  	lbu	a5, 0(s1)
   17844: 33 05 a4 00  	add	a0, s0, a0
   17848: 63 84 07 00  	beqz	a5, 0x17850 <__mo_lookup+0x1f0>
   1784c: 13 05 00 00  	li	a0, 0
   17850: 83 30 81 08  	ld	ra, 136(sp)
   17854: 03 34 01 08  	ld	s0, 128(sp)
   17858: 83 34 81 07  	ld	s1, 120(sp)
   1785c: 03 39 01 07  	ld	s2, 112(sp)
   17860: 83 39 81 06  	ld	s3, 104(sp)
   17864: 03 3a 01 06  	ld	s4, 96(sp)
   17868: 83 3a 81 05  	ld	s5, 88(sp)
   1786c: 03 3b 01 05  	ld	s6, 80(sp)
   17870: 83 3b 81 04  	ld	s7, 72(sp)
   17874: 03 3c 01 04  	ld	s8, 64(sp)
   17878: 83 3c 81 03  	ld	s9, 56(sp)
   1787c: 03 3d 01 03  	ld	s10, 48(sp)
   17880: 83 3d 81 02  	ld	s11, 40(sp)
   17884: 13 01 01 09  	addi	sp, sp, 144
   17888: 67 80 00 00  	ret
   1788c: e3 80 ac fd  	beq	s9, s10, 0x1784c <__mo_lookup+0x1ec>
   17890: 63 46 05 00  	bltz	a0, 0x1789c <__mo_lookup+0x23c>
   17894: 03 3b 81 00  	ld	s6, 8(sp)
   17898: bb 8b 8c 41  	subw	s7, s9, s8
   1789c: 93 8c 0b 00  	mv	s9, s7
   178a0: 6f f0 1f e9  	j	0x17730 <__mo_lookup+0xd0>

00000000000178a4 <__fpclassifyl>:
   178a4: 37 87 00 00  	lui	a4, 8
   178a8: 93 d6 05 03  	srli	a3, a1, 48
   178ac: 13 07 f7 ff  	addi	a4, a4, -1
   178b0: 93 95 05 01  	slli	a1, a1, 16
   178b4: b3 f6 e6 00  	and	a3, a3, a4
   178b8: 93 07 05 00  	mv	a5, a0
   178bc: 93 d5 05 01  	srli	a1, a1, 16
   178c0: 63 9a 06 00  	bnez	a3, 0x178d4 <__fpclassifyl+0x30>
   178c4: b3 e5 a5 00  	or	a1, a1, a0
   178c8: 33 35 b0 00  	snez	a0, a1
   178cc: 13 05 25 00  	addi	a0, a0, 2
   178d0: 67 80 00 00  	ret
   178d4: 13 05 40 00  	li	a0, 4
   178d8: 63 96 e6 00  	bne	a3, a4, 0x178e4 <__fpclassifyl+0x40>
   178dc: b3 e5 f5 00  	or	a1, a1, a5
   178e0: 13 b5 15 00  	seqz	a0, a1
   178e4: 67 80 00 00  	ret

00000000000178e8 <__signbitl>:
   178e8: 13 d5 f5 03  	srli	a0, a1, 63
   178ec: 67 80 00 00  	ret

00000000000178f0 <frexpl>:
   178f0: 37 87 00 00  	lui	a4, 8
   178f4: 13 01 01 fe  	addi	sp, sp, -32
   178f8: 93 d7 05 03  	srli	a5, a1, 48
   178fc: 13 07 f7 ff  	addi	a4, a4, -1
   17900: 23 38 81 00  	sd	s0, 16(sp)
   17904: 23 34 91 00  	sd	s1, 8(sp)
   17908: 23 30 21 01  	sd	s2, 0(sp)
   1790c: 23 3c 11 00  	sd	ra, 24(sp)
   17910: 13 09 06 00  	mv	s2, a2
   17914: 33 f6 e7 00  	and	a2, a5, a4
   17918: 93 04 05 00  	mv	s1, a0
   1791c: 13 84 05 00  	mv	s0, a1
   17920: 63 16 06 06  	bnez	a2, 0x1798c <frexpl+0x9c>
   17924: 93 06 00 00  	li	a3, 0
   17928: ef 10 40 31  	jal	0x18c3c <__netf2>
   1792c: 63 0c 05 04  	beqz	a0, 0x17984 <frexpl+0x94>
   17930: b7 c7 01 00  	lui	a5, 28
   17934: 83 b6 87 d3  	ld	a3, -712(a5)
   17938: 13 06 00 00  	li	a2, 0
   1793c: 13 85 04 00  	mv	a0, s1
   17940: 93 05 04 00  	mv	a1, s0
   17944: ef 10 80 3c  	jal	0x18d0c <__multf3>
   17948: 13 06 09 00  	mv	a2, s2
   1794c: ef f0 5f fa  	jal	0x178f0 <frexpl>
   17950: 83 27 09 00  	lw	a5, 0(s2)
   17954: 93 04 05 00  	mv	s1, a0
   17958: 13 84 05 00  	mv	s0, a1
   1795c: 9b 87 87 f8  	addiw	a5, a5, -120
   17960: 23 20 f9 00  	sw	a5, 0(s2)
   17964: 83 30 81 01  	ld	ra, 24(sp)
   17968: 93 05 04 00  	mv	a1, s0
   1796c: 03 34 01 01  	ld	s0, 16(sp)
   17970: 03 39 01 00  	ld	s2, 0(sp)
   17974: 13 85 04 00  	mv	a0, s1
   17978: 83 34 81 00  	ld	s1, 8(sp)
   1797c: 13 01 01 02  	addi	sp, sp, 32
   17980: 67 80 00 00  	ret
   17984: 23 20 09 00  	sw	zero, 0(s2)
   17988: 6f f0 df fd  	j	0x17964 <frexpl+0x74>
   1798c: 9b 06 06 00  	sext.w	a3, a2
   17990: e3 0a e6 fc  	beq	a2, a4, 0x17964 <frexpl+0x74>
   17994: 37 c7 ff ff  	lui	a4, 1048572
   17998: 1b 07 27 00  	addiw	a4, a4, 2
   1799c: 3b 87 e6 00  	addw	a4, a3, a4
   179a0: 23 20 e9 00  	sw	a4, 0(s2)
   179a4: 37 87 ff ff  	lui	a4, 1048568
   179a8: b3 f7 e7 00  	and	a5, a5, a4
   179ac: 37 47 00 00  	lui	a4, 4
   179b0: 13 07 e7 ff  	addi	a4, a4, -2
   179b4: b3 e7 e7 00  	or	a5, a5, a4
   179b8: 13 94 05 01  	slli	s0, a1, 16
   179bc: 93 97 07 03  	slli	a5, a5, 48
   179c0: 13 54 04 01  	srli	s0, s0, 16
   179c4: 33 64 f4 00  	or	s0, s0, a5
   179c8: 6f f0 df f9  	j	0x17964 <frexpl+0x74>

00000000000179cc <wctomb>:
   179cc: 63 02 05 02  	beqz	a0, 0x179f0 <wctomb+0x24>
   179d0: 13 01 01 ff  	addi	sp, sp, -16
   179d4: 13 06 00 00  	li	a2, 0
   179d8: 23 34 11 00  	sd	ra, 8(sp)
   179dc: ef 00 80 3a  	jal	0x17d84 <wcrtomb>
   179e0: 83 30 81 00  	ld	ra, 8(sp)
   179e4: 1b 05 05 00  	sext.w	a0, a0
   179e8: 13 01 01 01  	addi	sp, sp, 16
   179ec: 67 80 00 00  	ret
   179f0: 13 05 00 00  	li	a0, 0
   179f4: 67 80 00 00  	ret

00000000000179f8 <__restore_rt>:
   179f8: 93 08 b0 08  	li	a7, 139
   179fc: 73 00 00 00  	ecall	

0000000000017a00 <close_file>:
   17a00: 63 00 05 08  	beqz	a0, 0x17a80 <close_file+0x80>
   17a04: 83 27 c5 08  	lw	a5, 140(a0)
   17a08: 13 01 01 ff  	addi	sp, sp, -16
   17a0c: 23 30 81 00  	sd	s0, 0(sp)
   17a10: 23 34 11 00  	sd	ra, 8(sp)
   17a14: 9b 87 07 00  	sext.w	a5, a5
   17a18: 13 04 05 00  	mv	s0, a0
   17a1c: 63 c4 07 00  	bltz	a5, 0x17a24 <close_file+0x24>
   17a20: ef b0 df ad  	jal	0x134fc <__lockfile>
   17a24: 03 37 84 02  	ld	a4, 40(s0)
   17a28: 83 37 84 03  	ld	a5, 56(s0)
   17a2c: 63 0c f7 00  	beq	a4, a5, 0x17a44 <close_file+0x44>
   17a30: 83 37 84 04  	ld	a5, 72(s0)
   17a34: 13 06 00 00  	li	a2, 0
   17a38: 93 05 00 00  	li	a1, 0
   17a3c: 13 05 04 00  	mv	a0, s0
   17a40: e7 80 07 00  	jalr	a5
   17a44: 83 35 84 00  	ld	a1, 8(s0)
   17a48: 83 37 04 01  	ld	a5, 16(s0)
   17a4c: 63 82 f5 02  	beq	a1, a5, 0x17a70 <close_file+0x70>
   17a50: 03 37 04 05  	ld	a4, 80(s0)
   17a54: 13 05 04 00  	mv	a0, s0
   17a58: 03 34 01 00  	ld	s0, 0(sp)
   17a5c: 83 30 81 00  	ld	ra, 8(sp)
   17a60: 13 06 10 00  	li	a2, 1
   17a64: b3 85 f5 40  	sub	a1, a1, a5
   17a68: 13 01 01 01  	addi	sp, sp, 16
   17a6c: 67 00 07 00  	jr	a4
   17a70: 83 30 81 00  	ld	ra, 8(sp)
   17a74: 03 34 01 00  	ld	s0, 0(sp)
   17a78: 13 01 01 01  	addi	sp, sp, 16
   17a7c: 67 80 00 00  	ret
   17a80: 67 80 00 00  	ret

0000000000017a84 <__stdio_exit_needed>:
   17a84: 13 01 01 ff  	addi	sp, sp, -16
   17a88: 23 30 81 00  	sd	s0, 0(sp)
   17a8c: 23 34 11 00  	sd	ra, 8(sp)
   17a90: ef 00 00 04  	jal	0x17ad0 <__ofl_lock>
   17a94: 03 34 05 00  	ld	s0, 0(a0)
   17a98: 63 14 04 02  	bnez	s0, 0x17ac0 <__stdio_exit_needed+0x3c>
   17a9c: 03 b5 81 a7  	ld	a0, -1416(gp)
   17aa0: ef f0 1f f6  	jal	0x17a00 <close_file>
   17aa4: 03 b5 81 a7  	ld	a0, -1416(gp)
   17aa8: ef f0 9f f5  	jal	0x17a00 <close_file>
   17aac: 03 34 01 00  	ld	s0, 0(sp)
   17ab0: 83 30 81 00  	ld	ra, 8(sp)
   17ab4: 03 b5 01 99  	ld	a0, -1648(gp)
   17ab8: 13 01 01 01  	addi	sp, sp, 16
   17abc: 6f f0 5f f4  	j	0x17a00 <close_file>
   17ac0: 13 05 04 00  	mv	a0, s0
   17ac4: ef f0 df f3  	jal	0x17a00 <close_file>
   17ac8: 03 34 04 07  	ld	s0, 112(s0)
   17acc: 6f f0 df fc  	j	0x17a98 <__stdio_exit_needed+0x14>

0000000000017ad0 <__ofl_lock>:
   17ad0: 13 01 01 ff  	addi	sp, sp, -16
   17ad4: 13 85 81 a8  	addi	a0, gp, -1400
   17ad8: 23 34 11 00  	sd	ra, 8(sp)
   17adc: ef c0 5f 83  	jal	0x14310 <__lock>
   17ae0: 83 30 81 00  	ld	ra, 8(sp)
   17ae4: 13 85 01 a8  	addi	a0, gp, -1408
   17ae8: 13 01 01 01  	addi	sp, sp, 16
   17aec: 67 80 00 00  	ret

0000000000017af0 <__ofl_unlock>:
   17af0: 13 85 81 a8  	addi	a0, gp, -1400
   17af4: 6f c0 5f 91  	j	0x14408 <__unlock>

0000000000017af8 <memchr>:
   17af8: 93 f5 f5 0f  	andi	a1, a1, 255
   17afc: 93 77 75 00  	andi	a5, a0, 7
   17b00: 63 88 07 02  	beqz	a5, 0x17b30 <memchr+0x38>
   17b04: 63 00 06 08  	beqz	a2, 0x17b84 <memchr+0x8c>
   17b08: 83 47 05 00  	lbu	a5, 0(a0)
   17b0c: 63 9c b7 00  	bne	a5, a1, 0x17b24 <memchr+0x2c>
   17b10: 33 06 c5 00  	add	a2, a0, a2
   17b14: 63 08 c5 06  	beq	a0, a2, 0x17b84 <memchr+0x8c>
   17b18: 83 47 05 00  	lbu	a5, 0(a0)
   17b1c: 63 90 b7 06  	bne	a5, a1, 0x17b7c <memchr+0x84>
   17b20: 67 80 00 00  	ret
   17b24: 13 05 15 00  	addi	a0, a0, 1
   17b28: 13 06 f6 ff  	addi	a2, a2, -1
   17b2c: 6f f0 1f fd  	j	0x17afc <memchr+0x4>
   17b30: 63 0a 06 04  	beqz	a2, 0x17b84 <memchr+0x8c>
   17b34: 83 47 05 00  	lbu	a5, 0(a0)
   17b38: e3 8c b7 fc  	beq	a5, a1, 0x17b10 <memchr+0x18>
   17b3c: 83 b6 01 93  	ld	a3, -1744(gp)
   17b40: 83 b8 81 93  	ld	a7, -1736(gp)
   17b44: b3 86 d5 02  	<unknown>
   17b48: 03 b8 01 94  	ld	a6, -1728(gp)
   17b4c: 13 03 70 00  	li	t1, 7
   17b50: e3 70 c3 fc  	bgeu	t1, a2, 0x17b10 <memchr+0x18>
   17b54: 83 37 05 00  	ld	a5, 0(a0)
   17b58: b3 c7 f6 00  	xor	a5, a3, a5
   17b5c: 33 87 17 01  	add	a4, a5, a7
   17b60: 93 c7 f7 ff  	not	a5, a5
   17b64: b3 77 f7 00  	and	a5, a4, a5
   17b68: b3 f7 07 01  	and	a5, a5, a6
   17b6c: e3 92 07 fa  	bnez	a5, 0x17b10 <memchr+0x18>
   17b70: 13 05 85 00  	addi	a0, a0, 8
   17b74: 13 06 86 ff  	addi	a2, a2, -8
   17b78: 6f f0 9f fd  	j	0x17b50 <memchr+0x58>
   17b7c: 13 05 15 00  	addi	a0, a0, 1
   17b80: 6f f0 5f f9  	j	0x17b14 <memchr+0x1c>
   17b84: 13 05 00 00  	li	a0, 0
   17b88: 67 80 00 00  	ret

0000000000017b8c <strncmp>:
   17b8c: 63 0c 06 02  	beqz	a2, 0x17bc4 <strncmp+0x38>
   17b90: 13 06 f6 ff  	addi	a2, a2, -1
   17b94: 13 07 00 00  	li	a4, 0
   17b98: b3 07 e5 00  	add	a5, a0, a4
   17b9c: 83 c7 07 00  	lbu	a5, 0(a5)
   17ba0: b3 86 e5 00  	add	a3, a1, a4
   17ba4: 83 c6 06 00  	lbu	a3, 0(a3)
   17ba8: 63 8a 07 00  	beqz	a5, 0x17bbc <strncmp+0x30>
   17bac: 63 88 06 00  	beqz	a3, 0x17bbc <strncmp+0x30>
   17bb0: 63 06 e6 00  	beq	a2, a4, 0x17bbc <strncmp+0x30>
   17bb4: 13 07 17 00  	addi	a4, a4, 1
   17bb8: e3 80 d7 fe  	beq	a5, a3, 0x17b98 <strncmp+0xc>
   17bbc: 3b 85 d7 40  	subw	a0, a5, a3
   17bc0: 67 80 00 00  	ret
   17bc4: 13 05 00 00  	li	a0, 0
   17bc8: 67 80 00 00  	ret

0000000000017bcc <a_fetch_add.isra.0>:
   17bcc: 83 27 05 00  	lw	a5, 0(a0)
   17bd0: 9b 86 07 00  	sext.w	a3, a5
   17bd4: bb 87 b7 00  	addw	a5, a5, a1
   17bd8: 2f 27 05 16  	<unknown>
   17bdc: 63 16 d7 00  	bne	a4, a3, 0x17be8 <a_fetch_add.isra.0+0x1c>
   17be0: 2f 26 f5 1e  	<unknown>
   17be4: e3 1a 06 fe  	bnez	a2, 0x17bd8 <a_fetch_add.isra.0+0xc>
   17be8: 9b 07 07 00  	sext.w	a5, a4
   17bec: e3 90 f6 fe  	bne	a3, a5, 0x17bcc <a_fetch_add.isra.0>
   17bf0: 67 80 00 00  	ret

0000000000017bf4 <cleanup>:
   17bf4: 93 05 f0 ff  	li	a1, -1
   17bf8: 6f f0 5f fd  	j	0x17bcc <a_fetch_add.isra.0>

0000000000017bfc <sem_timedwait>:
   17bfc: 13 01 01 fa  	addi	sp, sp, -96
   17c00: 23 3c 11 04  	sd	ra, 88(sp)
   17c04: 23 38 81 04  	sd	s0, 80(sp)
   17c08: 23 30 21 05  	sd	s2, 64(sp)
   17c0c: 13 04 05 00  	mv	s0, a0
   17c10: 13 89 05 00  	mv	s2, a1
   17c14: 23 34 91 04  	sd	s1, 72(sp)
   17c18: 23 3c 31 03  	sd	s3, 56(sp)
   17c1c: 23 38 41 03  	sd	s4, 48(sp)
   17c20: 23 34 51 03  	sd	s5, 40(sp)
   17c24: 23 30 61 03  	sd	s6, 32(sp)
   17c28: ef 00 c0 4a  	jal	0x180d4 <pthread_testcancel>
   17c2c: 13 05 04 00  	mv	a0, s0
   17c30: ef 00 40 0e  	jal	0x17d14 <sem_trywait>
   17c34: 13 07 50 06  	li	a4, 101
   17c38: 63 1a 05 02  	bnez	a0, 0x17c6c <sem_timedwait+0x70>
   17c3c: 13 05 00 00  	li	a0, 0
   17c40: 83 30 81 05  	ld	ra, 88(sp)
   17c44: 03 34 01 05  	ld	s0, 80(sp)
   17c48: 83 34 81 04  	ld	s1, 72(sp)
   17c4c: 03 39 01 04  	ld	s2, 64(sp)
   17c50: 83 39 81 03  	ld	s3, 56(sp)
   17c54: 03 3a 01 03  	ld	s4, 48(sp)
   17c58: 83 3a 81 02  	ld	s5, 40(sp)
   17c5c: 03 3b 01 02  	ld	s6, 32(sp)
   17c60: 13 01 01 06  	addi	sp, sp, 96
   17c64: 67 80 00 00  	ret
   17c68: 0f 00 30 03  	fence	rw, rw
   17c6c: 1b 07 f7 ff  	addiw	a4, a4, -1
   17c70: 63 0e 07 00  	beqz	a4, 0x17c8c <sem_timedwait+0x90>
   17c74: 83 27 04 00  	lw	a5, 0(s0)
   17c78: 9b 87 07 00  	sext.w	a5, a5
   17c7c: 63 48 f0 00  	bgtz	a5, 0x17c8c <sem_timedwait+0x90>
   17c80: 83 27 44 00  	lw	a5, 4(s0)
   17c84: 9b 87 07 00  	sext.w	a5, a5
   17c88: e3 80 07 fe  	beqz	a5, 0x17c68 <sem_timedwait+0x6c>
   17c8c: 93 09 44 00  	addi	s3, s0, 4
   17c90: 13 0a 00 00  	li	s4, 0
   17c94: 93 0a f0 ff  	li	s5, -1
   17c98: 37 8b 01 00  	lui	s6, 24
   17c9c: 13 05 04 00  	mv	a0, s0
   17ca0: ef 00 40 07  	jal	0x17d14 <sem_trywait>
   17ca4: e3 0c 05 f8  	beqz	a0, 0x17c3c <sem_timedwait+0x40>
   17ca8: 93 05 10 00  	li	a1, 1
   17cac: 13 85 09 00  	mv	a0, s3
   17cb0: ef f0 df f1  	jal	0x17bcc <a_fetch_add.isra.0>
   17cb4: af 27 04 16  	<unknown>
   17cb8: 63 96 47 01  	bne	a5, s4, 0x17cc4 <sem_timedwait+0xc8>
   17cbc: 2f 27 54 1f  	<unknown>
   17cc0: e3 1a 07 fe  	bnez	a4, 0x17cb4 <sem_timedwait+0xb8>
   17cc4: 13 86 09 00  	mv	a2, s3
   17cc8: 93 05 4b bf  	addi	a1, s6, -1036
   17ccc: 13 05 81 00  	addi	a0, sp, 8
   17cd0: ef 00 40 3a  	jal	0x18074 <_pthread_cleanup_push>
   17cd4: 03 27 84 00  	lw	a4, 8(s0)
   17cd8: 93 05 f0 ff  	li	a1, -1
   17cdc: 93 06 09 00  	mv	a3, s2
   17ce0: 1b 07 07 00  	sext.w	a4, a4
   17ce4: 13 06 00 00  	li	a2, 0
   17ce8: 13 05 04 00  	mv	a0, s0
   17cec: ef 00 80 1c  	jal	0x17eb4 <__timedwait_cp>
   17cf0: 93 04 05 00  	mv	s1, a0
   17cf4: 93 05 10 00  	li	a1, 1
   17cf8: 13 05 81 00  	addi	a0, sp, 8
   17cfc: ef 00 40 38  	jal	0x18080 <_pthread_cleanup_pop>
   17d00: e3 8e 04 f8  	beqz	s1, 0x17c9c <sem_timedwait+0xa0>
   17d04: ef 90 df 91  	jal	0x11620 <__errno_location>
   17d08: 23 20 95 00  	sw	s1, 0(a0)
   17d0c: 13 05 f0 ff  	li	a0, -1
   17d10: 6f f0 1f f3  	j	0x17c40 <sem_timedwait+0x44>

0000000000017d14 <sem_trywait>:
   17d14: 13 06 10 00  	li	a2, 1
   17d18: 83 27 05 00  	lw	a5, 0(a0)
   17d1c: 9b 87 07 00  	sext.w	a5, a5
   17d20: 63 44 f0 02  	bgtz	a5, 0x17d48 <sem_trywait+0x34>
   17d24: 13 01 01 ff  	addi	sp, sp, -16
   17d28: 23 34 11 00  	sd	ra, 8(sp)
   17d2c: ef 90 5f 8f  	jal	0x11620 <__errno_location>
   17d30: 83 30 81 00  	ld	ra, 8(sp)
   17d34: 93 07 b0 00  	li	a5, 11
   17d38: 23 20 f5 00  	sw	a5, 0(a0)
   17d3c: 13 05 f0 ff  	li	a0, -1
   17d40: 13 01 01 01  	addi	sp, sp, 16
   17d44: 67 80 00 00  	ret
   17d48: 9b 86 f7 ff  	addiw	a3, a5, -1
   17d4c: 13 07 00 00  	li	a4, 0
   17d50: 63 98 c7 00  	bne	a5, a2, 0x17d60 <sem_trywait+0x4c>
   17d54: 03 27 45 00  	lw	a4, 4(a0)
   17d58: 1b 07 07 00  	sext.w	a4, a4
   17d5c: 33 37 e0 00  	snez	a4, a4
   17d60: 3b 87 e6 40  	subw	a4, a3, a4
   17d64: af 26 05 16  	<unknown>
   17d68: 63 96 f6 00  	bne	a3, a5, 0x17d74 <sem_trywait+0x60>
   17d6c: af 25 e5 1e  	<unknown>
   17d70: e3 9a 05 fe  	bnez	a1, 0x17d64 <sem_trywait+0x50>
   17d74: 1b 87 06 00  	sext.w	a4, a3
   17d78: e3 90 e7 fa  	bne	a5, a4, 0x17d18 <sem_trywait+0x4>
   17d7c: 13 05 00 00  	li	a0, 0
   17d80: 67 80 00 00  	ret

0000000000017d84 <wcrtomb>:
   17d84: 63 0a 05 00  	beqz	a0, 0x17d98 <wcrtomb+0x14>
   17d88: 93 06 f0 07  	li	a3, 127
   17d8c: 9b 87 05 00  	sext.w	a5, a1
   17d90: 63 e2 b6 02  	bltu	a3, a1, 0x17db4 <wcrtomb+0x30>
   17d94: 23 00 b5 00  	sb	a1, 0(a0)
   17d98: 13 05 10 00  	li	a0, 1
   17d9c: 67 80 00 00  	ret
   17da0: 23 00 b5 00  	sb	a1, 0(a0)
   17da4: 13 05 10 00  	li	a0, 1
   17da8: 83 30 81 00  	ld	ra, 8(sp)
   17dac: 13 01 01 01  	addi	sp, sp, 16
   17db0: 67 80 00 00  	ret
   17db4: 13 01 01 ff  	addi	sp, sp, -16
   17db8: 23 34 11 00  	sd	ra, 8(sp)
   17dbc: 13 07 02 00  	mv	a4, tp
   17dc0: 03 37 07 fd  	ld	a4, -48(a4)
   17dc4: 03 37 07 00  	ld	a4, 0(a4)
   17dc8: 63 14 07 02  	bnez	a4, 0x17df0 <wcrtomb+0x6c>
   17dcc: 37 27 ff ff  	lui	a4, 1048562
   17dd0: 1b 07 07 08  	addiw	a4, a4, 128
   17dd4: bb 07 f7 00  	addw	a5, a4, a5
   17dd8: e3 f4 f6 fc  	bgeu	a3, a5, 0x17da0 <wcrtomb+0x1c>
   17ddc: ef 90 5f 84  	jal	0x11620 <__errno_location>
   17de0: 93 07 40 05  	li	a5, 84
   17de4: 23 20 f5 00  	sw	a5, 0(a0)
   17de8: 13 05 f0 ff  	li	a0, -1
   17dec: 6f f0 df fb  	j	0x17da8 <wcrtomb+0x24>
   17df0: 13 07 f0 7f  	li	a4, 2047
   17df4: 63 62 f7 02  	bltu	a4, a5, 0x17e18 <wcrtomb+0x94>
   17df8: 9b d7 65 40  	sraiw	a5, a1, 6
   17dfc: 93 f5 f5 03  	andi	a1, a1, 63
   17e00: 93 e7 07 fc  	ori	a5, a5, -64
   17e04: 93 e5 05 f8  	ori	a1, a1, -128
   17e08: 23 00 f5 00  	sb	a5, 0(a0)
   17e0c: a3 00 b5 00  	sb	a1, 1(a0)
   17e10: 13 05 20 00  	li	a0, 2
   17e14: 6f f0 5f f9  	j	0x17da8 <wcrtomb+0x24>
   17e18: 37 d7 00 00  	lui	a4, 13
   17e1c: 13 07 f7 7f  	addi	a4, a4, 2047
   17e20: 63 7a f7 00  	bgeu	a4, a5, 0x17e34 <wcrtomb+0xb0>
   17e24: 37 27 ff ff  	lui	a4, 1048562
   17e28: 3b 07 f7 00  	addw	a4, a4, a5
   17e2c: b7 26 00 00  	lui	a3, 2
   17e30: 63 7a d7 02  	bgeu	a4, a3, 0x17e64 <wcrtomb+0xe0>
   17e34: 9b d7 c5 40  	sraiw	a5, a1, 12
   17e38: 93 e7 07 fe  	ori	a5, a5, -32
   17e3c: 23 00 f5 00  	sb	a5, 0(a0)
   17e40: 9b d7 65 40  	sraiw	a5, a1, 6
   17e44: 93 f7 f7 03  	andi	a5, a5, 63
   17e48: 93 f5 f5 03  	andi	a1, a1, 63
   17e4c: 93 e7 07 f8  	ori	a5, a5, -128
   17e50: 93 e5 05 f8  	ori	a1, a1, -128
   17e54: a3 00 f5 00  	sb	a5, 1(a0)
   17e58: 23 01 b5 00  	sb	a1, 2(a0)
   17e5c: 13 05 30 00  	li	a0, 3
   17e60: 6f f0 9f f4  	j	0x17da8 <wcrtomb+0x24>
   17e64: 37 07 ff ff  	lui	a4, 1048560
   17e68: bb 07 f7 00  	addw	a5, a4, a5
   17e6c: 37 07 10 00  	lui	a4, 256
   17e70: e3 f6 e7 f6  	bgeu	a5, a4, 0x17ddc <wcrtomb+0x58>
   17e74: 9b d7 25 41  	sraiw	a5, a1, 18
   17e78: 93 e7 07 ff  	ori	a5, a5, -16
   17e7c: 23 00 f5 00  	sb	a5, 0(a0)
   17e80: 9b d7 c5 40  	sraiw	a5, a1, 12
   17e84: 93 f7 f7 03  	andi	a5, a5, 63
   17e88: 93 e7 07 f8  	ori	a5, a5, -128
   17e8c: a3 00 f5 00  	sb	a5, 1(a0)
   17e90: 9b d7 65 40  	sraiw	a5, a1, 6
   17e94: 93 f7 f7 03  	andi	a5, a5, 63
   17e98: 93 f5 f5 03  	andi	a1, a1, 63
   17e9c: 93 e7 07 f8  	ori	a5, a5, -128
   17ea0: 93 e5 05 f8  	ori	a1, a1, -128
   17ea4: 23 01 f5 00  	sb	a5, 2(a0)
   17ea8: a3 01 b5 00  	sb	a1, 3(a0)
   17eac: 13 05 40 00  	li	a0, 4
   17eb0: 6f f0 9f ef  	j	0x17da8 <wcrtomb+0x24>

0000000000017eb4 <__timedwait_cp>:
   17eb4: 13 01 01 fc  	addi	sp, sp, -64
   17eb8: 23 38 81 02  	sd	s0, 48(sp)
   17ebc: 23 34 91 02  	sd	s1, 40(sp)
   17ec0: 23 30 21 03  	sd	s2, 32(sp)
   17ec4: 23 3c 31 01  	sd	s3, 24(sp)
   17ec8: 23 3c 11 02  	sd	ra, 56(sp)
   17ecc: 23 38 41 01  	sd	s4, 16(sp)
   17ed0: 93 04 05 00  	mv	s1, a0
   17ed4: 13 89 05 00  	mv	s2, a1
   17ed8: 13 05 06 00  	mv	a0, a2
   17edc: 13 84 06 00  	mv	s0, a3
   17ee0: 93 09 00 08  	li	s3, 128
   17ee4: 63 14 07 00  	bnez	a4, 0x17eec <__timedwait_cp+0x38>
   17ee8: 93 09 07 00  	mv	s3, a4
   17eec: 63 06 04 08  	beqz	s0, 0x17f78 <__timedwait_cp+0xc4>
   17ef0: 03 37 84 00  	ld	a4, 8(s0)
   17ef4: 37 da 9a 3b  	lui	s4, 244141
   17ef8: 93 07 fa 9f  	addi	a5, s4, -1537
   17efc: 63 f4 e7 02  	bgeu	a5, a4, 0x17f24 <__timedwait_cp+0x70>
   17f00: 13 05 60 01  	li	a0, 22
   17f04: 83 30 81 03  	ld	ra, 56(sp)
   17f08: 03 34 01 03  	ld	s0, 48(sp)
   17f0c: 83 34 81 02  	ld	s1, 40(sp)
   17f10: 03 39 01 02  	ld	s2, 32(sp)
   17f14: 83 39 81 01  	ld	s3, 24(sp)
   17f18: 03 3a 01 01  	ld	s4, 16(sp)
   17f1c: 13 01 01 04  	addi	sp, sp, 64
   17f20: 67 80 00 00  	ret
   17f24: 93 05 01 00  	mv	a1, sp
   17f28: ef 00 00 1b  	jal	0x180d8 <clock_gettime>
   17f2c: e3 1a 05 fc  	bnez	a0, 0x17f00 <__timedwait_cp+0x4c>
   17f30: 83 37 01 00  	ld	a5, 0(sp)
   17f34: 03 38 04 00  	ld	a6, 0(s0)
   17f38: 03 37 81 00  	ld	a4, 8(sp)
   17f3c: 33 08 f8 40  	sub	a6, a6, a5
   17f40: 83 37 84 00  	ld	a5, 8(s0)
   17f44: 23 30 01 01  	sd	a6, 0(sp)
   17f48: b3 87 e7 40  	sub	a5, a5, a4
   17f4c: 23 34 f1 00  	sd	a5, 8(sp)
   17f50: 63 dc 07 00  	bgez	a5, 0x17f68 <__timedwait_cp+0xb4>
   17f54: 13 0a 0a a0  	addi	s4, s4, -1536
   17f58: 13 08 f8 ff  	addi	a6, a6, -1
   17f5c: b3 87 47 01  	add	a5, a5, s4
   17f60: 23 30 01 01  	sd	a6, 0(sp)
   17f64: 23 34 f1 00  	sd	a5, 8(sp)
   17f68: 83 37 01 00  	ld	a5, 0(sp)
   17f6c: 13 05 e0 06  	li	a0, 110
   17f70: e3 ca 07 f8  	bltz	a5, 0x17f04 <__timedwait_cp+0x50>
   17f74: 13 04 01 00  	mv	s0, sp
   17f78: 93 07 00 00  	li	a5, 0
   17f7c: 13 07 04 00  	mv	a4, s0
   17f80: 13 08 00 00  	li	a6, 0
   17f84: 93 06 09 00  	mv	a3, s2
   17f88: 13 86 09 00  	mv	a2, s3
   17f8c: 93 85 04 00  	mv	a1, s1
   17f90: 13 05 20 06  	li	a0, 98
   17f94: ef c0 cf d0  	jal	0x144a0 <__syscall_cp>
   17f98: 9b 07 05 00  	sext.w	a5, a0
   17f9c: 13 07 a0 fd  	li	a4, -38
   17fa0: 63 94 e7 02  	bne	a5, a4, 0x17fc8 <__timedwait_cp+0x114>
   17fa4: 93 07 00 00  	li	a5, 0
   17fa8: 13 08 00 00  	li	a6, 0
   17fac: 13 07 04 00  	mv	a4, s0
   17fb0: 93 06 09 00  	mv	a3, s2
   17fb4: 13 06 00 00  	li	a2, 0
   17fb8: 93 85 04 00  	mv	a1, s1
   17fbc: 13 05 20 06  	li	a0, 98
   17fc0: ef c0 0f ce  	jal	0x144a0 <__syscall_cp>
   17fc4: 9b 07 05 00  	sext.w	a5, a0
   17fc8: 13 07 c0 ff  	li	a4, -4
   17fcc: 63 80 e7 02  	beq	a5, a4, 0x17fec <__timedwait_cp+0x138>
   17fd0: 13 07 20 f9  	li	a4, -110
   17fd4: 63 88 e7 00  	beq	a5, a4, 0x17fe4 <__timedwait_cp+0x130>
   17fd8: 13 07 30 f8  	li	a4, -125
   17fdc: 13 05 00 00  	li	a0, 0
   17fe0: e3 92 e7 f2  	bne	a5, a4, 0x17f04 <__timedwait_cp+0x50>
   17fe4: 3b 05 f0 40  	negw	a0, a5
   17fe8: 6f f0 df f1  	j	0x17f04 <__timedwait_cp+0x50>
   17fec: 03 a5 c1 a5  	lw	a0, -1444(gp)
   17ff0: 1b 05 05 00  	sext.w	a0, a0
   17ff4: e3 08 05 f0  	beqz	a0, 0x17f04 <__timedwait_cp+0x50>
   17ff8: 13 05 40 00  	li	a0, 4
   17ffc: 6f f0 9f f0  	j	0x17f04 <__timedwait_cp+0x50>

0000000000018000 <__timedwait>:
   18000: 13 01 01 fb  	addi	sp, sp, -80
   18004: 23 30 81 04  	sd	s0, 64(sp)
   18008: 23 3c 91 02  	sd	s1, 56(sp)
   1800c: 13 04 05 00  	mv	s0, a0
   18010: 93 84 05 00  	mv	s1, a1
   18014: 13 05 10 00  	li	a0, 1
   18018: 93 05 c1 02  	addi	a1, sp, 44
   1801c: 23 34 11 04  	sd	ra, 72(sp)
   18020: 23 3c c1 00  	sd	a2, 24(sp)
   18024: 23 38 d1 00  	sd	a3, 16(sp)
   18028: 23 34 e1 00  	sd	a4, 8(sp)
   1802c: ef f0 8f b5  	jal	0x17384 <pthread_setcancelstate>
   18030: 03 37 81 00  	ld	a4, 8(sp)
   18034: 83 36 01 01  	ld	a3, 16(sp)
   18038: 03 36 81 01  	ld	a2, 24(sp)
   1803c: 93 85 04 00  	mv	a1, s1
   18040: 13 05 04 00  	mv	a0, s0
   18044: ef f0 1f e7  	jal	0x17eb4 <__timedwait_cp>
   18048: 13 04 05 00  	mv	s0, a0
   1804c: 03 25 c1 02  	lw	a0, 44(sp)
   18050: 93 05 00 00  	li	a1, 0
   18054: ef f0 0f b3  	jal	0x17384 <pthread_setcancelstate>
   18058: 83 30 81 04  	ld	ra, 72(sp)
   1805c: 13 05 04 00  	mv	a0, s0
   18060: 03 34 01 04  	ld	s0, 64(sp)
   18064: 83 34 81 03  	ld	s1, 56(sp)
   18068: 13 01 01 05  	addi	sp, sp, 80
   1806c: 67 80 00 00  	ret

0000000000018070 <dummy>:
   18070: 67 80 00 00  	ret

0000000000018074 <_pthread_cleanup_push>:
   18074: 23 30 b5 00  	sd	a1, 0(a0)
   18078: 23 34 c5 00  	sd	a2, 8(a0)
   1807c: 6f f0 5f ff  	j	0x18070 <dummy>

0000000000018080 <_pthread_cleanup_pop>:
   18080: 13 01 01 fe  	addi	sp, sp, -32
   18084: 23 34 91 00  	sd	s1, 8(sp)
   18088: 93 84 05 00  	mv	s1, a1
   1808c: 23 38 81 00  	sd	s0, 16(sp)
   18090: 23 3c 11 00  	sd	ra, 24(sp)
   18094: 13 04 05 00  	mv	s0, a0
   18098: ef f0 9f fd  	jal	0x18070 <dummy>
   1809c: 63 80 04 02  	beqz	s1, 0x180bc <_pthread_cleanup_pop+0x3c>
   180a0: 83 37 04 00  	ld	a5, 0(s0)
   180a4: 03 35 84 00  	ld	a0, 8(s0)
   180a8: 03 34 01 01  	ld	s0, 16(sp)
   180ac: 83 30 81 01  	ld	ra, 24(sp)
   180b0: 83 34 81 00  	ld	s1, 8(sp)
   180b4: 13 01 01 02  	addi	sp, sp, 32
   180b8: 67 80 07 00  	jr	a5
   180bc: 83 30 81 01  	ld	ra, 24(sp)
   180c0: 03 34 01 01  	ld	s0, 16(sp)
   180c4: 83 34 81 00  	ld	s1, 8(sp)
   180c8: 13 01 01 02  	addi	sp, sp, 32
   180cc: 67 80 00 00  	ret

00000000000180d0 <dummy>:
   180d0: 67 80 00 00  	ret

00000000000180d4 <pthread_testcancel>:
   180d4: 6f f0 df ff  	j	0x180d0 <dummy>

00000000000180d8 <clock_gettime>:
   180d8: 93 07 05 00  	mv	a5, a0
   180dc: 93 08 10 07  	li	a7, 113
   180e0: 73 00 00 00  	ecall	
   180e4: 93 06 a0 fd  	li	a3, -38
   180e8: 1b 05 05 00  	sext.w	a0, a0
   180ec: 63 1c d5 02  	bne	a0, a3, 0x18124 <clock_gettime+0x4c>
   180f0: 13 05 a0 fe  	li	a0, -22
   180f4: 63 98 07 02  	bnez	a5, 0x18124 <clock_gettime+0x4c>
   180f8: 13 87 05 00  	mv	a4, a1
   180fc: 13 85 05 00  	mv	a0, a1
   18100: 93 08 90 0a  	li	a7, 169
   18104: 93 05 00 00  	li	a1, 0
   18108: 73 00 00 00  	ecall	
   1810c: 03 36 87 00  	ld	a2, 8(a4)
   18110: 93 06 80 3e  	li	a3, 1000
   18114: 13 85 07 00  	mv	a0, a5
   18118: bb 86 c6 02  	<unknown>
   1811c: 23 34 d7 00  	sd	a3, 8(a4)
   18120: 67 80 00 00  	ret
   18124: 13 01 01 ff  	addi	sp, sp, -16
   18128: 23 34 11 00  	sd	ra, 8(sp)
   1812c: ef 90 0f e6  	jal	0x1178c <__syscall_ret>
   18130: 83 30 81 00  	ld	ra, 8(sp)
   18134: 9b 07 05 00  	sext.w	a5, a0
   18138: 13 85 07 00  	mv	a0, a5
   1813c: 13 01 01 01  	addi	sp, sp, 16
   18140: 67 80 00 00  	ret

0000000000018144 <__addtf3>:
   18144: 13 01 01 fd  	addi	sp, sp, -48
   18148: 23 34 11 02  	sd	ra, 40(sp)
   1814c: 23 30 81 02  	sd	s0, 32(sp)
   18150: 23 3c 91 00  	sd	s1, 24(sp)
   18154: 23 38 21 01  	sd	s2, 16(sp)
   18158: 23 34 31 01  	sd	s3, 8(sp)
   1815c: 23 30 41 01  	sd	s4, 0(sp)
   18160: f3 24 20 00  	csrr	s1, frm
   18164: 93 0e f0 ff  	li	t4, -1
   18168: 13 d7 0e 01  	srli	a4, t4, 16
   1816c: 13 d4 05 03  	srli	s0, a1, 48
   18170: 13 d9 f5 03  	srli	s2, a1, 63
   18174: b3 f5 e5 00  	and	a1, a1, a4
   18178: 93 95 35 00  	slli	a1, a1, 3
   1817c: 93 57 d5 03  	srli	a5, a0, 61
   18180: 37 83 00 00  	lui	t1, 8
   18184: 13 0e f3 ff  	addi	t3, t1, -1
   18188: b3 e7 b7 00  	or	a5, a5, a1
   1818c: 93 d8 f6 03  	srli	a7, a3, 63
   18190: 93 d5 06 03  	srli	a1, a3, 48
   18194: b3 f6 e6 00  	and	a3, a3, a4
   18198: 93 96 36 00  	slli	a3, a3, 3
   1819c: 13 57 d6 03  	srli	a4, a2, 61
   181a0: 33 74 c4 01  	and	s0, s0, t3
   181a4: b3 f5 c5 01  	and	a1, a1, t3
   181a8: 33 67 d7 00  	or	a4, a4, a3
   181ac: bb 06 b4 40  	subw	a3, s0, a1
   181b0: 9b 84 04 00  	sext.w	s1, s1
   181b4: 13 15 35 00  	slli	a0, a0, 3
   181b8: 13 16 36 00  	slli	a2, a2, 3
   181bc: 1b 88 06 00  	sext.w	a6, a3
   181c0: 63 1a 19 4d  	bne	s2, a7, 0x18694 <__addtf3+0x550>
   181c4: 63 5e 00 13  	blez	a6, 0x18300 <__addtf3+0x1bc>
   181c8: 63 98 05 0a  	bnez	a1, 0x18278 <__addtf3+0x134>
   181cc: b3 65 c7 00  	or	a1, a4, a2
   181d0: 63 92 05 02  	bnez	a1, 0x181f4 <__addtf3+0xb0>
   181d4: 63 1a c4 4d  	bne	s0, t3, 0x186a8 <__addtf3+0x564>
   181d8: 33 e7 a7 00  	or	a4, a5, a0
   181dc: e3 0e 07 18  	beqz	a4, 0x18b78 <__addtf3+0xa34>
   181e0: 13 d7 27 03  	srli	a4, a5, 50
   181e4: 93 05 04 00  	mv	a1, s0
   181e8: 13 08 00 00  	li	a6, 0
   181ec: 63 1a 07 3e  	bnez	a4, 0x185e0 <__addtf3+0x49c>
   181f0: 6f 00 40 14  	j	0x18334 <__addtf3+0x1f0>
   181f4: 1b 88 f6 ff  	addiw	a6, a3, -1
   181f8: 63 14 08 06  	bnez	a6, 0x18260 <__addtf3+0x11c>
   181fc: 33 06 a6 00  	add	a2, a2, a0
   18200: 33 35 a6 00  	sltu	a0, a2, a0
   18204: 33 07 f7 00  	add	a4, a4, a5
   18208: 33 07 a7 00  	add	a4, a4, a0
   1820c: 93 05 04 00  	mv	a1, s0
   18210: 13 05 06 00  	mv	a0, a2
   18214: 93 57 37 03  	srli	a5, a4, 51
   18218: 93 f7 17 00  	andi	a5, a5, 1
   1821c: e3 8e 07 0c  	beqz	a5, 0x18af8 <__addtf3+0x9b4>
   18220: b7 86 00 00  	lui	a3, 8
   18224: 93 85 15 00  	addi	a1, a1, 1
   18228: 93 87 f6 ff  	addi	a5, a3, -1
   1822c: 63 84 f5 42  	beq	a1, a5, 0x18654 <__addtf3+0x510>
   18230: 93 07 f0 ff  	li	a5, -1
   18234: 93 97 37 03  	slli	a5, a5, 51
   18238: 93 87 f7 ff  	addi	a5, a5, -1
   1823c: b3 77 f7 00  	and	a5, a4, a5
   18240: 13 57 15 00  	srli	a4, a0, 1
   18244: 13 75 15 00  	andi	a0, a0, 1
   18248: 33 65 a7 00  	or	a0, a4, a0
   1824c: 13 97 f7 03  	slli	a4, a5, 63
   18250: 33 65 a7 00  	or	a0, a4, a0
   18254: 93 d7 17 00  	srli	a5, a5, 1
   18258: 13 08 00 00  	li	a6, 0
   1825c: 6f 00 40 38  	j	0x185e0 <__addtf3+0x49c>
   18260: 63 14 c4 03  	bne	s0, t3, 0x18288 <__addtf3+0x144>
   18264: 33 e7 a7 00  	or	a4, a5, a0
   18268: e3 08 07 10  	beqz	a4, 0x18b78 <__addtf3+0xa34>
   1826c: 13 d7 27 03  	srli	a4, a5, 50
   18270: 13 77 17 00  	andi	a4, a4, 1
   18274: 6f f0 1f f7  	j	0x181e4 <__addtf3+0xa0>
   18278: e3 06 c4 ff  	beq	s0, t3, 0x18264 <__addtf3+0x120>
   1827c: 93 06 10 00  	li	a3, 1
   18280: 93 96 36 03  	slli	a3, a3, 51
   18284: 33 67 d7 00  	or	a4, a4, a3
   18288: 93 06 40 07  	li	a3, 116
   1828c: 63 c4 06 07  	blt	a3, a6, 0x182f4 <__addtf3+0x1b0>
   18290: 93 06 f0 03  	li	a3, 63
   18294: 63 c6 06 03  	blt	a3, a6, 0x182c0 <__addtf3+0x17c>
   18298: 93 05 00 04  	li	a1, 64
   1829c: bb 85 05 41  	subw	a1, a1, a6
   182a0: b3 16 b7 00  	sll	a3, a4, a1
   182a4: b3 58 06 01  	srl	a7, a2, a6
   182a8: 33 16 b6 00  	sll	a2, a2, a1
   182ac: b3 e6 16 01  	or	a3, a3, a7
   182b0: 33 36 c0 00  	snez	a2, a2
   182b4: 33 e6 c6 00  	or	a2, a3, a2
   182b8: 33 57 07 01  	srl	a4, a4, a6
   182bc: 6f f0 1f f4  	j	0x181fc <__addtf3+0xb8>
   182c0: 9b 06 08 fc  	addiw	a3, a6, -64
   182c4: 93 08 00 04  	li	a7, 64
   182c8: b3 56 d7 00  	srl	a3, a4, a3
   182cc: 93 05 00 00  	li	a1, 0
   182d0: 63 08 18 01  	beq	a6, a7, 0x182e0 <__addtf3+0x19c>
   182d4: 93 05 00 08  	li	a1, 128
   182d8: bb 85 05 41  	subw	a1, a1, a6
   182dc: b3 15 b7 00  	sll	a1, a4, a1
   182e0: 33 e6 c5 00  	or	a2, a1, a2
   182e4: 33 36 c0 00  	snez	a2, a2
   182e8: 33 e6 c6 00  	or	a2, a3, a2
   182ec: 13 07 00 00  	li	a4, 0
   182f0: 6f f0 df f0  	j	0x181fc <__addtf3+0xb8>
   182f4: 33 66 c7 00  	or	a2, a4, a2
   182f8: 33 36 c0 00  	snez	a2, a2
   182fc: 6f f0 1f ff  	j	0x182ec <__addtf3+0x1a8>
   18300: 63 00 08 12  	beqz	a6, 0x18420 <__addtf3+0x2dc>
   18304: 63 10 04 08  	bnez	s0, 0x18384 <__addtf3+0x240>
   18308: 33 e8 a7 00  	or	a6, a5, a0
   1830c: 63 18 08 02  	bnez	a6, 0x1833c <__addtf3+0x1f8>
   18310: 13 05 06 00  	mv	a0, a2
   18314: 63 92 c5 7f  	bne	a1, t3, 0x18af8 <__addtf3+0x9b4>
   18318: 33 65 c7 00  	or	a0, a4, a2
   1831c: e3 02 05 04  	beqz	a0, 0x18b60 <__addtf3+0xa1c>
   18320: 93 57 27 03  	srli	a5, a4, 50
   18324: 93 f7 17 00  	andi	a5, a5, 1
   18328: e3 92 07 04  	bnez	a5, 0x18b6c <__addtf3+0xa28>
   1832c: 93 07 07 00  	mv	a5, a4
   18330: 13 05 06 00  	mv	a0, a2
   18334: 93 06 00 01  	li	a3, 16
   18338: 6f 00 00 14  	j	0x18478 <__addtf3+0x334>
   1833c: 93 c6 f6 ff  	not	a3, a3
   18340: 9b 86 06 00  	sext.w	a3, a3
   18344: 63 9c 06 00  	bnez	a3, 0x1835c <__addtf3+0x218>
   18348: 33 05 c5 00  	add	a0, a0, a2
   1834c: 33 87 e7 00  	add	a4, a5, a4
   18350: 33 36 c5 00  	sltu	a2, a0, a2
   18354: 33 07 c7 00  	add	a4, a4, a2
   18358: 6f f0 df eb  	j	0x18214 <__addtf3+0xd0>
   1835c: 63 9e c5 03  	bne	a1, t3, 0x18398 <__addtf3+0x254>
   18360: 33 65 c7 00  	or	a0, a4, a2
   18364: 63 0e 05 7e  	beqz	a0, 0x18b60 <__addtf3+0xa1c>
   18368: 93 57 27 03  	srli	a5, a4, 50
   1836c: 93 f7 17 00  	andi	a5, a5, 1
   18370: 63 9e 07 7e  	bnez	a5, 0x18b6c <__addtf3+0xa28>
   18374: 93 07 07 00  	mv	a5, a4
   18378: 13 05 06 00  	mv	a0, a2
   1837c: 13 08 00 00  	li	a6, 0
   18380: 6f f0 5f fb  	j	0x18334 <__addtf3+0x1f0>
   18384: e3 8e c5 fd  	beq	a1, t3, 0x18360 <__addtf3+0x21c>
   18388: 13 08 10 00  	li	a6, 1
   1838c: 13 18 38 03  	slli	a6, a6, 51
   18390: bb 06 d0 40  	negw	a3, a3
   18394: b3 e7 07 01  	or	a5, a5, a6
   18398: 13 08 40 07  	li	a6, 116
   1839c: 63 4c d8 06  	blt	a6, a3, 0x18414 <__addtf3+0x2d0>
   183a0: 13 08 f0 03  	li	a6, 63
   183a4: 63 4e d8 02  	blt	a6, a3, 0x183e0 <__addtf3+0x29c>
   183a8: 93 08 00 04  	li	a7, 64
   183ac: bb 88 d8 40  	subw	a7, a7, a3
   183b0: 33 53 d5 00  	srl	t1, a0, a3
   183b4: 33 98 17 01  	sll	a6, a5, a7
   183b8: 33 15 15 01  	sll	a0, a0, a7
   183bc: 33 68 68 00  	or	a6, a6, t1
   183c0: 33 35 a0 00  	snez	a0, a0
   183c4: 33 65 a8 00  	or	a0, a6, a0
   183c8: b3 d6 d7 00  	srl	a3, a5, a3
   183cc: 33 05 c5 00  	add	a0, a0, a2
   183d0: b3 86 e6 00  	add	a3, a3, a4
   183d4: 33 36 c5 00  	sltu	a2, a0, a2
   183d8: 33 87 c6 00  	add	a4, a3, a2
   183dc: 6f f0 9f e3  	j	0x18214 <__addtf3+0xd0>
   183e0: 1b 88 06 fc  	addiw	a6, a3, -64
   183e4: 13 03 00 04  	li	t1, 64
   183e8: 33 d8 07 01  	srl	a6, a5, a6
   183ec: 93 08 00 00  	li	a7, 0
   183f0: 63 88 66 00  	beq	a3, t1, 0x18400 <__addtf3+0x2bc>
   183f4: 93 08 00 08  	li	a7, 128
   183f8: bb 86 d8 40  	subw	a3, a7, a3
   183fc: b3 98 d7 00  	sll	a7, a5, a3
   18400: 33 e5 a8 00  	or	a0, a7, a0
   18404: 33 35 a0 00  	snez	a0, a0
   18408: 33 65 a8 00  	or	a0, a6, a0
   1840c: 93 06 00 00  	li	a3, 0
   18410: 6f f0 df fb  	j	0x183cc <__addtf3+0x288>
   18414: 33 e5 a7 00  	or	a0, a5, a0
   18418: 33 35 a0 00  	snez	a0, a0
   1841c: 6f f0 1f ff  	j	0x1840c <__addtf3+0x2c8>
   18420: 93 08 14 00  	addi	a7, s0, 1
   18424: 93 06 e3 ff  	addi	a3, t1, -2
   18428: 33 f3 d8 00  	and	t1, a7, a3
   1842c: 63 16 03 18  	bnez	t1, 0x185b8 <__addtf3+0x474>
   18430: b3 e8 a7 00  	or	a7, a5, a0
   18434: 63 10 04 06  	bnez	s0, 0x18494 <__addtf3+0x350>
   18438: 63 8c 08 6c  	beqz	a7, 0x18b10 <__addtf3+0x9cc>
   1843c: b3 66 c7 00  	or	a3, a4, a2
   18440: 63 8c 06 48  	beqz	a3, 0x188d8 <__addtf3+0x794>
   18444: 33 06 c5 00  	add	a2, a0, a2
   18448: b3 87 e7 00  	add	a5, a5, a4
   1844c: 33 35 a6 00  	sltu	a0, a2, a0
   18450: b3 87 a7 00  	add	a5, a5, a0
   18454: 13 d7 37 03  	srli	a4, a5, 51
   18458: 13 77 17 00  	andi	a4, a4, 1
   1845c: 63 0c 07 6a  	beqz	a4, 0x18b14 <__addtf3+0x9d0>
   18460: 13 97 3e 03  	slli	a4, t4, 51
   18464: 13 07 f7 ff  	addi	a4, a4, -1
   18468: b3 f7 e7 00  	and	a5, a5, a4
   1846c: 13 05 06 00  	mv	a0, a2
   18470: 93 06 00 00  	li	a3, 0
   18474: 93 05 10 00  	li	a1, 1
   18478: 13 77 75 00  	andi	a4, a0, 7
   1847c: 63 10 07 1a  	bnez	a4, 0x1861c <__addtf3+0x4d8>
   18480: 63 06 08 08  	beqz	a6, 0x1850c <__addtf3+0x3c8>
   18484: 13 f7 16 00  	andi	a4, a3, 1
   18488: 63 02 07 08  	beqz	a4, 0x1850c <__addtf3+0x3c8>
   1848c: 93 e6 26 00  	ori	a3, a3, 2
   18490: 6f 00 c0 07  	j	0x1850c <__addtf3+0x3c8>
   18494: 63 1c c4 03  	bne	s0, t3, 0x184cc <__addtf3+0x388>
   18498: 63 8c 08 78  	beqz	a7, 0x18c30 <__addtf3+0xaec>
   1849c: 93 d6 27 03  	srli	a3, a5, 50
   184a0: 93 f6 16 00  	andi	a3, a3, 1
   184a4: 93 b6 16 00  	seqz	a3, a3
   184a8: 93 96 46 00  	slli	a3, a3, 4
   184ac: 63 90 85 04  	bne	a1, s0, 0x184ec <__addtf3+0x3a8>
   184b0: b3 65 c7 00  	or	a1, a4, a2
   184b4: 63 80 05 02  	beqz	a1, 0x184d4 <__addtf3+0x390>
   184b8: 93 55 27 03  	srli	a1, a4, 50
   184bc: 93 f5 15 00  	andi	a1, a1, 1
   184c0: 63 9a 05 00  	bnez	a1, 0x184d4 <__addtf3+0x390>
   184c4: 93 06 00 01  	li	a3, 16
   184c8: 6f 00 c0 00  	j	0x184d4 <__addtf3+0x390>
   184cc: 93 06 00 00  	li	a3, 0
   184d0: e3 80 c5 ff  	beq	a1, t3, 0x184b0 <__addtf3+0x36c>
   184d4: 63 9c 08 00  	bnez	a7, 0x184ec <__addtf3+0x3a8>
   184d8: 93 07 07 00  	mv	a5, a4
   184dc: 13 05 06 00  	mv	a0, a2
   184e0: b7 85 00 00  	lui	a1, 8
   184e4: 93 85 f5 ff  	addi	a1, a1, -1
   184e8: 6f f0 1f f9  	j	0x18478 <__addtf3+0x334>
   184ec: 33 66 c7 00  	or	a2, a4, a2
   184f0: e3 08 06 fe  	beqz	a2, 0x184e0 <__addtf3+0x39c>
   184f4: 93 07 10 00  	li	a5, 1
   184f8: b7 85 00 00  	lui	a1, 8
   184fc: 13 09 00 00  	li	s2, 0
   18500: 93 97 27 03  	slli	a5, a5, 50
   18504: 13 05 00 00  	li	a0, 0
   18508: 93 85 f5 ff  	addi	a1, a1, -1
   1850c: 13 d7 37 03  	srli	a4, a5, 51
   18510: 13 77 17 00  	andi	a4, a4, 1
   18514: 63 02 07 02  	beqz	a4, 0x18538 <__addtf3+0x3f4>
   18518: 37 87 00 00  	lui	a4, 8
   1851c: 93 85 15 00  	addi	a1, a1, 1
   18520: 13 06 f7 ff  	addi	a2, a4, -1
   18524: 63 84 c5 6c  	beq	a1, a2, 0x18bec <__addtf3+0xaa8>
   18528: 13 07 f0 ff  	li	a4, -1
   1852c: 13 17 37 03  	slli	a4, a4, 51
   18530: 13 07 f7 ff  	addi	a4, a4, -1
   18534: b3 f7 e7 00  	and	a5, a5, a4
   18538: 13 57 35 00  	srli	a4, a0, 3
   1853c: 13 95 d7 03  	slli	a0, a5, 61
   18540: 33 65 e5 00  	or	a0, a0, a4
   18544: 37 87 00 00  	lui	a4, 8
   18548: 13 07 f7 ff  	addi	a4, a4, -1
   1854c: 93 d7 37 00  	srli	a5, a5, 3
   18550: 63 90 e5 02  	bne	a1, a4, 0x18570 <__addtf3+0x42c>
   18554: 33 65 f5 00  	or	a0, a0, a5
   18558: 93 07 00 00  	li	a5, 0
   1855c: 63 0a 05 00  	beqz	a0, 0x18570 <__addtf3+0x42c>
   18560: 93 07 10 00  	li	a5, 1
   18564: 93 97 f7 02  	slli	a5, a5, 47
   18568: 13 05 00 00  	li	a0, 0
   1856c: 13 09 00 00  	li	s2, 0
   18570: 93 95 15 03  	slli	a1, a1, 49
   18574: 13 19 f9 00  	slli	s2, s2, 15
   18578: 93 d5 15 03  	srli	a1, a1, 49
   1857c: b3 65 b9 00  	or	a1, s2, a1
   18580: 93 97 07 01  	slli	a5, a5, 16
   18584: 13 99 05 03  	slli	s2, a1, 48
   18588: 93 d5 07 01  	srli	a1, a5, 16
   1858c: b3 e5 25 01  	or	a1, a1, s2
   18590: 63 84 06 00  	beqz	a3, 0x18598 <__addtf3+0x454>
   18594: 73 a0 16 00  	csrs	fflags, a3
   18598: 83 30 81 02  	ld	ra, 40(sp)
   1859c: 03 34 01 02  	ld	s0, 32(sp)
   185a0: 83 34 81 01  	ld	s1, 24(sp)
   185a4: 03 39 01 01  	ld	s2, 16(sp)
   185a8: 83 39 81 00  	ld	s3, 8(sp)
   185ac: 03 3a 01 00  	ld	s4, 0(sp)
   185b0: 13 01 01 03  	addi	sp, sp, 48
   185b4: 67 80 00 00  	ret
   185b8: 63 88 c8 03  	beq	a7, t3, 0x185e8 <__addtf3+0x4a4>
   185bc: 33 06 c5 00  	add	a2, a0, a2
   185c0: 33 35 a6 00  	sltu	a0, a2, a0
   185c4: b3 87 e7 00  	add	a5, a5, a4
   185c8: b3 87 a7 00  	add	a5, a5, a0
   185cc: 13 95 f7 03  	slli	a0, a5, 63
   185d0: 13 56 16 00  	srli	a2, a2, 1
   185d4: 33 65 c5 00  	or	a0, a0, a2
   185d8: 93 d7 17 00  	srli	a5, a5, 1
   185dc: 93 85 08 00  	mv	a1, a7
   185e0: 93 06 00 00  	li	a3, 0
   185e4: 6f f0 5f e9  	j	0x18478 <__addtf3+0x334>
   185e8: 63 88 04 00  	beqz	s1, 0x185f8 <__addtf3+0x4b4>
   185ec: 93 07 30 00  	li	a5, 3
   185f0: 63 98 f4 00  	bne	s1, a5, 0x18600 <__addtf3+0x4bc>
   185f4: 63 1c 09 00  	bnez	s2, 0x1860c <__addtf3+0x4c8>
   185f8: 93 85 08 00  	mv	a1, a7
   185fc: 6f 00 80 06  	j	0x18664 <__addtf3+0x520>
   18600: 93 07 20 00  	li	a5, 2
   18604: 63 94 f4 00  	bne	s1, a5, 0x1860c <__addtf3+0x4c8>
   18608: e3 18 09 fe  	bnez	s2, 0x185f8 <__addtf3+0x4b4>
   1860c: 93 07 f0 ff  	li	a5, -1
   18610: 13 05 f0 ff  	li	a0, -1
   18614: 93 85 06 00  	mv	a1, a3
   18618: 93 06 50 00  	li	a3, 5
   1861c: 13 07 20 00  	li	a4, 2
   18620: 93 e6 16 00  	ori	a3, a3, 1
   18624: 63 8e e4 5a  	beq	s1, a4, 0x18be0 <__addtf3+0xa9c>
   18628: 13 07 30 00  	li	a4, 3
   1862c: 63 84 e4 5a  	beq	s1, a4, 0x18bd4 <__addtf3+0xa90>
   18630: 63 9a 04 5a  	bnez	s1, 0x18be4 <__addtf3+0xaa0>
   18634: 13 77 f5 00  	andi	a4, a0, 15
   18638: 13 06 40 00  	li	a2, 4
   1863c: 63 04 c7 5a  	beq	a4, a2, 0x18be4 <__addtf3+0xaa0>
   18640: 13 07 45 00  	addi	a4, a0, 4
   18644: 33 35 a7 00  	sltu	a0, a4, a0
   18648: b3 87 a7 00  	add	a5, a5, a0
   1864c: 13 05 07 00  	mv	a0, a4
   18650: 6f 00 40 59  	j	0x18be4 <__addtf3+0xaa0>
   18654: 63 88 04 00  	beqz	s1, 0x18664 <__addtf3+0x520>
   18658: 93 07 30 00  	li	a5, 3
   1865c: 63 9c f4 00  	bne	s1, a5, 0x18674 <__addtf3+0x530>
   18660: 63 10 09 02  	bnez	s2, 0x18680 <__addtf3+0x53c>
   18664: 93 07 00 00  	li	a5, 0
   18668: 13 05 00 00  	li	a0, 0
   1866c: 93 06 50 00  	li	a3, 5
   18670: 6f f0 df e9  	j	0x1850c <__addtf3+0x3c8>
   18674: 93 07 20 00  	li	a5, 2
   18678: 63 94 f4 00  	bne	s1, a5, 0x18680 <__addtf3+0x53c>
   1867c: e3 14 09 fe  	bnez	s2, 0x18664 <__addtf3+0x520>
   18680: 93 07 f0 ff  	li	a5, -1
   18684: 13 05 f0 ff  	li	a0, -1
   18688: 93 85 e6 ff  	addi	a1, a3, -2
   1868c: 13 08 00 00  	li	a6, 0
   18690: 6f f0 9f f8  	j	0x18618 <__addtf3+0x4d4>
   18694: 63 58 00 0f  	blez	a6, 0x18784 <__addtf3+0x640>
   18698: 63 9c 05 08  	bnez	a1, 0x18730 <__addtf3+0x5ec>
   1869c: b3 65 c7 00  	or	a1, a4, a2
   186a0: 63 9a 05 00  	bnez	a1, 0x186b4 <__addtf3+0x570>
   186a4: e3 00 c4 bd  	beq	s0, t3, 0x18264 <__addtf3+0x120>
   186a8: 13 87 07 00  	mv	a4, a5
   186ac: 93 05 04 00  	mv	a1, s0
   186b0: 6f 00 80 44  	j	0x18af8 <__addtf3+0x9b4>
   186b4: 1b 88 f6 ff  	addiw	a6, a3, -1
   186b8: 63 1e 08 02  	bnez	a6, 0x186f4 <__addtf3+0x5b0>
   186bc: 33 06 c5 40  	sub	a2, a0, a2
   186c0: 33 35 c5 00  	sltu	a0, a0, a2
   186c4: 33 87 e7 40  	sub	a4, a5, a4
   186c8: 33 07 a7 40  	sub	a4, a4, a0
   186cc: 93 05 04 00  	mv	a1, s0
   186d0: 13 05 06 00  	mv	a0, a2
   186d4: 93 57 37 03  	srli	a5, a4, 51
   186d8: 93 f7 17 00  	andi	a5, a5, 1
   186dc: 63 8e 07 40  	beqz	a5, 0x18af8 <__addtf3+0x9b4>
   186e0: 13 17 d7 00  	slli	a4, a4, 13
   186e4: 93 59 d7 00  	srli	s3, a4, 13
   186e8: 13 0a 05 00  	mv	s4, a0
   186ec: 13 84 05 00  	mv	s0, a1
   186f0: 6f 00 40 32  	j	0x18a14 <__addtf3+0x8d0>
   186f4: e3 08 c4 b7  	beq	s0, t3, 0x18264 <__addtf3+0x120>
   186f8: 93 06 40 07  	li	a3, 116
   186fc: 63 ce 06 07  	blt	a3, a6, 0x18778 <__addtf3+0x634>
   18700: 93 06 f0 03  	li	a3, 63
   18704: 63 c0 06 05  	blt	a3, a6, 0x18744 <__addtf3+0x600>
   18708: 93 05 00 04  	li	a1, 64
   1870c: bb 85 05 41  	subw	a1, a1, a6
   18710: b3 16 b7 00  	sll	a3, a4, a1
   18714: b3 58 06 01  	srl	a7, a2, a6
   18718: 33 16 b6 00  	sll	a2, a2, a1
   1871c: b3 e6 16 01  	or	a3, a3, a7
   18720: 33 36 c0 00  	snez	a2, a2
   18724: 33 e6 c6 00  	or	a2, a3, a2
   18728: 33 57 07 01  	srl	a4, a4, a6
   1872c: 6f f0 1f f9  	j	0x186bc <__addtf3+0x578>
   18730: e3 0a c4 b3  	beq	s0, t3, 0x18264 <__addtf3+0x120>
   18734: 93 06 10 00  	li	a3, 1
   18738: 93 96 36 03  	slli	a3, a3, 51
   1873c: 33 67 d7 00  	or	a4, a4, a3
   18740: 6f f0 9f fb  	j	0x186f8 <__addtf3+0x5b4>
   18744: 9b 06 08 fc  	addiw	a3, a6, -64
   18748: 93 08 00 04  	li	a7, 64
   1874c: b3 56 d7 00  	srl	a3, a4, a3
   18750: 93 05 00 00  	li	a1, 0
   18754: 63 08 18 01  	beq	a6, a7, 0x18764 <__addtf3+0x620>
   18758: 93 05 00 08  	li	a1, 128
   1875c: bb 85 05 41  	subw	a1, a1, a6
   18760: b3 15 b7 00  	sll	a1, a4, a1
   18764: 33 e6 c5 00  	or	a2, a1, a2
   18768: 33 36 c0 00  	snez	a2, a2
   1876c: 33 e6 c6 00  	or	a2, a3, a2
   18770: 13 07 00 00  	li	a4, 0
   18774: 6f f0 9f f4  	j	0x186bc <__addtf3+0x578>
   18778: 33 66 c7 00  	or	a2, a4, a2
   1877c: 33 36 c0 00  	snez	a2, a2
   18780: 6f f0 1f ff  	j	0x18770 <__addtf3+0x62c>
   18784: 63 00 08 12  	beqz	a6, 0x188a4 <__addtf3+0x760>
   18788: 63 10 04 08  	bnez	s0, 0x18808 <__addtf3+0x6c4>
   1878c: 33 e8 a7 00  	or	a6, a5, a0
   18790: 63 16 08 02  	bnez	a6, 0x187bc <__addtf3+0x678>
   18794: 63 98 c5 37  	bne	a1, t3, 0x18b04 <__addtf3+0x9c0>
   18798: 33 65 c7 00  	or	a0, a4, a2
   1879c: 63 06 05 3e  	beqz	a0, 0x18b88 <__addtf3+0xa44>
   187a0: 93 57 27 03  	srli	a5, a4, 50
   187a4: 93 f7 17 00  	andi	a5, a5, 1
   187a8: 63 96 07 3e  	bnez	a5, 0x18b94 <__addtf3+0xa50>
   187ac: 93 07 07 00  	mv	a5, a4
   187b0: 13 05 06 00  	mv	a0, a2
   187b4: 13 89 08 00  	mv	s2, a7
   187b8: 6f f0 df b7  	j	0x18334 <__addtf3+0x1f0>
   187bc: 93 c6 f6 ff  	not	a3, a3
   187c0: 9b 86 06 00  	sext.w	a3, a3
   187c4: 63 9e 06 00  	bnez	a3, 0x187e0 <__addtf3+0x69c>
   187c8: 33 05 a6 40  	sub	a0, a2, a0
   187cc: 33 07 f7 40  	sub	a4, a4, a5
   187d0: 33 36 a6 00  	sltu	a2, a2, a0
   187d4: 33 07 c7 40  	sub	a4, a4, a2
   187d8: 13 89 08 00  	mv	s2, a7
   187dc: 6f f0 9f ef  	j	0x186d4 <__addtf3+0x590>
   187e0: 63 9e c5 03  	bne	a1, t3, 0x1881c <__addtf3+0x6d8>
   187e4: 33 65 c7 00  	or	a0, a4, a2
   187e8: 63 00 05 3a  	beqz	a0, 0x18b88 <__addtf3+0xa44>
   187ec: 93 57 27 03  	srli	a5, a4, 50
   187f0: 93 f7 17 00  	andi	a5, a5, 1
   187f4: 63 90 07 3a  	bnez	a5, 0x18b94 <__addtf3+0xa50>
   187f8: 93 07 07 00  	mv	a5, a4
   187fc: 13 05 06 00  	mv	a0, a2
   18800: 13 89 08 00  	mv	s2, a7
   18804: 6f f0 9f b7  	j	0x1837c <__addtf3+0x238>
   18808: e3 8e c5 fd  	beq	a1, t3, 0x187e4 <__addtf3+0x6a0>
   1880c: 13 08 10 00  	li	a6, 1
   18810: 13 18 38 03  	slli	a6, a6, 51
   18814: bb 06 d0 40  	negw	a3, a3
   18818: b3 e7 07 01  	or	a5, a5, a6
   1881c: 13 08 40 07  	li	a6, 116
   18820: 63 4c d8 06  	blt	a6, a3, 0x18898 <__addtf3+0x754>
   18824: 13 08 f0 03  	li	a6, 63
   18828: 63 4e d8 02  	blt	a6, a3, 0x18864 <__addtf3+0x720>
   1882c: 13 03 00 04  	li	t1, 64
   18830: 3b 03 d3 40  	subw	t1, t1, a3
   18834: 33 98 67 00  	sll	a6, a5, t1
   18838: 33 5e d5 00  	srl	t3, a0, a3
   1883c: 33 15 65 00  	sll	a0, a0, t1
   18840: 33 68 c8 01  	or	a6, a6, t3
   18844: 33 35 a0 00  	snez	a0, a0
   18848: 33 65 a8 00  	or	a0, a6, a0
   1884c: b3 d7 d7 00  	srl	a5, a5, a3
   18850: 33 05 a6 40  	sub	a0, a2, a0
   18854: b3 07 f7 40  	sub	a5, a4, a5
   18858: 33 36 a6 00  	sltu	a2, a2, a0
   1885c: 33 87 c7 40  	sub	a4, a5, a2
   18860: 6f f0 9f f7  	j	0x187d8 <__addtf3+0x694>
   18864: 1b 88 06 fc  	addiw	a6, a3, -64
   18868: 13 0e 00 04  	li	t3, 64
   1886c: 33 d8 07 01  	srl	a6, a5, a6
   18870: 13 03 00 00  	li	t1, 0
   18874: 63 88 c6 01  	beq	a3, t3, 0x18884 <__addtf3+0x740>
   18878: 13 03 00 08  	li	t1, 128
   1887c: bb 06 d3 40  	subw	a3, t1, a3
   18880: 33 93 d7 00  	sll	t1, a5, a3
   18884: 33 65 a3 00  	or	a0, t1, a0
   18888: 33 35 a0 00  	snez	a0, a0
   1888c: 33 65 a8 00  	or	a0, a6, a0
   18890: 93 07 00 00  	li	a5, 0
   18894: 6f f0 df fb  	j	0x18850 <__addtf3+0x70c>
   18898: 33 e5 a7 00  	or	a0, a5, a0
   1889c: 33 35 a0 00  	snez	a0, a0
   188a0: 6f f0 1f ff  	j	0x18890 <__addtf3+0x74c>
   188a4: 93 0e 14 00  	addi	t4, s0, 1
   188a8: 93 06 e3 ff  	addi	a3, t1, -2
   188ac: b3 f6 de 00  	and	a3, t4, a3
   188b0: 63 9a 06 12  	bnez	a3, 0x189e4 <__addtf3+0x8a0>
   188b4: b3 ee a7 00  	or	t4, a5, a0
   188b8: 33 63 c7 00  	or	t1, a4, a2
   188bc: 63 16 04 0c  	bnez	s0, 0x18988 <__addtf3+0x844>
   188c0: 63 9c 0e 06  	bnez	t4, 0x18938 <__addtf3+0x7f4>
   188c4: 63 1c 03 24  	bnez	t1, 0x18b1c <__addtf3+0x9d8>
   188c8: 13 89 e4 ff  	addi	s2, s1, -2
   188cc: 13 39 19 00  	seqz	s2, s2
   188d0: 93 07 00 00  	li	a5, 0
   188d4: 13 05 00 00  	li	a0, 0
   188d8: 33 67 f5 00  	or	a4, a0, a5
   188dc: 63 04 07 2e  	beqz	a4, 0x18bc4 <__addtf3+0xa80>
   188e0: 13 57 f5 03  	srli	a4, a0, 63
   188e4: 13 98 17 00  	slli	a6, a5, 1
   188e8: 33 08 e8 00  	add	a6, a6, a4
   188ec: 13 17 15 00  	slli	a4, a0, 1
   188f0: 13 76 77 00  	andi	a2, a4, 7
   188f4: 93 06 00 00  	li	a3, 0
   188f8: 63 06 06 02  	beqz	a2, 0x18924 <__addtf3+0x7e0>
   188fc: 93 06 20 00  	li	a3, 2
   18900: 63 8a d4 24  	beq	s1, a3, 0x18b54 <__addtf3+0xa10>
   18904: 93 06 30 00  	li	a3, 3
   18908: 63 86 d4 22  	beq	s1, a3, 0x18b34 <__addtf3+0x9f0>
   1890c: 93 06 10 00  	li	a3, 1
   18910: 63 9a 04 00  	bnez	s1, 0x18924 <__addtf3+0x7e0>
   18914: 13 76 f7 00  	andi	a2, a4, 15
   18918: 93 05 40 00  	li	a1, 4
   1891c: 13 37 c7 ff  	sltiu	a4, a4, -4
   18920: 63 10 b6 22  	bne	a2, a1, 0x18b40 <__addtf3+0x9fc>
   18924: 13 58 48 03  	srli	a6, a6, 52
   18928: 13 48 18 00  	xori	a6, a6, 1
   1892c: 13 78 18 00  	andi	a6, a6, 1
   18930: 93 05 00 00  	li	a1, 0
   18934: 6f f0 5f b4  	j	0x18478 <__addtf3+0x334>
   18938: e3 00 03 fa  	beqz	t1, 0x188d8 <__addtf3+0x794>
   1893c: b3 05 c5 40  	sub	a1, a0, a2
   18940: 33 38 b5 00  	sltu	a6, a0, a1
   18944: b3 86 e7 40  	sub	a3, a5, a4
   18948: b3 86 06 41  	sub	a3, a3, a6
   1894c: 13 d8 36 03  	srli	a6, a3, 51
   18950: 13 78 18 00  	andi	a6, a6, 1
   18954: 63 0e 08 00  	beqz	a6, 0x18970 <__addtf3+0x82c>
   18958: 33 05 a6 40  	sub	a0, a2, a0
   1895c: b3 07 f7 40  	sub	a5, a4, a5
   18960: 33 36 a6 00  	sltu	a2, a2, a0
   18964: b3 87 c7 40  	sub	a5, a5, a2
   18968: 13 89 08 00  	mv	s2, a7
   1896c: 6f f0 df f6  	j	0x188d8 <__addtf3+0x794>
   18970: 33 e5 d5 00  	or	a0, a1, a3
   18974: 63 1a 05 1a  	bnez	a0, 0x18b28 <__addtf3+0x9e4>
   18978: 13 89 e4 ff  	addi	s2, s1, -2
   1897c: 13 39 19 00  	seqz	s2, s2
   18980: 93 07 00 00  	li	a5, 0
   18984: 6f f0 5f f5  	j	0x188d8 <__addtf3+0x794>
   18988: 63 1a c4 03  	bne	s0, t3, 0x189bc <__addtf3+0x878>
   1898c: 63 8c 0e 28  	beqz	t4, 0x18c24 <__addtf3+0xae0>
   18990: 93 d6 27 03  	srli	a3, a5, 50
   18994: 93 f6 16 00  	andi	a3, a3, 1
   18998: 93 b6 16 00  	seqz	a3, a3
   1899c: 93 96 46 00  	slli	a3, a3, 4
   189a0: 63 9e 85 02  	bne	a1, s0, 0x189dc <__addtf3+0x898>
   189a4: 63 00 03 02  	beqz	t1, 0x189c4 <__addtf3+0x880>
   189a8: 93 55 27 03  	srli	a1, a4, 50
   189ac: 93 f5 15 00  	andi	a1, a1, 1
   189b0: 63 9a 05 00  	bnez	a1, 0x189c4 <__addtf3+0x880>
   189b4: 93 06 00 01  	li	a3, 16
   189b8: 6f 00 c0 00  	j	0x189c4 <__addtf3+0x880>
   189bc: 93 06 00 00  	li	a3, 0
   189c0: e3 82 c5 ff  	beq	a1, t3, 0x189a4 <__addtf3+0x860>
   189c4: 63 9c 0e 00  	bnez	t4, 0x189dc <__addtf3+0x898>
   189c8: 63 0e 03 1c  	beqz	t1, 0x18ba4 <__addtf3+0xa60>
   189cc: 93 07 07 00  	mv	a5, a4
   189d0: 13 05 06 00  	mv	a0, a2
   189d4: 13 89 08 00  	mv	s2, a7
   189d8: 6f f0 9f b0  	j	0x184e0 <__addtf3+0x39c>
   189dc: e3 02 03 b0  	beqz	t1, 0x184e0 <__addtf3+0x39c>
   189e0: 6f f0 5f b1  	j	0x184f4 <__addtf3+0x3b0>
   189e4: 33 0a c5 40  	sub	s4, a0, a2
   189e8: b3 36 45 01  	sltu	a3, a0, s4
   189ec: b3 89 e7 40  	sub	s3, a5, a4
   189f0: b3 89 d9 40  	sub	s3, s3, a3
   189f4: 93 d6 39 03  	srli	a3, s3, 51
   189f8: 93 f6 16 00  	andi	a3, a3, 1
   189fc: 63 86 06 08  	beqz	a3, 0x18a88 <__addtf3+0x944>
   18a00: 33 0a a6 40  	sub	s4, a2, a0
   18a04: 33 07 f7 40  	sub	a4, a4, a5
   18a08: 33 36 46 01  	sltu	a2, a2, s4
   18a0c: b3 09 c7 40  	sub	s3, a4, a2
   18a10: 13 89 08 00  	mv	s2, a7
   18a14: 63 80 09 08  	beqz	s3, 0x18a94 <__addtf3+0x950>
   18a18: 13 85 09 00  	mv	a0, s3
   18a1c: ef 10 90 1f  	jal	0x1a414 <__clzdi2>
   18a20: 1b 05 05 00  	sext.w	a0, a0
   18a24: 9b 05 45 ff  	addiw	a1, a0, -12
   18a28: 93 07 f0 03  	li	a5, 63
   18a2c: 93 86 05 00  	mv	a3, a1
   18a30: 63 ca b7 06  	blt	a5, a1, 0x18aa4 <__addtf3+0x960>
   18a34: 13 07 00 04  	li	a4, 64
   18a38: 3b 07 b7 40  	subw	a4, a4, a1
   18a3c: b3 99 b9 00  	sll	s3, s3, a1
   18a40: 33 57 ea 00  	srl	a4, s4, a4
   18a44: 33 67 37 01  	or	a4, a4, s3
   18a48: 33 15 ba 00  	sll	a0, s4, a1
   18a4c: 63 cc 85 08  	blt	a1, s0, 0x18ae4 <__addtf3+0x9a0>
   18a50: 3b 84 86 40  	subw	s0, a3, s0
   18a54: 9b 07 14 00  	addiw	a5, s0, 1
   18a58: 93 06 f0 03  	li	a3, 63
   18a5c: 63 cc f6 04  	blt	a3, a5, 0x18ab4 <__addtf3+0x970>
   18a60: 93 06 00 04  	li	a3, 64
   18a64: bb 86 f6 40  	subw	a3, a3, a5
   18a68: b3 55 f5 00  	srl	a1, a0, a5
   18a6c: 33 16 d7 00  	sll	a2, a4, a3
   18a70: 33 15 d5 00  	sll	a0, a0, a3
   18a74: 33 66 b6 00  	or	a2, a2, a1
   18a78: 33 35 a0 00  	snez	a0, a0
   18a7c: 33 65 a6 00  	or	a0, a2, a0
   18a80: b3 57 f7 00  	srl	a5, a4, a5
   18a84: 6f f0 5f e5  	j	0x188d8 <__addtf3+0x794>
   18a88: 33 65 3a 01  	or	a0, s4, s3
   18a8c: e3 14 05 f8  	bnez	a0, 0x18a14 <__addtf3+0x8d0>
   18a90: 6f f0 9f ee  	j	0x18978 <__addtf3+0x834>
   18a94: 13 05 0a 00  	mv	a0, s4
   18a98: ef 10 d0 17  	jal	0x1a414 <__clzdi2>
   18a9c: 1b 05 05 04  	addiw	a0, a0, 64
   18aa0: 6f f0 5f f8  	j	0x18a24 <__addtf3+0x8e0>
   18aa4: 1b 07 45 fb  	addiw	a4, a0, -76
   18aa8: 33 17 ea 00  	sll	a4, s4, a4
   18aac: 13 05 00 00  	li	a0, 0
   18ab0: 6f f0 df f9  	j	0x18a4c <__addtf3+0x908>
   18ab4: 1b 04 14 fc  	addiw	s0, s0, -63
   18ab8: 93 05 00 04  	li	a1, 64
   18abc: 33 54 87 00  	srl	s0, a4, s0
   18ac0: 93 06 00 00  	li	a3, 0
   18ac4: 63 88 b7 00  	beq	a5, a1, 0x18ad4 <__addtf3+0x990>
   18ac8: 93 06 00 08  	li	a3, 128
   18acc: bb 86 f6 40  	subw	a3, a3, a5
   18ad0: b3 16 d7 00  	sll	a3, a4, a3
   18ad4: 33 65 d5 00  	or	a0, a0, a3
   18ad8: 33 35 a0 00  	snez	a0, a0
   18adc: 33 65 a4 00  	or	a0, s0, a0
   18ae0: 6f f0 1f ea  	j	0x18980 <__addtf3+0x83c>
   18ae4: 93 07 f0 ff  	li	a5, -1
   18ae8: 93 97 37 03  	slli	a5, a5, 51
   18aec: 93 87 f7 ff  	addi	a5, a5, -1
   18af0: b3 05 b4 40  	sub	a1, s0, a1
   18af4: 33 77 f7 00  	and	a4, a4, a5
   18af8: 93 07 07 00  	mv	a5, a4
   18afc: e3 8e 05 dc  	beqz	a1, 0x188d8 <__addtf3+0x794>
   18b00: 6f f0 8f f5  	j	0x18258 <__addtf3+0x114>
   18b04: 13 05 06 00  	mv	a0, a2
   18b08: 13 89 08 00  	mv	s2, a7
   18b0c: 6f f0 df fe  	j	0x18af8 <__addtf3+0x9b4>
   18b10: 93 07 07 00  	mv	a5, a4
   18b14: 13 05 06 00  	mv	a0, a2
   18b18: 6f f0 1f dc  	j	0x188d8 <__addtf3+0x794>
   18b1c: 93 07 07 00  	mv	a5, a4
   18b20: 13 05 06 00  	mv	a0, a2
   18b24: 6f f0 5f e4  	j	0x18968 <__addtf3+0x824>
   18b28: 93 87 06 00  	mv	a5, a3
   18b2c: 13 85 05 00  	mv	a0, a1
   18b30: 6f f0 9f da  	j	0x188d8 <__addtf3+0x794>
   18b34: 93 06 10 00  	li	a3, 1
   18b38: e3 16 09 de  	bnez	s2, 0x18924 <__addtf3+0x7e0>
   18b3c: 13 37 87 ff  	sltiu	a4, a4, -8
   18b40: 13 47 17 00  	xori	a4, a4, 1
   18b44: 13 17 07 02  	slli	a4, a4, 32
   18b48: 13 57 07 02  	srli	a4, a4, 32
   18b4c: 33 08 e8 00  	add	a6, a6, a4
   18b50: 6f f0 5f dd  	j	0x18924 <__addtf3+0x7e0>
   18b54: 93 06 10 00  	li	a3, 1
   18b58: e3 06 09 dc  	beqz	s2, 0x18924 <__addtf3+0x7e0>
   18b5c: 6f f0 1f fe  	j	0x18b3c <__addtf3+0x9f8>
   18b60: 93 07 00 00  	li	a5, 0
   18b64: 93 06 00 00  	li	a3, 0
   18b68: 6f f0 5f 9a  	j	0x1850c <__addtf3+0x3c8>
   18b6c: 93 07 07 00  	mv	a5, a4
   18b70: 13 05 06 00  	mv	a0, a2
   18b74: 6f f0 4f ee  	j	0x18258 <__addtf3+0x114>
   18b78: 93 07 00 00  	li	a5, 0
   18b7c: 13 05 00 00  	li	a0, 0
   18b80: 93 05 04 00  	mv	a1, s0
   18b84: 6f f0 1f fe  	j	0x18b64 <__addtf3+0xa20>
   18b88: 93 07 00 00  	li	a5, 0
   18b8c: 13 89 08 00  	mv	s2, a7
   18b90: 6f f0 5f fd  	j	0x18b64 <__addtf3+0xa20>
   18b94: 93 07 07 00  	mv	a5, a4
   18b98: 13 05 06 00  	mv	a0, a2
   18b9c: 13 89 08 00  	mv	s2, a7
   18ba0: 6f f0 8f eb  	j	0x18258 <__addtf3+0x114>
   18ba4: 93 07 10 00  	li	a5, 1
   18ba8: b7 85 00 00  	lui	a1, 8
   18bac: 13 05 00 00  	li	a0, 0
   18bb0: 13 09 00 00  	li	s2, 0
   18bb4: 93 97 27 03  	slli	a5, a5, 50
   18bb8: 93 85 f5 ff  	addi	a1, a1, -1
   18bbc: 93 06 00 01  	li	a3, 16
   18bc0: 6f f0 df 94  	j	0x1850c <__addtf3+0x3c8>
   18bc4: 93 07 00 00  	li	a5, 0
   18bc8: 13 05 00 00  	li	a0, 0
   18bcc: 93 05 00 00  	li	a1, 0
   18bd0: 6f f0 5f f9  	j	0x18b64 <__addtf3+0xa20>
   18bd4: 63 18 09 00  	bnez	s2, 0x18be4 <__addtf3+0xaa0>
   18bd8: 13 07 85 00  	addi	a4, a0, 8
   18bdc: 6f f0 9f a6  	j	0x18644 <__addtf3+0x500>
   18be0: e3 1c 09 fe  	bnez	s2, 0x18bd8 <__addtf3+0xa94>
   18be4: e3 14 08 8a  	bnez	a6, 0x1848c <__addtf3+0x348>
   18be8: 6f f0 5f 92  	j	0x1850c <__addtf3+0x3c8>
   18bec: 13 05 00 00  	li	a0, 0
   18bf0: 63 84 04 02  	beqz	s1, 0x18c18 <__addtf3+0xad4>
   18bf4: 93 07 30 00  	li	a5, 3
   18bf8: 63 9a f4 00  	bne	s1, a5, 0x18c0c <__addtf3+0xac8>
   18bfc: 63 0e 09 00  	beqz	s2, 0x18c18 <__addtf3+0xad4>
   18c00: 13 05 f0 ff  	li	a0, -1
   18c04: 93 05 e7 ff  	addi	a1, a4, -2
   18c08: 6f 00 00 01  	j	0x18c18 <__addtf3+0xad4>
   18c0c: 93 07 20 00  	li	a5, 2
   18c10: e3 98 f4 fe  	bne	s1, a5, 0x18c00 <__addtf3+0xabc>
   18c14: e3 06 09 fe  	beqz	s2, 0x18c00 <__addtf3+0xabc>
   18c18: 93 e6 56 00  	ori	a3, a3, 5
   18c1c: 93 07 05 00  	mv	a5, a0
   18c20: 6f f0 9f 91  	j	0x18538 <__addtf3+0x3f4>
   18c24: 93 06 00 00  	li	a3, 0
   18c28: e3 90 85 da  	bne	a1, s0, 0x189c8 <__addtf3+0x884>
   18c2c: 6f f0 9f d7  	j	0x189a4 <__addtf3+0x860>
   18c30: 93 06 00 00  	li	a3, 0
   18c34: e3 92 85 8a  	bne	a1, s0, 0x184d8 <__addtf3+0x394>
   18c38: 6f f0 9f 87  	j	0x184b0 <__addtf3+0x36c>

0000000000018c3c <__netf2>:
   18c3c: 13 08 05 00  	mv	a6, a0
   18c40: f3 27 20 00  	csrr	a5, frm
   18c44: 37 85 00 00  	lui	a0, 8
   18c48: 93 d8 05 03  	srli	a7, a1, 48
   18c4c: 13 05 f5 ff  	addi	a0, a0, -1
   18c50: 93 07 f0 ff  	li	a5, -1
   18c54: 93 d7 07 01  	srli	a5, a5, 16
   18c58: 13 d3 06 03  	srli	t1, a3, 48
   18c5c: b3 f8 a8 00  	and	a7, a7, a0
   18c60: 33 f7 f5 00  	and	a4, a1, a5
   18c64: 33 73 a3 00  	and	t1, t1, a0
   18c68: b3 f7 f6 00  	and	a5, a3, a5
   18c6c: 93 d5 f5 03  	srli	a1, a1, 63
   18c70: 93 d6 f6 03  	srli	a3, a3, 63
   18c74: 63 9a a8 00  	bne	a7, a0, 0x18c88 <__netf2+0x4c>
   18c78: 33 65 07 01  	or	a0, a4, a6
   18c7c: 63 16 05 02  	bnez	a0, 0x18ca8 <__netf2+0x6c>
   18c80: 63 18 13 05  	bne	t1, a7, 0x18cd0 <__netf2+0x94>
   18c84: 6f 00 80 00  	j	0x18c8c <__netf2+0x50>
   18c88: 63 18 a3 04  	bne	t1, a0, 0x18cd8 <__netf2+0x9c>
   18c8c: 33 e5 c7 00  	or	a0, a5, a2
   18c90: 63 04 05 04  	beqz	a0, 0x18cd8 <__netf2+0x9c>
   18c94: b7 86 00 00  	lui	a3, 8
   18c98: 93 86 f6 ff  	addi	a3, a3, -1
   18c9c: 63 96 d8 02  	bne	a7, a3, 0x18cc8 <__netf2+0x8c>
   18ca0: 33 65 07 01  	or	a0, a4, a6
   18ca4: 63 02 05 02  	beqz	a0, 0x18cc8 <__netf2+0x8c>
   18ca8: 13 57 f7 02  	srli	a4, a4, 47
   18cac: 63 0c 07 04  	beqz	a4, 0x18d04 <__netf2+0xc8>
   18cb0: 37 87 00 00  	lui	a4, 8
   18cb4: 13 07 f7 ff  	addi	a4, a4, -1
   18cb8: 13 05 10 00  	li	a0, 1
   18cbc: 63 1c e3 00  	bne	t1, a4, 0x18cd4 <__netf2+0x98>
   18cc0: 33 e6 c7 00  	or	a2, a5, a2
   18cc4: 63 08 06 00  	beqz	a2, 0x18cd4 <__netf2+0x98>
   18cc8: 93 d7 f7 02  	srli	a5, a5, 47
   18ccc: 63 8c 07 02  	beqz	a5, 0x18d04 <__netf2+0xc8>
   18cd0: 13 05 10 00  	li	a0, 1
   18cd4: 67 80 00 00  	ret
   18cd8: 13 05 10 00  	li	a0, 1
   18cdc: e3 9c 68 fe  	bne	a7, t1, 0x18cd4 <__netf2+0x98>
   18ce0: e3 1a f7 fe  	bne	a4, a5, 0x18cd4 <__netf2+0x98>
   18ce4: e3 18 c8 fe  	bne	a6, a2, 0x18cd4 <__netf2+0x98>
   18ce8: 63 8a d5 00  	beq	a1, a3, 0x18cfc <__netf2+0xc0>
   18cec: e3 94 08 fe  	bnez	a7, 0x18cd4 <__netf2+0x98>
   18cf0: 33 65 07 01  	or	a0, a4, a6
   18cf4: 33 35 a0 00  	snez	a0, a0
   18cf8: 67 80 00 00  	ret
   18cfc: 13 05 00 00  	li	a0, 0
   18d00: 67 80 00 00  	ret
   18d04: 73 60 18 00  	csrsi	fflags, 16
   18d08: 6f f0 9f fc  	j	0x18cd0 <__netf2+0x94>

0000000000018d0c <__multf3>:
   18d0c: 13 01 01 fa  	addi	sp, sp, -96
   18d10: 23 30 61 03  	sd	s6, 32(sp)
   18d14: 23 34 91 01  	sd	s9, 8(sp)
   18d18: 23 3c 11 04  	sd	ra, 88(sp)
   18d1c: 23 38 81 04  	sd	s0, 80(sp)
   18d20: 23 34 91 04  	sd	s1, 72(sp)
   18d24: 23 30 21 05  	sd	s2, 64(sp)
   18d28: 23 3c 31 03  	sd	s3, 56(sp)
   18d2c: 23 38 41 03  	sd	s4, 48(sp)
   18d30: 23 34 51 03  	sd	s5, 40(sp)
   18d34: 23 3c 71 01  	sd	s7, 24(sp)
   18d38: 23 38 81 01  	sd	s8, 16(sp)
   18d3c: 93 0c 06 00  	mv	s9, a2
   18d40: 13 8b 06 00  	mv	s6, a3
   18d44: 73 29 20 00  	csrr	s2, frm
   18d48: 37 87 00 00  	lui	a4, 8
   18d4c: 93 da 05 03  	srli	s5, a1, 48
   18d50: 13 07 f7 ff  	addi	a4, a4, -1
   18d54: 93 99 05 01  	slli	s3, a1, 16
   18d58: b3 f7 ea 00  	and	a5, s5, a4
   18d5c: 1b 09 09 00  	sext.w	s2, s2
   18d60: 93 d9 09 01  	srli	s3, s3, 16
   18d64: 93 db f5 03  	srli	s7, a1, 63
   18d68: 63 82 07 04  	beqz	a5, 0x18dac <__multf3+0xa0>
   18d6c: 13 0a 05 00  	mv	s4, a0
   18d70: 9b 8a 07 00  	sext.w	s5, a5
   18d74: 63 86 e7 0a  	beq	a5, a4, 0x18e20 <__multf3+0x114>
   18d78: 93 99 39 00  	slli	s3, s3, 3
   18d7c: 13 57 d5 03  	srli	a4, a0, 61
   18d80: 33 67 37 01  	or	a4, a4, s3
   18d84: b7 ca ff ff  	lui	s5, 1048572
   18d88: 93 09 10 00  	li	s3, 1
   18d8c: 93 99 39 03  	slli	s3, s3, 51
   18d90: 93 8a 1a 00  	addi	s5, s5, 1
   18d94: b3 69 37 01  	or	s3, a4, s3
   18d98: 13 1a 35 00  	slli	s4, a0, 3
   18d9c: b3 8a 57 01  	add	s5, a5, s5
   18da0: 13 0c 00 00  	li	s8, 0
   18da4: 93 04 00 00  	li	s1, 0
   18da8: 6f 00 40 09  	j	0x18e3c <__multf3+0x130>
   18dac: b3 e7 a9 00  	or	a5, s3, a0
   18db0: 13 04 05 00  	mv	s0, a0
   18db4: 63 8e 07 10  	beqz	a5, 0x18ed0 <__multf3+0x1c4>
   18db8: 63 86 09 04  	beqz	s3, 0x18e04 <__multf3+0xf8>
   18dbc: 13 85 09 00  	mv	a0, s3
   18dc0: ef 10 40 65  	jal	0x1a414 <__clzdi2>
   18dc4: 9b 07 05 00  	sext.w	a5, a0
   18dc8: 93 86 17 ff  	addi	a3, a5, -15
   18dcc: 13 06 c0 03  	li	a2, 60
   18dd0: 1b 87 06 00  	sext.w	a4, a3
   18dd4: 63 4e d6 02  	blt	a2, a3, 0x18e10 <__multf3+0x104>
   18dd8: 93 06 d0 03  	li	a3, 61
   18ddc: 1b 0a 37 00  	addiw	s4, a4, 3
   18de0: 3b 87 e6 40  	subw	a4, a3, a4
   18de4: b3 99 49 01  	sll	s3, s3, s4
   18de8: 33 57 e4 00  	srl	a4, s0, a4
   18dec: b3 69 37 01  	or	s3, a4, s3
   18df0: 33 1a 44 01  	sll	s4, s0, s4
   18df4: b7 ca ff ff  	lui	s5, 1048572
   18df8: 93 8a 1a 01  	addi	s5, s5, 17
   18dfc: b3 8a fa 40  	sub	s5, s5, a5
   18e00: 6f f0 1f fa  	j	0x18da0 <__multf3+0x94>
   18e04: ef 10 00 61  	jal	0x1a414 <__clzdi2>
   18e08: 9b 07 05 04  	addiw	a5, a0, 64
   18e0c: 6f f0 df fb  	j	0x18dc8 <__multf3+0xbc>
   18e10: 1b 07 37 fc  	addiw	a4, a4, -61
   18e14: b3 19 e4 00  	sll	s3, s0, a4
   18e18: 13 0a 00 00  	li	s4, 0
   18e1c: 6f f0 9f fd  	j	0x18df4 <__multf3+0xe8>
   18e20: b3 e7 a9 00  	or	a5, s3, a0
   18e24: 63 80 07 0c  	beqz	a5, 0x18ee4 <__multf3+0x1d8>
   18e28: 93 d7 f9 02  	srli	a5, s3, 47
   18e2c: 93 f7 17 00  	andi	a5, a5, 1
   18e30: 13 0c 30 00  	li	s8, 3
   18e34: 93 04 00 01  	li	s1, 16
   18e38: e3 96 07 f6  	bnez	a5, 0x18da4 <__multf3+0x98>
   18e3c: b7 86 00 00  	lui	a3, 8
   18e40: 13 55 0b 03  	srli	a0, s6, 48
   18e44: 93 86 f6 ff  	addi	a3, a3, -1
   18e48: 13 14 0b 01  	slli	s0, s6, 16
   18e4c: 33 77 d5 00  	and	a4, a0, a3
   18e50: 93 87 0c 00  	mv	a5, s9
   18e54: 13 54 04 01  	srli	s0, s0, 16
   18e58: 13 5b fb 03  	srli	s6, s6, 63
   18e5c: 63 0c 07 08  	beqz	a4, 0x18ef4 <__multf3+0x1e8>
   18e60: 1b 05 07 00  	sext.w	a0, a4
   18e64: 63 02 d7 10  	beq	a4, a3, 0x18f68 <__multf3+0x25c>
   18e68: 13 14 34 00  	slli	s0, s0, 3
   18e6c: 93 d6 dc 03  	srli	a3, s9, 61
   18e70: b3 e6 86 00  	or	a3, a3, s0
   18e74: 37 c5 ff ff  	lui	a0, 1048572
   18e78: 13 04 10 00  	li	s0, 1
   18e7c: 13 14 34 03  	slli	s0, s0, 51
   18e80: 13 05 15 00  	addi	a0, a0, 1
   18e84: 33 e4 86 00  	or	s0, a3, s0
   18e88: 93 97 3c 00  	slli	a5, s9, 3
   18e8c: 33 05 a7 00  	add	a0, a4, a0
   18e90: 13 07 00 00  	li	a4, 0
   18e94: 93 16 2c 00  	slli	a3, s8, 2
   18e98: b3 e6 e6 00  	or	a3, a3, a4
   18e9c: b3 0a 55 01  	add	s5, a0, s5
   18ea0: 93 86 f6 ff  	addi	a3, a3, -1
   18ea4: 93 05 e0 00  	li	a1, 14
   18ea8: 33 c6 6b 01  	xor	a2, s7, s6
   18eac: 13 88 1a 00  	addi	a6, s5, 1
   18eb0: 63 ee d5 16  	bltu	a1, a3, 0x1902c <__multf3+0x320>
   18eb4: 97 35 00 00  	auipc	a1, 3
   18eb8: 93 85 c5 e8  	addi	a1, a1, -372
   18ebc: 93 96 26 00  	slli	a3, a3, 2
   18ec0: b3 86 b6 00  	add	a3, a3, a1
   18ec4: 83 a6 06 00  	lw	a3, 0(a3)
   18ec8: b3 86 b6 00  	add	a3, a3, a1
   18ecc: 67 80 06 00  	jr	a3
   18ed0: 93 09 00 00  	li	s3, 0
   18ed4: 13 0a 00 00  	li	s4, 0
   18ed8: 93 0a 00 00  	li	s5, 0
   18edc: 13 0c 10 00  	li	s8, 1
   18ee0: 6f f0 5f ec  	j	0x18da4 <__multf3+0x98>
   18ee4: 93 09 00 00  	li	s3, 0
   18ee8: 13 0a 00 00  	li	s4, 0
   18eec: 13 0c 20 00  	li	s8, 2
   18ef0: 6f f0 5f eb  	j	0x18da4 <__multf3+0x98>
   18ef4: b3 e7 8c 00  	or	a5, s9, s0
   18ef8: 63 88 07 08  	beqz	a5, 0x18f88 <__multf3+0x27c>
   18efc: 63 06 04 04  	beqz	s0, 0x18f48 <__multf3+0x23c>
   18f00: 13 05 04 00  	mv	a0, s0
   18f04: ef 10 00 51  	jal	0x1a414 <__clzdi2>
   18f08: 1b 07 05 00  	sext.w	a4, a0
   18f0c: 93 07 17 ff  	addi	a5, a4, -15
   18f10: 13 06 c0 03  	li	a2, 60
   18f14: 9b 86 07 00  	sext.w	a3, a5
   18f18: 63 40 f6 04  	blt	a2, a5, 0x18f58 <__multf3+0x24c>
   18f1c: 13 06 d0 03  	li	a2, 61
   18f20: 9b 87 36 00  	addiw	a5, a3, 3
   18f24: bb 06 d6 40  	subw	a3, a2, a3
   18f28: 33 14 f4 00  	sll	s0, s0, a5
   18f2c: b3 d6 dc 00  	srl	a3, s9, a3
   18f30: 33 e4 86 00  	or	s0, a3, s0
   18f34: b3 97 fc 00  	sll	a5, s9, a5
   18f38: 37 c5 ff ff  	lui	a0, 1048572
   18f3c: 13 05 15 01  	addi	a0, a0, 17
   18f40: 33 05 e5 40  	sub	a0, a0, a4
   18f44: 6f f0 df f4  	j	0x18e90 <__multf3+0x184>
   18f48: 13 85 0c 00  	mv	a0, s9
   18f4c: ef 10 80 4c  	jal	0x1a414 <__clzdi2>
   18f50: 1b 07 05 04  	addiw	a4, a0, 64
   18f54: 6f f0 9f fb  	j	0x18f0c <__multf3+0x200>
   18f58: 9b 86 36 fc  	addiw	a3, a3, -61
   18f5c: 33 94 dc 00  	sll	s0, s9, a3
   18f60: 93 07 00 00  	li	a5, 0
   18f64: 6f f0 5f fd  	j	0x18f38 <__multf3+0x22c>
   18f68: 33 e7 8c 00  	or	a4, s9, s0
   18f6c: 63 08 07 02  	beqz	a4, 0x18f9c <__multf3+0x290>
   18f70: 13 57 f4 02  	srli	a4, s0, 47
   18f74: 13 77 17 00  	andi	a4, a4, 1
   18f78: 63 1a 07 02  	bnez	a4, 0x18fac <__multf3+0x2a0>
   18f7c: 13 07 30 00  	li	a4, 3
   18f80: 93 04 00 01  	li	s1, 16
   18f84: 6f f0 1f f1  	j	0x18e94 <__multf3+0x188>
   18f88: 13 04 00 00  	li	s0, 0
   18f8c: 93 07 00 00  	li	a5, 0
   18f90: 13 05 00 00  	li	a0, 0
   18f94: 13 07 10 00  	li	a4, 1
   18f98: 6f f0 df ef  	j	0x18e94 <__multf3+0x188>
   18f9c: 13 04 00 00  	li	s0, 0
   18fa0: 93 07 00 00  	li	a5, 0
   18fa4: 13 07 20 00  	li	a4, 2
   18fa8: 6f f0 df ee  	j	0x18e94 <__multf3+0x188>
   18fac: 13 07 30 00  	li	a4, 3
   18fb0: 6f f0 5f ee  	j	0x18e94 <__multf3+0x188>
   18fb4: 13 04 10 00  	li	s0, 1
   18fb8: 37 87 00 00  	lui	a4, 8
   18fbc: 13 14 f4 02  	slli	s0, s0, 47
   18fc0: 13 05 00 00  	li	a0, 0
   18fc4: 13 07 f7 ff  	addi	a4, a4, -1
   18fc8: 13 06 00 00  	li	a2, 0
   18fcc: 93 04 00 01  	li	s1, 16
   18fd0: 13 17 17 03  	slli	a4, a4, 49
   18fd4: 13 57 17 03  	srli	a4, a4, 49
   18fd8: 13 16 f6 00  	slli	a2, a2, 15
   18fdc: 13 14 04 01  	slli	s0, s0, 16
   18fe0: 33 67 e6 00  	or	a4, a2, a4
   18fe4: 13 17 07 03  	slli	a4, a4, 48
   18fe8: 93 55 04 01  	srli	a1, s0, 16
   18fec: b3 e5 e5 00  	or	a1, a1, a4
   18ff0: 63 84 04 00  	beqz	s1, 0x18ff8 <__multf3+0x2ec>
   18ff4: 73 a0 14 00  	csrs	fflags, s1
   18ff8: 83 30 81 05  	ld	ra, 88(sp)
   18ffc: 03 34 01 05  	ld	s0, 80(sp)
   19000: 83 34 81 04  	ld	s1, 72(sp)
   19004: 03 39 01 04  	ld	s2, 64(sp)
   19008: 83 39 81 03  	ld	s3, 56(sp)
   1900c: 03 3a 01 03  	ld	s4, 48(sp)
   19010: 83 3a 81 02  	ld	s5, 40(sp)
   19014: 03 3b 01 02  	ld	s6, 32(sp)
   19018: 83 3b 81 01  	ld	s7, 24(sp)
   1901c: 03 3c 01 01  	ld	s8, 16(sp)
   19020: 83 3c 81 00  	ld	s9, 8(sp)
   19024: 13 01 01 06  	addi	sp, sp, 96
   19028: 67 80 00 00  	ret
   1902c: 13 05 f0 ff  	li	a0, -1
   19030: 13 55 05 02  	srli	a0, a0, 32
   19034: b3 83 49 01  	add	t2, s3, s4
   19038: 33 8f 87 00  	add	t5, a5, s0
   1903c: 93 5e 0a 02  	srli	t4, s4, 32
   19040: 93 d6 07 02  	srli	a3, a5, 32
   19044: b3 bf 43 01  	sltu	t6, t2, s4
   19048: b3 32 ff 00  	sltu	t0, t5, a5
   1904c: 33 7a aa 00  	and	s4, s4, a0
   19050: b3 f7 a7 00  	and	a5, a5, a0
   19054: 33 85 47 03  	<unknown>
   19058: 13 8e 0f 00  	mv	t3, t6
   1905c: 13 83 02 00  	mv	t1, t0
   19060: b3 87 fe 02  	<unknown>
   19064: 33 87 de 02  	<unknown>
   19068: b3 86 46 03  	<unknown>
   1906c: 13 5a 05 02  	srli	s4, a0, 32
   19070: b3 86 f6 00  	add	a3, a3, a5
   19074: 33 0a da 00  	add	s4, s4, a3
   19078: 63 78 fa 00  	bgeu	s4, a5, 0x19088 <__multf3+0x37c>
   1907c: 93 07 10 00  	li	a5, 1
   19080: 93 97 07 02  	slli	a5, a5, 32
   19084: 33 07 f7 00  	add	a4, a4, a5
   19088: 93 06 f0 ff  	li	a3, -1
   1908c: 93 d6 06 02  	srli	a3, a3, 32
   19090: b3 75 da 00  	and	a1, s4, a3
   19094: 33 75 d5 00  	and	a0, a0, a3
   19098: 93 95 05 02  	slli	a1, a1, 32
   1909c: 93 d8 03 02  	srli	a7, t2, 32
   190a0: 93 57 0f 02  	srli	a5, t5, 32
   190a4: 93 5e 0a 02  	srli	t4, s4, 32
   190a8: b3 85 a5 00  	add	a1, a1, a0
   190ac: 33 f5 d3 00  	and	a0, t2, a3
   190b0: b3 76 df 00  	and	a3, t5, a3
   190b4: 33 8b f8 02  	<unknown>
   190b8: b3 8e ee 00  	add	t4, t4, a4
   190bc: b3 87 a7 02  	<unknown>
   190c0: 33 87 a6 02  	<unknown>
   190c4: b3 86 d8 02  	<unknown>
   190c8: 33 85 d7 00  	add	a0, a5, a3
   190cc: 93 57 07 02  	srli	a5, a4, 32
   190d0: b3 87 a7 00  	add	a5, a5, a0
   190d4: 63 f8 d7 00  	bgeu	a5, a3, 0x190e4 <__multf3+0x3d8>
   190d8: 93 06 10 00  	li	a3, 1
   190dc: 93 96 06 02  	slli	a3, a3, 32
   190e0: 33 0b db 00  	add	s6, s6, a3
   190e4: 93 08 f0 ff  	li	a7, -1
   190e8: 93 d8 08 02  	srli	a7, a7, 32
   190ec: b3 f6 17 01  	and	a3, a5, a7
   190f0: 93 5b 04 02  	srli	s7, s0, 32
   190f4: 33 75 17 01  	and	a0, a4, a7
   190f8: 13 da 07 02  	srli	s4, a5, 32
   190fc: 93 d7 09 02  	srli	a5, s3, 32
   19100: b3 f9 19 01  	and	s3, s3, a7
   19104: b3 78 14 01  	and	a7, s0, a7
   19108: 33 84 19 03  	<unknown>
   1910c: 93 96 06 02  	slli	a3, a3, 32
   19110: 33 85 a6 00  	add	a0, a3, a0
   19114: b3 88 17 03  	<unknown>
   19118: b3 87 77 03  	<unknown>
   1911c: b3 8b 3b 03  	<unknown>
   19120: 93 59 04 02  	srli	s3, s0, 32
   19124: b3 8b 1b 01  	add	s7, s7, a7
   19128: b3 89 79 01  	add	s3, s3, s7
   1912c: 63 f8 19 01  	bgeu	s3, a7, 0x1913c <__multf3+0x430>
   19130: 13 07 10 00  	li	a4, 1
   19134: 13 17 07 02  	slli	a4, a4, 32
   19138: b3 87 e7 00  	add	a5, a5, a4
   1913c: 93 d6 09 02  	srli	a3, s3, 32
   19140: b3 87 f6 00  	add	a5, a3, a5
   19144: 93 06 f0 ff  	li	a3, -1
   19148: 93 d6 06 02  	srli	a3, a3, 32
   1914c: 33 f7 d9 00  	and	a4, s3, a3
   19150: 33 74 d4 00  	and	s0, s0, a3
   19154: b3 06 d5 01  	add	a3, a0, t4
   19158: 33 b5 d6 01  	sltu	a0, a3, t4
   1915c: b3 08 aa 00  	add	a7, s4, a0
   19160: 33 03 60 40  	neg	t1, t1
   19164: b3 88 68 01  	add	a7, a7, s6
   19168: b3 73 73 00  	and	t2, t1, t2
   1916c: 33 0e c0 41  	neg	t3, t3
   19170: b3 83 13 01  	add	t2, t2, a7
   19174: 33 7f ee 01  	and	t5, t3, t5
   19178: 33 b5 a8 00  	sltu	a0, a7, a0
   1917c: b3 ff 5f 00  	and	t6, t6, t0
   19180: 33 0f 7f 00  	add	t5, t5, t2
   19184: b3 b8 13 01  	sltu	a7, t2, a7
   19188: 33 05 f5 01  	add	a0, a0, t6
   1918c: 33 83 b6 40  	sub	t1, a3, a1
   19190: 33 05 15 01  	add	a0, a0, a7
   19194: 33 be 66 00  	sltu	t3, a3, t1
   19198: b3 08 df 41  	sub	a7, t5, t4
   1919c: 13 17 07 02  	slli	a4, a4, 32
   191a0: b3 33 7f 00  	sltu	t2, t5, t2
   191a4: b3 3f 1f 01  	sltu	t6, t5, a7
   191a8: 33 07 87 00  	add	a4, a4, s0
   191ac: b3 88 c8 41  	sub	a7, a7, t3
   191b0: 33 05 75 00  	add	a0, a0, t2
   191b4: 13 0e 00 00  	li	t3, 0
   191b8: 63 f6 66 00  	bgeu	a3, t1, 0x191c4 <__multf3+0x4b8>
   191bc: 33 8f ee 41  	sub	t5, t4, t5
   191c0: 13 3e 1f 00  	seqz	t3, t5
   191c4: 33 6f fe 01  	or	t5, t3, t6
   191c8: 33 0e e3 40  	sub	t3, t1, a4
   191cc: b3 86 f8 40  	sub	a3, a7, a5
   191d0: 33 05 f5 00  	add	a0, a0, a5
   191d4: b3 37 c3 01  	sltu	a5, t1, t3
   191d8: b3 b8 d8 00  	sltu	a7, a7, a3
   191dc: b3 07 f7 40  	sub	a5, a4, a5
   191e0: 93 0e 00 00  	li	t4, 0
   191e4: 63 74 c3 01  	bgeu	t1, t3, 0x191ec <__multf3+0x4e0>
   191e8: 93 be 16 00  	seqz	t4, a3
   191ec: b3 86 f6 00  	add	a3, a3, a5
   191f0: 33 b7 e6 00  	sltu	a4, a3, a4
   191f4: 33 07 a7 00  	add	a4, a4, a0
   191f8: 33 07 e7 41  	sub	a4, a4, t5
   191fc: b3 e8 1e 01  	or	a7, t4, a7
   19200: 33 07 17 41  	sub	a4, a4, a7
   19204: 93 17 de 00  	slli	a5, t3, 13
   19208: 13 17 d7 00  	slli	a4, a4, 13
   1920c: 13 d4 36 03  	srli	s0, a3, 51
   19210: b3 e7 b7 00  	or	a5, a5, a1
   19214: 33 64 87 00  	or	s0, a4, s0
   19218: b3 37 f0 00  	snez	a5, a5
   1921c: 13 55 3e 03  	srli	a0, t3, 51
   19220: 13 57 47 03  	srli	a4, a4, 52
   19224: b3 e7 a7 00  	or	a5, a5, a0
   19228: 93 96 d6 00  	slli	a3, a3, 13
   1922c: 13 77 17 00  	andi	a4, a4, 1
   19230: b3 e7 d7 00  	or	a5, a5, a3
   19234: 63 04 07 0a  	beqz	a4, 0x192dc <__multf3+0x5d0>
   19238: 13 d7 17 00  	srli	a4, a5, 1
   1923c: 93 f7 17 00  	andi	a5, a5, 1
   19240: 13 15 f4 03  	slli	a0, s0, 63
   19244: b3 67 f7 00  	or	a5, a4, a5
   19248: b3 e7 a7 00  	or	a5, a5, a0
   1924c: 13 54 14 00  	srli	s0, s0, 1
   19250: 37 47 00 00  	lui	a4, 4
   19254: 13 07 f7 ff  	addi	a4, a4, -1
   19258: 33 07 e8 00  	add	a4, a6, a4
   1925c: 63 52 e0 12  	blez	a4, 0x19380 <__multf3+0x674>
   19260: 93 f6 77 00  	andi	a3, a5, 7
   19264: 63 88 06 08  	beqz	a3, 0x192f4 <__multf3+0x5e8>
   19268: 93 06 20 00  	li	a3, 2
   1926c: 93 e4 14 00  	ori	s1, s1, 1
   19270: 63 00 d9 08  	beq	s2, a3, 0x192f0 <__multf3+0x5e4>
   19274: 93 06 30 00  	li	a3, 3
   19278: 63 06 d9 06  	beq	s2, a3, 0x192e4 <__multf3+0x5d8>
   1927c: 63 1c 09 06  	bnez	s2, 0x192f4 <__multf3+0x5e8>
   19280: 93 f6 f7 00  	andi	a3, a5, 15
   19284: 93 05 40 00  	li	a1, 4
   19288: 63 86 b6 06  	beq	a3, a1, 0x192f4 <__multf3+0x5e8>
   1928c: 93 86 47 00  	addi	a3, a5, 4
   19290: b3 b7 f6 00  	sltu	a5, a3, a5
   19294: 33 04 f4 00  	add	s0, s0, a5
   19298: 93 87 06 00  	mv	a5, a3
   1929c: 6f 00 80 05  	j	0x192f4 <__multf3+0x5e8>
   192a0: 13 86 0b 00  	mv	a2, s7
   192a4: 13 84 09 00  	mv	s0, s3
   192a8: 93 07 0a 00  	mv	a5, s4
   192ac: 13 07 0c 00  	mv	a4, s8
   192b0: 93 06 20 00  	li	a3, 2
   192b4: 63 00 d7 2a  	beq	a4, a3, 0x19554 <__multf3+0x848>
   192b8: 93 06 30 00  	li	a3, 3
   192bc: 63 06 d7 2a  	beq	a4, a3, 0x19568 <__multf3+0x85c>
   192c0: 93 06 10 00  	li	a3, 1
   192c4: e3 16 d7 f8  	bne	a4, a3, 0x19250 <__multf3+0x544>
   192c8: 13 04 00 00  	li	s0, 0
   192cc: 13 05 00 00  	li	a0, 0
   192d0: 6f 00 00 26  	j	0x19530 <__multf3+0x824>
   192d4: 13 06 0b 00  	mv	a2, s6
   192d8: 6f f0 9f fd  	j	0x192b0 <__multf3+0x5a4>
   192dc: 13 88 0a 00  	mv	a6, s5
   192e0: 6f f0 1f f7  	j	0x19250 <__multf3+0x544>
   192e4: 63 18 06 00  	bnez	a2, 0x192f4 <__multf3+0x5e8>
   192e8: 93 86 87 00  	addi	a3, a5, 8
   192ec: 6f f0 5f fa  	j	0x19290 <__multf3+0x584>
   192f0: e3 1c 06 fe  	bnez	a2, 0x192e8 <__multf3+0x5dc>
   192f4: 93 56 44 03  	srli	a3, s0, 52
   192f8: 93 f6 16 00  	andi	a3, a3, 1
   192fc: 63 8e 06 00  	beqz	a3, 0x19318 <__multf3+0x60c>
   19300: 13 07 f0 ff  	li	a4, -1
   19304: 13 17 47 03  	slli	a4, a4, 52
   19308: 13 07 f7 ff  	addi	a4, a4, -1
   1930c: 33 74 e4 00  	and	s0, s0, a4
   19310: 37 47 00 00  	lui	a4, 4
   19314: 33 07 e8 00  	add	a4, a6, a4
   19318: b7 86 00 00  	lui	a3, 8
   1931c: 93 85 e6 ff  	addi	a1, a3, -2
   19320: 63 cc e5 00  	blt	a1, a4, 0x19338 <__multf3+0x62c>
   19324: 13 15 d4 03  	slli	a0, s0, 61
   19328: 93 d7 37 00  	srli	a5, a5, 3
   1932c: 33 65 f5 00  	or	a0, a0, a5
   19330: 13 54 34 00  	srli	s0, s0, 3
   19334: 6f f0 df c9  	j	0x18fd0 <__multf3+0x2c4>
   19338: 93 07 20 00  	li	a5, 2
   1933c: 63 0a f9 02  	beq	s2, a5, 0x19370 <__multf3+0x664>
   19340: 93 07 30 00  	li	a5, 3
   19344: 13 87 f6 ff  	addi	a4, a3, -1
   19348: 63 08 f9 00  	beq	s2, a5, 0x19358 <__multf3+0x64c>
   1934c: 63 18 09 00  	bnez	s2, 0x1935c <__multf3+0x650>
   19350: 13 05 00 00  	li	a0, 0
   19354: 6f 00 00 01  	j	0x19364 <__multf3+0x658>
   19358: e3 0c 06 fe  	beqz	a2, 0x19350 <__multf3+0x644>
   1935c: 13 05 f0 ff  	li	a0, -1
   19360: 13 87 05 00  	mv	a4, a1
   19364: 93 e4 54 00  	ori	s1, s1, 5
   19368: 13 04 05 00  	mv	s0, a0
   1936c: 6f f0 5f c6  	j	0x18fd0 <__multf3+0x2c4>
   19370: e3 06 06 fe  	beqz	a2, 0x1935c <__multf3+0x650>
   19374: 13 05 00 00  	li	a0, 0
   19378: 13 87 f6 ff  	addi	a4, a3, -1
   1937c: 6f f0 9f fe  	j	0x19364 <__multf3+0x658>
   19380: 93 06 10 00  	li	a3, 1
   19384: 63 14 07 06  	bnez	a4, 0x193ec <__multf3+0x6e0>
   19388: 93 f5 77 00  	andi	a1, a5, 7
   1938c: 93 06 04 00  	mv	a3, s0
   19390: 63 88 05 04  	beqz	a1, 0x193e0 <__multf3+0x6d4>
   19394: 93 05 20 00  	li	a1, 2
   19398: 93 e4 14 00  	ori	s1, s1, 1
   1939c: 63 00 b9 04  	beq	s2, a1, 0x193dc <__multf3+0x6d0>
   193a0: 93 05 30 00  	li	a1, 3
   193a4: 63 06 b9 02  	beq	s2, a1, 0x193d0 <__multf3+0x6c4>
   193a8: 63 1c 09 02  	bnez	s2, 0x193e0 <__multf3+0x6d4>
   193ac: 93 f5 f7 00  	andi	a1, a5, 15
   193b0: 13 05 40 00  	li	a0, 4
   193b4: 63 86 a5 02  	beq	a1, a0, 0x193e0 <__multf3+0x6d4>
   193b8: 93 b6 c7 ff  	sltiu	a3, a5, -4
   193bc: 93 c6 16 00  	xori	a3, a3, 1
   193c0: 93 96 06 02  	slli	a3, a3, 32
   193c4: 93 d6 06 02  	srli	a3, a3, 32
   193c8: b3 86 86 00  	add	a3, a3, s0
   193cc: 6f 00 40 01  	j	0x193e0 <__multf3+0x6d4>
   193d0: 63 18 06 00  	bnez	a2, 0x193e0 <__multf3+0x6d4>
   193d4: 93 b6 87 ff  	sltiu	a3, a5, -8
   193d8: 6f f0 5f fe  	j	0x193bc <__multf3+0x6b0>
   193dc: e3 1c 06 fe  	bnez	a2, 0x193d4 <__multf3+0x6c8>
   193e0: 93 d6 46 03  	srli	a3, a3, 52
   193e4: 93 c6 16 00  	xori	a3, a3, 1
   193e8: 93 f6 16 00  	andi	a3, a3, 1
   193ec: 13 08 10 00  	li	a6, 1
   193f0: 33 08 e8 40  	sub	a6, a6, a4
   193f4: 13 07 40 07  	li	a4, 116
   193f8: 63 42 07 11  	blt	a4, a6, 0x194fc <__multf3+0x7f0>
   193fc: 93 05 f0 03  	li	a1, 63
   19400: 1b 07 08 00  	sext.w	a4, a6
   19404: 63 c4 05 07  	blt	a1, a6, 0x1946c <__multf3+0x760>
   19408: 93 05 00 04  	li	a1, 64
   1940c: bb 85 e5 40  	subw	a1, a1, a4
   19410: 33 15 b4 00  	sll	a0, s0, a1
   19414: 33 d8 e7 00  	srl	a6, a5, a4
   19418: b3 97 b7 00  	sll	a5, a5, a1
   1941c: 33 65 05 01  	or	a0, a0, a6
   19420: b3 37 f0 00  	snez	a5, a5
   19424: 33 65 f5 00  	or	a0, a0, a5
   19428: 33 54 e4 00  	srl	s0, s0, a4
   1942c: 93 77 75 00  	andi	a5, a0, 7
   19430: 63 80 07 08  	beqz	a5, 0x194b0 <__multf3+0x7a4>
   19434: 93 07 20 00  	li	a5, 2
   19438: 93 e4 14 00  	ori	s1, s1, 1
   1943c: 63 08 f9 06  	beq	s2, a5, 0x194ac <__multf3+0x7a0>
   19440: 93 07 30 00  	li	a5, 3
   19444: 63 0e f9 04  	beq	s2, a5, 0x194a0 <__multf3+0x794>
   19448: 63 14 09 06  	bnez	s2, 0x194b0 <__multf3+0x7a4>
   1944c: 93 77 f5 00  	andi	a5, a0, 15
   19450: 13 07 40 00  	li	a4, 4
   19454: 63 8e e7 04  	beq	a5, a4, 0x194b0 <__multf3+0x7a4>
   19458: 93 07 45 00  	addi	a5, a0, 4
   1945c: 33 b5 a7 00  	sltu	a0, a5, a0
   19460: 33 04 a4 00  	add	s0, s0, a0
   19464: 13 85 07 00  	mv	a0, a5
   19468: 6f 00 80 04  	j	0x194b0 <__multf3+0x7a4>
   1946c: 1b 05 07 fc  	addiw	a0, a4, -64
   19470: 93 08 00 04  	li	a7, 64
   19474: 33 55 a4 00  	srl	a0, s0, a0
   19478: 93 05 00 00  	li	a1, 0
   1947c: 63 08 18 01  	beq	a6, a7, 0x1948c <__multf3+0x780>
   19480: 93 05 00 08  	li	a1, 128
   19484: 3b 87 e5 40  	subw	a4, a1, a4
   19488: b3 15 e4 00  	sll	a1, s0, a4
   1948c: b3 e7 f5 00  	or	a5, a1, a5
   19490: b3 37 f0 00  	snez	a5, a5
   19494: 33 65 f5 00  	or	a0, a0, a5
   19498: 13 04 00 00  	li	s0, 0
   1949c: 6f f0 1f f9  	j	0x1942c <__multf3+0x720>
   194a0: 63 18 06 00  	bnez	a2, 0x194b0 <__multf3+0x7a4>
   194a4: 93 07 85 00  	addi	a5, a0, 8
   194a8: 6f f0 5f fb  	j	0x1945c <__multf3+0x750>
   194ac: e3 1c 06 fe  	bnez	a2, 0x194a4 <__multf3+0x798>
   194b0: 93 57 34 03  	srli	a5, s0, 51
   194b4: 93 f7 17 00  	andi	a5, a5, 1
   194b8: 63 80 07 02  	beqz	a5, 0x194d8 <__multf3+0x7cc>
   194bc: 93 e4 14 00  	ori	s1, s1, 1
   194c0: 13 04 00 00  	li	s0, 0
   194c4: 13 05 00 00  	li	a0, 0
   194c8: 13 07 10 00  	li	a4, 1
   194cc: e3 82 06 b0  	beqz	a3, 0x18fd0 <__multf3+0x2c4>
   194d0: 93 e4 24 00  	ori	s1, s1, 2
   194d4: 6f f0 df af  	j	0x18fd0 <__multf3+0x2c4>
   194d8: 93 17 d4 03  	slli	a5, s0, 61
   194dc: 13 55 35 00  	srli	a0, a0, 3
   194e0: 33 e5 a7 00  	or	a0, a5, a0
   194e4: 13 54 34 00  	srli	s0, s0, 3
   194e8: 13 07 00 00  	li	a4, 0
   194ec: e3 82 06 ae  	beqz	a3, 0x18fd0 <__multf3+0x2c4>
   194f0: 93 f7 14 00  	andi	a5, s1, 1
   194f4: e3 8e 07 ac  	beqz	a5, 0x18fd0 <__multf3+0x2c4>
   194f8: 6f f0 9f fd  	j	0x194d0 <__multf3+0x7c4>
   194fc: 33 e5 87 00  	or	a0, a5, s0
   19500: 63 04 05 02  	beqz	a0, 0x19528 <__multf3+0x81c>
   19504: 93 07 20 00  	li	a5, 2
   19508: 93 e4 14 00  	ori	s1, s1, 1
   1950c: 63 0e f9 02  	beq	s2, a5, 0x19548 <__multf3+0x83c>
   19510: 93 07 30 00  	li	a5, 3
   19514: 63 02 f9 02  	beq	s2, a5, 0x19538 <__multf3+0x82c>
   19518: 93 07 10 00  	li	a5, 1
   1951c: 63 14 09 00  	bnez	s2, 0x19524 <__multf3+0x818>
   19520: 93 07 50 00  	li	a5, 5
   19524: 13 d5 37 00  	srli	a0, a5, 3
   19528: 93 e4 24 00  	ori	s1, s1, 2
   1952c: 13 04 00 00  	li	s0, 0
   19530: 13 07 00 00  	li	a4, 0
   19534: 6f f0 df a9  	j	0x18fd0 <__multf3+0x2c4>
   19538: 93 07 90 00  	li	a5, 9
   1953c: e3 04 06 fe  	beqz	a2, 0x19524 <__multf3+0x818>
   19540: 93 07 10 00  	li	a5, 1
   19544: 6f f0 1f fe  	j	0x19524 <__multf3+0x818>
   19548: 93 07 90 00  	li	a5, 9
   1954c: e3 1c 06 fc  	bnez	a2, 0x19524 <__multf3+0x818>
   19550: 6f f0 1f ff  	j	0x19540 <__multf3+0x834>
   19554: 37 87 00 00  	lui	a4, 8
   19558: 13 04 00 00  	li	s0, 0
   1955c: 13 05 00 00  	li	a0, 0
   19560: 13 07 f7 ff  	addi	a4, a4, -1
   19564: 6f f0 df a6  	j	0x18fd0 <__multf3+0x2c4>
   19568: 13 04 10 00  	li	s0, 1
   1956c: 37 87 00 00  	lui	a4, 8
   19570: 13 14 f4 02  	slli	s0, s0, 47
   19574: 13 05 00 00  	li	a0, 0
   19578: 13 07 f7 ff  	addi	a4, a4, -1
   1957c: 13 06 00 00  	li	a2, 0
   19580: 6f f0 1f a5  	j	0x18fd0 <__multf3+0x2c4>

0000000000019584 <__subtf3>:
   19584: 13 01 01 fd  	addi	sp, sp, -48
   19588: 23 34 11 02  	sd	ra, 40(sp)
   1958c: 23 30 81 02  	sd	s0, 32(sp)
   19590: 23 3c 91 00  	sd	s1, 24(sp)
   19594: 23 38 21 01  	sd	s2, 16(sp)
   19598: 23 34 31 01  	sd	s3, 8(sp)
   1959c: 23 30 41 01  	sd	s4, 0(sp)
   195a0: 73 24 20 00  	csrr	s0, frm
   195a4: 13 07 f0 ff  	li	a4, -1
   195a8: 13 57 07 01  	srli	a4, a4, 16
   195ac: 37 88 00 00  	lui	a6, 8
   195b0: 93 d8 05 03  	srli	a7, a1, 48
   195b4: 13 08 f8 ff  	addi	a6, a6, -1
   195b8: 93 de 06 03  	srli	t4, a3, 48
   195bc: 93 d4 f5 03  	srli	s1, a1, 63
   195c0: 13 d3 f6 03  	srli	t1, a3, 63
   195c4: b3 f5 e5 00  	and	a1, a1, a4
   195c8: b3 f6 e6 00  	and	a3, a3, a4
   195cc: 93 95 35 00  	slli	a1, a1, 3
   195d0: 93 57 d5 03  	srli	a5, a0, 61
   195d4: 13 57 d6 03  	srli	a4, a2, 61
   195d8: b3 f8 08 01  	and	a7, a7, a6
   195dc: b3 fe 0e 01  	and	t4, t4, a6
   195e0: 93 96 36 00  	slli	a3, a3, 3
   195e4: b3 e7 b7 00  	or	a5, a5, a1
   195e8: 1b 04 04 00  	sext.w	s0, s0
   195ec: 93 89 08 00  	mv	s3, a7
   195f0: 13 15 35 00  	slli	a0, a0, 3
   195f4: 93 85 0e 00  	mv	a1, t4
   195f8: 33 67 d7 00  	or	a4, a4, a3
   195fc: 13 16 36 00  	slli	a2, a2, 3
   19600: 63 96 0e 01  	bne	t4, a6, 0x1960c <__subtf3+0x88>
   19604: b3 66 c7 00  	or	a3, a4, a2
   19608: 63 94 06 00  	bnez	a3, 0x19610 <__subtf3+0x8c>
   1960c: 13 43 13 00  	xori	t1, t1, 1
   19610: bb 86 d8 41  	subw	a3, a7, t4
   19614: 37 8e 00 00  	lui	t3, 8
   19618: 1b 88 06 00  	sext.w	a6, a3
   1961c: 13 0f fe ff  	addi	t5, t3, -1
   19620: 63 16 93 4c  	bne	t1, s1, 0x19aec <__subtf3+0x568>
   19624: 63 5c 00 13  	blez	a6, 0x1975c <__subtf3+0x1d8>
   19628: 63 96 0e 0a  	bnez	t4, 0x196d4 <__subtf3+0x150>
   1962c: b3 65 c7 00  	or	a1, a4, a2
   19630: 63 9a 05 00  	bnez	a1, 0x19644 <__subtf3+0xc0>
   19634: 63 80 e8 09  	beq	a7, t5, 0x196b4 <__subtf3+0x130>
   19638: 13 87 07 00  	mv	a4, a5
   1963c: 93 85 08 00  	mv	a1, a7
   19640: 6f 00 10 10  	j	0x19f40 <__subtf3+0x9bc>
   19644: 1b 88 f6 ff  	addiw	a6, a3, -1
   19648: 63 14 08 06  	bnez	a6, 0x196b0 <__subtf3+0x12c>
   1964c: 33 06 a6 00  	add	a2, a2, a0
   19650: 33 35 a6 00  	sltu	a0, a2, a0
   19654: 33 07 f7 00  	add	a4, a4, a5
   19658: 33 07 a7 00  	add	a4, a4, a0
   1965c: 93 85 08 00  	mv	a1, a7
   19660: 13 05 06 00  	mv	a0, a2
   19664: 93 57 37 03  	srli	a5, a4, 51
   19668: 93 f7 17 00  	andi	a5, a5, 1
   1966c: e3 8a 07 0c  	beqz	a5, 0x19f40 <__subtf3+0x9bc>
   19670: b7 86 00 00  	lui	a3, 8
   19674: 93 85 15 00  	addi	a1, a1, 1
   19678: 93 87 f6 ff  	addi	a5, a3, -1
   1967c: 63 8e f5 42  	beq	a1, a5, 0x19ab8 <__subtf3+0x534>
   19680: 93 07 f0 ff  	li	a5, -1
   19684: 93 97 37 03  	slli	a5, a5, 51
   19688: 93 87 f7 ff  	addi	a5, a5, -1
   1968c: b3 77 f7 00  	and	a5, a4, a5
   19690: 13 57 15 00  	srli	a4, a0, 1
   19694: 13 75 15 00  	andi	a0, a0, 1
   19698: 33 65 a7 00  	or	a0, a4, a0
   1969c: 13 97 f7 03  	slli	a4, a5, 63
   196a0: 33 65 a7 00  	or	a0, a4, a0
   196a4: 93 d7 17 00  	srli	a5, a5, 1
   196a8: 13 08 00 00  	li	a6, 0
   196ac: 6f 00 00 39  	j	0x19a3c <__subtf3+0x4b8>
   196b0: 63 9a e8 03  	bne	a7, t5, 0x196e4 <__subtf3+0x160>
   196b4: 33 e7 a7 00  	or	a4, a5, a0
   196b8: e3 04 07 10  	beqz	a4, 0x19fc0 <__subtf3+0xa3c>
   196bc: 13 d7 27 03  	srli	a4, a5, 50
   196c0: 13 77 17 00  	andi	a4, a4, 1
   196c4: 93 85 08 00  	mv	a1, a7
   196c8: 13 08 00 00  	li	a6, 0
   196cc: 63 18 07 36  	bnez	a4, 0x19a3c <__subtf3+0x4b8>
   196d0: 6f 00 00 0c  	j	0x19790 <__subtf3+0x20c>
   196d4: e3 80 e8 ff  	beq	a7, t5, 0x196b4 <__subtf3+0x130>
   196d8: 93 06 10 00  	li	a3, 1
   196dc: 93 96 36 03  	slli	a3, a3, 51
   196e0: 33 67 d7 00  	or	a4, a4, a3
   196e4: 93 06 40 07  	li	a3, 116
   196e8: 63 c4 06 07  	blt	a3, a6, 0x19750 <__subtf3+0x1cc>
   196ec: 93 06 f0 03  	li	a3, 63
   196f0: 63 c6 06 03  	blt	a3, a6, 0x1971c <__subtf3+0x198>
   196f4: 93 05 00 04  	li	a1, 64
   196f8: bb 85 05 41  	subw	a1, a1, a6
   196fc: b3 16 b7 00  	sll	a3, a4, a1
   19700: 33 53 06 01  	srl	t1, a2, a6
   19704: 33 16 b6 00  	sll	a2, a2, a1
   19708: b3 e6 66 00  	or	a3, a3, t1
   1970c: 33 36 c0 00  	snez	a2, a2
   19710: 33 e6 c6 00  	or	a2, a3, a2
   19714: 33 57 07 01  	srl	a4, a4, a6
   19718: 6f f0 5f f3  	j	0x1964c <__subtf3+0xc8>
   1971c: 9b 06 08 fc  	addiw	a3, a6, -64
   19720: 13 03 00 04  	li	t1, 64
   19724: b3 56 d7 00  	srl	a3, a4, a3
   19728: 93 05 00 00  	li	a1, 0
   1972c: 63 08 68 00  	beq	a6, t1, 0x1973c <__subtf3+0x1b8>
   19730: 93 05 00 08  	li	a1, 128
   19734: bb 85 05 41  	subw	a1, a1, a6
   19738: b3 15 b7 00  	sll	a1, a4, a1
   1973c: 33 e6 c5 00  	or	a2, a1, a2
   19740: 33 36 c0 00  	snez	a2, a2
   19744: 33 e6 c6 00  	or	a2, a3, a2
   19748: 13 07 00 00  	li	a4, 0
   1974c: 6f f0 1f f0  	j	0x1964c <__subtf3+0xc8>
   19750: 33 66 c7 00  	or	a2, a4, a2
   19754: 33 36 c0 00  	snez	a2, a2
   19758: 6f f0 1f ff  	j	0x19748 <__subtf3+0x1c4>
   1975c: 63 00 08 12  	beqz	a6, 0x1987c <__subtf3+0x2f8>
   19760: 63 90 08 08  	bnez	a7, 0x197e0 <__subtf3+0x25c>
   19764: 33 e8 a7 00  	or	a6, a5, a0
   19768: 63 18 08 02  	bnez	a6, 0x19798 <__subtf3+0x214>
   1976c: 13 05 06 00  	mv	a0, a2
   19770: 63 98 ee 7d  	bne	t4, t5, 0x19f40 <__subtf3+0x9bc>
   19774: 33 65 c7 00  	or	a0, a4, a2
   19778: e3 08 05 02  	beqz	a0, 0x19fa8 <__subtf3+0xa24>
   1977c: 93 57 27 03  	srli	a5, a4, 50
   19780: 93 f7 17 00  	andi	a5, a5, 1
   19784: e3 98 07 02  	bnez	a5, 0x19fb4 <__subtf3+0xa30>
   19788: 93 07 07 00  	mv	a5, a4
   1978c: 13 05 06 00  	mv	a0, a2
   19790: 93 06 00 01  	li	a3, 16
   19794: 6f 00 40 14  	j	0x198d8 <__subtf3+0x354>
   19798: 93 c6 f6 ff  	not	a3, a3
   1979c: 9b 86 06 00  	sext.w	a3, a3
   197a0: 63 9c 06 00  	bnez	a3, 0x197b8 <__subtf3+0x234>
   197a4: 33 05 c5 00  	add	a0, a0, a2
   197a8: 33 87 e7 00  	add	a4, a5, a4
   197ac: 33 36 c5 00  	sltu	a2, a0, a2
   197b0: 33 07 c7 00  	add	a4, a4, a2
   197b4: 6f f0 1f eb  	j	0x19664 <__subtf3+0xe0>
   197b8: 63 9e ee 03  	bne	t4, t5, 0x197f4 <__subtf3+0x270>
   197bc: 33 65 c7 00  	or	a0, a4, a2
   197c0: 63 04 05 7e  	beqz	a0, 0x19fa8 <__subtf3+0xa24>
   197c4: 93 57 27 03  	srli	a5, a4, 50
   197c8: 93 f7 17 00  	andi	a5, a5, 1
   197cc: 63 94 07 7e  	bnez	a5, 0x19fb4 <__subtf3+0xa30>
   197d0: 93 07 07 00  	mv	a5, a4
   197d4: 13 05 06 00  	mv	a0, a2
   197d8: 13 08 00 00  	li	a6, 0
   197dc: 6f f0 5f fb  	j	0x19790 <__subtf3+0x20c>
   197e0: e3 8e ee fd  	beq	t4, t5, 0x197bc <__subtf3+0x238>
   197e4: 13 08 10 00  	li	a6, 1
   197e8: 13 18 38 03  	slli	a6, a6, 51
   197ec: bb 06 d0 40  	negw	a3, a3
   197f0: b3 e7 07 01  	or	a5, a5, a6
   197f4: 13 08 40 07  	li	a6, 116
   197f8: 63 4c d8 06  	blt	a6, a3, 0x19870 <__subtf3+0x2ec>
   197fc: 13 08 f0 03  	li	a6, 63
   19800: 63 4e d8 02  	blt	a6, a3, 0x1983c <__subtf3+0x2b8>
   19804: 93 08 00 04  	li	a7, 64
   19808: bb 88 d8 40  	subw	a7, a7, a3
   1980c: 33 53 d5 00  	srl	t1, a0, a3
   19810: 33 98 17 01  	sll	a6, a5, a7
   19814: 33 15 15 01  	sll	a0, a0, a7
   19818: 33 68 68 00  	or	a6, a6, t1
   1981c: 33 35 a0 00  	snez	a0, a0
   19820: 33 65 a8 00  	or	a0, a6, a0
   19824: b3 d6 d7 00  	srl	a3, a5, a3
   19828: 33 05 c5 00  	add	a0, a0, a2
   1982c: b3 86 e6 00  	add	a3, a3, a4
   19830: 33 36 c5 00  	sltu	a2, a0, a2
   19834: 33 87 c6 00  	add	a4, a3, a2
   19838: 6f f0 df e2  	j	0x19664 <__subtf3+0xe0>
   1983c: 1b 88 06 fc  	addiw	a6, a3, -64
   19840: 13 03 00 04  	li	t1, 64
   19844: 33 d8 07 01  	srl	a6, a5, a6
   19848: 93 08 00 00  	li	a7, 0
   1984c: 63 88 66 00  	beq	a3, t1, 0x1985c <__subtf3+0x2d8>
   19850: 93 08 00 08  	li	a7, 128
   19854: bb 86 d8 40  	subw	a3, a7, a3
   19858: b3 98 d7 00  	sll	a7, a5, a3
   1985c: 33 e5 a8 00  	or	a0, a7, a0
   19860: 33 35 a0 00  	snez	a0, a0
   19864: 33 65 a8 00  	or	a0, a6, a0
   19868: 93 06 00 00  	li	a3, 0
   1986c: 6f f0 df fb  	j	0x19828 <__subtf3+0x2a4>
   19870: 33 e5 a7 00  	or	a0, a5, a0
   19874: 33 35 a0 00  	snez	a0, a0
   19878: 6f f0 1f ff  	j	0x19868 <__subtf3+0x2e4>
   1987c: 93 85 18 00  	addi	a1, a7, 1
   19880: 93 06 ee ff  	addi	a3, t3, -2
   19884: 33 f3 d5 00  	and	t1, a1, a3
   19888: 63 18 03 18  	bnez	t1, 0x19a18 <__subtf3+0x494>
   1988c: b3 e5 a7 00  	or	a1, a5, a0
   19890: 63 92 08 06  	bnez	a7, 0x198f4 <__subtf3+0x370>
   19894: 63 82 05 6c  	beqz	a1, 0x19f58 <__subtf3+0x9d4>
   19898: b3 66 c7 00  	or	a3, a4, a2
   1989c: 63 82 06 48  	beqz	a3, 0x19d20 <__subtf3+0x79c>
   198a0: 33 06 c5 00  	add	a2, a0, a2
   198a4: b3 87 e7 00  	add	a5, a5, a4
   198a8: 33 35 a6 00  	sltu	a0, a2, a0
   198ac: b3 87 a7 00  	add	a5, a5, a0
   198b0: 13 d7 37 03  	srli	a4, a5, 51
   198b4: 13 77 17 00  	andi	a4, a4, 1
   198b8: 63 02 07 6a  	beqz	a4, 0x19f5c <__subtf3+0x9d8>
   198bc: 13 07 f0 ff  	li	a4, -1
   198c0: 13 17 37 03  	slli	a4, a4, 51
   198c4: 13 07 f7 ff  	addi	a4, a4, -1
   198c8: b3 f7 e7 00  	and	a5, a5, a4
   198cc: 13 05 06 00  	mv	a0, a2
   198d0: 93 06 00 00  	li	a3, 0
   198d4: 93 05 10 00  	li	a1, 1
   198d8: 13 77 75 00  	andi	a4, a0, 7
   198dc: 63 12 07 1a  	bnez	a4, 0x19a80 <__subtf3+0x4fc>
   198e0: 63 06 08 08  	beqz	a6, 0x1996c <__subtf3+0x3e8>
   198e4: 13 f7 16 00  	andi	a4, a3, 1
   198e8: 63 02 07 08  	beqz	a4, 0x1996c <__subtf3+0x3e8>
   198ec: 93 e6 26 00  	ori	a3, a3, 2
   198f0: 6f 00 c0 07  	j	0x1996c <__subtf3+0x3e8>
   198f4: 63 9c e8 03  	bne	a7, t5, 0x1992c <__subtf3+0x3a8>
   198f8: 63 80 05 78  	beqz	a1, 0x1a078 <__subtf3+0xaf4>
   198fc: 93 d6 27 03  	srli	a3, a5, 50
   19900: 93 f6 16 00  	andi	a3, a3, 1
   19904: 93 b6 16 00  	seqz	a3, a3
   19908: 93 96 46 00  	slli	a3, a3, 4
   1990c: 63 90 1e 05  	bne	t4, a7, 0x1994c <__subtf3+0x3c8>
   19910: b3 68 c7 00  	or	a7, a4, a2
   19914: 63 80 08 02  	beqz	a7, 0x19934 <__subtf3+0x3b0>
   19918: 93 58 27 03  	srli	a7, a4, 50
   1991c: 93 f8 18 00  	andi	a7, a7, 1
   19920: 63 9a 08 00  	bnez	a7, 0x19934 <__subtf3+0x3b0>
   19924: 93 06 00 01  	li	a3, 16
   19928: 6f 00 c0 00  	j	0x19934 <__subtf3+0x3b0>
   1992c: 93 06 00 00  	li	a3, 0
   19930: e3 80 ee ff  	beq	t4, t5, 0x19910 <__subtf3+0x38c>
   19934: 63 9c 05 00  	bnez	a1, 0x1994c <__subtf3+0x3c8>
   19938: 93 07 07 00  	mv	a5, a4
   1993c: 13 05 06 00  	mv	a0, a2
   19940: b7 85 00 00  	lui	a1, 8
   19944: 93 85 f5 ff  	addi	a1, a1, -1
   19948: 6f f0 1f f9  	j	0x198d8 <__subtf3+0x354>
   1994c: 33 66 c7 00  	or	a2, a4, a2
   19950: e3 08 06 fe  	beqz	a2, 0x19940 <__subtf3+0x3bc>
   19954: 93 07 10 00  	li	a5, 1
   19958: b7 85 00 00  	lui	a1, 8
   1995c: 93 04 00 00  	li	s1, 0
   19960: 93 97 27 03  	slli	a5, a5, 50
   19964: 13 05 00 00  	li	a0, 0
   19968: 93 85 f5 ff  	addi	a1, a1, -1
   1996c: 13 d7 37 03  	srli	a4, a5, 51
   19970: 13 77 17 00  	andi	a4, a4, 1
   19974: 63 02 07 02  	beqz	a4, 0x19998 <__subtf3+0x414>
   19978: 37 87 00 00  	lui	a4, 8
   1997c: 93 85 15 00  	addi	a1, a1, 1
   19980: 13 06 f7 ff  	addi	a2, a4, -1
   19984: 63 88 c5 6a  	beq	a1, a2, 0x1a034 <__subtf3+0xab0>
   19988: 13 07 f0 ff  	li	a4, -1
   1998c: 13 17 37 03  	slli	a4, a4, 51
   19990: 13 07 f7 ff  	addi	a4, a4, -1
   19994: b3 f7 e7 00  	and	a5, a5, a4
   19998: 13 57 35 00  	srli	a4, a0, 3
   1999c: 13 95 d7 03  	slli	a0, a5, 61
   199a0: 33 65 e5 00  	or	a0, a0, a4
   199a4: 37 87 00 00  	lui	a4, 8
   199a8: 13 07 f7 ff  	addi	a4, a4, -1
   199ac: 93 d7 37 00  	srli	a5, a5, 3
   199b0: 63 90 e5 02  	bne	a1, a4, 0x199d0 <__subtf3+0x44c>
   199b4: 33 65 f5 00  	or	a0, a0, a5
   199b8: 93 07 00 00  	li	a5, 0
   199bc: 63 0a 05 00  	beqz	a0, 0x199d0 <__subtf3+0x44c>
   199c0: 93 07 10 00  	li	a5, 1
   199c4: 93 97 f7 02  	slli	a5, a5, 47
   199c8: 13 05 00 00  	li	a0, 0
   199cc: 93 04 00 00  	li	s1, 0
   199d0: 93 95 15 03  	slli	a1, a1, 49
   199d4: 9b 94 f4 00  	slliw	s1, s1, 15
   199d8: 93 d5 15 03  	srli	a1, a1, 49
   199dc: b3 e5 95 00  	or	a1, a1, s1
   199e0: 93 97 07 01  	slli	a5, a5, 16
   199e4: 93 94 05 03  	slli	s1, a1, 48
   199e8: 93 d5 07 01  	srli	a1, a5, 16
   199ec: b3 e5 95 00  	or	a1, a1, s1
   199f0: 63 84 06 00  	beqz	a3, 0x199f8 <__subtf3+0x474>
   199f4: 73 a0 16 00  	csrs	fflags, a3
   199f8: 83 30 81 02  	ld	ra, 40(sp)
   199fc: 03 34 01 02  	ld	s0, 32(sp)
   19a00: 83 34 81 01  	ld	s1, 24(sp)
   19a04: 03 39 01 01  	ld	s2, 16(sp)
   19a08: 83 39 81 00  	ld	s3, 8(sp)
   19a0c: 03 3a 01 00  	ld	s4, 0(sp)
   19a10: 13 01 01 03  	addi	sp, sp, 48
   19a14: 67 80 00 00  	ret
   19a18: 63 86 e5 03  	beq	a1, t5, 0x19a44 <__subtf3+0x4c0>
   19a1c: 33 06 c5 00  	add	a2, a0, a2
   19a20: 33 35 a6 00  	sltu	a0, a2, a0
   19a24: b3 87 e7 00  	add	a5, a5, a4
   19a28: b3 87 a7 00  	add	a5, a5, a0
   19a2c: 13 95 f7 03  	slli	a0, a5, 63
   19a30: 13 56 16 00  	srli	a2, a2, 1
   19a34: 33 65 c5 00  	or	a0, a0, a2
   19a38: 93 d7 17 00  	srli	a5, a5, 1
   19a3c: 93 06 00 00  	li	a3, 0
   19a40: 6f f0 9f e9  	j	0x198d8 <__subtf3+0x354>
   19a44: 63 08 04 00  	beqz	s0, 0x19a54 <__subtf3+0x4d0>
   19a48: 93 07 30 00  	li	a5, 3
   19a4c: 63 1c f4 00  	bne	s0, a5, 0x19a64 <__subtf3+0x4e0>
   19a50: 63 90 04 02  	bnez	s1, 0x19a70 <__subtf3+0x4ec>
   19a54: 93 07 00 00  	li	a5, 0
   19a58: 13 05 00 00  	li	a0, 0
   19a5c: 93 06 50 00  	li	a3, 5
   19a60: 6f f0 df f0  	j	0x1996c <__subtf3+0x3e8>
   19a64: 93 07 20 00  	li	a5, 2
   19a68: 63 14 f4 00  	bne	s0, a5, 0x19a70 <__subtf3+0x4ec>
   19a6c: e3 94 04 fe  	bnez	s1, 0x19a54 <__subtf3+0x4d0>
   19a70: 93 07 f0 ff  	li	a5, -1
   19a74: 13 05 f0 ff  	li	a0, -1
   19a78: 93 85 06 00  	mv	a1, a3
   19a7c: 93 06 50 00  	li	a3, 5
   19a80: 13 07 20 00  	li	a4, 2
   19a84: 93 e6 16 00  	ori	a3, a3, 1
   19a88: 63 00 e4 5a  	beq	s0, a4, 0x1a028 <__subtf3+0xaa4>
   19a8c: 13 07 30 00  	li	a4, 3
   19a90: 63 06 e4 58  	beq	s0, a4, 0x1a01c <__subtf3+0xa98>
   19a94: 63 1c 04 58  	bnez	s0, 0x1a02c <__subtf3+0xaa8>
   19a98: 13 77 f5 00  	andi	a4, a0, 15
   19a9c: 13 06 40 00  	li	a2, 4
   19aa0: 63 06 c7 58  	beq	a4, a2, 0x1a02c <__subtf3+0xaa8>
   19aa4: 13 07 45 00  	addi	a4, a0, 4
   19aa8: 33 35 a7 00  	sltu	a0, a4, a0
   19aac: b3 87 a7 00  	add	a5, a5, a0
   19ab0: 13 05 07 00  	mv	a0, a4
   19ab4: 6f 00 80 57  	j	0x1a02c <__subtf3+0xaa8>
   19ab8: e3 0e 04 f8  	beqz	s0, 0x19a54 <__subtf3+0x4d0>
   19abc: 93 07 30 00  	li	a5, 3
   19ac0: 63 1e f4 00  	bne	s0, a5, 0x19adc <__subtf3+0x558>
   19ac4: e3 88 04 f8  	beqz	s1, 0x19a54 <__subtf3+0x4d0>
   19ac8: 93 07 f0 ff  	li	a5, -1
   19acc: 13 05 f0 ff  	li	a0, -1
   19ad0: 93 85 e6 ff  	addi	a1, a3, -2
   19ad4: 13 08 00 00  	li	a6, 0
   19ad8: 6f f0 5f fa  	j	0x19a7c <__subtf3+0x4f8>
   19adc: 93 07 20 00  	li	a5, 2
   19ae0: e3 14 f4 fe  	bne	s0, a5, 0x19ac8 <__subtf3+0x544>
   19ae4: e3 98 04 f6  	bnez	s1, 0x19a54 <__subtf3+0x4d0>
   19ae8: 6f f0 1f fe  	j	0x19ac8 <__subtf3+0x544>
   19aec: 63 50 00 0f  	blez	a6, 0x19bcc <__subtf3+0x648>
   19af0: 63 94 0e 08  	bnez	t4, 0x19b78 <__subtf3+0x5f4>
   19af4: b3 65 c7 00  	or	a1, a4, a2
   19af8: e3 8e 05 b2  	beqz	a1, 0x19634 <__subtf3+0xb0>
   19afc: 1b 88 f6 ff  	addiw	a6, a3, -1
   19b00: 63 1e 08 02  	bnez	a6, 0x19b3c <__subtf3+0x5b8>
   19b04: 33 06 c5 40  	sub	a2, a0, a2
   19b08: 33 35 c5 00  	sltu	a0, a0, a2
   19b0c: 33 87 e7 40  	sub	a4, a5, a4
   19b10: 33 07 a7 40  	sub	a4, a4, a0
   19b14: 93 85 08 00  	mv	a1, a7
   19b18: 13 05 06 00  	mv	a0, a2
   19b1c: 93 57 37 03  	srli	a5, a4, 51
   19b20: 93 f7 17 00  	andi	a5, a5, 1
   19b24: 63 8e 07 40  	beqz	a5, 0x19f40 <__subtf3+0x9bc>
   19b28: 13 17 d7 00  	slli	a4, a4, 13
   19b2c: 13 59 d7 00  	srli	s2, a4, 13
   19b30: 13 0a 05 00  	mv	s4, a0
   19b34: 93 89 05 00  	mv	s3, a1
   19b38: 6f 00 40 32  	j	0x19e5c <__subtf3+0x8d8>
   19b3c: e3 8c e8 b7  	beq	a7, t5, 0x196b4 <__subtf3+0x130>
   19b40: 93 06 40 07  	li	a3, 116
   19b44: 63 ce 06 07  	blt	a3, a6, 0x19bc0 <__subtf3+0x63c>
   19b48: 93 06 f0 03  	li	a3, 63
   19b4c: 63 c0 06 05  	blt	a3, a6, 0x19b8c <__subtf3+0x608>
   19b50: 93 05 00 04  	li	a1, 64
   19b54: bb 85 05 41  	subw	a1, a1, a6
   19b58: b3 16 b7 00  	sll	a3, a4, a1
   19b5c: 33 53 06 01  	srl	t1, a2, a6
   19b60: 33 16 b6 00  	sll	a2, a2, a1
   19b64: b3 e6 66 00  	or	a3, a3, t1
   19b68: 33 36 c0 00  	snez	a2, a2
   19b6c: 33 e6 c6 00  	or	a2, a3, a2
   19b70: 33 57 07 01  	srl	a4, a4, a6
   19b74: 6f f0 1f f9  	j	0x19b04 <__subtf3+0x580>
   19b78: e3 8e e8 b3  	beq	a7, t5, 0x196b4 <__subtf3+0x130>
   19b7c: 93 06 10 00  	li	a3, 1
   19b80: 93 96 36 03  	slli	a3, a3, 51
   19b84: 33 67 d7 00  	or	a4, a4, a3
   19b88: 6f f0 9f fb  	j	0x19b40 <__subtf3+0x5bc>
   19b8c: 9b 06 08 fc  	addiw	a3, a6, -64
   19b90: 13 03 00 04  	li	t1, 64
   19b94: b3 56 d7 00  	srl	a3, a4, a3
   19b98: 93 05 00 00  	li	a1, 0
   19b9c: 63 08 68 00  	beq	a6, t1, 0x19bac <__subtf3+0x628>
   19ba0: 93 05 00 08  	li	a1, 128
   19ba4: bb 85 05 41  	subw	a1, a1, a6
   19ba8: b3 15 b7 00  	sll	a1, a4, a1
   19bac: 33 e6 c5 00  	or	a2, a1, a2
   19bb0: 33 36 c0 00  	snez	a2, a2
   19bb4: 33 e6 c6 00  	or	a2, a3, a2
   19bb8: 13 07 00 00  	li	a4, 0
   19bbc: 6f f0 9f f4  	j	0x19b04 <__subtf3+0x580>
   19bc0: 33 66 c7 00  	or	a2, a4, a2
   19bc4: 33 36 c0 00  	snez	a2, a2
   19bc8: 6f f0 1f ff  	j	0x19bb8 <__subtf3+0x634>
   19bcc: 63 00 08 12  	beqz	a6, 0x19cec <__subtf3+0x768>
   19bd0: 63 90 08 08  	bnez	a7, 0x19c50 <__subtf3+0x6cc>
   19bd4: 33 e8 a7 00  	or	a6, a5, a0
   19bd8: 63 16 08 02  	bnez	a6, 0x19c04 <__subtf3+0x680>
   19bdc: 63 98 ee 37  	bne	t4, t5, 0x19f4c <__subtf3+0x9c8>
   19be0: 33 65 c7 00  	or	a0, a4, a2
   19be4: 63 06 05 3e  	beqz	a0, 0x19fd0 <__subtf3+0xa4c>
   19be8: 93 57 27 03  	srli	a5, a4, 50
   19bec: 93 f7 17 00  	andi	a5, a5, 1
   19bf0: 63 96 07 3e  	bnez	a5, 0x19fdc <__subtf3+0xa58>
   19bf4: 93 07 07 00  	mv	a5, a4
   19bf8: 13 05 06 00  	mv	a0, a2
   19bfc: 93 04 03 00  	mv	s1, t1
   19c00: 6f f0 1f b9  	j	0x19790 <__subtf3+0x20c>
   19c04: 93 c6 f6 ff  	not	a3, a3
   19c08: 9b 86 06 00  	sext.w	a3, a3
   19c0c: 63 9e 06 00  	bnez	a3, 0x19c28 <__subtf3+0x6a4>
   19c10: 33 05 a6 40  	sub	a0, a2, a0
   19c14: 33 07 f7 40  	sub	a4, a4, a5
   19c18: 33 36 a6 00  	sltu	a2, a2, a0
   19c1c: 33 07 c7 40  	sub	a4, a4, a2
   19c20: 93 04 03 00  	mv	s1, t1
   19c24: 6f f0 9f ef  	j	0x19b1c <__subtf3+0x598>
   19c28: 63 9e ee 03  	bne	t4, t5, 0x19c64 <__subtf3+0x6e0>
   19c2c: 33 65 c7 00  	or	a0, a4, a2
   19c30: 63 00 05 3a  	beqz	a0, 0x19fd0 <__subtf3+0xa4c>
   19c34: 93 57 27 03  	srli	a5, a4, 50
   19c38: 93 f7 17 00  	andi	a5, a5, 1
   19c3c: 63 90 07 3a  	bnez	a5, 0x19fdc <__subtf3+0xa58>
   19c40: 93 07 07 00  	mv	a5, a4
   19c44: 13 05 06 00  	mv	a0, a2
   19c48: 93 04 03 00  	mv	s1, t1
   19c4c: 6f f0 df b8  	j	0x197d8 <__subtf3+0x254>
   19c50: e3 8e ee fd  	beq	t4, t5, 0x19c2c <__subtf3+0x6a8>
   19c54: 13 08 10 00  	li	a6, 1
   19c58: 13 18 38 03  	slli	a6, a6, 51
   19c5c: bb 06 d0 40  	negw	a3, a3
   19c60: b3 e7 07 01  	or	a5, a5, a6
   19c64: 13 08 40 07  	li	a6, 116
   19c68: 63 4c d8 06  	blt	a6, a3, 0x19ce0 <__subtf3+0x75c>
   19c6c: 13 08 f0 03  	li	a6, 63
   19c70: 63 4e d8 02  	blt	a6, a3, 0x19cac <__subtf3+0x728>
   19c74: 93 08 00 04  	li	a7, 64
   19c78: bb 88 d8 40  	subw	a7, a7, a3
   19c7c: 33 98 17 01  	sll	a6, a5, a7
   19c80: 33 5e d5 00  	srl	t3, a0, a3
   19c84: 33 15 15 01  	sll	a0, a0, a7
   19c88: 33 68 c8 01  	or	a6, a6, t3
   19c8c: 33 35 a0 00  	snez	a0, a0
   19c90: 33 65 a8 00  	or	a0, a6, a0
   19c94: b3 d7 d7 00  	srl	a5, a5, a3
   19c98: 33 05 a6 40  	sub	a0, a2, a0
   19c9c: b3 07 f7 40  	sub	a5, a4, a5
   19ca0: 33 36 a6 00  	sltu	a2, a2, a0
   19ca4: 33 87 c7 40  	sub	a4, a5, a2
   19ca8: 6f f0 9f f7  	j	0x19c20 <__subtf3+0x69c>
   19cac: 1b 88 06 fc  	addiw	a6, a3, -64
   19cb0: 13 0e 00 04  	li	t3, 64
   19cb4: 33 d8 07 01  	srl	a6, a5, a6
   19cb8: 93 08 00 00  	li	a7, 0
   19cbc: 63 88 c6 01  	beq	a3, t3, 0x19ccc <__subtf3+0x748>
   19cc0: 93 08 00 08  	li	a7, 128
   19cc4: bb 86 d8 40  	subw	a3, a7, a3
   19cc8: b3 98 d7 00  	sll	a7, a5, a3
   19ccc: 33 e5 a8 00  	or	a0, a7, a0
   19cd0: 33 35 a0 00  	snez	a0, a0
   19cd4: 33 65 a8 00  	or	a0, a6, a0
   19cd8: 93 07 00 00  	li	a5, 0
   19cdc: 6f f0 df fb  	j	0x19c98 <__subtf3+0x714>
   19ce0: 33 e5 a7 00  	or	a0, a5, a0
   19ce4: 33 35 a0 00  	snez	a0, a0
   19ce8: 6f f0 1f ff  	j	0x19cd8 <__subtf3+0x754>
   19cec: 93 85 18 00  	addi	a1, a7, 1
   19cf0: 93 06 ee ff  	addi	a3, t3, -2
   19cf4: b3 f6 d5 00  	and	a3, a1, a3
   19cf8: 63 9a 06 12  	bnez	a3, 0x19e2c <__subtf3+0x8a8>
   19cfc: 33 ee a7 00  	or	t3, a5, a0
   19d00: b3 65 c7 00  	or	a1, a4, a2
   19d04: 63 96 08 0c  	bnez	a7, 0x19dd0 <__subtf3+0x84c>
   19d08: 63 1c 0e 06  	bnez	t3, 0x19d80 <__subtf3+0x7fc>
   19d0c: 63 9c 05 24  	bnez	a1, 0x19f64 <__subtf3+0x9e0>
   19d10: 93 04 e4 ff  	addi	s1, s0, -2
   19d14: 93 b4 14 00  	seqz	s1, s1
   19d18: 93 07 00 00  	li	a5, 0
   19d1c: 13 05 00 00  	li	a0, 0
   19d20: 33 67 f5 00  	or	a4, a0, a5
   19d24: 63 04 07 2e  	beqz	a4, 0x1a00c <__subtf3+0xa88>
   19d28: 13 57 f5 03  	srli	a4, a0, 63
   19d2c: 13 98 17 00  	slli	a6, a5, 1
   19d30: 33 08 e8 00  	add	a6, a6, a4
   19d34: 13 17 15 00  	slli	a4, a0, 1
   19d38: 13 76 77 00  	andi	a2, a4, 7
   19d3c: 93 06 00 00  	li	a3, 0
   19d40: 63 06 06 02  	beqz	a2, 0x19d6c <__subtf3+0x7e8>
   19d44: 93 06 20 00  	li	a3, 2
   19d48: 63 0a d4 24  	beq	s0, a3, 0x19f9c <__subtf3+0xa18>
   19d4c: 93 06 30 00  	li	a3, 3
   19d50: 63 06 d4 22  	beq	s0, a3, 0x19f7c <__subtf3+0x9f8>
   19d54: 93 06 10 00  	li	a3, 1
   19d58: 63 1a 04 00  	bnez	s0, 0x19d6c <__subtf3+0x7e8>
   19d5c: 13 76 f7 00  	andi	a2, a4, 15
   19d60: 93 05 40 00  	li	a1, 4
   19d64: 13 37 c7 ff  	sltiu	a4, a4, -4
   19d68: 63 10 b6 22  	bne	a2, a1, 0x19f88 <__subtf3+0xa04>
   19d6c: 13 58 48 03  	srli	a6, a6, 52
   19d70: 13 48 18 00  	xori	a6, a6, 1
   19d74: 13 78 18 00  	andi	a6, a6, 1
   19d78: 93 05 00 00  	li	a1, 0
   19d7c: 6f f0 df b5  	j	0x198d8 <__subtf3+0x354>
   19d80: e3 80 05 fa  	beqz	a1, 0x19d20 <__subtf3+0x79c>
   19d84: b3 05 c5 40  	sub	a1, a0, a2
   19d88: 33 38 b5 00  	sltu	a6, a0, a1
   19d8c: b3 86 e7 40  	sub	a3, a5, a4
   19d90: b3 86 06 41  	sub	a3, a3, a6
   19d94: 13 d8 36 03  	srli	a6, a3, 51
   19d98: 13 78 18 00  	andi	a6, a6, 1
   19d9c: 63 0e 08 00  	beqz	a6, 0x19db8 <__subtf3+0x834>
   19da0: 33 05 a6 40  	sub	a0, a2, a0
   19da4: b3 07 f7 40  	sub	a5, a4, a5
   19da8: 33 36 a6 00  	sltu	a2, a2, a0
   19dac: b3 87 c7 40  	sub	a5, a5, a2
   19db0: 93 04 03 00  	mv	s1, t1
   19db4: 6f f0 df f6  	j	0x19d20 <__subtf3+0x79c>
   19db8: 33 e5 d5 00  	or	a0, a1, a3
   19dbc: 63 1a 05 1a  	bnez	a0, 0x19f70 <__subtf3+0x9ec>
   19dc0: 93 04 e4 ff  	addi	s1, s0, -2
   19dc4: 93 b4 14 00  	seqz	s1, s1
   19dc8: 93 07 00 00  	li	a5, 0
   19dcc: 6f f0 5f f5  	j	0x19d20 <__subtf3+0x79c>
   19dd0: 63 9a e8 03  	bne	a7, t5, 0x19e04 <__subtf3+0x880>
   19dd4: 63 0c 0e 28  	beqz	t3, 0x1a06c <__subtf3+0xae8>
   19dd8: 93 d6 27 03  	srli	a3, a5, 50
   19ddc: 93 f6 16 00  	andi	a3, a3, 1
   19de0: 93 b6 16 00  	seqz	a3, a3
   19de4: 93 96 46 00  	slli	a3, a3, 4
   19de8: 63 9e 1e 03  	bne	t4, a7, 0x19e24 <__subtf3+0x8a0>
   19dec: 63 80 05 02  	beqz	a1, 0x19e0c <__subtf3+0x888>
   19df0: 93 58 27 03  	srli	a7, a4, 50
   19df4: 93 f8 18 00  	andi	a7, a7, 1
   19df8: 63 9a 08 00  	bnez	a7, 0x19e0c <__subtf3+0x888>
   19dfc: 93 06 00 01  	li	a3, 16
   19e00: 6f 00 c0 00  	j	0x19e0c <__subtf3+0x888>
   19e04: 93 06 00 00  	li	a3, 0
   19e08: e3 82 ee ff  	beq	t4, t5, 0x19dec <__subtf3+0x868>
   19e0c: 63 1c 0e 00  	bnez	t3, 0x19e24 <__subtf3+0x8a0>
   19e10: 63 8e 05 1c  	beqz	a1, 0x19fec <__subtf3+0xa68>
   19e14: 93 07 07 00  	mv	a5, a4
   19e18: 13 05 06 00  	mv	a0, a2
   19e1c: 93 04 03 00  	mv	s1, t1
   19e20: 6f f0 1f b2  	j	0x19940 <__subtf3+0x3bc>
   19e24: e3 8e 05 b0  	beqz	a1, 0x19940 <__subtf3+0x3bc>
   19e28: 6f f0 df b2  	j	0x19954 <__subtf3+0x3d0>
   19e2c: 33 0a c5 40  	sub	s4, a0, a2
   19e30: b3 36 45 01  	sltu	a3, a0, s4
   19e34: 33 89 e7 40  	sub	s2, a5, a4
   19e38: 33 09 d9 40  	sub	s2, s2, a3
   19e3c: 93 56 39 03  	srli	a3, s2, 51
   19e40: 93 f6 16 00  	andi	a3, a3, 1
   19e44: 63 86 06 08  	beqz	a3, 0x19ed0 <__subtf3+0x94c>
   19e48: 33 0a a6 40  	sub	s4, a2, a0
   19e4c: 33 07 f7 40  	sub	a4, a4, a5
   19e50: 33 36 46 01  	sltu	a2, a2, s4
   19e54: 33 09 c7 40  	sub	s2, a4, a2
   19e58: 93 04 03 00  	mv	s1, t1
   19e5c: 63 00 09 08  	beqz	s2, 0x19edc <__subtf3+0x958>
   19e60: 13 05 09 00  	mv	a0, s2
   19e64: ef 00 00 5b  	jal	0x1a414 <__clzdi2>
   19e68: 1b 05 05 00  	sext.w	a0, a0
   19e6c: 9b 05 45 ff  	addiw	a1, a0, -12
   19e70: 93 07 f0 03  	li	a5, 63
   19e74: 93 86 05 00  	mv	a3, a1
   19e78: 63 ca b7 06  	blt	a5, a1, 0x19eec <__subtf3+0x968>
   19e7c: 13 07 00 04  	li	a4, 64
   19e80: 3b 07 b7 40  	subw	a4, a4, a1
   19e84: 33 19 b9 00  	sll	s2, s2, a1
   19e88: 33 57 ea 00  	srl	a4, s4, a4
   19e8c: 33 67 27 01  	or	a4, a4, s2
   19e90: 33 15 ba 00  	sll	a0, s4, a1
   19e94: 63 cc 35 09  	blt	a1, s3, 0x19f2c <__subtf3+0x9a8>
   19e98: bb 86 36 41  	subw	a3, a3, s3
   19e9c: 9b 87 16 00  	addiw	a5, a3, 1
   19ea0: 13 06 f0 03  	li	a2, 63
   19ea4: 63 4c f6 04  	blt	a2, a5, 0x19efc <__subtf3+0x978>
   19ea8: 93 06 00 04  	li	a3, 64
   19eac: bb 86 f6 40  	subw	a3, a3, a5
   19eb0: b3 55 f5 00  	srl	a1, a0, a5
   19eb4: 33 16 d7 00  	sll	a2, a4, a3
   19eb8: 33 15 d5 00  	sll	a0, a0, a3
   19ebc: 33 66 b6 00  	or	a2, a2, a1
   19ec0: 33 35 a0 00  	snez	a0, a0
   19ec4: 33 65 a6 00  	or	a0, a2, a0
   19ec8: b3 57 f7 00  	srl	a5, a4, a5
   19ecc: 6f f0 5f e5  	j	0x19d20 <__subtf3+0x79c>
   19ed0: 33 65 2a 01  	or	a0, s4, s2
   19ed4: e3 14 05 f8  	bnez	a0, 0x19e5c <__subtf3+0x8d8>
   19ed8: 6f f0 9f ee  	j	0x19dc0 <__subtf3+0x83c>
   19edc: 13 05 0a 00  	mv	a0, s4
   19ee0: ef 00 40 53  	jal	0x1a414 <__clzdi2>
   19ee4: 1b 05 05 04  	addiw	a0, a0, 64
   19ee8: 6f f0 5f f8  	j	0x19e6c <__subtf3+0x8e8>
   19eec: 1b 07 45 fb  	addiw	a4, a0, -76
   19ef0: 33 17 ea 00  	sll	a4, s4, a4
   19ef4: 13 05 00 00  	li	a0, 0
   19ef8: 6f f0 df f9  	j	0x19e94 <__subtf3+0x910>
   19efc: 9b 86 16 fc  	addiw	a3, a3, -63
   19f00: 13 08 00 04  	li	a6, 64
   19f04: 33 56 d7 00  	srl	a2, a4, a3
   19f08: 93 06 00 00  	li	a3, 0
   19f0c: 63 88 07 01  	beq	a5, a6, 0x19f1c <__subtf3+0x998>
   19f10: 93 06 00 08  	li	a3, 128
   19f14: bb 86 f6 40  	subw	a3, a3, a5
   19f18: b3 16 d7 00  	sll	a3, a4, a3
   19f1c: 33 65 d5 00  	or	a0, a0, a3
   19f20: 33 35 a0 00  	snez	a0, a0
   19f24: 33 65 a6 00  	or	a0, a2, a0
   19f28: 6f f0 1f ea  	j	0x19dc8 <__subtf3+0x844>
   19f2c: 93 07 f0 ff  	li	a5, -1
   19f30: 93 97 37 03  	slli	a5, a5, 51
   19f34: 93 87 f7 ff  	addi	a5, a5, -1
   19f38: b3 85 b9 40  	sub	a1, s3, a1
   19f3c: 33 77 f7 00  	and	a4, a4, a5
   19f40: 93 07 07 00  	mv	a5, a4
   19f44: e3 8e 05 dc  	beqz	a1, 0x19d20 <__subtf3+0x79c>
   19f48: 6f f0 0f f6  	j	0x196a8 <__subtf3+0x124>
   19f4c: 13 05 06 00  	mv	a0, a2
   19f50: 93 04 03 00  	mv	s1, t1
   19f54: 6f f0 df fe  	j	0x19f40 <__subtf3+0x9bc>
   19f58: 93 07 07 00  	mv	a5, a4
   19f5c: 13 05 06 00  	mv	a0, a2
   19f60: 6f f0 1f dc  	j	0x19d20 <__subtf3+0x79c>
   19f64: 93 07 07 00  	mv	a5, a4
   19f68: 13 05 06 00  	mv	a0, a2
   19f6c: 6f f0 5f e4  	j	0x19db0 <__subtf3+0x82c>
   19f70: 93 87 06 00  	mv	a5, a3
   19f74: 13 85 05 00  	mv	a0, a1
   19f78: 6f f0 9f da  	j	0x19d20 <__subtf3+0x79c>
   19f7c: 93 06 10 00  	li	a3, 1
   19f80: e3 96 04 de  	bnez	s1, 0x19d6c <__subtf3+0x7e8>
   19f84: 13 37 87 ff  	sltiu	a4, a4, -8
   19f88: 13 47 17 00  	xori	a4, a4, 1
   19f8c: 13 17 07 02  	slli	a4, a4, 32
   19f90: 13 57 07 02  	srli	a4, a4, 32
   19f94: 33 08 e8 00  	add	a6, a6, a4
   19f98: 6f f0 5f dd  	j	0x19d6c <__subtf3+0x7e8>
   19f9c: 93 06 10 00  	li	a3, 1
   19fa0: e3 86 04 dc  	beqz	s1, 0x19d6c <__subtf3+0x7e8>
   19fa4: 6f f0 1f fe  	j	0x19f84 <__subtf3+0xa00>
   19fa8: 93 07 00 00  	li	a5, 0
   19fac: 93 06 00 00  	li	a3, 0
   19fb0: 6f f0 df 9b  	j	0x1996c <__subtf3+0x3e8>
   19fb4: 93 07 07 00  	mv	a5, a4
   19fb8: 13 05 06 00  	mv	a0, a2
   19fbc: 6f f0 cf ee  	j	0x196a8 <__subtf3+0x124>
   19fc0: 93 07 00 00  	li	a5, 0
   19fc4: 13 05 00 00  	li	a0, 0
   19fc8: 93 85 08 00  	mv	a1, a7
   19fcc: 6f f0 1f fe  	j	0x19fac <__subtf3+0xa28>
   19fd0: 93 07 00 00  	li	a5, 0
   19fd4: 93 04 03 00  	mv	s1, t1
   19fd8: 6f f0 5f fd  	j	0x19fac <__subtf3+0xa28>
   19fdc: 93 07 07 00  	mv	a5, a4
   19fe0: 13 05 06 00  	mv	a0, a2
   19fe4: 93 04 03 00  	mv	s1, t1
   19fe8: 6f f0 0f ec  	j	0x196a8 <__subtf3+0x124>
   19fec: 93 07 10 00  	li	a5, 1
   19ff0: b7 85 00 00  	lui	a1, 8
   19ff4: 13 05 00 00  	li	a0, 0
   19ff8: 93 04 00 00  	li	s1, 0
   19ffc: 93 97 27 03  	slli	a5, a5, 50
   1a000: 93 85 f5 ff  	addi	a1, a1, -1
   1a004: 93 06 00 01  	li	a3, 16
   1a008: 6f f0 5f 96  	j	0x1996c <__subtf3+0x3e8>
   1a00c: 93 07 00 00  	li	a5, 0
   1a010: 13 05 00 00  	li	a0, 0
   1a014: 93 05 00 00  	li	a1, 0
   1a018: 6f f0 5f f9  	j	0x19fac <__subtf3+0xa28>
   1a01c: 63 98 04 00  	bnez	s1, 0x1a02c <__subtf3+0xaa8>
   1a020: 13 07 85 00  	addi	a4, a0, 8
   1a024: 6f f0 5f a8  	j	0x19aa8 <__subtf3+0x524>
   1a028: e3 9c 04 fe  	bnez	s1, 0x1a020 <__subtf3+0xa9c>
   1a02c: e3 10 08 8c  	bnez	a6, 0x198ec <__subtf3+0x368>
   1a030: 6f f0 df 93  	j	0x1996c <__subtf3+0x3e8>
   1a034: 13 05 00 00  	li	a0, 0
   1a038: 63 04 04 02  	beqz	s0, 0x1a060 <__subtf3+0xadc>
   1a03c: 93 07 30 00  	li	a5, 3
   1a040: 63 1a f4 00  	bne	s0, a5, 0x1a054 <__subtf3+0xad0>
   1a044: 63 8e 04 00  	beqz	s1, 0x1a060 <__subtf3+0xadc>
   1a048: 13 05 f0 ff  	li	a0, -1
   1a04c: 93 05 e7 ff  	addi	a1, a4, -2
   1a050: 6f 00 00 01  	j	0x1a060 <__subtf3+0xadc>
   1a054: 93 07 20 00  	li	a5, 2
   1a058: e3 18 f4 fe  	bne	s0, a5, 0x1a048 <__subtf3+0xac4>
   1a05c: e3 86 04 fe  	beqz	s1, 0x1a048 <__subtf3+0xac4>
   1a060: 93 e6 56 00  	ori	a3, a3, 5
   1a064: 93 07 05 00  	mv	a5, a0
   1a068: 6f f0 1f 93  	j	0x19998 <__subtf3+0x414>
   1a06c: 93 06 00 00  	li	a3, 0
   1a070: e3 90 1e db  	bne	t4, a7, 0x19e10 <__subtf3+0x88c>
   1a074: 6f f0 9f d7  	j	0x19dec <__subtf3+0x868>
   1a078: 93 06 00 00  	li	a3, 0
   1a07c: e3 9e 1e 8b  	bne	t4, a7, 0x19938 <__subtf3+0x3b4>
   1a080: 6f f0 1f 89  	j	0x19910 <__subtf3+0x38c>

000000000001a084 <__fixtfsi>:
   1a084: 13 06 05 00  	mv	a2, a0
   1a088: f3 27 20 00  	csrr	a5, frm
   1a08c: 37 48 00 00  	lui	a6, 4
   1a090: 93 96 15 00  	slli	a3, a1, 1
   1a094: 93 97 05 01  	slli	a5, a1, 16
   1a098: 93 d6 16 03  	srli	a3, a3, 49
   1a09c: 13 07 e8 ff  	addi	a4, a6, -2
   1a0a0: 93 d7 07 01  	srli	a5, a5, 16
   1a0a4: 93 d5 f5 03  	srli	a1, a1, 63
   1a0a8: 63 4c d7 00  	blt	a4, a3, 0x1a0c0 <__fixtfsi+0x3c>
   1a0ac: 63 9c 06 08  	bnez	a3, 0x1a144 <__fixtfsi+0xc0>
   1a0b0: b3 67 f5 00  	or	a5, a0, a5
   1a0b4: 13 05 00 00  	li	a0, 0
   1a0b8: 63 90 07 04  	bnez	a5, 0x1a0f8 <__fixtfsi+0x74>
   1a0bc: 67 80 00 00  	ret
   1a0c0: 13 07 d8 01  	addi	a4, a6, 29
   1a0c4: 63 5e d7 02  	bge	a4, a3, 0x1a100 <__fixtfsi+0x7c>
   1a0c8: 37 07 00 80  	lui	a4, 524288
   1a0cc: 13 47 f7 ff  	not	a4, a4
   1a0d0: 3b 05 b7 00  	addw	a0, a4, a1
   1a0d4: 63 8c 05 06  	beqz	a1, 0x1a14c <__fixtfsi+0xc8>
   1a0d8: 13 08 e8 01  	addi	a6, a6, 30
   1a0dc: 13 07 00 01  	li	a4, 16
   1a0e0: 63 98 06 07  	bne	a3, a6, 0x1a150 <__fixtfsi+0xcc>
   1a0e4: 93 d6 17 01  	srli	a3, a5, 17
   1a0e8: 63 94 06 06  	bnez	a3, 0x1a150 <__fixtfsi+0xcc>
   1a0ec: 93 97 f7 02  	slli	a5, a5, 47
   1a0f0: b3 e7 c7 00  	or	a5, a5, a2
   1a0f4: 63 86 07 04  	beqz	a5, 0x1a140 <__fixtfsi+0xbc>
   1a0f8: 13 07 10 00  	li	a4, 1
   1a0fc: 6f 00 40 05  	j	0x1a150 <__fixtfsi+0xcc>
   1a100: 13 05 10 00  	li	a0, 1
   1a104: 13 15 05 03  	slli	a0, a0, 48
   1a108: b3 e7 a7 00  	or	a5, a5, a0
   1a10c: 37 c7 ff ff  	lui	a4, 1048572
   1a110: 37 45 00 00  	lui	a0, 4
   1a114: 1b 05 f5 02  	addiw	a0, a0, 47
   1a118: 1b 07 17 01  	addiw	a4, a4, 17
   1a11c: 3b 07 d7 00  	addw	a4, a4, a3
   1a120: bb 06 d5 40  	subw	a3, a0, a3
   1a124: 33 97 e7 00  	sll	a4, a5, a4
   1a128: b3 d7 d7 00  	srl	a5, a5, a3
   1a12c: 33 67 c7 00  	or	a4, a4, a2
   1a130: 1b 85 07 00  	sext.w	a0, a5
   1a134: 63 84 05 00  	beqz	a1, 0x1a13c <__fixtfsi+0xb8>
   1a138: 3b 05 a0 40  	negw	a0, a0
   1a13c: e3 1e 07 fa  	bnez	a4, 0x1a0f8 <__fixtfsi+0x74>
   1a140: 67 80 00 00  	ret
   1a144: 13 05 00 00  	li	a0, 0
   1a148: 6f f0 1f fb  	j	0x1a0f8 <__fixtfsi+0x74>
   1a14c: 13 07 00 01  	li	a4, 16
   1a150: 73 20 17 00  	csrs	fflags, a4
   1a154: 6f f0 df fe  	j	0x1a140 <__fixtfsi+0xbc>

000000000001a158 <__fixunstfsi>:
   1a158: 93 06 05 00  	mv	a3, a0
   1a15c: f3 27 20 00  	csrr	a5, frm
   1a160: 37 46 00 00  	lui	a2, 4
   1a164: 13 97 15 00  	slli	a4, a1, 1
   1a168: 93 97 05 01  	slli	a5, a1, 16
   1a16c: 13 57 17 03  	srli	a4, a4, 49
   1a170: 13 05 e6 ff  	addi	a0, a2, -2
   1a174: 93 d7 07 01  	srli	a5, a5, 16
   1a178: 93 d5 f5 03  	srli	a1, a1, 63
   1a17c: 63 4c e5 00  	blt	a0, a4, 0x1a194 <__fixunstfsi+0x3c>
   1a180: 63 1c 07 06  	bnez	a4, 0x1a1f8 <__fixunstfsi+0xa0>
   1a184: b3 e7 f6 00  	or	a5, a3, a5
   1a188: 63 98 07 06  	bnez	a5, 0x1a1f8 <__fixunstfsi+0xa0>
   1a18c: 13 05 00 00  	li	a0, 0
   1a190: 67 80 00 00  	ret
   1a194: 13 05 e6 01  	addi	a0, a2, 30
   1a198: 63 94 05 00  	bnez	a1, 0x1a1a0 <__fixunstfsi+0x48>
   1a19c: 13 05 f6 01  	addi	a0, a2, 31
   1a1a0: 63 54 a7 04  	bge	a4, a0, 0x1a1e8 <__fixunstfsi+0x90>
   1a1a4: 63 90 05 06  	bnez	a1, 0x1a204 <__fixunstfsi+0xac>
   1a1a8: 13 06 10 00  	li	a2, 1
   1a1ac: 13 16 06 03  	slli	a2, a2, 48
   1a1b0: b3 e7 c7 00  	or	a5, a5, a2
   1a1b4: b7 45 00 00  	lui	a1, 4
   1a1b8: 37 c6 ff ff  	lui	a2, 1048572
   1a1bc: 9b 85 f5 02  	addiw	a1, a1, 47
   1a1c0: 1b 06 16 01  	addiw	a2, a2, 17
   1a1c4: bb 85 e5 40  	subw	a1, a1, a4
   1a1c8: 3b 07 e6 00  	addw	a4, a2, a4
   1a1cc: b3 d5 b7 00  	srl	a1, a5, a1
   1a1d0: b3 97 e7 00  	sll	a5, a5, a4
   1a1d4: b3 e7 d7 00  	or	a5, a5, a3
   1a1d8: 1b 85 05 00  	sext.w	a0, a1
   1a1dc: 63 8c 07 00  	beqz	a5, 0x1a1f4 <__fixunstfsi+0x9c>
   1a1e0: 93 07 10 00  	li	a5, 1
   1a1e4: 6f 00 c0 00  	j	0x1a1f0 <__fixunstfsi+0x98>
   1a1e8: 13 85 f5 ff  	addi	a0, a1, -1
   1a1ec: 93 07 00 01  	li	a5, 16
   1a1f0: 73 a0 17 00  	csrs	fflags, a5
   1a1f4: 67 80 00 00  	ret
   1a1f8: 93 07 10 00  	li	a5, 1
   1a1fc: 13 05 00 00  	li	a0, 0
   1a200: 6f f0 1f ff  	j	0x1a1f0 <__fixunstfsi+0x98>
   1a204: 93 07 00 01  	li	a5, 16
   1a208: 6f f0 5f ff  	j	0x1a1fc <__fixunstfsi+0xa4>

000000000001a20c <__floatsitf>:
   1a20c: 13 01 01 fe  	addi	sp, sp, -32
   1a210: 23 3c 11 00  	sd	ra, 24(sp)
   1a214: 23 38 81 00  	sd	s0, 16(sp)
   1a218: 23 34 91 00  	sd	s1, 8(sp)
   1a21c: 63 04 05 06  	beqz	a0, 0x1a284 <__floatsitf+0x78>
   1a220: 9b 07 05 00  	sext.w	a5, a0
   1a224: 93 54 f5 03  	srli	s1, a0, 63
   1a228: 63 54 05 00  	bgez	a0, 0x1a230 <__floatsitf+0x24>
   1a22c: bb 07 f0 40  	negw	a5, a5
   1a230: 13 94 07 02  	slli	s0, a5, 32
   1a234: 13 54 04 02  	srli	s0, s0, 32
   1a238: 13 05 04 00  	mv	a0, s0
   1a23c: ef 00 80 1d  	jal	0x1a414 <__clzdi2>
   1a240: b7 45 00 00  	lui	a1, 4
   1a244: 9b 85 e5 03  	addiw	a1, a1, 62
   1a248: 9b 07 15 ff  	addiw	a5, a0, -15
   1a24c: bb 85 a5 40  	subw	a1, a1, a0
   1a250: b3 17 f4 00  	sll	a5, s0, a5
   1a254: 83 30 81 01  	ld	ra, 24(sp)
   1a258: 03 34 01 01  	ld	s0, 16(sp)
   1a25c: 9b 94 f4 00  	slliw	s1, s1, 15
   1a260: b3 e5 95 00  	or	a1, a1, s1
   1a264: 93 97 07 01  	slli	a5, a5, 16
   1a268: 93 95 05 03  	slli	a1, a1, 48
   1a26c: 93 d7 07 01  	srli	a5, a5, 16
   1a270: 83 34 81 00  	ld	s1, 8(sp)
   1a274: 13 05 00 00  	li	a0, 0
   1a278: b3 e5 b7 00  	or	a1, a5, a1
   1a27c: 13 01 01 02  	addi	sp, sp, 32
   1a280: 67 80 00 00  	ret
   1a284: 93 07 00 00  	li	a5, 0
   1a288: 93 05 00 00  	li	a1, 0
   1a28c: 93 04 00 00  	li	s1, 0
   1a290: 6f f0 5f fc  	j	0x1a254 <__floatsitf+0x48>

000000000001a294 <__floatunsitf>:
   1a294: 13 01 01 ff  	addi	sp, sp, -16
   1a298: 23 34 11 00  	sd	ra, 8(sp)
   1a29c: 23 30 81 00  	sd	s0, 0(sp)
   1a2a0: 63 06 05 04  	beqz	a0, 0x1a2ec <__floatunsitf+0x58>
   1a2a4: 13 14 05 02  	slli	s0, a0, 32
   1a2a8: 13 54 04 02  	srli	s0, s0, 32
   1a2ac: 13 05 04 00  	mv	a0, s0
   1a2b0: ef 00 40 16  	jal	0x1a414 <__clzdi2>
   1a2b4: b7 45 00 00  	lui	a1, 4
   1a2b8: 9b 85 e5 03  	addiw	a1, a1, 62
   1a2bc: bb 85 a5 40  	subw	a1, a1, a0
   1a2c0: 1b 05 15 ff  	addiw	a0, a0, -15
   1a2c4: 33 14 a4 00  	sll	s0, s0, a0
   1a2c8: 13 14 04 01  	slli	s0, s0, 16
   1a2cc: 13 54 04 01  	srli	s0, s0, 16
   1a2d0: 93 95 05 03  	slli	a1, a1, 48
   1a2d4: 83 30 81 00  	ld	ra, 8(sp)
   1a2d8: b3 65 b4 00  	or	a1, s0, a1
   1a2dc: 03 34 01 00  	ld	s0, 0(sp)
   1a2e0: 13 05 00 00  	li	a0, 0
   1a2e4: 13 01 01 01  	addi	sp, sp, 16
   1a2e8: 67 80 00 00  	ret
   1a2ec: 13 04 00 00  	li	s0, 0
   1a2f0: 93 05 00 00  	li	a1, 0
   1a2f4: 6f f0 5f fd  	j	0x1a2c8 <__floatunsitf+0x34>

000000000001a2f8 <__extenddftf2>:
   1a2f8: 13 01 01 fe  	addi	sp, sp, -32
   1a2fc: 23 3c 11 00  	sd	ra, 24(sp)
   1a300: 23 38 81 00  	sd	s0, 16(sp)
   1a304: 23 34 91 00  	sd	s1, 8(sp)
   1a308: f3 27 20 00  	csrr	a5, frm
   1a30c: 93 57 45 03  	srli	a5, a0, 52
   1a310: 93 f7 f7 7f  	andi	a5, a5, 2047
   1a314: 13 87 17 00  	addi	a4, a5, 1
   1a318: 13 14 c5 00  	slli	s0, a0, 12
   1a31c: 13 77 e7 7f  	andi	a4, a4, 2046
   1a320: 13 54 c4 00  	srli	s0, s0, 12
   1a324: 93 54 f5 03  	srli	s1, a0, 63
   1a328: 63 00 07 02  	beqz	a4, 0x1a348 <__extenddftf2+0x50>
   1a32c: 37 47 00 00  	lui	a4, 4
   1a330: 13 07 07 c0  	addi	a4, a4, -1024
   1a334: 93 55 44 00  	srli	a1, s0, 4
   1a338: b3 87 e7 00  	add	a5, a5, a4
   1a33c: 13 14 c4 03  	slli	s0, s0, 60
   1a340: 13 07 00 00  	li	a4, 0
   1a344: 6f 00 80 08  	j	0x1a3cc <__extenddftf2+0xd4>
   1a348: 63 9a 07 04  	bnez	a5, 0x1a39c <__extenddftf2+0xa4>
   1a34c: 93 05 00 00  	li	a1, 0
   1a350: e3 08 04 fe  	beqz	s0, 0x1a340 <__extenddftf2+0x48>
   1a354: 13 05 04 00  	mv	a0, s0
   1a358: ef 00 c0 0b  	jal	0x1a414 <__clzdi2>
   1a35c: 1b 07 05 00  	sext.w	a4, a0
   1a360: 93 07 e0 00  	li	a5, 14
   1a364: 63 c4 e7 02  	blt	a5, a4, 0x1a38c <__extenddftf2+0x94>
   1a368: 93 05 f0 00  	li	a1, 15
   1a36c: bb 85 a5 40  	subw	a1, a1, a0
   1a370: 9b 07 15 03  	addiw	a5, a0, 49
   1a374: b3 55 b4 00  	srl	a1, s0, a1
   1a378: 33 14 f4 00  	sll	s0, s0, a5
   1a37c: 37 47 00 00  	lui	a4, 4
   1a380: 1b 07 c7 c0  	addiw	a4, a4, -1012
   1a384: bb 07 a7 40  	subw	a5, a4, a0
   1a388: 6f f0 9f fb  	j	0x1a340 <__extenddftf2+0x48>
   1a38c: 9b 05 15 ff  	addiw	a1, a0, -15
   1a390: b3 15 b4 00  	sll	a1, s0, a1
   1a394: 13 04 00 00  	li	s0, 0
   1a398: 6f f0 5f fe  	j	0x1a37c <__extenddftf2+0x84>
   1a39c: 63 04 04 06  	beqz	s0, 0x1a404 <__extenddftf2+0x10c>
   1a3a0: 93 07 10 00  	li	a5, 1
   1a3a4: 13 97 37 03  	slli	a4, a5, 51
   1a3a8: 33 77 e4 00  	and	a4, s0, a4
   1a3ac: 93 55 44 00  	srli	a1, s0, 4
   1a3b0: 93 97 f7 02  	slli	a5, a5, 47
   1a3b4: 13 37 17 00  	seqz	a4, a4
   1a3b8: b3 e5 f5 00  	or	a1, a1, a5
   1a3bc: b7 87 00 00  	lui	a5, 8
   1a3c0: 13 17 47 00  	slli	a4, a4, 4
   1a3c4: 13 14 c4 03  	slli	s0, s0, 60
   1a3c8: 93 87 f7 ff  	addi	a5, a5, -1
   1a3cc: 1b 95 f4 00  	slliw	a0, s1, 15
   1a3d0: 93 95 05 01  	slli	a1, a1, 16
   1a3d4: b3 e7 a7 00  	or	a5, a5, a0
   1a3d8: 93 97 07 03  	slli	a5, a5, 48
   1a3dc: 93 d5 05 01  	srli	a1, a1, 16
   1a3e0: b3 e5 f5 00  	or	a1, a1, a5
   1a3e4: 63 04 07 00  	beqz	a4, 0x1a3ec <__extenddftf2+0xf4>
   1a3e8: 73 20 17 00  	csrs	fflags, a4
   1a3ec: 83 30 81 01  	ld	ra, 24(sp)
   1a3f0: 13 05 04 00  	mv	a0, s0
   1a3f4: 03 34 01 01  	ld	s0, 16(sp)
   1a3f8: 83 34 81 00  	ld	s1, 8(sp)
   1a3fc: 13 01 01 02  	addi	sp, sp, 32
   1a400: 67 80 00 00  	ret
   1a404: b7 87 00 00  	lui	a5, 8
   1a408: 93 05 00 00  	li	a1, 0
   1a40c: 93 87 f7 ff  	addi	a5, a5, -1
   1a410: 6f f0 1f f3  	j	0x1a340 <__extenddftf2+0x48>

000000000001a414 <__clzdi2>:
   1a414: 93 07 80 03  	li	a5, 56
   1a418: 33 57 f5 00  	srl	a4, a0, a5
   1a41c: 13 77 f7 0f  	andi	a4, a4, 255
   1a420: 63 16 07 00  	bnez	a4, 0x1a42c <__clzdi2+0x18>
   1a424: 93 87 87 ff  	addi	a5, a5, -8
   1a428: e3 98 07 fe  	bnez	a5, 0x1a418 <__clzdi2+0x4>
   1a42c: 13 07 00 04  	li	a4, 64
   1a430: 33 07 f7 40  	sub	a4, a4, a5
   1a434: 33 55 f5 00  	srl	a0, a0, a5
   1a438: 97 37 00 00  	auipc	a5, 3
   1a43c: 83 b7 87 cc  	ld	a5, -824(a5)
   1a440: 33 85 a7 00  	add	a0, a5, a0
   1a444: 03 45 05 00  	lbu	a0, 0(a0)
   1a448: 3b 05 a7 40  	subw	a0, a4, a0
   1a44c: 67 80 00 00  	ret
