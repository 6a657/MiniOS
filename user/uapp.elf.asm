
uapp.elf:     file format elf64-littleriscv


Disassembly of section .text.init:

0000000000000000 <_start>:
   0:	21d0006f          	j	a1c <main>

Disassembly of section .text.atoi:

0000000000000004 <atoi>:
   4:	fd010113          	addi	sp,sp,-48
   8:	02113423          	sd	ra,40(sp)
   c:	02813023          	sd	s0,32(sp)
  10:	03010413          	addi	s0,sp,48
  14:	fca43c23          	sd	a0,-40(s0)
  18:	fe042623          	sw	zero,-20(s0)
  1c:	fd843503          	ld	a0,-40(s0)
  20:	00002097          	auipc	ra,0x2
  24:	b34080e7          	jalr	-1228(ra) # 1b54 <strlen>
  28:	00050793          	mv	a5,a0
  2c:	fef42223          	sw	a5,-28(s0)
  30:	fe042423          	sw	zero,-24(s0)
  34:	0500006f          	j	84 <atoi+0x80>
  38:	fec42783          	lw	a5,-20(s0)
  3c:	00078713          	mv	a4,a5
  40:	00070793          	mv	a5,a4
  44:	0027979b          	slliw	a5,a5,0x2
  48:	00e787bb          	addw	a5,a5,a4
  4c:	0017979b          	slliw	a5,a5,0x1
  50:	0007871b          	sext.w	a4,a5
  54:	fe842783          	lw	a5,-24(s0)
  58:	fd843683          	ld	a3,-40(s0)
  5c:	00f687b3          	add	a5,a3,a5
  60:	0007c783          	lbu	a5,0(a5)
  64:	0007879b          	sext.w	a5,a5
  68:	00f707bb          	addw	a5,a4,a5
  6c:	0007879b          	sext.w	a5,a5
  70:	fd07879b          	addiw	a5,a5,-48
  74:	fef42623          	sw	a5,-20(s0)
  78:	fe842783          	lw	a5,-24(s0)
  7c:	0017879b          	addiw	a5,a5,1
  80:	fef42423          	sw	a5,-24(s0)
  84:	fe842783          	lw	a5,-24(s0)
  88:	00078713          	mv	a4,a5
  8c:	fe442783          	lw	a5,-28(s0)
  90:	0007071b          	sext.w	a4,a4
  94:	0007879b          	sext.w	a5,a5
  98:	faf740e3          	blt	a4,a5,38 <atoi+0x34>
  9c:	fec42783          	lw	a5,-20(s0)
  a0:	00078513          	mv	a0,a5
  a4:	02813083          	ld	ra,40(sp)
  a8:	02013403          	ld	s0,32(sp)
  ac:	03010113          	addi	sp,sp,48
  b0:	00008067          	ret

Disassembly of section .text.get_param:

00000000000000b4 <get_param>:
  b4:	fd010113          	addi	sp,sp,-48
  b8:	02813423          	sd	s0,40(sp)
  bc:	03010413          	addi	s0,sp,48
  c0:	fca43c23          	sd	a0,-40(s0)
  c4:	0100006f          	j	d4 <get_param+0x20>
  c8:	fd843783          	ld	a5,-40(s0)
  cc:	00178793          	addi	a5,a5,1
  d0:	fcf43c23          	sd	a5,-40(s0)
  d4:	fd843783          	ld	a5,-40(s0)
  d8:	0007c783          	lbu	a5,0(a5)
  dc:	00078713          	mv	a4,a5
  e0:	02000793          	li	a5,32
  e4:	fef702e3          	beq	a4,a5,c8 <get_param+0x14>
  e8:	fe042623          	sw	zero,-20(s0)
  ec:	0300006f          	j	11c <get_param+0x68>
  f0:	fd843703          	ld	a4,-40(s0)
  f4:	00170793          	addi	a5,a4,1
  f8:	fcf43c23          	sd	a5,-40(s0)
  fc:	fec42783          	lw	a5,-20(s0)
 100:	0017869b          	addiw	a3,a5,1
 104:	fed42623          	sw	a3,-20(s0)
 108:	00074703          	lbu	a4,0(a4)
 10c:	00002697          	auipc	a3,0x2
 110:	18468693          	addi	a3,a3,388 # 2290 <string_buf>
 114:	00f687b3          	add	a5,a3,a5
 118:	00e78023          	sb	a4,0(a5)
 11c:	fd843783          	ld	a5,-40(s0)
 120:	0007c783          	lbu	a5,0(a5)
 124:	00078c63          	beqz	a5,13c <get_param+0x88>
 128:	fd843783          	ld	a5,-40(s0)
 12c:	0007c783          	lbu	a5,0(a5)
 130:	00078713          	mv	a4,a5
 134:	02000793          	li	a5,32
 138:	faf71ce3          	bne	a4,a5,f0 <get_param+0x3c>
 13c:	00002717          	auipc	a4,0x2
 140:	15470713          	addi	a4,a4,340 # 2290 <string_buf>
 144:	fec42783          	lw	a5,-20(s0)
 148:	00f707b3          	add	a5,a4,a5
 14c:	00078023          	sb	zero,0(a5)
 150:	00002797          	auipc	a5,0x2
 154:	14078793          	addi	a5,a5,320 # 2290 <string_buf>
 158:	00078513          	mv	a0,a5
 15c:	02813403          	ld	s0,40(sp)
 160:	03010113          	addi	sp,sp,48
 164:	00008067          	ret

Disassembly of section .text.get_string:

0000000000000168 <get_string>:
 168:	fd010113          	addi	sp,sp,-48
 16c:	02113423          	sd	ra,40(sp)
 170:	02813023          	sd	s0,32(sp)
 174:	03010413          	addi	s0,sp,48
 178:	fca43c23          	sd	a0,-40(s0)
 17c:	0100006f          	j	18c <get_string+0x24>
 180:	fd843783          	ld	a5,-40(s0)
 184:	00178793          	addi	a5,a5,1
 188:	fcf43c23          	sd	a5,-40(s0)
 18c:	fd843783          	ld	a5,-40(s0)
 190:	0007c783          	lbu	a5,0(a5)
 194:	00078713          	mv	a4,a5
 198:	02000793          	li	a5,32
 19c:	fef702e3          	beq	a4,a5,180 <get_string+0x18>
 1a0:	fd843783          	ld	a5,-40(s0)
 1a4:	0007c783          	lbu	a5,0(a5)
 1a8:	00078713          	mv	a4,a5
 1ac:	02200793          	li	a5,34
 1b0:	06f71c63          	bne	a4,a5,228 <get_string+0xc0>
 1b4:	fd843783          	ld	a5,-40(s0)
 1b8:	00178793          	addi	a5,a5,1
 1bc:	fcf43c23          	sd	a5,-40(s0)
 1c0:	fe042623          	sw	zero,-20(s0)
 1c4:	0300006f          	j	1f4 <get_string+0x8c>
 1c8:	fd843703          	ld	a4,-40(s0)
 1cc:	00170793          	addi	a5,a4,1
 1d0:	fcf43c23          	sd	a5,-40(s0)
 1d4:	fec42783          	lw	a5,-20(s0)
 1d8:	0017869b          	addiw	a3,a5,1
 1dc:	fed42623          	sw	a3,-20(s0)
 1e0:	00074703          	lbu	a4,0(a4)
 1e4:	00002697          	auipc	a3,0x2
 1e8:	0ac68693          	addi	a3,a3,172 # 2290 <string_buf>
 1ec:	00f687b3          	add	a5,a3,a5
 1f0:	00e78023          	sb	a4,0(a5)
 1f4:	fd843783          	ld	a5,-40(s0)
 1f8:	0007c783          	lbu	a5,0(a5)
 1fc:	00078713          	mv	a4,a5
 200:	02200793          	li	a5,34
 204:	fcf712e3          	bne	a4,a5,1c8 <get_string+0x60>
 208:	00002717          	auipc	a4,0x2
 20c:	08870713          	addi	a4,a4,136 # 2290 <string_buf>
 210:	fec42783          	lw	a5,-20(s0)
 214:	00f707b3          	add	a5,a4,a5
 218:	00078023          	sb	zero,0(a5)
 21c:	00002797          	auipc	a5,0x2
 220:	07478793          	addi	a5,a5,116 # 2290 <string_buf>
 224:	0140006f          	j	238 <get_string+0xd0>
 228:	fd843503          	ld	a0,-40(s0)
 22c:	00000097          	auipc	ra,0x0
 230:	e88080e7          	jalr	-376(ra) # b4 <get_param>
 234:	00050793          	mv	a5,a0
 238:	00078513          	mv	a0,a5
 23c:	02813083          	ld	ra,40(sp)
 240:	02013403          	ld	s0,32(sp)
 244:	03010113          	addi	sp,sp,48
 248:	00008067          	ret

Disassembly of section .text.parse_cmd:

000000000000024c <parse_cmd>:
 24c:	c9010113          	addi	sp,sp,-880
 250:	36113423          	sd	ra,872(sp)
 254:	36813023          	sd	s0,864(sp)
 258:	34913c23          	sd	s1,856(sp)
 25c:	35213823          	sd	s2,848(sp)
 260:	35313423          	sd	s3,840(sp)
 264:	35413023          	sd	s4,832(sp)
 268:	33513c23          	sd	s5,824(sp)
 26c:	33613823          	sd	s6,816(sp)
 270:	33713423          	sd	s7,808(sp)
 274:	33813023          	sd	s8,800(sp)
 278:	31913c23          	sd	s9,792(sp)
 27c:	31a13823          	sd	s10,784(sp)
 280:	31b13423          	sd	s11,776(sp)
 284:	37010413          	addi	s0,sp,880
 288:	d0a43423          	sd	a0,-760(s0)
 28c:	00058793          	mv	a5,a1
 290:	d0f42223          	sw	a5,-764(s0)
 294:	d0843783          	ld	a5,-760(s0)
 298:	0007c783          	lbu	a5,0(a5)
 29c:	00078713          	mv	a4,a5
 2a0:	06500793          	li	a5,101
 2a4:	0cf71063          	bne	a4,a5,364 <parse_cmd+0x118>
 2a8:	d0843783          	ld	a5,-760(s0)
 2ac:	00178793          	addi	a5,a5,1
 2b0:	0007c783          	lbu	a5,0(a5)
 2b4:	00078713          	mv	a4,a5
 2b8:	06300793          	li	a5,99
 2bc:	0af71463          	bne	a4,a5,364 <parse_cmd+0x118>
 2c0:	d0843783          	ld	a5,-760(s0)
 2c4:	00278793          	addi	a5,a5,2
 2c8:	0007c783          	lbu	a5,0(a5)
 2cc:	00078713          	mv	a4,a5
 2d0:	06800793          	li	a5,104
 2d4:	08f71863          	bne	a4,a5,364 <parse_cmd+0x118>
 2d8:	d0843783          	ld	a5,-760(s0)
 2dc:	00378793          	addi	a5,a5,3
 2e0:	0007c783          	lbu	a5,0(a5)
 2e4:	00078713          	mv	a4,a5
 2e8:	06f00793          	li	a5,111
 2ec:	06f71c63          	bne	a4,a5,364 <parse_cmd+0x118>
 2f0:	d0843783          	ld	a5,-760(s0)
 2f4:	00478793          	addi	a5,a5,4
 2f8:	d0f43423          	sd	a5,-760(s0)
 2fc:	d0843503          	ld	a0,-760(s0)
 300:	00000097          	auipc	ra,0x0
 304:	e68080e7          	jalr	-408(ra) # 168 <get_string>
 308:	f6a43823          	sd	a0,-144(s0)
 30c:	f7043503          	ld	a0,-144(s0)
 310:	00002097          	auipc	ra,0x2
 314:	844080e7          	jalr	-1980(ra) # 1b54 <strlen>
 318:	00050793          	mv	a5,a0
 31c:	d0f42223          	sw	a5,-764(s0)
 320:	d0442783          	lw	a5,-764(s0)
 324:	d0843703          	ld	a4,-760(s0)
 328:	00f707b3          	add	a5,a4,a5
 32c:	d0f43423          	sd	a5,-760(s0)
 330:	d0442783          	lw	a5,-764(s0)
 334:	00078613          	mv	a2,a5
 338:	f7043583          	ld	a1,-144(s0)
 33c:	00100513          	li	a0,1
 340:	00002097          	auipc	ra,0x2
 344:	860080e7          	jalr	-1952(ra) # 1ba0 <write>
 348:	00100613          	li	a2,1
 34c:	00002597          	auipc	a1,0x2
 350:	e6c58593          	addi	a1,a1,-404 # 21b8 <lseek+0x39c>
 354:	00100513          	li	a0,1
 358:	00002097          	auipc	ra,0x2
 35c:	848080e7          	jalr	-1976(ra) # 1ba0 <write>
 360:	67c0006f          	j	9dc <parse_cmd+0x790>
 364:	d0843783          	ld	a5,-760(s0)
 368:	0007c783          	lbu	a5,0(a5)
 36c:	00078713          	mv	a4,a5
 370:	06300793          	li	a5,99
 374:	18f71663          	bne	a4,a5,500 <parse_cmd+0x2b4>
 378:	d0843783          	ld	a5,-760(s0)
 37c:	00178793          	addi	a5,a5,1
 380:	0007c783          	lbu	a5,0(a5)
 384:	00078713          	mv	a4,a5
 388:	06100793          	li	a5,97
 38c:	16f71a63          	bne	a4,a5,500 <parse_cmd+0x2b4>
 390:	d0843783          	ld	a5,-760(s0)
 394:	00278793          	addi	a5,a5,2
 398:	0007c783          	lbu	a5,0(a5)
 39c:	00078713          	mv	a4,a5
 3a0:	07400793          	li	a5,116
 3a4:	14f71e63          	bne	a4,a5,500 <parse_cmd+0x2b4>
 3a8:	d0843783          	ld	a5,-760(s0)
 3ac:	00378793          	addi	a5,a5,3
 3b0:	00078513          	mv	a0,a5
 3b4:	00000097          	auipc	ra,0x0
 3b8:	d00080e7          	jalr	-768(ra) # b4 <get_param>
 3bc:	f6a43423          	sd	a0,-152(s0)
 3c0:	00100593          	li	a1,1
 3c4:	f6843503          	ld	a0,-152(s0)
 3c8:	00002097          	auipc	ra,0x2
 3cc:	9c0080e7          	jalr	-1600(ra) # 1d88 <open>
 3d0:	00050793          	mv	a5,a0
 3d4:	f6f42223          	sw	a5,-156(s0)
 3d8:	f6442783          	lw	a5,-156(s0)
 3dc:	0007871b          	sext.w	a4,a5
 3e0:	fff00793          	li	a5,-1
 3e4:	00f71e63          	bne	a4,a5,400 <parse_cmd+0x1b4>
 3e8:	f6843583          	ld	a1,-152(s0)
 3ec:	00002517          	auipc	a0,0x2
 3f0:	dd450513          	addi	a0,a0,-556 # 21c0 <lseek+0x3a4>
 3f4:	00001097          	auipc	ra,0x1
 3f8:	660080e7          	jalr	1632(ra) # 1a54 <printf>
 3fc:	5e00006f          	j	9dc <parse_cmd+0x790>
 400:	d1840713          	addi	a4,s0,-744
 404:	f6442783          	lw	a5,-156(s0)
 408:	1fd00613          	li	a2,509
 40c:	00070593          	mv	a1,a4
 410:	00078513          	mv	a0,a5
 414:	00002097          	auipc	ra,0x2
 418:	8ac080e7          	jalr	-1876(ra) # 1cc0 <read>
 41c:	00050793          	mv	a5,a0
 420:	f6f42023          	sw	a5,-160(s0)
 424:	f6042783          	lw	a5,-160(s0)
 428:	0007879b          	sext.w	a5,a5
 42c:	02079463          	bnez	a5,454 <parse_cmd+0x208>
 430:	f8f44783          	lbu	a5,-113(s0)
 434:	0ff7f713          	zext.b	a4,a5
 438:	00a00793          	li	a5,10
 43c:	0af70663          	beq	a4,a5,4e8 <parse_cmd+0x29c>
 440:	00002517          	auipc	a0,0x2
 444:	d9850513          	addi	a0,a0,-616 # 21d8 <lseek+0x3bc>
 448:	00001097          	auipc	ra,0x1
 44c:	60c080e7          	jalr	1548(ra) # 1a54 <printf>
 450:	0980006f          	j	4e8 <parse_cmd+0x29c>
 454:	f8042423          	sw	zero,-120(s0)
 458:	0740006f          	j	4cc <parse_cmd+0x280>
 45c:	f8842783          	lw	a5,-120(s0)
 460:	f9078793          	addi	a5,a5,-112
 464:	008787b3          	add	a5,a5,s0
 468:	d887c783          	lbu	a5,-632(a5)
 46c:	02079063          	bnez	a5,48c <parse_cmd+0x240>
 470:	00100613          	li	a2,1
 474:	00002597          	auipc	a1,0x2
 478:	d6c58593          	addi	a1,a1,-660 # 21e0 <lseek+0x3c4>
 47c:	00100513          	li	a0,1
 480:	00001097          	auipc	ra,0x1
 484:	720080e7          	jalr	1824(ra) # 1ba0 <write>
 488:	0240006f          	j	4ac <parse_cmd+0x260>
 48c:	d1840713          	addi	a4,s0,-744
 490:	f8842783          	lw	a5,-120(s0)
 494:	00f707b3          	add	a5,a4,a5
 498:	00100613          	li	a2,1
 49c:	00078593          	mv	a1,a5
 4a0:	00100513          	li	a0,1
 4a4:	00001097          	auipc	ra,0x1
 4a8:	6fc080e7          	jalr	1788(ra) # 1ba0 <write>
 4ac:	f8842783          	lw	a5,-120(s0)
 4b0:	f9078793          	addi	a5,a5,-112
 4b4:	008787b3          	add	a5,a5,s0
 4b8:	d887c783          	lbu	a5,-632(a5)
 4bc:	f8f407a3          	sb	a5,-113(s0)
 4c0:	f8842783          	lw	a5,-120(s0)
 4c4:	0017879b          	addiw	a5,a5,1
 4c8:	f8f42423          	sw	a5,-120(s0)
 4cc:	f8842783          	lw	a5,-120(s0)
 4d0:	00078713          	mv	a4,a5
 4d4:	f6042783          	lw	a5,-160(s0)
 4d8:	0007071b          	sext.w	a4,a4
 4dc:	0007879b          	sext.w	a5,a5
 4e0:	f6f74ee3          	blt	a4,a5,45c <parse_cmd+0x210>
 4e4:	f1dff06f          	j	400 <parse_cmd+0x1b4>
 4e8:	00000013          	nop
 4ec:	f6442783          	lw	a5,-156(s0)
 4f0:	00078513          	mv	a0,a5
 4f4:	00002097          	auipc	ra,0x2
 4f8:	8e0080e7          	jalr	-1824(ra) # 1dd4 <close>
 4fc:	4e00006f          	j	9dc <parse_cmd+0x790>
 500:	d0843783          	ld	a5,-760(s0)
 504:	0007c783          	lbu	a5,0(a5)
 508:	00078713          	mv	a4,a5
 50c:	06500793          	li	a5,101
 510:	4af71c63          	bne	a4,a5,9c8 <parse_cmd+0x77c>
 514:	d0843783          	ld	a5,-760(s0)
 518:	00178793          	addi	a5,a5,1
 51c:	0007c783          	lbu	a5,0(a5)
 520:	00078713          	mv	a4,a5
 524:	06400793          	li	a5,100
 528:	4af71063          	bne	a4,a5,9c8 <parse_cmd+0x77c>
 52c:	d0843783          	ld	a5,-760(s0)
 530:	00278793          	addi	a5,a5,2
 534:	0007c783          	lbu	a5,0(a5)
 538:	00078713          	mv	a4,a5
 53c:	06900793          	li	a5,105
 540:	48f71463          	bne	a4,a5,9c8 <parse_cmd+0x77c>
 544:	d0843783          	ld	a5,-760(s0)
 548:	00378793          	addi	a5,a5,3
 54c:	0007c783          	lbu	a5,0(a5)
 550:	00078713          	mv	a4,a5
 554:	07400793          	li	a5,116
 558:	46f71863          	bne	a4,a5,9c8 <parse_cmd+0x77c>
 55c:	00010793          	mv	a5,sp
 560:	00078493          	mv	s1,a5
 564:	d0843783          	ld	a5,-760(s0)
 568:	00478793          	addi	a5,a5,4
 56c:	d0f43423          	sd	a5,-760(s0)
 570:	0100006f          	j	580 <parse_cmd+0x334>
 574:	d0843783          	ld	a5,-760(s0)
 578:	00178793          	addi	a5,a5,1
 57c:	d0f43423          	sd	a5,-760(s0)
 580:	d0843783          	ld	a5,-760(s0)
 584:	0007c783          	lbu	a5,0(a5)
 588:	00078713          	mv	a4,a5
 58c:	02000793          	li	a5,32
 590:	00f71863          	bne	a4,a5,5a0 <parse_cmd+0x354>
 594:	d0843783          	ld	a5,-760(s0)
 598:	0007c783          	lbu	a5,0(a5)
 59c:	fc079ce3          	bnez	a5,574 <parse_cmd+0x328>
 5a0:	d0843503          	ld	a0,-760(s0)
 5a4:	00000097          	auipc	ra,0x0
 5a8:	b10080e7          	jalr	-1264(ra) # b4 <get_param>
 5ac:	f4a43c23          	sd	a0,-168(s0)
 5b0:	f5843503          	ld	a0,-168(s0)
 5b4:	00001097          	auipc	ra,0x1
 5b8:	5a0080e7          	jalr	1440(ra) # 1b54 <strlen>
 5bc:	00050793          	mv	a5,a0
 5c0:	f4f42a23          	sw	a5,-172(s0)
 5c4:	f5442783          	lw	a5,-172(s0)
 5c8:	0017879b          	addiw	a5,a5,1
 5cc:	0007879b          	sext.w	a5,a5
 5d0:	00078713          	mv	a4,a5
 5d4:	fff70713          	addi	a4,a4,-1
 5d8:	f4e43423          	sd	a4,-184(s0)
 5dc:	00078713          	mv	a4,a5
 5e0:	cee43823          	sd	a4,-784(s0)
 5e4:	ce043c23          	sd	zero,-776(s0)
 5e8:	cf043703          	ld	a4,-784(s0)
 5ec:	03d75713          	srli	a4,a4,0x3d
 5f0:	cf843683          	ld	a3,-776(s0)
 5f4:	00369693          	slli	a3,a3,0x3
 5f8:	c8d43c23          	sd	a3,-872(s0)
 5fc:	c9843683          	ld	a3,-872(s0)
 600:	00d76733          	or	a4,a4,a3
 604:	c8e43c23          	sd	a4,-872(s0)
 608:	cf043703          	ld	a4,-784(s0)
 60c:	00371713          	slli	a4,a4,0x3
 610:	c8e43823          	sd	a4,-880(s0)
 614:	00078713          	mv	a4,a5
 618:	cee43023          	sd	a4,-800(s0)
 61c:	ce043423          	sd	zero,-792(s0)
 620:	ce043703          	ld	a4,-800(s0)
 624:	03d75713          	srli	a4,a4,0x3d
 628:	ce843683          	ld	a3,-792(s0)
 62c:	00369d93          	slli	s11,a3,0x3
 630:	01b76db3          	or	s11,a4,s11
 634:	ce043703          	ld	a4,-800(s0)
 638:	00371d13          	slli	s10,a4,0x3
 63c:	00f78793          	addi	a5,a5,15
 640:	0047d793          	srli	a5,a5,0x4
 644:	00479793          	slli	a5,a5,0x4
 648:	40f10133          	sub	sp,sp,a5
 64c:	00010793          	mv	a5,sp
 650:	00078793          	mv	a5,a5
 654:	f4f43023          	sd	a5,-192(s0)
 658:	f8042223          	sw	zero,-124(s0)
 65c:	0300006f          	j	68c <parse_cmd+0x440>
 660:	f8442783          	lw	a5,-124(s0)
 664:	f5843703          	ld	a4,-168(s0)
 668:	00f707b3          	add	a5,a4,a5
 66c:	0007c703          	lbu	a4,0(a5)
 670:	f4043683          	ld	a3,-192(s0)
 674:	f8442783          	lw	a5,-124(s0)
 678:	00f687b3          	add	a5,a3,a5
 67c:	00e78023          	sb	a4,0(a5)
 680:	f8442783          	lw	a5,-124(s0)
 684:	0017879b          	addiw	a5,a5,1
 688:	f8f42223          	sw	a5,-124(s0)
 68c:	f8442783          	lw	a5,-124(s0)
 690:	00078713          	mv	a4,a5
 694:	f5442783          	lw	a5,-172(s0)
 698:	0007071b          	sext.w	a4,a4
 69c:	0007879b          	sext.w	a5,a5
 6a0:	fcf740e3          	blt	a4,a5,660 <parse_cmd+0x414>
 6a4:	f4043703          	ld	a4,-192(s0)
 6a8:	f5442783          	lw	a5,-172(s0)
 6ac:	00f707b3          	add	a5,a4,a5
 6b0:	00078023          	sb	zero,0(a5)
 6b4:	f5442783          	lw	a5,-172(s0)
 6b8:	d0843703          	ld	a4,-760(s0)
 6bc:	00f707b3          	add	a5,a4,a5
 6c0:	d0f43423          	sd	a5,-760(s0)
 6c4:	0100006f          	j	6d4 <parse_cmd+0x488>
 6c8:	d0843783          	ld	a5,-760(s0)
 6cc:	00178793          	addi	a5,a5,1
 6d0:	d0f43423          	sd	a5,-760(s0)
 6d4:	d0843783          	ld	a5,-760(s0)
 6d8:	0007c783          	lbu	a5,0(a5)
 6dc:	00078713          	mv	a4,a5
 6e0:	02000793          	li	a5,32
 6e4:	00f71863          	bne	a4,a5,6f4 <parse_cmd+0x4a8>
 6e8:	d0843783          	ld	a5,-760(s0)
 6ec:	0007c783          	lbu	a5,0(a5)
 6f0:	fc079ce3          	bnez	a5,6c8 <parse_cmd+0x47c>
 6f4:	d0843503          	ld	a0,-760(s0)
 6f8:	00000097          	auipc	ra,0x0
 6fc:	9bc080e7          	jalr	-1604(ra) # b4 <get_param>
 700:	f4a43c23          	sd	a0,-168(s0)
 704:	f5843503          	ld	a0,-168(s0)
 708:	00001097          	auipc	ra,0x1
 70c:	44c080e7          	jalr	1100(ra) # 1b54 <strlen>
 710:	00050793          	mv	a5,a0
 714:	f4f42a23          	sw	a5,-172(s0)
 718:	f5442783          	lw	a5,-172(s0)
 71c:	0017879b          	addiw	a5,a5,1
 720:	0007879b          	sext.w	a5,a5
 724:	00078713          	mv	a4,a5
 728:	fff70713          	addi	a4,a4,-1
 72c:	f2e43c23          	sd	a4,-200(s0)
 730:	00078713          	mv	a4,a5
 734:	cce43823          	sd	a4,-816(s0)
 738:	cc043c23          	sd	zero,-808(s0)
 73c:	cd043703          	ld	a4,-816(s0)
 740:	03d75713          	srli	a4,a4,0x3d
 744:	cd843683          	ld	a3,-808(s0)
 748:	00369c93          	slli	s9,a3,0x3
 74c:	01976cb3          	or	s9,a4,s9
 750:	cd043703          	ld	a4,-816(s0)
 754:	00371c13          	slli	s8,a4,0x3
 758:	00078713          	mv	a4,a5
 75c:	cce43023          	sd	a4,-832(s0)
 760:	cc043423          	sd	zero,-824(s0)
 764:	cc043703          	ld	a4,-832(s0)
 768:	03d75713          	srli	a4,a4,0x3d
 76c:	cc843683          	ld	a3,-824(s0)
 770:	00369b93          	slli	s7,a3,0x3
 774:	01776bb3          	or	s7,a4,s7
 778:	cc043703          	ld	a4,-832(s0)
 77c:	00371b13          	slli	s6,a4,0x3
 780:	00f78793          	addi	a5,a5,15
 784:	0047d793          	srli	a5,a5,0x4
 788:	00479793          	slli	a5,a5,0x4
 78c:	40f10133          	sub	sp,sp,a5
 790:	00010793          	mv	a5,sp
 794:	00078793          	mv	a5,a5
 798:	f2f43823          	sd	a5,-208(s0)
 79c:	f8042023          	sw	zero,-128(s0)
 7a0:	0300006f          	j	7d0 <parse_cmd+0x584>
 7a4:	f8042783          	lw	a5,-128(s0)
 7a8:	f5843703          	ld	a4,-168(s0)
 7ac:	00f707b3          	add	a5,a4,a5
 7b0:	0007c703          	lbu	a4,0(a5)
 7b4:	f3043683          	ld	a3,-208(s0)
 7b8:	f8042783          	lw	a5,-128(s0)
 7bc:	00f687b3          	add	a5,a3,a5
 7c0:	00e78023          	sb	a4,0(a5)
 7c4:	f8042783          	lw	a5,-128(s0)
 7c8:	0017879b          	addiw	a5,a5,1
 7cc:	f8f42023          	sw	a5,-128(s0)
 7d0:	f8042783          	lw	a5,-128(s0)
 7d4:	00078713          	mv	a4,a5
 7d8:	f5442783          	lw	a5,-172(s0)
 7dc:	0007071b          	sext.w	a4,a4
 7e0:	0007879b          	sext.w	a5,a5
 7e4:	fcf740e3          	blt	a4,a5,7a4 <parse_cmd+0x558>
 7e8:	f3043703          	ld	a4,-208(s0)
 7ec:	f5442783          	lw	a5,-172(s0)
 7f0:	00f707b3          	add	a5,a4,a5
 7f4:	00078023          	sb	zero,0(a5)
 7f8:	f5442783          	lw	a5,-172(s0)
 7fc:	d0843703          	ld	a4,-760(s0)
 800:	00f707b3          	add	a5,a4,a5
 804:	d0f43423          	sd	a5,-760(s0)
 808:	0100006f          	j	818 <parse_cmd+0x5cc>
 80c:	d0843783          	ld	a5,-760(s0)
 810:	00178793          	addi	a5,a5,1
 814:	d0f43423          	sd	a5,-760(s0)
 818:	d0843783          	ld	a5,-760(s0)
 81c:	0007c783          	lbu	a5,0(a5)
 820:	00078713          	mv	a4,a5
 824:	02000793          	li	a5,32
 828:	00f71863          	bne	a4,a5,838 <parse_cmd+0x5ec>
 82c:	d0843783          	ld	a5,-760(s0)
 830:	0007c783          	lbu	a5,0(a5)
 834:	fc079ce3          	bnez	a5,80c <parse_cmd+0x5c0>
 838:	d0843503          	ld	a0,-760(s0)
 83c:	00000097          	auipc	ra,0x0
 840:	92c080e7          	jalr	-1748(ra) # 168 <get_string>
 844:	f4a43c23          	sd	a0,-168(s0)
 848:	f5843503          	ld	a0,-168(s0)
 84c:	00001097          	auipc	ra,0x1
 850:	308080e7          	jalr	776(ra) # 1b54 <strlen>
 854:	00050793          	mv	a5,a0
 858:	f4f42a23          	sw	a5,-172(s0)
 85c:	f5442783          	lw	a5,-172(s0)
 860:	0017879b          	addiw	a5,a5,1
 864:	0007879b          	sext.w	a5,a5
 868:	00078713          	mv	a4,a5
 86c:	fff70713          	addi	a4,a4,-1
 870:	f2e43423          	sd	a4,-216(s0)
 874:	00078713          	mv	a4,a5
 878:	cae43823          	sd	a4,-848(s0)
 87c:	ca043c23          	sd	zero,-840(s0)
 880:	cb043703          	ld	a4,-848(s0)
 884:	03d75713          	srli	a4,a4,0x3d
 888:	cb843683          	ld	a3,-840(s0)
 88c:	00369a93          	slli	s5,a3,0x3
 890:	01576ab3          	or	s5,a4,s5
 894:	cb043703          	ld	a4,-848(s0)
 898:	00371a13          	slli	s4,a4,0x3
 89c:	00078713          	mv	a4,a5
 8a0:	cae43023          	sd	a4,-864(s0)
 8a4:	ca043423          	sd	zero,-856(s0)
 8a8:	ca043703          	ld	a4,-864(s0)
 8ac:	03d75713          	srli	a4,a4,0x3d
 8b0:	ca843683          	ld	a3,-856(s0)
 8b4:	00369993          	slli	s3,a3,0x3
 8b8:	013769b3          	or	s3,a4,s3
 8bc:	ca043703          	ld	a4,-864(s0)
 8c0:	00371913          	slli	s2,a4,0x3
 8c4:	00f78793          	addi	a5,a5,15
 8c8:	0047d793          	srli	a5,a5,0x4
 8cc:	00479793          	slli	a5,a5,0x4
 8d0:	40f10133          	sub	sp,sp,a5
 8d4:	00010793          	mv	a5,sp
 8d8:	00078793          	mv	a5,a5
 8dc:	f2f43023          	sd	a5,-224(s0)
 8e0:	f6042e23          	sw	zero,-132(s0)
 8e4:	0300006f          	j	914 <parse_cmd+0x6c8>
 8e8:	f7c42783          	lw	a5,-132(s0)
 8ec:	f5843703          	ld	a4,-168(s0)
 8f0:	00f707b3          	add	a5,a4,a5
 8f4:	0007c703          	lbu	a4,0(a5)
 8f8:	f2043683          	ld	a3,-224(s0)
 8fc:	f7c42783          	lw	a5,-132(s0)
 900:	00f687b3          	add	a5,a3,a5
 904:	00e78023          	sb	a4,0(a5)
 908:	f7c42783          	lw	a5,-132(s0)
 90c:	0017879b          	addiw	a5,a5,1
 910:	f6f42e23          	sw	a5,-132(s0)
 914:	f7c42783          	lw	a5,-132(s0)
 918:	00078713          	mv	a4,a5
 91c:	f5442783          	lw	a5,-172(s0)
 920:	0007071b          	sext.w	a4,a4
 924:	0007879b          	sext.w	a5,a5
 928:	fcf740e3          	blt	a4,a5,8e8 <parse_cmd+0x69c>
 92c:	f2043703          	ld	a4,-224(s0)
 930:	f5442783          	lw	a5,-172(s0)
 934:	00f707b3          	add	a5,a4,a5
 938:	00078023          	sb	zero,0(a5)
 93c:	f5442783          	lw	a5,-172(s0)
 940:	d0843703          	ld	a4,-760(s0)
 944:	00f707b3          	add	a5,a4,a5
 948:	d0f43423          	sd	a5,-760(s0)
 94c:	f3043503          	ld	a0,-208(s0)
 950:	fffff097          	auipc	ra,0xfffff
 954:	6b4080e7          	jalr	1716(ra) # 4 <atoi>
 958:	00050793          	mv	a5,a0
 95c:	f0f42e23          	sw	a5,-228(s0)
 960:	00300593          	li	a1,3
 964:	f4043503          	ld	a0,-192(s0)
 968:	00001097          	auipc	ra,0x1
 96c:	420080e7          	jalr	1056(ra) # 1d88 <open>
 970:	00050793          	mv	a5,a0
 974:	f0f42c23          	sw	a5,-232(s0)
 978:	f1c42703          	lw	a4,-228(s0)
 97c:	f1842783          	lw	a5,-232(s0)
 980:	00000613          	li	a2,0
 984:	00070593          	mv	a1,a4
 988:	00078513          	mv	a0,a5
 98c:	00001097          	auipc	ra,0x1
 990:	490080e7          	jalr	1168(ra) # 1e1c <lseek>
 994:	f5442703          	lw	a4,-172(s0)
 998:	f1842783          	lw	a5,-232(s0)
 99c:	00070613          	mv	a2,a4
 9a0:	f2043583          	ld	a1,-224(s0)
 9a4:	00078513          	mv	a0,a5
 9a8:	00001097          	auipc	ra,0x1
 9ac:	1f8080e7          	jalr	504(ra) # 1ba0 <write>
 9b0:	f1842783          	lw	a5,-232(s0)
 9b4:	00078513          	mv	a0,a5
 9b8:	00001097          	auipc	ra,0x1
 9bc:	41c080e7          	jalr	1052(ra) # 1dd4 <close>
 9c0:	00048113          	mv	sp,s1
 9c4:	0180006f          	j	9dc <parse_cmd+0x790>
 9c8:	d0843583          	ld	a1,-760(s0)
 9cc:	00002517          	auipc	a0,0x2
 9d0:	81c50513          	addi	a0,a0,-2020 # 21e8 <lseek+0x3cc>
 9d4:	00001097          	auipc	ra,0x1
 9d8:	080080e7          	jalr	128(ra) # 1a54 <printf>
 9dc:	c9040113          	addi	sp,s0,-880
 9e0:	36813083          	ld	ra,872(sp)
 9e4:	36013403          	ld	s0,864(sp)
 9e8:	35813483          	ld	s1,856(sp)
 9ec:	35013903          	ld	s2,848(sp)
 9f0:	34813983          	ld	s3,840(sp)
 9f4:	34013a03          	ld	s4,832(sp)
 9f8:	33813a83          	ld	s5,824(sp)
 9fc:	33013b03          	ld	s6,816(sp)
 a00:	32813b83          	ld	s7,808(sp)
 a04:	32013c03          	ld	s8,800(sp)
 a08:	31813c83          	ld	s9,792(sp)
 a0c:	31013d03          	ld	s10,784(sp)
 a10:	30813d83          	ld	s11,776(sp)
 a14:	37010113          	addi	sp,sp,880
 a18:	00008067          	ret

Disassembly of section .text.main:

0000000000000a1c <main>:
 a1c:	f6010113          	addi	sp,sp,-160
 a20:	08113c23          	sd	ra,152(sp)
 a24:	08813823          	sd	s0,144(sp)
 a28:	0a010413          	addi	s0,sp,160
 a2c:	00f00613          	li	a2,15
 a30:	00001597          	auipc	a1,0x1
 a34:	7d058593          	addi	a1,a1,2000 # 2200 <lseek+0x3e4>
 a38:	00100513          	li	a0,1
 a3c:	00001097          	auipc	ra,0x1
 a40:	164080e7          	jalr	356(ra) # 1ba0 <write>
 a44:	00f00613          	li	a2,15
 a48:	00001597          	auipc	a1,0x1
 a4c:	7c858593          	addi	a1,a1,1992 # 2210 <lseek+0x3f4>
 a50:	00200513          	li	a0,2
 a54:	00001097          	auipc	ra,0x1
 a58:	14c080e7          	jalr	332(ra) # 1ba0 <write>
 a5c:	fe042623          	sw	zero,-20(s0)
 a60:	00001517          	auipc	a0,0x1
 a64:	7c050513          	addi	a0,a0,1984 # 2220 <lseek+0x404>
 a68:	00001097          	auipc	ra,0x1
 a6c:	fec080e7          	jalr	-20(ra) # 1a54 <printf>
 a70:	fe840793          	addi	a5,s0,-24
 a74:	00100613          	li	a2,1
 a78:	00078593          	mv	a1,a5
 a7c:	00000513          	li	a0,0
 a80:	00001097          	auipc	ra,0x1
 a84:	240080e7          	jalr	576(ra) # 1cc0 <read>
 a88:	fe844783          	lbu	a5,-24(s0)
 a8c:	00078713          	mv	a4,a5
 a90:	00d00793          	li	a5,13
 a94:	02f71063          	bne	a4,a5,ab4 <main+0x98>
 a98:	00100613          	li	a2,1
 a9c:	00001597          	auipc	a1,0x1
 aa0:	71c58593          	addi	a1,a1,1820 # 21b8 <lseek+0x39c>
 aa4:	00100513          	li	a0,1
 aa8:	00001097          	auipc	ra,0x1
 aac:	0f8080e7          	jalr	248(ra) # 1ba0 <write>
 ab0:	0480006f          	j	af8 <main+0xdc>
 ab4:	fe844783          	lbu	a5,-24(s0)
 ab8:	00078713          	mv	a4,a5
 abc:	07f00793          	li	a5,127
 ac0:	02f71c63          	bne	a4,a5,af8 <main+0xdc>
 ac4:	fec42783          	lw	a5,-20(s0)
 ac8:	0007879b          	sext.w	a5,a5
 acc:	0af05a63          	blez	a5,b80 <main+0x164>
 ad0:	00300613          	li	a2,3
 ad4:	00001597          	auipc	a1,0x1
 ad8:	76458593          	addi	a1,a1,1892 # 2238 <lseek+0x41c>
 adc:	00100513          	li	a0,1
 ae0:	00001097          	auipc	ra,0x1
 ae4:	0c0080e7          	jalr	192(ra) # 1ba0 <write>
 ae8:	fec42783          	lw	a5,-20(s0)
 aec:	fff7879b          	addiw	a5,a5,-1
 af0:	fef42623          	sw	a5,-20(s0)
 af4:	08c0006f          	j	b80 <main+0x164>
 af8:	fe840793          	addi	a5,s0,-24
 afc:	00100613          	li	a2,1
 b00:	00078593          	mv	a1,a5
 b04:	00100513          	li	a0,1
 b08:	00001097          	auipc	ra,0x1
 b0c:	098080e7          	jalr	152(ra) # 1ba0 <write>
 b10:	fe844783          	lbu	a5,-24(s0)
 b14:	00078713          	mv	a4,a5
 b18:	00d00793          	li	a5,13
 b1c:	04f71263          	bne	a4,a5,b60 <main+0x144>
 b20:	fec42783          	lw	a5,-20(s0)
 b24:	ff078793          	addi	a5,a5,-16
 b28:	008787b3          	add	a5,a5,s0
 b2c:	f6078c23          	sb	zero,-136(a5)
 b30:	fec42703          	lw	a4,-20(s0)
 b34:	f6840793          	addi	a5,s0,-152
 b38:	00070593          	mv	a1,a4
 b3c:	00078513          	mv	a0,a5
 b40:	fffff097          	auipc	ra,0xfffff
 b44:	70c080e7          	jalr	1804(ra) # 24c <parse_cmd>
 b48:	fe042623          	sw	zero,-20(s0)
 b4c:	00001517          	auipc	a0,0x1
 b50:	6d450513          	addi	a0,a0,1748 # 2220 <lseek+0x404>
 b54:	00001097          	auipc	ra,0x1
 b58:	f00080e7          	jalr	-256(ra) # 1a54 <printf>
 b5c:	f15ff06f          	j	a70 <main+0x54>
 b60:	fec42783          	lw	a5,-20(s0)
 b64:	0017871b          	addiw	a4,a5,1
 b68:	fee42623          	sw	a4,-20(s0)
 b6c:	fe844703          	lbu	a4,-24(s0)
 b70:	ff078793          	addi	a5,a5,-16
 b74:	008787b3          	add	a5,a5,s0
 b78:	f6e78c23          	sb	a4,-136(a5)
 b7c:	ef5ff06f          	j	a70 <main+0x54>
 b80:	00000013          	nop
 b84:	eedff06f          	j	a70 <main+0x54>

Disassembly of section .text.putc:

0000000000000b88 <putc>:
 b88:	fe010113          	addi	sp,sp,-32
 b8c:	00813c23          	sd	s0,24(sp)
 b90:	02010413          	addi	s0,sp,32
 b94:	00050793          	mv	a5,a0
 b98:	fef42623          	sw	a5,-20(s0)
 b9c:	00002797          	auipc	a5,0x2
 ba0:	6f478793          	addi	a5,a5,1780 # 3290 <tail>
 ba4:	0007a783          	lw	a5,0(a5)
 ba8:	0017871b          	addiw	a4,a5,1
 bac:	0007069b          	sext.w	a3,a4
 bb0:	00002717          	auipc	a4,0x2
 bb4:	6e070713          	addi	a4,a4,1760 # 3290 <tail>
 bb8:	00d72023          	sw	a3,0(a4)
 bbc:	fec42703          	lw	a4,-20(s0)
 bc0:	0ff77713          	zext.b	a4,a4
 bc4:	00002697          	auipc	a3,0x2
 bc8:	6d468693          	addi	a3,a3,1748 # 3298 <buffer>
 bcc:	00f687b3          	add	a5,a3,a5
 bd0:	00e78023          	sb	a4,0(a5)
 bd4:	fec42783          	lw	a5,-20(s0)
 bd8:	0ff7f793          	zext.b	a5,a5
 bdc:	0007879b          	sext.w	a5,a5
 be0:	00078513          	mv	a0,a5
 be4:	01813403          	ld	s0,24(sp)
 be8:	02010113          	addi	sp,sp,32
 bec:	00008067          	ret

Disassembly of section .text.isspace:

0000000000000bf0 <isspace>:
 bf0:	fe010113          	addi	sp,sp,-32
 bf4:	00813c23          	sd	s0,24(sp)
 bf8:	02010413          	addi	s0,sp,32
 bfc:	00050793          	mv	a5,a0
 c00:	fef42623          	sw	a5,-20(s0)
 c04:	fec42783          	lw	a5,-20(s0)
 c08:	0007871b          	sext.w	a4,a5
 c0c:	02000793          	li	a5,32
 c10:	02f70263          	beq	a4,a5,c34 <isspace+0x44>
 c14:	fec42783          	lw	a5,-20(s0)
 c18:	0007871b          	sext.w	a4,a5
 c1c:	00800793          	li	a5,8
 c20:	00e7de63          	bge	a5,a4,c3c <isspace+0x4c>
 c24:	fec42783          	lw	a5,-20(s0)
 c28:	0007871b          	sext.w	a4,a5
 c2c:	00d00793          	li	a5,13
 c30:	00e7c663          	blt	a5,a4,c3c <isspace+0x4c>
 c34:	00100793          	li	a5,1
 c38:	0080006f          	j	c40 <isspace+0x50>
 c3c:	00000793          	li	a5,0
 c40:	00078513          	mv	a0,a5
 c44:	01813403          	ld	s0,24(sp)
 c48:	02010113          	addi	sp,sp,32
 c4c:	00008067          	ret

Disassembly of section .text.strtol:

0000000000000c50 <strtol>:
 c50:	fb010113          	addi	sp,sp,-80
 c54:	04113423          	sd	ra,72(sp)
 c58:	04813023          	sd	s0,64(sp)
 c5c:	05010413          	addi	s0,sp,80
 c60:	fca43423          	sd	a0,-56(s0)
 c64:	fcb43023          	sd	a1,-64(s0)
 c68:	00060793          	mv	a5,a2
 c6c:	faf42e23          	sw	a5,-68(s0)
 c70:	fe043423          	sd	zero,-24(s0)
 c74:	fe0403a3          	sb	zero,-25(s0)
 c78:	fc843783          	ld	a5,-56(s0)
 c7c:	fcf43c23          	sd	a5,-40(s0)
 c80:	0100006f          	j	c90 <strtol+0x40>
 c84:	fd843783          	ld	a5,-40(s0)
 c88:	00178793          	addi	a5,a5,1
 c8c:	fcf43c23          	sd	a5,-40(s0)
 c90:	fd843783          	ld	a5,-40(s0)
 c94:	0007c783          	lbu	a5,0(a5)
 c98:	0007879b          	sext.w	a5,a5
 c9c:	00078513          	mv	a0,a5
 ca0:	00000097          	auipc	ra,0x0
 ca4:	f50080e7          	jalr	-176(ra) # bf0 <isspace>
 ca8:	00050793          	mv	a5,a0
 cac:	fc079ce3          	bnez	a5,c84 <strtol+0x34>
 cb0:	fd843783          	ld	a5,-40(s0)
 cb4:	0007c783          	lbu	a5,0(a5)
 cb8:	00078713          	mv	a4,a5
 cbc:	02d00793          	li	a5,45
 cc0:	00f71e63          	bne	a4,a5,cdc <strtol+0x8c>
 cc4:	00100793          	li	a5,1
 cc8:	fef403a3          	sb	a5,-25(s0)
 ccc:	fd843783          	ld	a5,-40(s0)
 cd0:	00178793          	addi	a5,a5,1
 cd4:	fcf43c23          	sd	a5,-40(s0)
 cd8:	0240006f          	j	cfc <strtol+0xac>
 cdc:	fd843783          	ld	a5,-40(s0)
 ce0:	0007c783          	lbu	a5,0(a5)
 ce4:	00078713          	mv	a4,a5
 ce8:	02b00793          	li	a5,43
 cec:	00f71863          	bne	a4,a5,cfc <strtol+0xac>
 cf0:	fd843783          	ld	a5,-40(s0)
 cf4:	00178793          	addi	a5,a5,1
 cf8:	fcf43c23          	sd	a5,-40(s0)
 cfc:	fbc42783          	lw	a5,-68(s0)
 d00:	0007879b          	sext.w	a5,a5
 d04:	06079c63          	bnez	a5,d7c <strtol+0x12c>
 d08:	fd843783          	ld	a5,-40(s0)
 d0c:	0007c783          	lbu	a5,0(a5)
 d10:	00078713          	mv	a4,a5
 d14:	03000793          	li	a5,48
 d18:	04f71e63          	bne	a4,a5,d74 <strtol+0x124>
 d1c:	fd843783          	ld	a5,-40(s0)
 d20:	00178793          	addi	a5,a5,1
 d24:	fcf43c23          	sd	a5,-40(s0)
 d28:	fd843783          	ld	a5,-40(s0)
 d2c:	0007c783          	lbu	a5,0(a5)
 d30:	00078713          	mv	a4,a5
 d34:	07800793          	li	a5,120
 d38:	00f70c63          	beq	a4,a5,d50 <strtol+0x100>
 d3c:	fd843783          	ld	a5,-40(s0)
 d40:	0007c783          	lbu	a5,0(a5)
 d44:	00078713          	mv	a4,a5
 d48:	05800793          	li	a5,88
 d4c:	00f71e63          	bne	a4,a5,d68 <strtol+0x118>
 d50:	01000793          	li	a5,16
 d54:	faf42e23          	sw	a5,-68(s0)
 d58:	fd843783          	ld	a5,-40(s0)
 d5c:	00178793          	addi	a5,a5,1
 d60:	fcf43c23          	sd	a5,-40(s0)
 d64:	0180006f          	j	d7c <strtol+0x12c>
 d68:	00800793          	li	a5,8
 d6c:	faf42e23          	sw	a5,-68(s0)
 d70:	00c0006f          	j	d7c <strtol+0x12c>
 d74:	00a00793          	li	a5,10
 d78:	faf42e23          	sw	a5,-68(s0)
 d7c:	fd843783          	ld	a5,-40(s0)
 d80:	0007c783          	lbu	a5,0(a5)
 d84:	00078713          	mv	a4,a5
 d88:	02f00793          	li	a5,47
 d8c:	02e7f863          	bgeu	a5,a4,dbc <strtol+0x16c>
 d90:	fd843783          	ld	a5,-40(s0)
 d94:	0007c783          	lbu	a5,0(a5)
 d98:	00078713          	mv	a4,a5
 d9c:	03900793          	li	a5,57
 da0:	00e7ee63          	bltu	a5,a4,dbc <strtol+0x16c>
 da4:	fd843783          	ld	a5,-40(s0)
 da8:	0007c783          	lbu	a5,0(a5)
 dac:	0007879b          	sext.w	a5,a5
 db0:	fd07879b          	addiw	a5,a5,-48
 db4:	fcf42a23          	sw	a5,-44(s0)
 db8:	0800006f          	j	e38 <strtol+0x1e8>
 dbc:	fd843783          	ld	a5,-40(s0)
 dc0:	0007c783          	lbu	a5,0(a5)
 dc4:	00078713          	mv	a4,a5
 dc8:	06000793          	li	a5,96
 dcc:	02e7f863          	bgeu	a5,a4,dfc <strtol+0x1ac>
 dd0:	fd843783          	ld	a5,-40(s0)
 dd4:	0007c783          	lbu	a5,0(a5)
 dd8:	00078713          	mv	a4,a5
 ddc:	07a00793          	li	a5,122
 de0:	00e7ee63          	bltu	a5,a4,dfc <strtol+0x1ac>
 de4:	fd843783          	ld	a5,-40(s0)
 de8:	0007c783          	lbu	a5,0(a5)
 dec:	0007879b          	sext.w	a5,a5
 df0:	fa97879b          	addiw	a5,a5,-87
 df4:	fcf42a23          	sw	a5,-44(s0)
 df8:	0400006f          	j	e38 <strtol+0x1e8>
 dfc:	fd843783          	ld	a5,-40(s0)
 e00:	0007c783          	lbu	a5,0(a5)
 e04:	00078713          	mv	a4,a5
 e08:	04000793          	li	a5,64
 e0c:	06e7f863          	bgeu	a5,a4,e7c <strtol+0x22c>
 e10:	fd843783          	ld	a5,-40(s0)
 e14:	0007c783          	lbu	a5,0(a5)
 e18:	00078713          	mv	a4,a5
 e1c:	05a00793          	li	a5,90
 e20:	04e7ee63          	bltu	a5,a4,e7c <strtol+0x22c>
 e24:	fd843783          	ld	a5,-40(s0)
 e28:	0007c783          	lbu	a5,0(a5)
 e2c:	0007879b          	sext.w	a5,a5
 e30:	fc97879b          	addiw	a5,a5,-55
 e34:	fcf42a23          	sw	a5,-44(s0)
 e38:	fd442783          	lw	a5,-44(s0)
 e3c:	00078713          	mv	a4,a5
 e40:	fbc42783          	lw	a5,-68(s0)
 e44:	0007071b          	sext.w	a4,a4
 e48:	0007879b          	sext.w	a5,a5
 e4c:	02f75663          	bge	a4,a5,e78 <strtol+0x228>
 e50:	fbc42703          	lw	a4,-68(s0)
 e54:	fe843783          	ld	a5,-24(s0)
 e58:	02f70733          	mul	a4,a4,a5
 e5c:	fd442783          	lw	a5,-44(s0)
 e60:	00f707b3          	add	a5,a4,a5
 e64:	fef43423          	sd	a5,-24(s0)
 e68:	fd843783          	ld	a5,-40(s0)
 e6c:	00178793          	addi	a5,a5,1
 e70:	fcf43c23          	sd	a5,-40(s0)
 e74:	f09ff06f          	j	d7c <strtol+0x12c>
 e78:	00000013          	nop
 e7c:	fc043783          	ld	a5,-64(s0)
 e80:	00078863          	beqz	a5,e90 <strtol+0x240>
 e84:	fc043783          	ld	a5,-64(s0)
 e88:	fd843703          	ld	a4,-40(s0)
 e8c:	00e7b023          	sd	a4,0(a5)
 e90:	fe744783          	lbu	a5,-25(s0)
 e94:	0ff7f793          	zext.b	a5,a5
 e98:	00078863          	beqz	a5,ea8 <strtol+0x258>
 e9c:	fe843783          	ld	a5,-24(s0)
 ea0:	40f007b3          	neg	a5,a5
 ea4:	0080006f          	j	eac <strtol+0x25c>
 ea8:	fe843783          	ld	a5,-24(s0)
 eac:	00078513          	mv	a0,a5
 eb0:	04813083          	ld	ra,72(sp)
 eb4:	04013403          	ld	s0,64(sp)
 eb8:	05010113          	addi	sp,sp,80
 ebc:	00008067          	ret

Disassembly of section .text.puts_wo_nl:

0000000000000ec0 <puts_wo_nl>:
 ec0:	fd010113          	addi	sp,sp,-48
 ec4:	02113423          	sd	ra,40(sp)
 ec8:	02813023          	sd	s0,32(sp)
 ecc:	03010413          	addi	s0,sp,48
 ed0:	fca43c23          	sd	a0,-40(s0)
 ed4:	fcb43823          	sd	a1,-48(s0)
 ed8:	fd043783          	ld	a5,-48(s0)
 edc:	00079863          	bnez	a5,eec <puts_wo_nl+0x2c>
 ee0:	00001797          	auipc	a5,0x1
 ee4:	36078793          	addi	a5,a5,864 # 2240 <lseek+0x424>
 ee8:	fcf43823          	sd	a5,-48(s0)
 eec:	fd043783          	ld	a5,-48(s0)
 ef0:	fef43423          	sd	a5,-24(s0)
 ef4:	0240006f          	j	f18 <puts_wo_nl+0x58>
 ef8:	fe843783          	ld	a5,-24(s0)
 efc:	00178713          	addi	a4,a5,1
 f00:	fee43423          	sd	a4,-24(s0)
 f04:	0007c783          	lbu	a5,0(a5)
 f08:	0007871b          	sext.w	a4,a5
 f0c:	fd843783          	ld	a5,-40(s0)
 f10:	00070513          	mv	a0,a4
 f14:	000780e7          	jalr	a5
 f18:	fe843783          	ld	a5,-24(s0)
 f1c:	0007c783          	lbu	a5,0(a5)
 f20:	fc079ce3          	bnez	a5,ef8 <puts_wo_nl+0x38>
 f24:	fe843703          	ld	a4,-24(s0)
 f28:	fd043783          	ld	a5,-48(s0)
 f2c:	40f707b3          	sub	a5,a4,a5
 f30:	0007879b          	sext.w	a5,a5
 f34:	00078513          	mv	a0,a5
 f38:	02813083          	ld	ra,40(sp)
 f3c:	02013403          	ld	s0,32(sp)
 f40:	03010113          	addi	sp,sp,48
 f44:	00008067          	ret

Disassembly of section .text.print_dec_int:

0000000000000f48 <print_dec_int>:
     f48:	f9010113          	addi	sp,sp,-112
     f4c:	06113423          	sd	ra,104(sp)
     f50:	06813023          	sd	s0,96(sp)
     f54:	07010413          	addi	s0,sp,112
     f58:	faa43423          	sd	a0,-88(s0)
     f5c:	fab43023          	sd	a1,-96(s0)
     f60:	00060793          	mv	a5,a2
     f64:	f8d43823          	sd	a3,-112(s0)
     f68:	f8f40fa3          	sb	a5,-97(s0)
     f6c:	f9f44783          	lbu	a5,-97(s0)
     f70:	0ff7f793          	zext.b	a5,a5
     f74:	02078863          	beqz	a5,fa4 <print_dec_int+0x5c>
     f78:	fa043703          	ld	a4,-96(s0)
     f7c:	fff00793          	li	a5,-1
     f80:	03f79793          	slli	a5,a5,0x3f
     f84:	02f71063          	bne	a4,a5,fa4 <print_dec_int+0x5c>
     f88:	00001597          	auipc	a1,0x1
     f8c:	2c058593          	addi	a1,a1,704 # 2248 <lseek+0x42c>
     f90:	fa843503          	ld	a0,-88(s0)
     f94:	00000097          	auipc	ra,0x0
     f98:	f2c080e7          	jalr	-212(ra) # ec0 <puts_wo_nl>
     f9c:	00050793          	mv	a5,a0
     fa0:	2a00006f          	j	1240 <print_dec_int+0x2f8>
     fa4:	f9043783          	ld	a5,-112(s0)
     fa8:	00c7a783          	lw	a5,12(a5)
     fac:	00079a63          	bnez	a5,fc0 <print_dec_int+0x78>
     fb0:	fa043783          	ld	a5,-96(s0)
     fb4:	00079663          	bnez	a5,fc0 <print_dec_int+0x78>
     fb8:	00000793          	li	a5,0
     fbc:	2840006f          	j	1240 <print_dec_int+0x2f8>
     fc0:	fe0407a3          	sb	zero,-17(s0)
     fc4:	f9f44783          	lbu	a5,-97(s0)
     fc8:	0ff7f793          	zext.b	a5,a5
     fcc:	02078063          	beqz	a5,fec <print_dec_int+0xa4>
     fd0:	fa043783          	ld	a5,-96(s0)
     fd4:	0007dc63          	bgez	a5,fec <print_dec_int+0xa4>
     fd8:	00100793          	li	a5,1
     fdc:	fef407a3          	sb	a5,-17(s0)
     fe0:	fa043783          	ld	a5,-96(s0)
     fe4:	40f007b3          	neg	a5,a5
     fe8:	faf43023          	sd	a5,-96(s0)
     fec:	fe042423          	sw	zero,-24(s0)
     ff0:	f9f44783          	lbu	a5,-97(s0)
     ff4:	0ff7f793          	zext.b	a5,a5
     ff8:	02078863          	beqz	a5,1028 <print_dec_int+0xe0>
     ffc:	fef44783          	lbu	a5,-17(s0)
    1000:	0ff7f793          	zext.b	a5,a5
    1004:	00079e63          	bnez	a5,1020 <print_dec_int+0xd8>
    1008:	f9043783          	ld	a5,-112(s0)
    100c:	0057c783          	lbu	a5,5(a5)
    1010:	00079863          	bnez	a5,1020 <print_dec_int+0xd8>
    1014:	f9043783          	ld	a5,-112(s0)
    1018:	0047c783          	lbu	a5,4(a5)
    101c:	00078663          	beqz	a5,1028 <print_dec_int+0xe0>
    1020:	00100793          	li	a5,1
    1024:	0080006f          	j	102c <print_dec_int+0xe4>
    1028:	00000793          	li	a5,0
    102c:	fcf40ba3          	sb	a5,-41(s0)
    1030:	fd744783          	lbu	a5,-41(s0)
    1034:	0017f793          	andi	a5,a5,1
    1038:	fcf40ba3          	sb	a5,-41(s0)
    103c:	fa043703          	ld	a4,-96(s0)
    1040:	00a00793          	li	a5,10
    1044:	02f777b3          	remu	a5,a4,a5
    1048:	0ff7f713          	zext.b	a4,a5
    104c:	fe842783          	lw	a5,-24(s0)
    1050:	0017869b          	addiw	a3,a5,1
    1054:	fed42423          	sw	a3,-24(s0)
    1058:	0307071b          	addiw	a4,a4,48
    105c:	0ff77713          	zext.b	a4,a4
    1060:	ff078793          	addi	a5,a5,-16
    1064:	008787b3          	add	a5,a5,s0
    1068:	fce78423          	sb	a4,-56(a5)
    106c:	fa043703          	ld	a4,-96(s0)
    1070:	00a00793          	li	a5,10
    1074:	02f757b3          	divu	a5,a4,a5
    1078:	faf43023          	sd	a5,-96(s0)
    107c:	fa043783          	ld	a5,-96(s0)
    1080:	fa079ee3          	bnez	a5,103c <print_dec_int+0xf4>
    1084:	f9043783          	ld	a5,-112(s0)
    1088:	00c7a783          	lw	a5,12(a5)
    108c:	00078713          	mv	a4,a5
    1090:	fff00793          	li	a5,-1
    1094:	02f71063          	bne	a4,a5,10b4 <print_dec_int+0x16c>
    1098:	f9043783          	ld	a5,-112(s0)
    109c:	0037c783          	lbu	a5,3(a5)
    10a0:	00078a63          	beqz	a5,10b4 <print_dec_int+0x16c>
    10a4:	f9043783          	ld	a5,-112(s0)
    10a8:	0087a703          	lw	a4,8(a5)
    10ac:	f9043783          	ld	a5,-112(s0)
    10b0:	00e7a623          	sw	a4,12(a5)
    10b4:	fe042223          	sw	zero,-28(s0)
    10b8:	f9043783          	ld	a5,-112(s0)
    10bc:	0087a703          	lw	a4,8(a5)
    10c0:	fe842783          	lw	a5,-24(s0)
    10c4:	fcf42823          	sw	a5,-48(s0)
    10c8:	f9043783          	ld	a5,-112(s0)
    10cc:	00c7a783          	lw	a5,12(a5)
    10d0:	fcf42623          	sw	a5,-52(s0)
    10d4:	fd042783          	lw	a5,-48(s0)
    10d8:	00078593          	mv	a1,a5
    10dc:	fcc42783          	lw	a5,-52(s0)
    10e0:	00078613          	mv	a2,a5
    10e4:	0006069b          	sext.w	a3,a2
    10e8:	0005879b          	sext.w	a5,a1
    10ec:	00f6d463          	bge	a3,a5,10f4 <print_dec_int+0x1ac>
    10f0:	00058613          	mv	a2,a1
    10f4:	0006079b          	sext.w	a5,a2
    10f8:	40f707bb          	subw	a5,a4,a5
    10fc:	0007871b          	sext.w	a4,a5
    1100:	fd744783          	lbu	a5,-41(s0)
    1104:	0007879b          	sext.w	a5,a5
    1108:	40f707bb          	subw	a5,a4,a5
    110c:	fef42023          	sw	a5,-32(s0)
    1110:	0280006f          	j	1138 <print_dec_int+0x1f0>
    1114:	fa843783          	ld	a5,-88(s0)
    1118:	02000513          	li	a0,32
    111c:	000780e7          	jalr	a5
    1120:	fe442783          	lw	a5,-28(s0)
    1124:	0017879b          	addiw	a5,a5,1
    1128:	fef42223          	sw	a5,-28(s0)
    112c:	fe042783          	lw	a5,-32(s0)
    1130:	fff7879b          	addiw	a5,a5,-1
    1134:	fef42023          	sw	a5,-32(s0)
    1138:	fe042783          	lw	a5,-32(s0)
    113c:	0007879b          	sext.w	a5,a5
    1140:	fcf04ae3          	bgtz	a5,1114 <print_dec_int+0x1cc>
    1144:	fd744783          	lbu	a5,-41(s0)
    1148:	0ff7f793          	zext.b	a5,a5
    114c:	04078463          	beqz	a5,1194 <print_dec_int+0x24c>
    1150:	fef44783          	lbu	a5,-17(s0)
    1154:	0ff7f793          	zext.b	a5,a5
    1158:	00078663          	beqz	a5,1164 <print_dec_int+0x21c>
    115c:	02d00793          	li	a5,45
    1160:	01c0006f          	j	117c <print_dec_int+0x234>
    1164:	f9043783          	ld	a5,-112(s0)
    1168:	0057c783          	lbu	a5,5(a5)
    116c:	00078663          	beqz	a5,1178 <print_dec_int+0x230>
    1170:	02b00793          	li	a5,43
    1174:	0080006f          	j	117c <print_dec_int+0x234>
    1178:	02000793          	li	a5,32
    117c:	fa843703          	ld	a4,-88(s0)
    1180:	00078513          	mv	a0,a5
    1184:	000700e7          	jalr	a4
    1188:	fe442783          	lw	a5,-28(s0)
    118c:	0017879b          	addiw	a5,a5,1
    1190:	fef42223          	sw	a5,-28(s0)
    1194:	fe842783          	lw	a5,-24(s0)
    1198:	fcf42e23          	sw	a5,-36(s0)
    119c:	0280006f          	j	11c4 <print_dec_int+0x27c>
    11a0:	fa843783          	ld	a5,-88(s0)
    11a4:	03000513          	li	a0,48
    11a8:	000780e7          	jalr	a5
    11ac:	fe442783          	lw	a5,-28(s0)
    11b0:	0017879b          	addiw	a5,a5,1
    11b4:	fef42223          	sw	a5,-28(s0)
    11b8:	fdc42783          	lw	a5,-36(s0)
    11bc:	0017879b          	addiw	a5,a5,1
    11c0:	fcf42e23          	sw	a5,-36(s0)
    11c4:	f9043783          	ld	a5,-112(s0)
    11c8:	00c7a703          	lw	a4,12(a5)
    11cc:	fd744783          	lbu	a5,-41(s0)
    11d0:	0007879b          	sext.w	a5,a5
    11d4:	40f707bb          	subw	a5,a4,a5
    11d8:	0007871b          	sext.w	a4,a5
    11dc:	fdc42783          	lw	a5,-36(s0)
    11e0:	0007879b          	sext.w	a5,a5
    11e4:	fae7cee3          	blt	a5,a4,11a0 <print_dec_int+0x258>
    11e8:	fe842783          	lw	a5,-24(s0)
    11ec:	fff7879b          	addiw	a5,a5,-1
    11f0:	fcf42c23          	sw	a5,-40(s0)
    11f4:	03c0006f          	j	1230 <print_dec_int+0x2e8>
    11f8:	fd842783          	lw	a5,-40(s0)
    11fc:	ff078793          	addi	a5,a5,-16
    1200:	008787b3          	add	a5,a5,s0
    1204:	fc87c783          	lbu	a5,-56(a5)
    1208:	0007871b          	sext.w	a4,a5
    120c:	fa843783          	ld	a5,-88(s0)
    1210:	00070513          	mv	a0,a4
    1214:	000780e7          	jalr	a5
    1218:	fe442783          	lw	a5,-28(s0)
    121c:	0017879b          	addiw	a5,a5,1
    1220:	fef42223          	sw	a5,-28(s0)
    1224:	fd842783          	lw	a5,-40(s0)
    1228:	fff7879b          	addiw	a5,a5,-1
    122c:	fcf42c23          	sw	a5,-40(s0)
    1230:	fd842783          	lw	a5,-40(s0)
    1234:	0007879b          	sext.w	a5,a5
    1238:	fc07d0e3          	bgez	a5,11f8 <print_dec_int+0x2b0>
    123c:	fe442783          	lw	a5,-28(s0)
    1240:	00078513          	mv	a0,a5
    1244:	06813083          	ld	ra,104(sp)
    1248:	06013403          	ld	s0,96(sp)
    124c:	07010113          	addi	sp,sp,112
    1250:	00008067          	ret

Disassembly of section .text.vprintfmt:

0000000000001254 <vprintfmt>:
    1254:	f4010113          	addi	sp,sp,-192
    1258:	0a113c23          	sd	ra,184(sp)
    125c:	0a813823          	sd	s0,176(sp)
    1260:	0c010413          	addi	s0,sp,192
    1264:	f4a43c23          	sd	a0,-168(s0)
    1268:	f4b43823          	sd	a1,-176(s0)
    126c:	f4c43423          	sd	a2,-184(s0)
    1270:	f8043023          	sd	zero,-128(s0)
    1274:	f8043423          	sd	zero,-120(s0)
    1278:	fe042623          	sw	zero,-20(s0)
    127c:	7b40006f          	j	1a30 <vprintfmt+0x7dc>
    1280:	f8044783          	lbu	a5,-128(s0)
    1284:	74078663          	beqz	a5,19d0 <vprintfmt+0x77c>
    1288:	f5043783          	ld	a5,-176(s0)
    128c:	0007c783          	lbu	a5,0(a5)
    1290:	00078713          	mv	a4,a5
    1294:	02300793          	li	a5,35
    1298:	00f71863          	bne	a4,a5,12a8 <vprintfmt+0x54>
    129c:	00100793          	li	a5,1
    12a0:	f8f40123          	sb	a5,-126(s0)
    12a4:	7800006f          	j	1a24 <vprintfmt+0x7d0>
    12a8:	f5043783          	ld	a5,-176(s0)
    12ac:	0007c783          	lbu	a5,0(a5)
    12b0:	00078713          	mv	a4,a5
    12b4:	03000793          	li	a5,48
    12b8:	00f71863          	bne	a4,a5,12c8 <vprintfmt+0x74>
    12bc:	00100793          	li	a5,1
    12c0:	f8f401a3          	sb	a5,-125(s0)
    12c4:	7600006f          	j	1a24 <vprintfmt+0x7d0>
    12c8:	f5043783          	ld	a5,-176(s0)
    12cc:	0007c783          	lbu	a5,0(a5)
    12d0:	00078713          	mv	a4,a5
    12d4:	06c00793          	li	a5,108
    12d8:	04f70063          	beq	a4,a5,1318 <vprintfmt+0xc4>
    12dc:	f5043783          	ld	a5,-176(s0)
    12e0:	0007c783          	lbu	a5,0(a5)
    12e4:	00078713          	mv	a4,a5
    12e8:	07a00793          	li	a5,122
    12ec:	02f70663          	beq	a4,a5,1318 <vprintfmt+0xc4>
    12f0:	f5043783          	ld	a5,-176(s0)
    12f4:	0007c783          	lbu	a5,0(a5)
    12f8:	00078713          	mv	a4,a5
    12fc:	07400793          	li	a5,116
    1300:	00f70c63          	beq	a4,a5,1318 <vprintfmt+0xc4>
    1304:	f5043783          	ld	a5,-176(s0)
    1308:	0007c783          	lbu	a5,0(a5)
    130c:	00078713          	mv	a4,a5
    1310:	06a00793          	li	a5,106
    1314:	00f71863          	bne	a4,a5,1324 <vprintfmt+0xd0>
    1318:	00100793          	li	a5,1
    131c:	f8f400a3          	sb	a5,-127(s0)
    1320:	7040006f          	j	1a24 <vprintfmt+0x7d0>
    1324:	f5043783          	ld	a5,-176(s0)
    1328:	0007c783          	lbu	a5,0(a5)
    132c:	00078713          	mv	a4,a5
    1330:	02b00793          	li	a5,43
    1334:	00f71863          	bne	a4,a5,1344 <vprintfmt+0xf0>
    1338:	00100793          	li	a5,1
    133c:	f8f402a3          	sb	a5,-123(s0)
    1340:	6e40006f          	j	1a24 <vprintfmt+0x7d0>
    1344:	f5043783          	ld	a5,-176(s0)
    1348:	0007c783          	lbu	a5,0(a5)
    134c:	00078713          	mv	a4,a5
    1350:	02000793          	li	a5,32
    1354:	00f71863          	bne	a4,a5,1364 <vprintfmt+0x110>
    1358:	00100793          	li	a5,1
    135c:	f8f40223          	sb	a5,-124(s0)
    1360:	6c40006f          	j	1a24 <vprintfmt+0x7d0>
    1364:	f5043783          	ld	a5,-176(s0)
    1368:	0007c783          	lbu	a5,0(a5)
    136c:	00078713          	mv	a4,a5
    1370:	02a00793          	li	a5,42
    1374:	00f71e63          	bne	a4,a5,1390 <vprintfmt+0x13c>
    1378:	f4843783          	ld	a5,-184(s0)
    137c:	00878713          	addi	a4,a5,8
    1380:	f4e43423          	sd	a4,-184(s0)
    1384:	0007a783          	lw	a5,0(a5)
    1388:	f8f42423          	sw	a5,-120(s0)
    138c:	6980006f          	j	1a24 <vprintfmt+0x7d0>
    1390:	f5043783          	ld	a5,-176(s0)
    1394:	0007c783          	lbu	a5,0(a5)
    1398:	00078713          	mv	a4,a5
    139c:	03000793          	li	a5,48
    13a0:	04e7f863          	bgeu	a5,a4,13f0 <vprintfmt+0x19c>
    13a4:	f5043783          	ld	a5,-176(s0)
    13a8:	0007c783          	lbu	a5,0(a5)
    13ac:	00078713          	mv	a4,a5
    13b0:	03900793          	li	a5,57
    13b4:	02e7ee63          	bltu	a5,a4,13f0 <vprintfmt+0x19c>
    13b8:	f5043783          	ld	a5,-176(s0)
    13bc:	f5040713          	addi	a4,s0,-176
    13c0:	00a00613          	li	a2,10
    13c4:	00070593          	mv	a1,a4
    13c8:	00078513          	mv	a0,a5
    13cc:	00000097          	auipc	ra,0x0
    13d0:	884080e7          	jalr	-1916(ra) # c50 <strtol>
    13d4:	00050793          	mv	a5,a0
    13d8:	0007879b          	sext.w	a5,a5
    13dc:	f8f42423          	sw	a5,-120(s0)
    13e0:	f5043783          	ld	a5,-176(s0)
    13e4:	fff78793          	addi	a5,a5,-1
    13e8:	f4f43823          	sd	a5,-176(s0)
    13ec:	6380006f          	j	1a24 <vprintfmt+0x7d0>
    13f0:	f5043783          	ld	a5,-176(s0)
    13f4:	0007c783          	lbu	a5,0(a5)
    13f8:	00078713          	mv	a4,a5
    13fc:	02e00793          	li	a5,46
    1400:	06f71a63          	bne	a4,a5,1474 <vprintfmt+0x220>
    1404:	f5043783          	ld	a5,-176(s0)
    1408:	00178793          	addi	a5,a5,1
    140c:	f4f43823          	sd	a5,-176(s0)
    1410:	f5043783          	ld	a5,-176(s0)
    1414:	0007c783          	lbu	a5,0(a5)
    1418:	00078713          	mv	a4,a5
    141c:	02a00793          	li	a5,42
    1420:	00f71e63          	bne	a4,a5,143c <vprintfmt+0x1e8>
    1424:	f4843783          	ld	a5,-184(s0)
    1428:	00878713          	addi	a4,a5,8
    142c:	f4e43423          	sd	a4,-184(s0)
    1430:	0007a783          	lw	a5,0(a5)
    1434:	f8f42623          	sw	a5,-116(s0)
    1438:	5ec0006f          	j	1a24 <vprintfmt+0x7d0>
    143c:	f5043783          	ld	a5,-176(s0)
    1440:	f5040713          	addi	a4,s0,-176
    1444:	00a00613          	li	a2,10
    1448:	00070593          	mv	a1,a4
    144c:	00078513          	mv	a0,a5
    1450:	00000097          	auipc	ra,0x0
    1454:	800080e7          	jalr	-2048(ra) # c50 <strtol>
    1458:	00050793          	mv	a5,a0
    145c:	0007879b          	sext.w	a5,a5
    1460:	f8f42623          	sw	a5,-116(s0)
    1464:	f5043783          	ld	a5,-176(s0)
    1468:	fff78793          	addi	a5,a5,-1
    146c:	f4f43823          	sd	a5,-176(s0)
    1470:	5b40006f          	j	1a24 <vprintfmt+0x7d0>
    1474:	f5043783          	ld	a5,-176(s0)
    1478:	0007c783          	lbu	a5,0(a5)
    147c:	00078713          	mv	a4,a5
    1480:	07800793          	li	a5,120
    1484:	02f70663          	beq	a4,a5,14b0 <vprintfmt+0x25c>
    1488:	f5043783          	ld	a5,-176(s0)
    148c:	0007c783          	lbu	a5,0(a5)
    1490:	00078713          	mv	a4,a5
    1494:	05800793          	li	a5,88
    1498:	00f70c63          	beq	a4,a5,14b0 <vprintfmt+0x25c>
    149c:	f5043783          	ld	a5,-176(s0)
    14a0:	0007c783          	lbu	a5,0(a5)
    14a4:	00078713          	mv	a4,a5
    14a8:	07000793          	li	a5,112
    14ac:	30f71263          	bne	a4,a5,17b0 <vprintfmt+0x55c>
    14b0:	f5043783          	ld	a5,-176(s0)
    14b4:	0007c783          	lbu	a5,0(a5)
    14b8:	00078713          	mv	a4,a5
    14bc:	07000793          	li	a5,112
    14c0:	00f70663          	beq	a4,a5,14cc <vprintfmt+0x278>
    14c4:	f8144783          	lbu	a5,-127(s0)
    14c8:	00078663          	beqz	a5,14d4 <vprintfmt+0x280>
    14cc:	00100793          	li	a5,1
    14d0:	0080006f          	j	14d8 <vprintfmt+0x284>
    14d4:	00000793          	li	a5,0
    14d8:	faf403a3          	sb	a5,-89(s0)
    14dc:	fa744783          	lbu	a5,-89(s0)
    14e0:	0017f793          	andi	a5,a5,1
    14e4:	faf403a3          	sb	a5,-89(s0)
    14e8:	fa744783          	lbu	a5,-89(s0)
    14ec:	0ff7f793          	zext.b	a5,a5
    14f0:	00078c63          	beqz	a5,1508 <vprintfmt+0x2b4>
    14f4:	f4843783          	ld	a5,-184(s0)
    14f8:	00878713          	addi	a4,a5,8
    14fc:	f4e43423          	sd	a4,-184(s0)
    1500:	0007b783          	ld	a5,0(a5)
    1504:	01c0006f          	j	1520 <vprintfmt+0x2cc>
    1508:	f4843783          	ld	a5,-184(s0)
    150c:	00878713          	addi	a4,a5,8
    1510:	f4e43423          	sd	a4,-184(s0)
    1514:	0007a783          	lw	a5,0(a5)
    1518:	02079793          	slli	a5,a5,0x20
    151c:	0207d793          	srli	a5,a5,0x20
    1520:	fef43023          	sd	a5,-32(s0)
    1524:	f8c42783          	lw	a5,-116(s0)
    1528:	02079463          	bnez	a5,1550 <vprintfmt+0x2fc>
    152c:	fe043783          	ld	a5,-32(s0)
    1530:	02079063          	bnez	a5,1550 <vprintfmt+0x2fc>
    1534:	f5043783          	ld	a5,-176(s0)
    1538:	0007c783          	lbu	a5,0(a5)
    153c:	00078713          	mv	a4,a5
    1540:	07000793          	li	a5,112
    1544:	00f70663          	beq	a4,a5,1550 <vprintfmt+0x2fc>
    1548:	f8040023          	sb	zero,-128(s0)
    154c:	4d80006f          	j	1a24 <vprintfmt+0x7d0>
    1550:	f5043783          	ld	a5,-176(s0)
    1554:	0007c783          	lbu	a5,0(a5)
    1558:	00078713          	mv	a4,a5
    155c:	07000793          	li	a5,112
    1560:	00f70a63          	beq	a4,a5,1574 <vprintfmt+0x320>
    1564:	f8244783          	lbu	a5,-126(s0)
    1568:	00078a63          	beqz	a5,157c <vprintfmt+0x328>
    156c:	fe043783          	ld	a5,-32(s0)
    1570:	00078663          	beqz	a5,157c <vprintfmt+0x328>
    1574:	00100793          	li	a5,1
    1578:	0080006f          	j	1580 <vprintfmt+0x32c>
    157c:	00000793          	li	a5,0
    1580:	faf40323          	sb	a5,-90(s0)
    1584:	fa644783          	lbu	a5,-90(s0)
    1588:	0017f793          	andi	a5,a5,1
    158c:	faf40323          	sb	a5,-90(s0)
    1590:	fc042e23          	sw	zero,-36(s0)
    1594:	f5043783          	ld	a5,-176(s0)
    1598:	0007c783          	lbu	a5,0(a5)
    159c:	00078713          	mv	a4,a5
    15a0:	05800793          	li	a5,88
    15a4:	00f71863          	bne	a4,a5,15b4 <vprintfmt+0x360>
    15a8:	00001797          	auipc	a5,0x1
    15ac:	cb878793          	addi	a5,a5,-840 # 2260 <upperxdigits.1>
    15b0:	00c0006f          	j	15bc <vprintfmt+0x368>
    15b4:	00001797          	auipc	a5,0x1
    15b8:	cc478793          	addi	a5,a5,-828 # 2278 <lowerxdigits.0>
    15bc:	f8f43c23          	sd	a5,-104(s0)
    15c0:	fe043783          	ld	a5,-32(s0)
    15c4:	00f7f793          	andi	a5,a5,15
    15c8:	f9843703          	ld	a4,-104(s0)
    15cc:	00f70733          	add	a4,a4,a5
    15d0:	fdc42783          	lw	a5,-36(s0)
    15d4:	0017869b          	addiw	a3,a5,1
    15d8:	fcd42e23          	sw	a3,-36(s0)
    15dc:	00074703          	lbu	a4,0(a4)
    15e0:	ff078793          	addi	a5,a5,-16
    15e4:	008787b3          	add	a5,a5,s0
    15e8:	f8e78023          	sb	a4,-128(a5)
    15ec:	fe043783          	ld	a5,-32(s0)
    15f0:	0047d793          	srli	a5,a5,0x4
    15f4:	fef43023          	sd	a5,-32(s0)
    15f8:	fe043783          	ld	a5,-32(s0)
    15fc:	fc0792e3          	bnez	a5,15c0 <vprintfmt+0x36c>
    1600:	f8c42783          	lw	a5,-116(s0)
    1604:	00078713          	mv	a4,a5
    1608:	fff00793          	li	a5,-1
    160c:	02f71663          	bne	a4,a5,1638 <vprintfmt+0x3e4>
    1610:	f8344783          	lbu	a5,-125(s0)
    1614:	02078263          	beqz	a5,1638 <vprintfmt+0x3e4>
    1618:	f8842703          	lw	a4,-120(s0)
    161c:	fa644783          	lbu	a5,-90(s0)
    1620:	0007879b          	sext.w	a5,a5
    1624:	0017979b          	slliw	a5,a5,0x1
    1628:	0007879b          	sext.w	a5,a5
    162c:	40f707bb          	subw	a5,a4,a5
    1630:	0007879b          	sext.w	a5,a5
    1634:	f8f42623          	sw	a5,-116(s0)
    1638:	f8842703          	lw	a4,-120(s0)
    163c:	fa644783          	lbu	a5,-90(s0)
    1640:	0007879b          	sext.w	a5,a5
    1644:	0017979b          	slliw	a5,a5,0x1
    1648:	0007879b          	sext.w	a5,a5
    164c:	40f707bb          	subw	a5,a4,a5
    1650:	0007871b          	sext.w	a4,a5
    1654:	fdc42783          	lw	a5,-36(s0)
    1658:	f8f42a23          	sw	a5,-108(s0)
    165c:	f8c42783          	lw	a5,-116(s0)
    1660:	f8f42823          	sw	a5,-112(s0)
    1664:	f9442783          	lw	a5,-108(s0)
    1668:	00078593          	mv	a1,a5
    166c:	f9042783          	lw	a5,-112(s0)
    1670:	00078613          	mv	a2,a5
    1674:	0006069b          	sext.w	a3,a2
    1678:	0005879b          	sext.w	a5,a1
    167c:	00f6d463          	bge	a3,a5,1684 <vprintfmt+0x430>
    1680:	00058613          	mv	a2,a1
    1684:	0006079b          	sext.w	a5,a2
    1688:	40f707bb          	subw	a5,a4,a5
    168c:	fcf42c23          	sw	a5,-40(s0)
    1690:	0280006f          	j	16b8 <vprintfmt+0x464>
    1694:	f5843783          	ld	a5,-168(s0)
    1698:	02000513          	li	a0,32
    169c:	000780e7          	jalr	a5
    16a0:	fec42783          	lw	a5,-20(s0)
    16a4:	0017879b          	addiw	a5,a5,1
    16a8:	fef42623          	sw	a5,-20(s0)
    16ac:	fd842783          	lw	a5,-40(s0)
    16b0:	fff7879b          	addiw	a5,a5,-1
    16b4:	fcf42c23          	sw	a5,-40(s0)
    16b8:	fd842783          	lw	a5,-40(s0)
    16bc:	0007879b          	sext.w	a5,a5
    16c0:	fcf04ae3          	bgtz	a5,1694 <vprintfmt+0x440>
    16c4:	fa644783          	lbu	a5,-90(s0)
    16c8:	0ff7f793          	zext.b	a5,a5
    16cc:	04078463          	beqz	a5,1714 <vprintfmt+0x4c0>
    16d0:	f5843783          	ld	a5,-168(s0)
    16d4:	03000513          	li	a0,48
    16d8:	000780e7          	jalr	a5
    16dc:	f5043783          	ld	a5,-176(s0)
    16e0:	0007c783          	lbu	a5,0(a5)
    16e4:	00078713          	mv	a4,a5
    16e8:	05800793          	li	a5,88
    16ec:	00f71663          	bne	a4,a5,16f8 <vprintfmt+0x4a4>
    16f0:	05800793          	li	a5,88
    16f4:	0080006f          	j	16fc <vprintfmt+0x4a8>
    16f8:	07800793          	li	a5,120
    16fc:	f5843703          	ld	a4,-168(s0)
    1700:	00078513          	mv	a0,a5
    1704:	000700e7          	jalr	a4
    1708:	fec42783          	lw	a5,-20(s0)
    170c:	0027879b          	addiw	a5,a5,2
    1710:	fef42623          	sw	a5,-20(s0)
    1714:	fdc42783          	lw	a5,-36(s0)
    1718:	fcf42a23          	sw	a5,-44(s0)
    171c:	0280006f          	j	1744 <vprintfmt+0x4f0>
    1720:	f5843783          	ld	a5,-168(s0)
    1724:	03000513          	li	a0,48
    1728:	000780e7          	jalr	a5
    172c:	fec42783          	lw	a5,-20(s0)
    1730:	0017879b          	addiw	a5,a5,1
    1734:	fef42623          	sw	a5,-20(s0)
    1738:	fd442783          	lw	a5,-44(s0)
    173c:	0017879b          	addiw	a5,a5,1
    1740:	fcf42a23          	sw	a5,-44(s0)
    1744:	f8c42703          	lw	a4,-116(s0)
    1748:	fd442783          	lw	a5,-44(s0)
    174c:	0007879b          	sext.w	a5,a5
    1750:	fce7c8e3          	blt	a5,a4,1720 <vprintfmt+0x4cc>
    1754:	fdc42783          	lw	a5,-36(s0)
    1758:	fff7879b          	addiw	a5,a5,-1
    175c:	fcf42823          	sw	a5,-48(s0)
    1760:	03c0006f          	j	179c <vprintfmt+0x548>
    1764:	fd042783          	lw	a5,-48(s0)
    1768:	ff078793          	addi	a5,a5,-16
    176c:	008787b3          	add	a5,a5,s0
    1770:	f807c783          	lbu	a5,-128(a5)
    1774:	0007871b          	sext.w	a4,a5
    1778:	f5843783          	ld	a5,-168(s0)
    177c:	00070513          	mv	a0,a4
    1780:	000780e7          	jalr	a5
    1784:	fec42783          	lw	a5,-20(s0)
    1788:	0017879b          	addiw	a5,a5,1
    178c:	fef42623          	sw	a5,-20(s0)
    1790:	fd042783          	lw	a5,-48(s0)
    1794:	fff7879b          	addiw	a5,a5,-1
    1798:	fcf42823          	sw	a5,-48(s0)
    179c:	fd042783          	lw	a5,-48(s0)
    17a0:	0007879b          	sext.w	a5,a5
    17a4:	fc07d0e3          	bgez	a5,1764 <vprintfmt+0x510>
    17a8:	f8040023          	sb	zero,-128(s0)
    17ac:	2780006f          	j	1a24 <vprintfmt+0x7d0>
    17b0:	f5043783          	ld	a5,-176(s0)
    17b4:	0007c783          	lbu	a5,0(a5)
    17b8:	00078713          	mv	a4,a5
    17bc:	06400793          	li	a5,100
    17c0:	02f70663          	beq	a4,a5,17ec <vprintfmt+0x598>
    17c4:	f5043783          	ld	a5,-176(s0)
    17c8:	0007c783          	lbu	a5,0(a5)
    17cc:	00078713          	mv	a4,a5
    17d0:	06900793          	li	a5,105
    17d4:	00f70c63          	beq	a4,a5,17ec <vprintfmt+0x598>
    17d8:	f5043783          	ld	a5,-176(s0)
    17dc:	0007c783          	lbu	a5,0(a5)
    17e0:	00078713          	mv	a4,a5
    17e4:	07500793          	li	a5,117
    17e8:	08f71263          	bne	a4,a5,186c <vprintfmt+0x618>
    17ec:	f8144783          	lbu	a5,-127(s0)
    17f0:	00078c63          	beqz	a5,1808 <vprintfmt+0x5b4>
    17f4:	f4843783          	ld	a5,-184(s0)
    17f8:	00878713          	addi	a4,a5,8
    17fc:	f4e43423          	sd	a4,-184(s0)
    1800:	0007b783          	ld	a5,0(a5)
    1804:	0140006f          	j	1818 <vprintfmt+0x5c4>
    1808:	f4843783          	ld	a5,-184(s0)
    180c:	00878713          	addi	a4,a5,8
    1810:	f4e43423          	sd	a4,-184(s0)
    1814:	0007a783          	lw	a5,0(a5)
    1818:	faf43423          	sd	a5,-88(s0)
    181c:	fa843583          	ld	a1,-88(s0)
    1820:	f5043783          	ld	a5,-176(s0)
    1824:	0007c783          	lbu	a5,0(a5)
    1828:	0007871b          	sext.w	a4,a5
    182c:	07500793          	li	a5,117
    1830:	40f707b3          	sub	a5,a4,a5
    1834:	00f037b3          	snez	a5,a5
    1838:	0ff7f793          	zext.b	a5,a5
    183c:	f8040713          	addi	a4,s0,-128
    1840:	00070693          	mv	a3,a4
    1844:	00078613          	mv	a2,a5
    1848:	f5843503          	ld	a0,-168(s0)
    184c:	fffff097          	auipc	ra,0xfffff
    1850:	6fc080e7          	jalr	1788(ra) # f48 <print_dec_int>
    1854:	00050793          	mv	a5,a0
    1858:	fec42703          	lw	a4,-20(s0)
    185c:	00f707bb          	addw	a5,a4,a5
    1860:	fef42623          	sw	a5,-20(s0)
    1864:	f8040023          	sb	zero,-128(s0)
    1868:	1bc0006f          	j	1a24 <vprintfmt+0x7d0>
    186c:	f5043783          	ld	a5,-176(s0)
    1870:	0007c783          	lbu	a5,0(a5)
    1874:	00078713          	mv	a4,a5
    1878:	06e00793          	li	a5,110
    187c:	04f71c63          	bne	a4,a5,18d4 <vprintfmt+0x680>
    1880:	f8144783          	lbu	a5,-127(s0)
    1884:	02078463          	beqz	a5,18ac <vprintfmt+0x658>
    1888:	f4843783          	ld	a5,-184(s0)
    188c:	00878713          	addi	a4,a5,8
    1890:	f4e43423          	sd	a4,-184(s0)
    1894:	0007b783          	ld	a5,0(a5)
    1898:	faf43823          	sd	a5,-80(s0)
    189c:	fec42703          	lw	a4,-20(s0)
    18a0:	fb043783          	ld	a5,-80(s0)
    18a4:	00e7b023          	sd	a4,0(a5)
    18a8:	0240006f          	j	18cc <vprintfmt+0x678>
    18ac:	f4843783          	ld	a5,-184(s0)
    18b0:	00878713          	addi	a4,a5,8
    18b4:	f4e43423          	sd	a4,-184(s0)
    18b8:	0007b783          	ld	a5,0(a5)
    18bc:	faf43c23          	sd	a5,-72(s0)
    18c0:	fb843783          	ld	a5,-72(s0)
    18c4:	fec42703          	lw	a4,-20(s0)
    18c8:	00e7a023          	sw	a4,0(a5)
    18cc:	f8040023          	sb	zero,-128(s0)
    18d0:	1540006f          	j	1a24 <vprintfmt+0x7d0>
    18d4:	f5043783          	ld	a5,-176(s0)
    18d8:	0007c783          	lbu	a5,0(a5)
    18dc:	00078713          	mv	a4,a5
    18e0:	07300793          	li	a5,115
    18e4:	04f71063          	bne	a4,a5,1924 <vprintfmt+0x6d0>
    18e8:	f4843783          	ld	a5,-184(s0)
    18ec:	00878713          	addi	a4,a5,8
    18f0:	f4e43423          	sd	a4,-184(s0)
    18f4:	0007b783          	ld	a5,0(a5)
    18f8:	fcf43023          	sd	a5,-64(s0)
    18fc:	fc043583          	ld	a1,-64(s0)
    1900:	f5843503          	ld	a0,-168(s0)
    1904:	fffff097          	auipc	ra,0xfffff
    1908:	5bc080e7          	jalr	1468(ra) # ec0 <puts_wo_nl>
    190c:	00050793          	mv	a5,a0
    1910:	fec42703          	lw	a4,-20(s0)
    1914:	00f707bb          	addw	a5,a4,a5
    1918:	fef42623          	sw	a5,-20(s0)
    191c:	f8040023          	sb	zero,-128(s0)
    1920:	1040006f          	j	1a24 <vprintfmt+0x7d0>
    1924:	f5043783          	ld	a5,-176(s0)
    1928:	0007c783          	lbu	a5,0(a5)
    192c:	00078713          	mv	a4,a5
    1930:	06300793          	li	a5,99
    1934:	02f71e63          	bne	a4,a5,1970 <vprintfmt+0x71c>
    1938:	f4843783          	ld	a5,-184(s0)
    193c:	00878713          	addi	a4,a5,8
    1940:	f4e43423          	sd	a4,-184(s0)
    1944:	0007a783          	lw	a5,0(a5)
    1948:	fcf42623          	sw	a5,-52(s0)
    194c:	fcc42703          	lw	a4,-52(s0)
    1950:	f5843783          	ld	a5,-168(s0)
    1954:	00070513          	mv	a0,a4
    1958:	000780e7          	jalr	a5
    195c:	fec42783          	lw	a5,-20(s0)
    1960:	0017879b          	addiw	a5,a5,1
    1964:	fef42623          	sw	a5,-20(s0)
    1968:	f8040023          	sb	zero,-128(s0)
    196c:	0b80006f          	j	1a24 <vprintfmt+0x7d0>
    1970:	f5043783          	ld	a5,-176(s0)
    1974:	0007c783          	lbu	a5,0(a5)
    1978:	00078713          	mv	a4,a5
    197c:	02500793          	li	a5,37
    1980:	02f71263          	bne	a4,a5,19a4 <vprintfmt+0x750>
    1984:	f5843783          	ld	a5,-168(s0)
    1988:	02500513          	li	a0,37
    198c:	000780e7          	jalr	a5
    1990:	fec42783          	lw	a5,-20(s0)
    1994:	0017879b          	addiw	a5,a5,1
    1998:	fef42623          	sw	a5,-20(s0)
    199c:	f8040023          	sb	zero,-128(s0)
    19a0:	0840006f          	j	1a24 <vprintfmt+0x7d0>
    19a4:	f5043783          	ld	a5,-176(s0)
    19a8:	0007c783          	lbu	a5,0(a5)
    19ac:	0007871b          	sext.w	a4,a5
    19b0:	f5843783          	ld	a5,-168(s0)
    19b4:	00070513          	mv	a0,a4
    19b8:	000780e7          	jalr	a5
    19bc:	fec42783          	lw	a5,-20(s0)
    19c0:	0017879b          	addiw	a5,a5,1
    19c4:	fef42623          	sw	a5,-20(s0)
    19c8:	f8040023          	sb	zero,-128(s0)
    19cc:	0580006f          	j	1a24 <vprintfmt+0x7d0>
    19d0:	f5043783          	ld	a5,-176(s0)
    19d4:	0007c783          	lbu	a5,0(a5)
    19d8:	00078713          	mv	a4,a5
    19dc:	02500793          	li	a5,37
    19e0:	02f71063          	bne	a4,a5,1a00 <vprintfmt+0x7ac>
    19e4:	f8043023          	sd	zero,-128(s0)
    19e8:	f8043423          	sd	zero,-120(s0)
    19ec:	00100793          	li	a5,1
    19f0:	f8f40023          	sb	a5,-128(s0)
    19f4:	fff00793          	li	a5,-1
    19f8:	f8f42623          	sw	a5,-116(s0)
    19fc:	0280006f          	j	1a24 <vprintfmt+0x7d0>
    1a00:	f5043783          	ld	a5,-176(s0)
    1a04:	0007c783          	lbu	a5,0(a5)
    1a08:	0007871b          	sext.w	a4,a5
    1a0c:	f5843783          	ld	a5,-168(s0)
    1a10:	00070513          	mv	a0,a4
    1a14:	000780e7          	jalr	a5
    1a18:	fec42783          	lw	a5,-20(s0)
    1a1c:	0017879b          	addiw	a5,a5,1
    1a20:	fef42623          	sw	a5,-20(s0)
    1a24:	f5043783          	ld	a5,-176(s0)
    1a28:	00178793          	addi	a5,a5,1
    1a2c:	f4f43823          	sd	a5,-176(s0)
    1a30:	f5043783          	ld	a5,-176(s0)
    1a34:	0007c783          	lbu	a5,0(a5)
    1a38:	840794e3          	bnez	a5,1280 <vprintfmt+0x2c>
    1a3c:	fec42783          	lw	a5,-20(s0)
    1a40:	00078513          	mv	a0,a5
    1a44:	0b813083          	ld	ra,184(sp)
    1a48:	0b013403          	ld	s0,176(sp)
    1a4c:	0c010113          	addi	sp,sp,192
    1a50:	00008067          	ret

Disassembly of section .text.printf:

0000000000001a54 <printf>:
    1a54:	f8010113          	addi	sp,sp,-128
    1a58:	02113c23          	sd	ra,56(sp)
    1a5c:	02813823          	sd	s0,48(sp)
    1a60:	04010413          	addi	s0,sp,64
    1a64:	fca43423          	sd	a0,-56(s0)
    1a68:	00b43423          	sd	a1,8(s0)
    1a6c:	00c43823          	sd	a2,16(s0)
    1a70:	00d43c23          	sd	a3,24(s0)
    1a74:	02e43023          	sd	a4,32(s0)
    1a78:	02f43423          	sd	a5,40(s0)
    1a7c:	03043823          	sd	a6,48(s0)
    1a80:	03143c23          	sd	a7,56(s0)
    1a84:	fe042623          	sw	zero,-20(s0)
    1a88:	04040793          	addi	a5,s0,64
    1a8c:	fcf43023          	sd	a5,-64(s0)
    1a90:	fc043783          	ld	a5,-64(s0)
    1a94:	fc878793          	addi	a5,a5,-56
    1a98:	fcf43823          	sd	a5,-48(s0)
    1a9c:	fd043783          	ld	a5,-48(s0)
    1aa0:	00078613          	mv	a2,a5
    1aa4:	fc843583          	ld	a1,-56(s0)
    1aa8:	fffff517          	auipc	a0,0xfffff
    1aac:	0e050513          	addi	a0,a0,224 # b88 <putc>
    1ab0:	fffff097          	auipc	ra,0xfffff
    1ab4:	7a4080e7          	jalr	1956(ra) # 1254 <vprintfmt>
    1ab8:	00050793          	mv	a5,a0
    1abc:	fef42623          	sw	a5,-20(s0)
    1ac0:	00100793          	li	a5,1
    1ac4:	fef43023          	sd	a5,-32(s0)
    1ac8:	00001797          	auipc	a5,0x1
    1acc:	7c878793          	addi	a5,a5,1992 # 3290 <tail>
    1ad0:	0007a783          	lw	a5,0(a5)
    1ad4:	0017871b          	addiw	a4,a5,1
    1ad8:	0007069b          	sext.w	a3,a4
    1adc:	00001717          	auipc	a4,0x1
    1ae0:	7b470713          	addi	a4,a4,1972 # 3290 <tail>
    1ae4:	00d72023          	sw	a3,0(a4)
    1ae8:	00001717          	auipc	a4,0x1
    1aec:	7b070713          	addi	a4,a4,1968 # 3298 <buffer>
    1af0:	00f707b3          	add	a5,a4,a5
    1af4:	00078023          	sb	zero,0(a5)
    1af8:	00001797          	auipc	a5,0x1
    1afc:	79878793          	addi	a5,a5,1944 # 3290 <tail>
    1b00:	0007a603          	lw	a2,0(a5)
    1b04:	fe043703          	ld	a4,-32(s0)
    1b08:	00001697          	auipc	a3,0x1
    1b0c:	79068693          	addi	a3,a3,1936 # 3298 <buffer>
    1b10:	fd843783          	ld	a5,-40(s0)
    1b14:	04000893          	li	a7,64
    1b18:	00070513          	mv	a0,a4
    1b1c:	00068593          	mv	a1,a3
    1b20:	00060613          	mv	a2,a2
    1b24:	00000073          	ecall
    1b28:	00050793          	mv	a5,a0
    1b2c:	fcf43c23          	sd	a5,-40(s0)
    1b30:	00001797          	auipc	a5,0x1
    1b34:	76078793          	addi	a5,a5,1888 # 3290 <tail>
    1b38:	0007a023          	sw	zero,0(a5)
    1b3c:	fec42783          	lw	a5,-20(s0)
    1b40:	00078513          	mv	a0,a5
    1b44:	03813083          	ld	ra,56(sp)
    1b48:	03013403          	ld	s0,48(sp)
    1b4c:	08010113          	addi	sp,sp,128
    1b50:	00008067          	ret

Disassembly of section .text.strlen:

0000000000001b54 <strlen>:
    1b54:	fd010113          	addi	sp,sp,-48
    1b58:	02813423          	sd	s0,40(sp)
    1b5c:	03010413          	addi	s0,sp,48
    1b60:	fca43c23          	sd	a0,-40(s0)
    1b64:	fe042623          	sw	zero,-20(s0)
    1b68:	0100006f          	j	1b78 <strlen+0x24>
    1b6c:	fec42783          	lw	a5,-20(s0)
    1b70:	0017879b          	addiw	a5,a5,1
    1b74:	fef42623          	sw	a5,-20(s0)
    1b78:	fd843783          	ld	a5,-40(s0)
    1b7c:	00178713          	addi	a4,a5,1
    1b80:	fce43c23          	sd	a4,-40(s0)
    1b84:	0007c783          	lbu	a5,0(a5)
    1b88:	fe0792e3          	bnez	a5,1b6c <strlen+0x18>
    1b8c:	fec42783          	lw	a5,-20(s0)
    1b90:	00078513          	mv	a0,a5
    1b94:	02813403          	ld	s0,40(sp)
    1b98:	03010113          	addi	sp,sp,48
    1b9c:	00008067          	ret

Disassembly of section .text.write:

0000000000001ba0 <write>:
    1ba0:	fb010113          	addi	sp,sp,-80
    1ba4:	04813423          	sd	s0,72(sp)
    1ba8:	05010413          	addi	s0,sp,80
    1bac:	00050693          	mv	a3,a0
    1bb0:	fcb43023          	sd	a1,-64(s0)
    1bb4:	fac43c23          	sd	a2,-72(s0)
    1bb8:	fcd42623          	sw	a3,-52(s0)
    1bbc:	00010693          	mv	a3,sp
    1bc0:	00068593          	mv	a1,a3
    1bc4:	fb843683          	ld	a3,-72(s0)
    1bc8:	00168693          	addi	a3,a3,1
    1bcc:	00068613          	mv	a2,a3
    1bd0:	fff60613          	addi	a2,a2,-1
    1bd4:	fec43023          	sd	a2,-32(s0)
    1bd8:	00068e13          	mv	t3,a3
    1bdc:	00000e93          	li	t4,0
    1be0:	03de5613          	srli	a2,t3,0x3d
    1be4:	003e9893          	slli	a7,t4,0x3
    1be8:	011668b3          	or	a7,a2,a7
    1bec:	003e1813          	slli	a6,t3,0x3
    1bf0:	00068313          	mv	t1,a3
    1bf4:	00000393          	li	t2,0
    1bf8:	03d35613          	srli	a2,t1,0x3d
    1bfc:	00339793          	slli	a5,t2,0x3
    1c00:	00f667b3          	or	a5,a2,a5
    1c04:	00331713          	slli	a4,t1,0x3
    1c08:	00f68793          	addi	a5,a3,15
    1c0c:	0047d793          	srli	a5,a5,0x4
    1c10:	00479793          	slli	a5,a5,0x4
    1c14:	40f10133          	sub	sp,sp,a5
    1c18:	00010793          	mv	a5,sp
    1c1c:	00078793          	mv	a5,a5
    1c20:	fcf43c23          	sd	a5,-40(s0)
    1c24:	fe042623          	sw	zero,-20(s0)
    1c28:	0300006f          	j	1c58 <write+0xb8>
    1c2c:	fec42783          	lw	a5,-20(s0)
    1c30:	fc043703          	ld	a4,-64(s0)
    1c34:	00f707b3          	add	a5,a4,a5
    1c38:	0007c703          	lbu	a4,0(a5)
    1c3c:	fd843683          	ld	a3,-40(s0)
    1c40:	fec42783          	lw	a5,-20(s0)
    1c44:	00f687b3          	add	a5,a3,a5
    1c48:	00e78023          	sb	a4,0(a5)
    1c4c:	fec42783          	lw	a5,-20(s0)
    1c50:	0017879b          	addiw	a5,a5,1
    1c54:	fef42623          	sw	a5,-20(s0)
    1c58:	fec42783          	lw	a5,-20(s0)
    1c5c:	fb843703          	ld	a4,-72(s0)
    1c60:	fce7e6e3          	bltu	a5,a4,1c2c <write+0x8c>
    1c64:	fd843703          	ld	a4,-40(s0)
    1c68:	fb843783          	ld	a5,-72(s0)
    1c6c:	00f707b3          	add	a5,a4,a5
    1c70:	00078023          	sb	zero,0(a5)
    1c74:	fcc42703          	lw	a4,-52(s0)
    1c78:	fd843683          	ld	a3,-40(s0)
    1c7c:	fb843603          	ld	a2,-72(s0)
    1c80:	fd043783          	ld	a5,-48(s0)
    1c84:	04000893          	li	a7,64
    1c88:	00070513          	mv	a0,a4
    1c8c:	00068593          	mv	a1,a3
    1c90:	00060613          	mv	a2,a2
    1c94:	00000073          	ecall
    1c98:	00050793          	mv	a5,a0
    1c9c:	fcf43823          	sd	a5,-48(s0)
    1ca0:	fd043783          	ld	a5,-48(s0)
    1ca4:	0007879b          	sext.w	a5,a5
    1ca8:	00058113          	mv	sp,a1
    1cac:	00078513          	mv	a0,a5
    1cb0:	fb040113          	addi	sp,s0,-80
    1cb4:	04813403          	ld	s0,72(sp)
    1cb8:	05010113          	addi	sp,sp,80
    1cbc:	00008067          	ret

Disassembly of section .text.read:

0000000000001cc0 <read>:
    1cc0:	fc010113          	addi	sp,sp,-64
    1cc4:	02813c23          	sd	s0,56(sp)
    1cc8:	04010413          	addi	s0,sp,64
    1ccc:	00050793          	mv	a5,a0
    1cd0:	fcb43823          	sd	a1,-48(s0)
    1cd4:	fcc43423          	sd	a2,-56(s0)
    1cd8:	fcf42e23          	sw	a5,-36(s0)
    1cdc:	fdc42703          	lw	a4,-36(s0)
    1ce0:	fd043683          	ld	a3,-48(s0)
    1ce4:	fc843603          	ld	a2,-56(s0)
    1ce8:	fe843783          	ld	a5,-24(s0)
    1cec:	03f00893          	li	a7,63
    1cf0:	00070513          	mv	a0,a4
    1cf4:	00068593          	mv	a1,a3
    1cf8:	00060613          	mv	a2,a2
    1cfc:	00000073          	ecall
    1d00:	00050793          	mv	a5,a0
    1d04:	fef43423          	sd	a5,-24(s0)
    1d08:	fe843783          	ld	a5,-24(s0)
    1d0c:	0007879b          	sext.w	a5,a5
    1d10:	00078513          	mv	a0,a5
    1d14:	03813403          	ld	s0,56(sp)
    1d18:	04010113          	addi	sp,sp,64
    1d1c:	00008067          	ret

Disassembly of section .text.sys_openat:

0000000000001d20 <sys_openat>:
    1d20:	fd010113          	addi	sp,sp,-48
    1d24:	02813423          	sd	s0,40(sp)
    1d28:	03010413          	addi	s0,sp,48
    1d2c:	00050793          	mv	a5,a0
    1d30:	fcb43823          	sd	a1,-48(s0)
    1d34:	00060713          	mv	a4,a2
    1d38:	fcf42e23          	sw	a5,-36(s0)
    1d3c:	00070793          	mv	a5,a4
    1d40:	fcf42c23          	sw	a5,-40(s0)
    1d44:	fdc42703          	lw	a4,-36(s0)
    1d48:	fd842603          	lw	a2,-40(s0)
    1d4c:	fd043683          	ld	a3,-48(s0)
    1d50:	fe843783          	ld	a5,-24(s0)
    1d54:	04000893          	li	a7,64
    1d58:	00070513          	mv	a0,a4
    1d5c:	00068593          	mv	a1,a3
    1d60:	00060613          	mv	a2,a2
    1d64:	00000073          	ecall
    1d68:	00050793          	mv	a5,a0
    1d6c:	fef43423          	sd	a5,-24(s0)
    1d70:	fe843783          	ld	a5,-24(s0)
    1d74:	0007879b          	sext.w	a5,a5
    1d78:	00078513          	mv	a0,a5
    1d7c:	02813403          	ld	s0,40(sp)
    1d80:	03010113          	addi	sp,sp,48
    1d84:	00008067          	ret

Disassembly of section .text.open:

0000000000001d88 <open>:
    1d88:	fe010113          	addi	sp,sp,-32
    1d8c:	00113c23          	sd	ra,24(sp)
    1d90:	00813823          	sd	s0,16(sp)
    1d94:	02010413          	addi	s0,sp,32
    1d98:	fea43423          	sd	a0,-24(s0)
    1d9c:	00058793          	mv	a5,a1
    1da0:	fef42223          	sw	a5,-28(s0)
    1da4:	fe442783          	lw	a5,-28(s0)
    1da8:	00078613          	mv	a2,a5
    1dac:	fe843583          	ld	a1,-24(s0)
    1db0:	f9c00513          	li	a0,-100
    1db4:	00000097          	auipc	ra,0x0
    1db8:	f6c080e7          	jalr	-148(ra) # 1d20 <sys_openat>
    1dbc:	00050793          	mv	a5,a0
    1dc0:	00078513          	mv	a0,a5
    1dc4:	01813083          	ld	ra,24(sp)
    1dc8:	01013403          	ld	s0,16(sp)
    1dcc:	02010113          	addi	sp,sp,32
    1dd0:	00008067          	ret

Disassembly of section .text.close:

0000000000001dd4 <close>:
    1dd4:	fd010113          	addi	sp,sp,-48
    1dd8:	02813423          	sd	s0,40(sp)
    1ddc:	03010413          	addi	s0,sp,48
    1de0:	00050793          	mv	a5,a0
    1de4:	fcf42e23          	sw	a5,-36(s0)
    1de8:	fdc42703          	lw	a4,-36(s0)
    1dec:	fe843783          	ld	a5,-24(s0)
    1df0:	04000893          	li	a7,64
    1df4:	00070513          	mv	a0,a4
    1df8:	00000073          	ecall
    1dfc:	00050793          	mv	a5,a0
    1e00:	fef43423          	sd	a5,-24(s0)
    1e04:	fe843783          	ld	a5,-24(s0)
    1e08:	0007879b          	sext.w	a5,a5
    1e0c:	00078513          	mv	a0,a5
    1e10:	02813403          	ld	s0,40(sp)
    1e14:	03010113          	addi	sp,sp,48
    1e18:	00008067          	ret

Disassembly of section .text.lseek:

0000000000001e1c <lseek>:
    1e1c:	fd010113          	addi	sp,sp,-48
    1e20:	02813423          	sd	s0,40(sp)
    1e24:	03010413          	addi	s0,sp,48
    1e28:	00050793          	mv	a5,a0
    1e2c:	00058693          	mv	a3,a1
    1e30:	00060713          	mv	a4,a2
    1e34:	fcf42e23          	sw	a5,-36(s0)
    1e38:	00068793          	mv	a5,a3
    1e3c:	fcf42c23          	sw	a5,-40(s0)
    1e40:	00070793          	mv	a5,a4
    1e44:	fcf42a23          	sw	a5,-44(s0)
    1e48:	fdc42703          	lw	a4,-36(s0)
    1e4c:	fd842683          	lw	a3,-40(s0)
    1e50:	fd442603          	lw	a2,-44(s0)
    1e54:	fe843783          	ld	a5,-24(s0)
    1e58:	0ac00893          	li	a7,172
    1e5c:	00070513          	mv	a0,a4
    1e60:	00068593          	mv	a1,a3
    1e64:	00060613          	mv	a2,a2
    1e68:	00000073          	ecall
    1e6c:	00050793          	mv	a5,a0
    1e70:	fef43423          	sd	a5,-24(s0)
    1e74:	fe843783          	ld	a5,-24(s0)
    1e78:	0007879b          	sext.w	a5,a5
    1e7c:	00078513          	mv	a0,a5
    1e80:	02813403          	ld	s0,40(sp)
    1e84:	03010113          	addi	sp,sp,48
    1e88:	00008067          	ret
