
uapp:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <_start>:
   100e8:	21d0006f          	j	10b04 <main>

00000000000100ec <atoi>:
   100ec:	fd010113          	addi	sp,sp,-48
   100f0:	02113423          	sd	ra,40(sp)
   100f4:	02813023          	sd	s0,32(sp)
   100f8:	03010413          	addi	s0,sp,48
   100fc:	fca43c23          	sd	a0,-40(s0)
   10100:	fe042623          	sw	zero,-20(s0)
   10104:	fd843503          	ld	a0,-40(s0)
   10108:	00002097          	auipc	ra,0x2
   1010c:	b34080e7          	jalr	-1228(ra) # 11c3c <strlen>
   10110:	00050793          	mv	a5,a0
   10114:	fef42223          	sw	a5,-28(s0)
   10118:	fe042423          	sw	zero,-24(s0)
   1011c:	0500006f          	j	1016c <atoi+0x80>
   10120:	fec42783          	lw	a5,-20(s0)
   10124:	00078713          	mv	a4,a5
   10128:	00070793          	mv	a5,a4
   1012c:	0027979b          	slliw	a5,a5,0x2
   10130:	00e787bb          	addw	a5,a5,a4
   10134:	0017979b          	slliw	a5,a5,0x1
   10138:	0007871b          	sext.w	a4,a5
   1013c:	fe842783          	lw	a5,-24(s0)
   10140:	fd843683          	ld	a3,-40(s0)
   10144:	00f687b3          	add	a5,a3,a5
   10148:	0007c783          	lbu	a5,0(a5)
   1014c:	0007879b          	sext.w	a5,a5
   10150:	00f707bb          	addw	a5,a4,a5
   10154:	0007879b          	sext.w	a5,a5
   10158:	fd07879b          	addiw	a5,a5,-48
   1015c:	fef42623          	sw	a5,-20(s0)
   10160:	fe842783          	lw	a5,-24(s0)
   10164:	0017879b          	addiw	a5,a5,1
   10168:	fef42423          	sw	a5,-24(s0)
   1016c:	fe842783          	lw	a5,-24(s0)
   10170:	00078713          	mv	a4,a5
   10174:	fe442783          	lw	a5,-28(s0)
   10178:	0007071b          	sext.w	a4,a4
   1017c:	0007879b          	sext.w	a5,a5
   10180:	faf740e3          	blt	a4,a5,10120 <atoi+0x34>
   10184:	fec42783          	lw	a5,-20(s0)
   10188:	00078513          	mv	a0,a5
   1018c:	02813083          	ld	ra,40(sp)
   10190:	02013403          	ld	s0,32(sp)
   10194:	03010113          	addi	sp,sp,48
   10198:	00008067          	ret

000000000001019c <get_param>:
   1019c:	fd010113          	addi	sp,sp,-48
   101a0:	02813423          	sd	s0,40(sp)
   101a4:	03010413          	addi	s0,sp,48
   101a8:	fca43c23          	sd	a0,-40(s0)
   101ac:	0100006f          	j	101bc <get_param+0x20>
   101b0:	fd843783          	ld	a5,-40(s0)
   101b4:	00178793          	addi	a5,a5,1
   101b8:	fcf43c23          	sd	a5,-40(s0)
   101bc:	fd843783          	ld	a5,-40(s0)
   101c0:	0007c783          	lbu	a5,0(a5)
   101c4:	00078713          	mv	a4,a5
   101c8:	02000793          	li	a5,32
   101cc:	fef702e3          	beq	a4,a5,101b0 <get_param+0x14>
   101d0:	fe042623          	sw	zero,-20(s0)
   101d4:	0300006f          	j	10204 <get_param+0x68>
   101d8:	fd843703          	ld	a4,-40(s0)
   101dc:	00170793          	addi	a5,a4,1
   101e0:	fcf43c23          	sd	a5,-40(s0)
   101e4:	fec42783          	lw	a5,-20(s0)
   101e8:	0017869b          	addiw	a3,a5,1
   101ec:	fed42623          	sw	a3,-20(s0)
   101f0:	00074703          	lbu	a4,0(a4)
   101f4:	00003697          	auipc	a3,0x3
   101f8:	e1468693          	addi	a3,a3,-492 # 13008 <string_buf>
   101fc:	00f687b3          	add	a5,a3,a5
   10200:	00e78023          	sb	a4,0(a5)
   10204:	fd843783          	ld	a5,-40(s0)
   10208:	0007c783          	lbu	a5,0(a5)
   1020c:	00078c63          	beqz	a5,10224 <get_param+0x88>
   10210:	fd843783          	ld	a5,-40(s0)
   10214:	0007c783          	lbu	a5,0(a5)
   10218:	00078713          	mv	a4,a5
   1021c:	02000793          	li	a5,32
   10220:	faf71ce3          	bne	a4,a5,101d8 <get_param+0x3c>
   10224:	00003717          	auipc	a4,0x3
   10228:	de470713          	addi	a4,a4,-540 # 13008 <string_buf>
   1022c:	fec42783          	lw	a5,-20(s0)
   10230:	00f707b3          	add	a5,a4,a5
   10234:	00078023          	sb	zero,0(a5)
   10238:	00003797          	auipc	a5,0x3
   1023c:	dd078793          	addi	a5,a5,-560 # 13008 <string_buf>
   10240:	00078513          	mv	a0,a5
   10244:	02813403          	ld	s0,40(sp)
   10248:	03010113          	addi	sp,sp,48
   1024c:	00008067          	ret

0000000000010250 <get_string>:
   10250:	fd010113          	addi	sp,sp,-48
   10254:	02113423          	sd	ra,40(sp)
   10258:	02813023          	sd	s0,32(sp)
   1025c:	03010413          	addi	s0,sp,48
   10260:	fca43c23          	sd	a0,-40(s0)
   10264:	0100006f          	j	10274 <get_string+0x24>
   10268:	fd843783          	ld	a5,-40(s0)
   1026c:	00178793          	addi	a5,a5,1
   10270:	fcf43c23          	sd	a5,-40(s0)
   10274:	fd843783          	ld	a5,-40(s0)
   10278:	0007c783          	lbu	a5,0(a5)
   1027c:	00078713          	mv	a4,a5
   10280:	02000793          	li	a5,32
   10284:	fef702e3          	beq	a4,a5,10268 <get_string+0x18>
   10288:	fd843783          	ld	a5,-40(s0)
   1028c:	0007c783          	lbu	a5,0(a5)
   10290:	00078713          	mv	a4,a5
   10294:	02200793          	li	a5,34
   10298:	06f71c63          	bne	a4,a5,10310 <get_string+0xc0>
   1029c:	fd843783          	ld	a5,-40(s0)
   102a0:	00178793          	addi	a5,a5,1
   102a4:	fcf43c23          	sd	a5,-40(s0)
   102a8:	fe042623          	sw	zero,-20(s0)
   102ac:	0300006f          	j	102dc <get_string+0x8c>
   102b0:	fd843703          	ld	a4,-40(s0)
   102b4:	00170793          	addi	a5,a4,1
   102b8:	fcf43c23          	sd	a5,-40(s0)
   102bc:	fec42783          	lw	a5,-20(s0)
   102c0:	0017869b          	addiw	a3,a5,1
   102c4:	fed42623          	sw	a3,-20(s0)
   102c8:	00074703          	lbu	a4,0(a4)
   102cc:	00003697          	auipc	a3,0x3
   102d0:	d3c68693          	addi	a3,a3,-708 # 13008 <string_buf>
   102d4:	00f687b3          	add	a5,a3,a5
   102d8:	00e78023          	sb	a4,0(a5)
   102dc:	fd843783          	ld	a5,-40(s0)
   102e0:	0007c783          	lbu	a5,0(a5)
   102e4:	00078713          	mv	a4,a5
   102e8:	02200793          	li	a5,34
   102ec:	fcf712e3          	bne	a4,a5,102b0 <get_string+0x60>
   102f0:	00003717          	auipc	a4,0x3
   102f4:	d1870713          	addi	a4,a4,-744 # 13008 <string_buf>
   102f8:	fec42783          	lw	a5,-20(s0)
   102fc:	00f707b3          	add	a5,a4,a5
   10300:	00078023          	sb	zero,0(a5)
   10304:	00003797          	auipc	a5,0x3
   10308:	d0478793          	addi	a5,a5,-764 # 13008 <string_buf>
   1030c:	0140006f          	j	10320 <get_string+0xd0>
   10310:	fd843503          	ld	a0,-40(s0)
   10314:	00000097          	auipc	ra,0x0
   10318:	e88080e7          	jalr	-376(ra) # 1019c <get_param>
   1031c:	00050793          	mv	a5,a0
   10320:	00078513          	mv	a0,a5
   10324:	02813083          	ld	ra,40(sp)
   10328:	02013403          	ld	s0,32(sp)
   1032c:	03010113          	addi	sp,sp,48
   10330:	00008067          	ret

0000000000010334 <parse_cmd>:
   10334:	c9010113          	addi	sp,sp,-880
   10338:	36113423          	sd	ra,872(sp)
   1033c:	36813023          	sd	s0,864(sp)
   10340:	34913c23          	sd	s1,856(sp)
   10344:	35213823          	sd	s2,848(sp)
   10348:	35313423          	sd	s3,840(sp)
   1034c:	35413023          	sd	s4,832(sp)
   10350:	33513c23          	sd	s5,824(sp)
   10354:	33613823          	sd	s6,816(sp)
   10358:	33713423          	sd	s7,808(sp)
   1035c:	33813023          	sd	s8,800(sp)
   10360:	31913c23          	sd	s9,792(sp)
   10364:	31a13823          	sd	s10,784(sp)
   10368:	31b13423          	sd	s11,776(sp)
   1036c:	37010413          	addi	s0,sp,880
   10370:	d0a43423          	sd	a0,-760(s0)
   10374:	00058793          	mv	a5,a1
   10378:	d0f42223          	sw	a5,-764(s0)
   1037c:	d0843783          	ld	a5,-760(s0)
   10380:	0007c783          	lbu	a5,0(a5)
   10384:	00078713          	mv	a4,a5
   10388:	06500793          	li	a5,101
   1038c:	0cf71063          	bne	a4,a5,1044c <parse_cmd+0x118>
   10390:	d0843783          	ld	a5,-760(s0)
   10394:	00178793          	addi	a5,a5,1
   10398:	0007c783          	lbu	a5,0(a5)
   1039c:	00078713          	mv	a4,a5
   103a0:	06300793          	li	a5,99
   103a4:	0af71463          	bne	a4,a5,1044c <parse_cmd+0x118>
   103a8:	d0843783          	ld	a5,-760(s0)
   103ac:	00278793          	addi	a5,a5,2
   103b0:	0007c783          	lbu	a5,0(a5)
   103b4:	00078713          	mv	a4,a5
   103b8:	06800793          	li	a5,104
   103bc:	08f71863          	bne	a4,a5,1044c <parse_cmd+0x118>
   103c0:	d0843783          	ld	a5,-760(s0)
   103c4:	00378793          	addi	a5,a5,3
   103c8:	0007c783          	lbu	a5,0(a5)
   103cc:	00078713          	mv	a4,a5
   103d0:	06f00793          	li	a5,111
   103d4:	06f71c63          	bne	a4,a5,1044c <parse_cmd+0x118>
   103d8:	d0843783          	ld	a5,-760(s0)
   103dc:	00478793          	addi	a5,a5,4
   103e0:	d0f43423          	sd	a5,-760(s0)
   103e4:	d0843503          	ld	a0,-760(s0)
   103e8:	00000097          	auipc	ra,0x0
   103ec:	e68080e7          	jalr	-408(ra) # 10250 <get_string>
   103f0:	f6a43823          	sd	a0,-144(s0)
   103f4:	f7043503          	ld	a0,-144(s0)
   103f8:	00002097          	auipc	ra,0x2
   103fc:	844080e7          	jalr	-1980(ra) # 11c3c <strlen>
   10400:	00050793          	mv	a5,a0
   10404:	d0f42223          	sw	a5,-764(s0)
   10408:	d0442783          	lw	a5,-764(s0)
   1040c:	d0843703          	ld	a4,-760(s0)
   10410:	00f707b3          	add	a5,a4,a5
   10414:	d0f43423          	sd	a5,-760(s0)
   10418:	d0442783          	lw	a5,-764(s0)
   1041c:	00078613          	mv	a2,a5
   10420:	f7043583          	ld	a1,-144(s0)
   10424:	00100513          	li	a0,1
   10428:	00002097          	auipc	ra,0x2
   1042c:	860080e7          	jalr	-1952(ra) # 11c88 <write>
   10430:	00100613          	li	a2,1
   10434:	00002597          	auipc	a1,0x2
   10438:	b4458593          	addi	a1,a1,-1212 # 11f78 <lseek+0x74>
   1043c:	00100513          	li	a0,1
   10440:	00002097          	auipc	ra,0x2
   10444:	848080e7          	jalr	-1976(ra) # 11c88 <write>
   10448:	67c0006f          	j	10ac4 <parse_cmd+0x790>
   1044c:	d0843783          	ld	a5,-760(s0)
   10450:	0007c783          	lbu	a5,0(a5)
   10454:	00078713          	mv	a4,a5
   10458:	06300793          	li	a5,99
   1045c:	18f71663          	bne	a4,a5,105e8 <parse_cmd+0x2b4>
   10460:	d0843783          	ld	a5,-760(s0)
   10464:	00178793          	addi	a5,a5,1
   10468:	0007c783          	lbu	a5,0(a5)
   1046c:	00078713          	mv	a4,a5
   10470:	06100793          	li	a5,97
   10474:	16f71a63          	bne	a4,a5,105e8 <parse_cmd+0x2b4>
   10478:	d0843783          	ld	a5,-760(s0)
   1047c:	00278793          	addi	a5,a5,2
   10480:	0007c783          	lbu	a5,0(a5)
   10484:	00078713          	mv	a4,a5
   10488:	07400793          	li	a5,116
   1048c:	14f71e63          	bne	a4,a5,105e8 <parse_cmd+0x2b4>
   10490:	d0843783          	ld	a5,-760(s0)
   10494:	00378793          	addi	a5,a5,3
   10498:	00078513          	mv	a0,a5
   1049c:	00000097          	auipc	ra,0x0
   104a0:	d00080e7          	jalr	-768(ra) # 1019c <get_param>
   104a4:	f6a43423          	sd	a0,-152(s0)
   104a8:	00100593          	li	a1,1
   104ac:	f6843503          	ld	a0,-152(s0)
   104b0:	00002097          	auipc	ra,0x2
   104b4:	9c0080e7          	jalr	-1600(ra) # 11e70 <open>
   104b8:	00050793          	mv	a5,a0
   104bc:	f6f42223          	sw	a5,-156(s0)
   104c0:	f6442783          	lw	a5,-156(s0)
   104c4:	0007871b          	sext.w	a4,a5
   104c8:	fff00793          	li	a5,-1
   104cc:	00f71e63          	bne	a4,a5,104e8 <parse_cmd+0x1b4>
   104d0:	f6843583          	ld	a1,-152(s0)
   104d4:	00002517          	auipc	a0,0x2
   104d8:	aac50513          	addi	a0,a0,-1364 # 11f80 <lseek+0x7c>
   104dc:	00001097          	auipc	ra,0x1
   104e0:	660080e7          	jalr	1632(ra) # 11b3c <printf>
   104e4:	5e00006f          	j	10ac4 <parse_cmd+0x790>
   104e8:	d1840713          	addi	a4,s0,-744
   104ec:	f6442783          	lw	a5,-156(s0)
   104f0:	1fd00613          	li	a2,509
   104f4:	00070593          	mv	a1,a4
   104f8:	00078513          	mv	a0,a5
   104fc:	00002097          	auipc	ra,0x2
   10500:	8ac080e7          	jalr	-1876(ra) # 11da8 <read>
   10504:	00050793          	mv	a5,a0
   10508:	f6f42023          	sw	a5,-160(s0)
   1050c:	f6042783          	lw	a5,-160(s0)
   10510:	0007879b          	sext.w	a5,a5
   10514:	02079463          	bnez	a5,1053c <parse_cmd+0x208>
   10518:	f8f44783          	lbu	a5,-113(s0)
   1051c:	0ff7f713          	zext.b	a4,a5
   10520:	00a00793          	li	a5,10
   10524:	0af70663          	beq	a4,a5,105d0 <parse_cmd+0x29c>
   10528:	00002517          	auipc	a0,0x2
   1052c:	a7050513          	addi	a0,a0,-1424 # 11f98 <lseek+0x94>
   10530:	00001097          	auipc	ra,0x1
   10534:	60c080e7          	jalr	1548(ra) # 11b3c <printf>
   10538:	0980006f          	j	105d0 <parse_cmd+0x29c>
   1053c:	f8042423          	sw	zero,-120(s0)
   10540:	0740006f          	j	105b4 <parse_cmd+0x280>
   10544:	f8842783          	lw	a5,-120(s0)
   10548:	f9078793          	addi	a5,a5,-112
   1054c:	008787b3          	add	a5,a5,s0
   10550:	d887c783          	lbu	a5,-632(a5)
   10554:	02079063          	bnez	a5,10574 <parse_cmd+0x240>
   10558:	00100613          	li	a2,1
   1055c:	00002597          	auipc	a1,0x2
   10560:	a4458593          	addi	a1,a1,-1468 # 11fa0 <lseek+0x9c>
   10564:	00100513          	li	a0,1
   10568:	00001097          	auipc	ra,0x1
   1056c:	720080e7          	jalr	1824(ra) # 11c88 <write>
   10570:	0240006f          	j	10594 <parse_cmd+0x260>
   10574:	d1840713          	addi	a4,s0,-744
   10578:	f8842783          	lw	a5,-120(s0)
   1057c:	00f707b3          	add	a5,a4,a5
   10580:	00100613          	li	a2,1
   10584:	00078593          	mv	a1,a5
   10588:	00100513          	li	a0,1
   1058c:	00001097          	auipc	ra,0x1
   10590:	6fc080e7          	jalr	1788(ra) # 11c88 <write>
   10594:	f8842783          	lw	a5,-120(s0)
   10598:	f9078793          	addi	a5,a5,-112
   1059c:	008787b3          	add	a5,a5,s0
   105a0:	d887c783          	lbu	a5,-632(a5)
   105a4:	f8f407a3          	sb	a5,-113(s0)
   105a8:	f8842783          	lw	a5,-120(s0)
   105ac:	0017879b          	addiw	a5,a5,1
   105b0:	f8f42423          	sw	a5,-120(s0)
   105b4:	f8842783          	lw	a5,-120(s0)
   105b8:	00078713          	mv	a4,a5
   105bc:	f6042783          	lw	a5,-160(s0)
   105c0:	0007071b          	sext.w	a4,a4
   105c4:	0007879b          	sext.w	a5,a5
   105c8:	f6f74ee3          	blt	a4,a5,10544 <parse_cmd+0x210>
   105cc:	f1dff06f          	j	104e8 <parse_cmd+0x1b4>
   105d0:	00000013          	nop
   105d4:	f6442783          	lw	a5,-156(s0)
   105d8:	00078513          	mv	a0,a5
   105dc:	00002097          	auipc	ra,0x2
   105e0:	8e0080e7          	jalr	-1824(ra) # 11ebc <close>
   105e4:	4e00006f          	j	10ac4 <parse_cmd+0x790>
   105e8:	d0843783          	ld	a5,-760(s0)
   105ec:	0007c783          	lbu	a5,0(a5)
   105f0:	00078713          	mv	a4,a5
   105f4:	06500793          	li	a5,101
   105f8:	4af71c63          	bne	a4,a5,10ab0 <parse_cmd+0x77c>
   105fc:	d0843783          	ld	a5,-760(s0)
   10600:	00178793          	addi	a5,a5,1
   10604:	0007c783          	lbu	a5,0(a5)
   10608:	00078713          	mv	a4,a5
   1060c:	06400793          	li	a5,100
   10610:	4af71063          	bne	a4,a5,10ab0 <parse_cmd+0x77c>
   10614:	d0843783          	ld	a5,-760(s0)
   10618:	00278793          	addi	a5,a5,2
   1061c:	0007c783          	lbu	a5,0(a5)
   10620:	00078713          	mv	a4,a5
   10624:	06900793          	li	a5,105
   10628:	48f71463          	bne	a4,a5,10ab0 <parse_cmd+0x77c>
   1062c:	d0843783          	ld	a5,-760(s0)
   10630:	00378793          	addi	a5,a5,3
   10634:	0007c783          	lbu	a5,0(a5)
   10638:	00078713          	mv	a4,a5
   1063c:	07400793          	li	a5,116
   10640:	46f71863          	bne	a4,a5,10ab0 <parse_cmd+0x77c>
   10644:	00010793          	mv	a5,sp
   10648:	00078493          	mv	s1,a5
   1064c:	d0843783          	ld	a5,-760(s0)
   10650:	00478793          	addi	a5,a5,4
   10654:	d0f43423          	sd	a5,-760(s0)
   10658:	0100006f          	j	10668 <parse_cmd+0x334>
   1065c:	d0843783          	ld	a5,-760(s0)
   10660:	00178793          	addi	a5,a5,1
   10664:	d0f43423          	sd	a5,-760(s0)
   10668:	d0843783          	ld	a5,-760(s0)
   1066c:	0007c783          	lbu	a5,0(a5)
   10670:	00078713          	mv	a4,a5
   10674:	02000793          	li	a5,32
   10678:	00f71863          	bne	a4,a5,10688 <parse_cmd+0x354>
   1067c:	d0843783          	ld	a5,-760(s0)
   10680:	0007c783          	lbu	a5,0(a5)
   10684:	fc079ce3          	bnez	a5,1065c <parse_cmd+0x328>
   10688:	d0843503          	ld	a0,-760(s0)
   1068c:	00000097          	auipc	ra,0x0
   10690:	b10080e7          	jalr	-1264(ra) # 1019c <get_param>
   10694:	f4a43c23          	sd	a0,-168(s0)
   10698:	f5843503          	ld	a0,-168(s0)
   1069c:	00001097          	auipc	ra,0x1
   106a0:	5a0080e7          	jalr	1440(ra) # 11c3c <strlen>
   106a4:	00050793          	mv	a5,a0
   106a8:	f4f42a23          	sw	a5,-172(s0)
   106ac:	f5442783          	lw	a5,-172(s0)
   106b0:	0017879b          	addiw	a5,a5,1
   106b4:	0007879b          	sext.w	a5,a5
   106b8:	00078713          	mv	a4,a5
   106bc:	fff70713          	addi	a4,a4,-1
   106c0:	f4e43423          	sd	a4,-184(s0)
   106c4:	00078713          	mv	a4,a5
   106c8:	cee43823          	sd	a4,-784(s0)
   106cc:	ce043c23          	sd	zero,-776(s0)
   106d0:	cf043703          	ld	a4,-784(s0)
   106d4:	03d75713          	srli	a4,a4,0x3d
   106d8:	cf843683          	ld	a3,-776(s0)
   106dc:	00369693          	slli	a3,a3,0x3
   106e0:	c8d43c23          	sd	a3,-872(s0)
   106e4:	c9843683          	ld	a3,-872(s0)
   106e8:	00d76733          	or	a4,a4,a3
   106ec:	c8e43c23          	sd	a4,-872(s0)
   106f0:	cf043703          	ld	a4,-784(s0)
   106f4:	00371713          	slli	a4,a4,0x3
   106f8:	c8e43823          	sd	a4,-880(s0)
   106fc:	00078713          	mv	a4,a5
   10700:	cee43023          	sd	a4,-800(s0)
   10704:	ce043423          	sd	zero,-792(s0)
   10708:	ce043703          	ld	a4,-800(s0)
   1070c:	03d75713          	srli	a4,a4,0x3d
   10710:	ce843683          	ld	a3,-792(s0)
   10714:	00369d93          	slli	s11,a3,0x3
   10718:	01b76db3          	or	s11,a4,s11
   1071c:	ce043703          	ld	a4,-800(s0)
   10720:	00371d13          	slli	s10,a4,0x3
   10724:	00f78793          	addi	a5,a5,15
   10728:	0047d793          	srli	a5,a5,0x4
   1072c:	00479793          	slli	a5,a5,0x4
   10730:	40f10133          	sub	sp,sp,a5
   10734:	00010793          	mv	a5,sp
   10738:	00078793          	mv	a5,a5
   1073c:	f4f43023          	sd	a5,-192(s0)
   10740:	f8042223          	sw	zero,-124(s0)
   10744:	0300006f          	j	10774 <parse_cmd+0x440>
   10748:	f8442783          	lw	a5,-124(s0)
   1074c:	f5843703          	ld	a4,-168(s0)
   10750:	00f707b3          	add	a5,a4,a5
   10754:	0007c703          	lbu	a4,0(a5)
   10758:	f4043683          	ld	a3,-192(s0)
   1075c:	f8442783          	lw	a5,-124(s0)
   10760:	00f687b3          	add	a5,a3,a5
   10764:	00e78023          	sb	a4,0(a5)
   10768:	f8442783          	lw	a5,-124(s0)
   1076c:	0017879b          	addiw	a5,a5,1
   10770:	f8f42223          	sw	a5,-124(s0)
   10774:	f8442783          	lw	a5,-124(s0)
   10778:	00078713          	mv	a4,a5
   1077c:	f5442783          	lw	a5,-172(s0)
   10780:	0007071b          	sext.w	a4,a4
   10784:	0007879b          	sext.w	a5,a5
   10788:	fcf740e3          	blt	a4,a5,10748 <parse_cmd+0x414>
   1078c:	f4043703          	ld	a4,-192(s0)
   10790:	f5442783          	lw	a5,-172(s0)
   10794:	00f707b3          	add	a5,a4,a5
   10798:	00078023          	sb	zero,0(a5)
   1079c:	f5442783          	lw	a5,-172(s0)
   107a0:	d0843703          	ld	a4,-760(s0)
   107a4:	00f707b3          	add	a5,a4,a5
   107a8:	d0f43423          	sd	a5,-760(s0)
   107ac:	0100006f          	j	107bc <parse_cmd+0x488>
   107b0:	d0843783          	ld	a5,-760(s0)
   107b4:	00178793          	addi	a5,a5,1
   107b8:	d0f43423          	sd	a5,-760(s0)
   107bc:	d0843783          	ld	a5,-760(s0)
   107c0:	0007c783          	lbu	a5,0(a5)
   107c4:	00078713          	mv	a4,a5
   107c8:	02000793          	li	a5,32
   107cc:	00f71863          	bne	a4,a5,107dc <parse_cmd+0x4a8>
   107d0:	d0843783          	ld	a5,-760(s0)
   107d4:	0007c783          	lbu	a5,0(a5)
   107d8:	fc079ce3          	bnez	a5,107b0 <parse_cmd+0x47c>
   107dc:	d0843503          	ld	a0,-760(s0)
   107e0:	00000097          	auipc	ra,0x0
   107e4:	9bc080e7          	jalr	-1604(ra) # 1019c <get_param>
   107e8:	f4a43c23          	sd	a0,-168(s0)
   107ec:	f5843503          	ld	a0,-168(s0)
   107f0:	00001097          	auipc	ra,0x1
   107f4:	44c080e7          	jalr	1100(ra) # 11c3c <strlen>
   107f8:	00050793          	mv	a5,a0
   107fc:	f4f42a23          	sw	a5,-172(s0)
   10800:	f5442783          	lw	a5,-172(s0)
   10804:	0017879b          	addiw	a5,a5,1
   10808:	0007879b          	sext.w	a5,a5
   1080c:	00078713          	mv	a4,a5
   10810:	fff70713          	addi	a4,a4,-1
   10814:	f2e43c23          	sd	a4,-200(s0)
   10818:	00078713          	mv	a4,a5
   1081c:	cce43823          	sd	a4,-816(s0)
   10820:	cc043c23          	sd	zero,-808(s0)
   10824:	cd043703          	ld	a4,-816(s0)
   10828:	03d75713          	srli	a4,a4,0x3d
   1082c:	cd843683          	ld	a3,-808(s0)
   10830:	00369c93          	slli	s9,a3,0x3
   10834:	01976cb3          	or	s9,a4,s9
   10838:	cd043703          	ld	a4,-816(s0)
   1083c:	00371c13          	slli	s8,a4,0x3
   10840:	00078713          	mv	a4,a5
   10844:	cce43023          	sd	a4,-832(s0)
   10848:	cc043423          	sd	zero,-824(s0)
   1084c:	cc043703          	ld	a4,-832(s0)
   10850:	03d75713          	srli	a4,a4,0x3d
   10854:	cc843683          	ld	a3,-824(s0)
   10858:	00369b93          	slli	s7,a3,0x3
   1085c:	01776bb3          	or	s7,a4,s7
   10860:	cc043703          	ld	a4,-832(s0)
   10864:	00371b13          	slli	s6,a4,0x3
   10868:	00f78793          	addi	a5,a5,15
   1086c:	0047d793          	srli	a5,a5,0x4
   10870:	00479793          	slli	a5,a5,0x4
   10874:	40f10133          	sub	sp,sp,a5
   10878:	00010793          	mv	a5,sp
   1087c:	00078793          	mv	a5,a5
   10880:	f2f43823          	sd	a5,-208(s0)
   10884:	f8042023          	sw	zero,-128(s0)
   10888:	0300006f          	j	108b8 <parse_cmd+0x584>
   1088c:	f8042783          	lw	a5,-128(s0)
   10890:	f5843703          	ld	a4,-168(s0)
   10894:	00f707b3          	add	a5,a4,a5
   10898:	0007c703          	lbu	a4,0(a5)
   1089c:	f3043683          	ld	a3,-208(s0)
   108a0:	f8042783          	lw	a5,-128(s0)
   108a4:	00f687b3          	add	a5,a3,a5
   108a8:	00e78023          	sb	a4,0(a5)
   108ac:	f8042783          	lw	a5,-128(s0)
   108b0:	0017879b          	addiw	a5,a5,1
   108b4:	f8f42023          	sw	a5,-128(s0)
   108b8:	f8042783          	lw	a5,-128(s0)
   108bc:	00078713          	mv	a4,a5
   108c0:	f5442783          	lw	a5,-172(s0)
   108c4:	0007071b          	sext.w	a4,a4
   108c8:	0007879b          	sext.w	a5,a5
   108cc:	fcf740e3          	blt	a4,a5,1088c <parse_cmd+0x558>
   108d0:	f3043703          	ld	a4,-208(s0)
   108d4:	f5442783          	lw	a5,-172(s0)
   108d8:	00f707b3          	add	a5,a4,a5
   108dc:	00078023          	sb	zero,0(a5)
   108e0:	f5442783          	lw	a5,-172(s0)
   108e4:	d0843703          	ld	a4,-760(s0)
   108e8:	00f707b3          	add	a5,a4,a5
   108ec:	d0f43423          	sd	a5,-760(s0)
   108f0:	0100006f          	j	10900 <parse_cmd+0x5cc>
   108f4:	d0843783          	ld	a5,-760(s0)
   108f8:	00178793          	addi	a5,a5,1
   108fc:	d0f43423          	sd	a5,-760(s0)
   10900:	d0843783          	ld	a5,-760(s0)
   10904:	0007c783          	lbu	a5,0(a5)
   10908:	00078713          	mv	a4,a5
   1090c:	02000793          	li	a5,32
   10910:	00f71863          	bne	a4,a5,10920 <parse_cmd+0x5ec>
   10914:	d0843783          	ld	a5,-760(s0)
   10918:	0007c783          	lbu	a5,0(a5)
   1091c:	fc079ce3          	bnez	a5,108f4 <parse_cmd+0x5c0>
   10920:	d0843503          	ld	a0,-760(s0)
   10924:	00000097          	auipc	ra,0x0
   10928:	92c080e7          	jalr	-1748(ra) # 10250 <get_string>
   1092c:	f4a43c23          	sd	a0,-168(s0)
   10930:	f5843503          	ld	a0,-168(s0)
   10934:	00001097          	auipc	ra,0x1
   10938:	308080e7          	jalr	776(ra) # 11c3c <strlen>
   1093c:	00050793          	mv	a5,a0
   10940:	f4f42a23          	sw	a5,-172(s0)
   10944:	f5442783          	lw	a5,-172(s0)
   10948:	0017879b          	addiw	a5,a5,1
   1094c:	0007879b          	sext.w	a5,a5
   10950:	00078713          	mv	a4,a5
   10954:	fff70713          	addi	a4,a4,-1
   10958:	f2e43423          	sd	a4,-216(s0)
   1095c:	00078713          	mv	a4,a5
   10960:	cae43823          	sd	a4,-848(s0)
   10964:	ca043c23          	sd	zero,-840(s0)
   10968:	cb043703          	ld	a4,-848(s0)
   1096c:	03d75713          	srli	a4,a4,0x3d
   10970:	cb843683          	ld	a3,-840(s0)
   10974:	00369a93          	slli	s5,a3,0x3
   10978:	01576ab3          	or	s5,a4,s5
   1097c:	cb043703          	ld	a4,-848(s0)
   10980:	00371a13          	slli	s4,a4,0x3
   10984:	00078713          	mv	a4,a5
   10988:	cae43023          	sd	a4,-864(s0)
   1098c:	ca043423          	sd	zero,-856(s0)
   10990:	ca043703          	ld	a4,-864(s0)
   10994:	03d75713          	srli	a4,a4,0x3d
   10998:	ca843683          	ld	a3,-856(s0)
   1099c:	00369993          	slli	s3,a3,0x3
   109a0:	013769b3          	or	s3,a4,s3
   109a4:	ca043703          	ld	a4,-864(s0)
   109a8:	00371913          	slli	s2,a4,0x3
   109ac:	00f78793          	addi	a5,a5,15
   109b0:	0047d793          	srli	a5,a5,0x4
   109b4:	00479793          	slli	a5,a5,0x4
   109b8:	40f10133          	sub	sp,sp,a5
   109bc:	00010793          	mv	a5,sp
   109c0:	00078793          	mv	a5,a5
   109c4:	f2f43023          	sd	a5,-224(s0)
   109c8:	f6042e23          	sw	zero,-132(s0)
   109cc:	0300006f          	j	109fc <parse_cmd+0x6c8>
   109d0:	f7c42783          	lw	a5,-132(s0)
   109d4:	f5843703          	ld	a4,-168(s0)
   109d8:	00f707b3          	add	a5,a4,a5
   109dc:	0007c703          	lbu	a4,0(a5)
   109e0:	f2043683          	ld	a3,-224(s0)
   109e4:	f7c42783          	lw	a5,-132(s0)
   109e8:	00f687b3          	add	a5,a3,a5
   109ec:	00e78023          	sb	a4,0(a5)
   109f0:	f7c42783          	lw	a5,-132(s0)
   109f4:	0017879b          	addiw	a5,a5,1
   109f8:	f6f42e23          	sw	a5,-132(s0)
   109fc:	f7c42783          	lw	a5,-132(s0)
   10a00:	00078713          	mv	a4,a5
   10a04:	f5442783          	lw	a5,-172(s0)
   10a08:	0007071b          	sext.w	a4,a4
   10a0c:	0007879b          	sext.w	a5,a5
   10a10:	fcf740e3          	blt	a4,a5,109d0 <parse_cmd+0x69c>
   10a14:	f2043703          	ld	a4,-224(s0)
   10a18:	f5442783          	lw	a5,-172(s0)
   10a1c:	00f707b3          	add	a5,a4,a5
   10a20:	00078023          	sb	zero,0(a5)
   10a24:	f5442783          	lw	a5,-172(s0)
   10a28:	d0843703          	ld	a4,-760(s0)
   10a2c:	00f707b3          	add	a5,a4,a5
   10a30:	d0f43423          	sd	a5,-760(s0)
   10a34:	f3043503          	ld	a0,-208(s0)
   10a38:	fffff097          	auipc	ra,0xfffff
   10a3c:	6b4080e7          	jalr	1716(ra) # 100ec <atoi>
   10a40:	00050793          	mv	a5,a0
   10a44:	f0f42e23          	sw	a5,-228(s0)
   10a48:	00300593          	li	a1,3
   10a4c:	f4043503          	ld	a0,-192(s0)
   10a50:	00001097          	auipc	ra,0x1
   10a54:	420080e7          	jalr	1056(ra) # 11e70 <open>
   10a58:	00050793          	mv	a5,a0
   10a5c:	f0f42c23          	sw	a5,-232(s0)
   10a60:	f1c42703          	lw	a4,-228(s0)
   10a64:	f1842783          	lw	a5,-232(s0)
   10a68:	00000613          	li	a2,0
   10a6c:	00070593          	mv	a1,a4
   10a70:	00078513          	mv	a0,a5
   10a74:	00001097          	auipc	ra,0x1
   10a78:	490080e7          	jalr	1168(ra) # 11f04 <lseek>
   10a7c:	f5442703          	lw	a4,-172(s0)
   10a80:	f1842783          	lw	a5,-232(s0)
   10a84:	00070613          	mv	a2,a4
   10a88:	f2043583          	ld	a1,-224(s0)
   10a8c:	00078513          	mv	a0,a5
   10a90:	00001097          	auipc	ra,0x1
   10a94:	1f8080e7          	jalr	504(ra) # 11c88 <write>
   10a98:	f1842783          	lw	a5,-232(s0)
   10a9c:	00078513          	mv	a0,a5
   10aa0:	00001097          	auipc	ra,0x1
   10aa4:	41c080e7          	jalr	1052(ra) # 11ebc <close>
   10aa8:	00048113          	mv	sp,s1
   10aac:	0180006f          	j	10ac4 <parse_cmd+0x790>
   10ab0:	d0843583          	ld	a1,-760(s0)
   10ab4:	00001517          	auipc	a0,0x1
   10ab8:	4f450513          	addi	a0,a0,1268 # 11fa8 <lseek+0xa4>
   10abc:	00001097          	auipc	ra,0x1
   10ac0:	080080e7          	jalr	128(ra) # 11b3c <printf>
   10ac4:	c9040113          	addi	sp,s0,-880
   10ac8:	36813083          	ld	ra,872(sp)
   10acc:	36013403          	ld	s0,864(sp)
   10ad0:	35813483          	ld	s1,856(sp)
   10ad4:	35013903          	ld	s2,848(sp)
   10ad8:	34813983          	ld	s3,840(sp)
   10adc:	34013a03          	ld	s4,832(sp)
   10ae0:	33813a83          	ld	s5,824(sp)
   10ae4:	33013b03          	ld	s6,816(sp)
   10ae8:	32813b83          	ld	s7,808(sp)
   10aec:	32013c03          	ld	s8,800(sp)
   10af0:	31813c83          	ld	s9,792(sp)
   10af4:	31013d03          	ld	s10,784(sp)
   10af8:	30813d83          	ld	s11,776(sp)
   10afc:	37010113          	addi	sp,sp,880
   10b00:	00008067          	ret

0000000000010b04 <main>:
   10b04:	f6010113          	addi	sp,sp,-160
   10b08:	08113c23          	sd	ra,152(sp)
   10b0c:	08813823          	sd	s0,144(sp)
   10b10:	0a010413          	addi	s0,sp,160
   10b14:	00f00613          	li	a2,15
   10b18:	00001597          	auipc	a1,0x1
   10b1c:	4a858593          	addi	a1,a1,1192 # 11fc0 <lseek+0xbc>
   10b20:	00100513          	li	a0,1
   10b24:	00001097          	auipc	ra,0x1
   10b28:	164080e7          	jalr	356(ra) # 11c88 <write>
   10b2c:	00f00613          	li	a2,15
   10b30:	00001597          	auipc	a1,0x1
   10b34:	4a058593          	addi	a1,a1,1184 # 11fd0 <lseek+0xcc>
   10b38:	00200513          	li	a0,2
   10b3c:	00001097          	auipc	ra,0x1
   10b40:	14c080e7          	jalr	332(ra) # 11c88 <write>
   10b44:	fe042623          	sw	zero,-20(s0)
   10b48:	00001517          	auipc	a0,0x1
   10b4c:	49850513          	addi	a0,a0,1176 # 11fe0 <lseek+0xdc>
   10b50:	00001097          	auipc	ra,0x1
   10b54:	fec080e7          	jalr	-20(ra) # 11b3c <printf>
   10b58:	fe840793          	addi	a5,s0,-24
   10b5c:	00100613          	li	a2,1
   10b60:	00078593          	mv	a1,a5
   10b64:	00000513          	li	a0,0
   10b68:	00001097          	auipc	ra,0x1
   10b6c:	240080e7          	jalr	576(ra) # 11da8 <read>
   10b70:	fe844783          	lbu	a5,-24(s0)
   10b74:	00078713          	mv	a4,a5
   10b78:	00d00793          	li	a5,13
   10b7c:	02f71063          	bne	a4,a5,10b9c <main+0x98>
   10b80:	00100613          	li	a2,1
   10b84:	00001597          	auipc	a1,0x1
   10b88:	3f458593          	addi	a1,a1,1012 # 11f78 <lseek+0x74>
   10b8c:	00100513          	li	a0,1
   10b90:	00001097          	auipc	ra,0x1
   10b94:	0f8080e7          	jalr	248(ra) # 11c88 <write>
   10b98:	0480006f          	j	10be0 <main+0xdc>
   10b9c:	fe844783          	lbu	a5,-24(s0)
   10ba0:	00078713          	mv	a4,a5
   10ba4:	07f00793          	li	a5,127
   10ba8:	02f71c63          	bne	a4,a5,10be0 <main+0xdc>
   10bac:	fec42783          	lw	a5,-20(s0)
   10bb0:	0007879b          	sext.w	a5,a5
   10bb4:	0af05a63          	blez	a5,10c68 <main+0x164>
   10bb8:	00300613          	li	a2,3
   10bbc:	00001597          	auipc	a1,0x1
   10bc0:	43c58593          	addi	a1,a1,1084 # 11ff8 <lseek+0xf4>
   10bc4:	00100513          	li	a0,1
   10bc8:	00001097          	auipc	ra,0x1
   10bcc:	0c0080e7          	jalr	192(ra) # 11c88 <write>
   10bd0:	fec42783          	lw	a5,-20(s0)
   10bd4:	fff7879b          	addiw	a5,a5,-1
   10bd8:	fef42623          	sw	a5,-20(s0)
   10bdc:	08c0006f          	j	10c68 <main+0x164>
   10be0:	fe840793          	addi	a5,s0,-24
   10be4:	00100613          	li	a2,1
   10be8:	00078593          	mv	a1,a5
   10bec:	00100513          	li	a0,1
   10bf0:	00001097          	auipc	ra,0x1
   10bf4:	098080e7          	jalr	152(ra) # 11c88 <write>
   10bf8:	fe844783          	lbu	a5,-24(s0)
   10bfc:	00078713          	mv	a4,a5
   10c00:	00d00793          	li	a5,13
   10c04:	04f71263          	bne	a4,a5,10c48 <main+0x144>
   10c08:	fec42783          	lw	a5,-20(s0)
   10c0c:	ff078793          	addi	a5,a5,-16
   10c10:	008787b3          	add	a5,a5,s0
   10c14:	f6078c23          	sb	zero,-136(a5)
   10c18:	fec42703          	lw	a4,-20(s0)
   10c1c:	f6840793          	addi	a5,s0,-152
   10c20:	00070593          	mv	a1,a4
   10c24:	00078513          	mv	a0,a5
   10c28:	fffff097          	auipc	ra,0xfffff
   10c2c:	70c080e7          	jalr	1804(ra) # 10334 <parse_cmd>
   10c30:	fe042623          	sw	zero,-20(s0)
   10c34:	00001517          	auipc	a0,0x1
   10c38:	3ac50513          	addi	a0,a0,940 # 11fe0 <lseek+0xdc>
   10c3c:	00001097          	auipc	ra,0x1
   10c40:	f00080e7          	jalr	-256(ra) # 11b3c <printf>
   10c44:	f15ff06f          	j	10b58 <main+0x54>
   10c48:	fec42783          	lw	a5,-20(s0)
   10c4c:	0017871b          	addiw	a4,a5,1
   10c50:	fee42623          	sw	a4,-20(s0)
   10c54:	fe844703          	lbu	a4,-24(s0)
   10c58:	ff078793          	addi	a5,a5,-16
   10c5c:	008787b3          	add	a5,a5,s0
   10c60:	f6e78c23          	sb	a4,-136(a5)
   10c64:	ef5ff06f          	j	10b58 <main+0x54>
   10c68:	00000013          	nop
   10c6c:	eedff06f          	j	10b58 <main+0x54>

0000000000010c70 <putc>:
   10c70:	fe010113          	addi	sp,sp,-32
   10c74:	00813c23          	sd	s0,24(sp)
   10c78:	02010413          	addi	s0,sp,32
   10c7c:	00050793          	mv	a5,a0
   10c80:	fef42623          	sw	a5,-20(s0)
   10c84:	00003797          	auipc	a5,0x3
   10c88:	38478793          	addi	a5,a5,900 # 14008 <tail>
   10c8c:	0007a783          	lw	a5,0(a5)
   10c90:	0017871b          	addiw	a4,a5,1
   10c94:	0007069b          	sext.w	a3,a4
   10c98:	00003717          	auipc	a4,0x3
   10c9c:	37070713          	addi	a4,a4,880 # 14008 <tail>
   10ca0:	00d72023          	sw	a3,0(a4)
   10ca4:	fec42703          	lw	a4,-20(s0)
   10ca8:	0ff77713          	zext.b	a4,a4
   10cac:	00003697          	auipc	a3,0x3
   10cb0:	36468693          	addi	a3,a3,868 # 14010 <buffer>
   10cb4:	00f687b3          	add	a5,a3,a5
   10cb8:	00e78023          	sb	a4,0(a5)
   10cbc:	fec42783          	lw	a5,-20(s0)
   10cc0:	0ff7f793          	zext.b	a5,a5
   10cc4:	0007879b          	sext.w	a5,a5
   10cc8:	00078513          	mv	a0,a5
   10ccc:	01813403          	ld	s0,24(sp)
   10cd0:	02010113          	addi	sp,sp,32
   10cd4:	00008067          	ret

0000000000010cd8 <isspace>:
   10cd8:	fe010113          	addi	sp,sp,-32
   10cdc:	00813c23          	sd	s0,24(sp)
   10ce0:	02010413          	addi	s0,sp,32
   10ce4:	00050793          	mv	a5,a0
   10ce8:	fef42623          	sw	a5,-20(s0)
   10cec:	fec42783          	lw	a5,-20(s0)
   10cf0:	0007871b          	sext.w	a4,a5
   10cf4:	02000793          	li	a5,32
   10cf8:	02f70263          	beq	a4,a5,10d1c <isspace+0x44>
   10cfc:	fec42783          	lw	a5,-20(s0)
   10d00:	0007871b          	sext.w	a4,a5
   10d04:	00800793          	li	a5,8
   10d08:	00e7de63          	bge	a5,a4,10d24 <isspace+0x4c>
   10d0c:	fec42783          	lw	a5,-20(s0)
   10d10:	0007871b          	sext.w	a4,a5
   10d14:	00d00793          	li	a5,13
   10d18:	00e7c663          	blt	a5,a4,10d24 <isspace+0x4c>
   10d1c:	00100793          	li	a5,1
   10d20:	0080006f          	j	10d28 <isspace+0x50>
   10d24:	00000793          	li	a5,0
   10d28:	00078513          	mv	a0,a5
   10d2c:	01813403          	ld	s0,24(sp)
   10d30:	02010113          	addi	sp,sp,32
   10d34:	00008067          	ret

0000000000010d38 <strtol>:
   10d38:	fb010113          	addi	sp,sp,-80
   10d3c:	04113423          	sd	ra,72(sp)
   10d40:	04813023          	sd	s0,64(sp)
   10d44:	05010413          	addi	s0,sp,80
   10d48:	fca43423          	sd	a0,-56(s0)
   10d4c:	fcb43023          	sd	a1,-64(s0)
   10d50:	00060793          	mv	a5,a2
   10d54:	faf42e23          	sw	a5,-68(s0)
   10d58:	fe043423          	sd	zero,-24(s0)
   10d5c:	fe0403a3          	sb	zero,-25(s0)
   10d60:	fc843783          	ld	a5,-56(s0)
   10d64:	fcf43c23          	sd	a5,-40(s0)
   10d68:	0100006f          	j	10d78 <strtol+0x40>
   10d6c:	fd843783          	ld	a5,-40(s0)
   10d70:	00178793          	addi	a5,a5,1
   10d74:	fcf43c23          	sd	a5,-40(s0)
   10d78:	fd843783          	ld	a5,-40(s0)
   10d7c:	0007c783          	lbu	a5,0(a5)
   10d80:	0007879b          	sext.w	a5,a5
   10d84:	00078513          	mv	a0,a5
   10d88:	00000097          	auipc	ra,0x0
   10d8c:	f50080e7          	jalr	-176(ra) # 10cd8 <isspace>
   10d90:	00050793          	mv	a5,a0
   10d94:	fc079ce3          	bnez	a5,10d6c <strtol+0x34>
   10d98:	fd843783          	ld	a5,-40(s0)
   10d9c:	0007c783          	lbu	a5,0(a5)
   10da0:	00078713          	mv	a4,a5
   10da4:	02d00793          	li	a5,45
   10da8:	00f71e63          	bne	a4,a5,10dc4 <strtol+0x8c>
   10dac:	00100793          	li	a5,1
   10db0:	fef403a3          	sb	a5,-25(s0)
   10db4:	fd843783          	ld	a5,-40(s0)
   10db8:	00178793          	addi	a5,a5,1
   10dbc:	fcf43c23          	sd	a5,-40(s0)
   10dc0:	0240006f          	j	10de4 <strtol+0xac>
   10dc4:	fd843783          	ld	a5,-40(s0)
   10dc8:	0007c783          	lbu	a5,0(a5)
   10dcc:	00078713          	mv	a4,a5
   10dd0:	02b00793          	li	a5,43
   10dd4:	00f71863          	bne	a4,a5,10de4 <strtol+0xac>
   10dd8:	fd843783          	ld	a5,-40(s0)
   10ddc:	00178793          	addi	a5,a5,1
   10de0:	fcf43c23          	sd	a5,-40(s0)
   10de4:	fbc42783          	lw	a5,-68(s0)
   10de8:	0007879b          	sext.w	a5,a5
   10dec:	06079c63          	bnez	a5,10e64 <strtol+0x12c>
   10df0:	fd843783          	ld	a5,-40(s0)
   10df4:	0007c783          	lbu	a5,0(a5)
   10df8:	00078713          	mv	a4,a5
   10dfc:	03000793          	li	a5,48
   10e00:	04f71e63          	bne	a4,a5,10e5c <strtol+0x124>
   10e04:	fd843783          	ld	a5,-40(s0)
   10e08:	00178793          	addi	a5,a5,1
   10e0c:	fcf43c23          	sd	a5,-40(s0)
   10e10:	fd843783          	ld	a5,-40(s0)
   10e14:	0007c783          	lbu	a5,0(a5)
   10e18:	00078713          	mv	a4,a5
   10e1c:	07800793          	li	a5,120
   10e20:	00f70c63          	beq	a4,a5,10e38 <strtol+0x100>
   10e24:	fd843783          	ld	a5,-40(s0)
   10e28:	0007c783          	lbu	a5,0(a5)
   10e2c:	00078713          	mv	a4,a5
   10e30:	05800793          	li	a5,88
   10e34:	00f71e63          	bne	a4,a5,10e50 <strtol+0x118>
   10e38:	01000793          	li	a5,16
   10e3c:	faf42e23          	sw	a5,-68(s0)
   10e40:	fd843783          	ld	a5,-40(s0)
   10e44:	00178793          	addi	a5,a5,1
   10e48:	fcf43c23          	sd	a5,-40(s0)
   10e4c:	0180006f          	j	10e64 <strtol+0x12c>
   10e50:	00800793          	li	a5,8
   10e54:	faf42e23          	sw	a5,-68(s0)
   10e58:	00c0006f          	j	10e64 <strtol+0x12c>
   10e5c:	00a00793          	li	a5,10
   10e60:	faf42e23          	sw	a5,-68(s0)
   10e64:	fd843783          	ld	a5,-40(s0)
   10e68:	0007c783          	lbu	a5,0(a5)
   10e6c:	00078713          	mv	a4,a5
   10e70:	02f00793          	li	a5,47
   10e74:	02e7f863          	bgeu	a5,a4,10ea4 <strtol+0x16c>
   10e78:	fd843783          	ld	a5,-40(s0)
   10e7c:	0007c783          	lbu	a5,0(a5)
   10e80:	00078713          	mv	a4,a5
   10e84:	03900793          	li	a5,57
   10e88:	00e7ee63          	bltu	a5,a4,10ea4 <strtol+0x16c>
   10e8c:	fd843783          	ld	a5,-40(s0)
   10e90:	0007c783          	lbu	a5,0(a5)
   10e94:	0007879b          	sext.w	a5,a5
   10e98:	fd07879b          	addiw	a5,a5,-48
   10e9c:	fcf42a23          	sw	a5,-44(s0)
   10ea0:	0800006f          	j	10f20 <strtol+0x1e8>
   10ea4:	fd843783          	ld	a5,-40(s0)
   10ea8:	0007c783          	lbu	a5,0(a5)
   10eac:	00078713          	mv	a4,a5
   10eb0:	06000793          	li	a5,96
   10eb4:	02e7f863          	bgeu	a5,a4,10ee4 <strtol+0x1ac>
   10eb8:	fd843783          	ld	a5,-40(s0)
   10ebc:	0007c783          	lbu	a5,0(a5)
   10ec0:	00078713          	mv	a4,a5
   10ec4:	07a00793          	li	a5,122
   10ec8:	00e7ee63          	bltu	a5,a4,10ee4 <strtol+0x1ac>
   10ecc:	fd843783          	ld	a5,-40(s0)
   10ed0:	0007c783          	lbu	a5,0(a5)
   10ed4:	0007879b          	sext.w	a5,a5
   10ed8:	fa97879b          	addiw	a5,a5,-87
   10edc:	fcf42a23          	sw	a5,-44(s0)
   10ee0:	0400006f          	j	10f20 <strtol+0x1e8>
   10ee4:	fd843783          	ld	a5,-40(s0)
   10ee8:	0007c783          	lbu	a5,0(a5)
   10eec:	00078713          	mv	a4,a5
   10ef0:	04000793          	li	a5,64
   10ef4:	06e7f863          	bgeu	a5,a4,10f64 <strtol+0x22c>
   10ef8:	fd843783          	ld	a5,-40(s0)
   10efc:	0007c783          	lbu	a5,0(a5)
   10f00:	00078713          	mv	a4,a5
   10f04:	05a00793          	li	a5,90
   10f08:	04e7ee63          	bltu	a5,a4,10f64 <strtol+0x22c>
   10f0c:	fd843783          	ld	a5,-40(s0)
   10f10:	0007c783          	lbu	a5,0(a5)
   10f14:	0007879b          	sext.w	a5,a5
   10f18:	fc97879b          	addiw	a5,a5,-55
   10f1c:	fcf42a23          	sw	a5,-44(s0)
   10f20:	fd442783          	lw	a5,-44(s0)
   10f24:	00078713          	mv	a4,a5
   10f28:	fbc42783          	lw	a5,-68(s0)
   10f2c:	0007071b          	sext.w	a4,a4
   10f30:	0007879b          	sext.w	a5,a5
   10f34:	02f75663          	bge	a4,a5,10f60 <strtol+0x228>
   10f38:	fbc42703          	lw	a4,-68(s0)
   10f3c:	fe843783          	ld	a5,-24(s0)
   10f40:	02f70733          	mul	a4,a4,a5
   10f44:	fd442783          	lw	a5,-44(s0)
   10f48:	00f707b3          	add	a5,a4,a5
   10f4c:	fef43423          	sd	a5,-24(s0)
   10f50:	fd843783          	ld	a5,-40(s0)
   10f54:	00178793          	addi	a5,a5,1
   10f58:	fcf43c23          	sd	a5,-40(s0)
   10f5c:	f09ff06f          	j	10e64 <strtol+0x12c>
   10f60:	00000013          	nop
   10f64:	fc043783          	ld	a5,-64(s0)
   10f68:	00078863          	beqz	a5,10f78 <strtol+0x240>
   10f6c:	fc043783          	ld	a5,-64(s0)
   10f70:	fd843703          	ld	a4,-40(s0)
   10f74:	00e7b023          	sd	a4,0(a5)
   10f78:	fe744783          	lbu	a5,-25(s0)
   10f7c:	0ff7f793          	zext.b	a5,a5
   10f80:	00078863          	beqz	a5,10f90 <strtol+0x258>
   10f84:	fe843783          	ld	a5,-24(s0)
   10f88:	40f007b3          	neg	a5,a5
   10f8c:	0080006f          	j	10f94 <strtol+0x25c>
   10f90:	fe843783          	ld	a5,-24(s0)
   10f94:	00078513          	mv	a0,a5
   10f98:	04813083          	ld	ra,72(sp)
   10f9c:	04013403          	ld	s0,64(sp)
   10fa0:	05010113          	addi	sp,sp,80
   10fa4:	00008067          	ret

0000000000010fa8 <puts_wo_nl>:
   10fa8:	fd010113          	addi	sp,sp,-48
   10fac:	02113423          	sd	ra,40(sp)
   10fb0:	02813023          	sd	s0,32(sp)
   10fb4:	03010413          	addi	s0,sp,48
   10fb8:	fca43c23          	sd	a0,-40(s0)
   10fbc:	fcb43823          	sd	a1,-48(s0)
   10fc0:	fd043783          	ld	a5,-48(s0)
   10fc4:	00079863          	bnez	a5,10fd4 <puts_wo_nl+0x2c>
   10fc8:	00001797          	auipc	a5,0x1
   10fcc:	03878793          	addi	a5,a5,56 # 12000 <lseek+0xfc>
   10fd0:	fcf43823          	sd	a5,-48(s0)
   10fd4:	fd043783          	ld	a5,-48(s0)
   10fd8:	fef43423          	sd	a5,-24(s0)
   10fdc:	0240006f          	j	11000 <puts_wo_nl+0x58>
   10fe0:	fe843783          	ld	a5,-24(s0)
   10fe4:	00178713          	addi	a4,a5,1
   10fe8:	fee43423          	sd	a4,-24(s0)
   10fec:	0007c783          	lbu	a5,0(a5)
   10ff0:	0007871b          	sext.w	a4,a5
   10ff4:	fd843783          	ld	a5,-40(s0)
   10ff8:	00070513          	mv	a0,a4
   10ffc:	000780e7          	jalr	a5
   11000:	fe843783          	ld	a5,-24(s0)
   11004:	0007c783          	lbu	a5,0(a5)
   11008:	fc079ce3          	bnez	a5,10fe0 <puts_wo_nl+0x38>
   1100c:	fe843703          	ld	a4,-24(s0)
   11010:	fd043783          	ld	a5,-48(s0)
   11014:	40f707b3          	sub	a5,a4,a5
   11018:	0007879b          	sext.w	a5,a5
   1101c:	00078513          	mv	a0,a5
   11020:	02813083          	ld	ra,40(sp)
   11024:	02013403          	ld	s0,32(sp)
   11028:	03010113          	addi	sp,sp,48
   1102c:	00008067          	ret

0000000000011030 <print_dec_int>:
   11030:	f9010113          	addi	sp,sp,-112
   11034:	06113423          	sd	ra,104(sp)
   11038:	06813023          	sd	s0,96(sp)
   1103c:	07010413          	addi	s0,sp,112
   11040:	faa43423          	sd	a0,-88(s0)
   11044:	fab43023          	sd	a1,-96(s0)
   11048:	00060793          	mv	a5,a2
   1104c:	f8d43823          	sd	a3,-112(s0)
   11050:	f8f40fa3          	sb	a5,-97(s0)
   11054:	f9f44783          	lbu	a5,-97(s0)
   11058:	0ff7f793          	zext.b	a5,a5
   1105c:	02078863          	beqz	a5,1108c <print_dec_int+0x5c>
   11060:	fa043703          	ld	a4,-96(s0)
   11064:	fff00793          	li	a5,-1
   11068:	03f79793          	slli	a5,a5,0x3f
   1106c:	02f71063          	bne	a4,a5,1108c <print_dec_int+0x5c>
   11070:	00001597          	auipc	a1,0x1
   11074:	f9858593          	addi	a1,a1,-104 # 12008 <lseek+0x104>
   11078:	fa843503          	ld	a0,-88(s0)
   1107c:	00000097          	auipc	ra,0x0
   11080:	f2c080e7          	jalr	-212(ra) # 10fa8 <puts_wo_nl>
   11084:	00050793          	mv	a5,a0
   11088:	2a00006f          	j	11328 <print_dec_int+0x2f8>
   1108c:	f9043783          	ld	a5,-112(s0)
   11090:	00c7a783          	lw	a5,12(a5)
   11094:	00079a63          	bnez	a5,110a8 <print_dec_int+0x78>
   11098:	fa043783          	ld	a5,-96(s0)
   1109c:	00079663          	bnez	a5,110a8 <print_dec_int+0x78>
   110a0:	00000793          	li	a5,0
   110a4:	2840006f          	j	11328 <print_dec_int+0x2f8>
   110a8:	fe0407a3          	sb	zero,-17(s0)
   110ac:	f9f44783          	lbu	a5,-97(s0)
   110b0:	0ff7f793          	zext.b	a5,a5
   110b4:	02078063          	beqz	a5,110d4 <print_dec_int+0xa4>
   110b8:	fa043783          	ld	a5,-96(s0)
   110bc:	0007dc63          	bgez	a5,110d4 <print_dec_int+0xa4>
   110c0:	00100793          	li	a5,1
   110c4:	fef407a3          	sb	a5,-17(s0)
   110c8:	fa043783          	ld	a5,-96(s0)
   110cc:	40f007b3          	neg	a5,a5
   110d0:	faf43023          	sd	a5,-96(s0)
   110d4:	fe042423          	sw	zero,-24(s0)
   110d8:	f9f44783          	lbu	a5,-97(s0)
   110dc:	0ff7f793          	zext.b	a5,a5
   110e0:	02078863          	beqz	a5,11110 <print_dec_int+0xe0>
   110e4:	fef44783          	lbu	a5,-17(s0)
   110e8:	0ff7f793          	zext.b	a5,a5
   110ec:	00079e63          	bnez	a5,11108 <print_dec_int+0xd8>
   110f0:	f9043783          	ld	a5,-112(s0)
   110f4:	0057c783          	lbu	a5,5(a5)
   110f8:	00079863          	bnez	a5,11108 <print_dec_int+0xd8>
   110fc:	f9043783          	ld	a5,-112(s0)
   11100:	0047c783          	lbu	a5,4(a5)
   11104:	00078663          	beqz	a5,11110 <print_dec_int+0xe0>
   11108:	00100793          	li	a5,1
   1110c:	0080006f          	j	11114 <print_dec_int+0xe4>
   11110:	00000793          	li	a5,0
   11114:	fcf40ba3          	sb	a5,-41(s0)
   11118:	fd744783          	lbu	a5,-41(s0)
   1111c:	0017f793          	andi	a5,a5,1
   11120:	fcf40ba3          	sb	a5,-41(s0)
   11124:	fa043703          	ld	a4,-96(s0)
   11128:	00a00793          	li	a5,10
   1112c:	02f777b3          	remu	a5,a4,a5
   11130:	0ff7f713          	zext.b	a4,a5
   11134:	fe842783          	lw	a5,-24(s0)
   11138:	0017869b          	addiw	a3,a5,1
   1113c:	fed42423          	sw	a3,-24(s0)
   11140:	0307071b          	addiw	a4,a4,48
   11144:	0ff77713          	zext.b	a4,a4
   11148:	ff078793          	addi	a5,a5,-16
   1114c:	008787b3          	add	a5,a5,s0
   11150:	fce78423          	sb	a4,-56(a5)
   11154:	fa043703          	ld	a4,-96(s0)
   11158:	00a00793          	li	a5,10
   1115c:	02f757b3          	divu	a5,a4,a5
   11160:	faf43023          	sd	a5,-96(s0)
   11164:	fa043783          	ld	a5,-96(s0)
   11168:	fa079ee3          	bnez	a5,11124 <print_dec_int+0xf4>
   1116c:	f9043783          	ld	a5,-112(s0)
   11170:	00c7a783          	lw	a5,12(a5)
   11174:	00078713          	mv	a4,a5
   11178:	fff00793          	li	a5,-1
   1117c:	02f71063          	bne	a4,a5,1119c <print_dec_int+0x16c>
   11180:	f9043783          	ld	a5,-112(s0)
   11184:	0037c783          	lbu	a5,3(a5)
   11188:	00078a63          	beqz	a5,1119c <print_dec_int+0x16c>
   1118c:	f9043783          	ld	a5,-112(s0)
   11190:	0087a703          	lw	a4,8(a5)
   11194:	f9043783          	ld	a5,-112(s0)
   11198:	00e7a623          	sw	a4,12(a5)
   1119c:	fe042223          	sw	zero,-28(s0)
   111a0:	f9043783          	ld	a5,-112(s0)
   111a4:	0087a703          	lw	a4,8(a5)
   111a8:	fe842783          	lw	a5,-24(s0)
   111ac:	fcf42823          	sw	a5,-48(s0)
   111b0:	f9043783          	ld	a5,-112(s0)
   111b4:	00c7a783          	lw	a5,12(a5)
   111b8:	fcf42623          	sw	a5,-52(s0)
   111bc:	fd042783          	lw	a5,-48(s0)
   111c0:	00078593          	mv	a1,a5
   111c4:	fcc42783          	lw	a5,-52(s0)
   111c8:	00078613          	mv	a2,a5
   111cc:	0006069b          	sext.w	a3,a2
   111d0:	0005879b          	sext.w	a5,a1
   111d4:	00f6d463          	bge	a3,a5,111dc <print_dec_int+0x1ac>
   111d8:	00058613          	mv	a2,a1
   111dc:	0006079b          	sext.w	a5,a2
   111e0:	40f707bb          	subw	a5,a4,a5
   111e4:	0007871b          	sext.w	a4,a5
   111e8:	fd744783          	lbu	a5,-41(s0)
   111ec:	0007879b          	sext.w	a5,a5
   111f0:	40f707bb          	subw	a5,a4,a5
   111f4:	fef42023          	sw	a5,-32(s0)
   111f8:	0280006f          	j	11220 <print_dec_int+0x1f0>
   111fc:	fa843783          	ld	a5,-88(s0)
   11200:	02000513          	li	a0,32
   11204:	000780e7          	jalr	a5
   11208:	fe442783          	lw	a5,-28(s0)
   1120c:	0017879b          	addiw	a5,a5,1
   11210:	fef42223          	sw	a5,-28(s0)
   11214:	fe042783          	lw	a5,-32(s0)
   11218:	fff7879b          	addiw	a5,a5,-1
   1121c:	fef42023          	sw	a5,-32(s0)
   11220:	fe042783          	lw	a5,-32(s0)
   11224:	0007879b          	sext.w	a5,a5
   11228:	fcf04ae3          	bgtz	a5,111fc <print_dec_int+0x1cc>
   1122c:	fd744783          	lbu	a5,-41(s0)
   11230:	0ff7f793          	zext.b	a5,a5
   11234:	04078463          	beqz	a5,1127c <print_dec_int+0x24c>
   11238:	fef44783          	lbu	a5,-17(s0)
   1123c:	0ff7f793          	zext.b	a5,a5
   11240:	00078663          	beqz	a5,1124c <print_dec_int+0x21c>
   11244:	02d00793          	li	a5,45
   11248:	01c0006f          	j	11264 <print_dec_int+0x234>
   1124c:	f9043783          	ld	a5,-112(s0)
   11250:	0057c783          	lbu	a5,5(a5)
   11254:	00078663          	beqz	a5,11260 <print_dec_int+0x230>
   11258:	02b00793          	li	a5,43
   1125c:	0080006f          	j	11264 <print_dec_int+0x234>
   11260:	02000793          	li	a5,32
   11264:	fa843703          	ld	a4,-88(s0)
   11268:	00078513          	mv	a0,a5
   1126c:	000700e7          	jalr	a4
   11270:	fe442783          	lw	a5,-28(s0)
   11274:	0017879b          	addiw	a5,a5,1
   11278:	fef42223          	sw	a5,-28(s0)
   1127c:	fe842783          	lw	a5,-24(s0)
   11280:	fcf42e23          	sw	a5,-36(s0)
   11284:	0280006f          	j	112ac <print_dec_int+0x27c>
   11288:	fa843783          	ld	a5,-88(s0)
   1128c:	03000513          	li	a0,48
   11290:	000780e7          	jalr	a5
   11294:	fe442783          	lw	a5,-28(s0)
   11298:	0017879b          	addiw	a5,a5,1
   1129c:	fef42223          	sw	a5,-28(s0)
   112a0:	fdc42783          	lw	a5,-36(s0)
   112a4:	0017879b          	addiw	a5,a5,1
   112a8:	fcf42e23          	sw	a5,-36(s0)
   112ac:	f9043783          	ld	a5,-112(s0)
   112b0:	00c7a703          	lw	a4,12(a5)
   112b4:	fd744783          	lbu	a5,-41(s0)
   112b8:	0007879b          	sext.w	a5,a5
   112bc:	40f707bb          	subw	a5,a4,a5
   112c0:	0007871b          	sext.w	a4,a5
   112c4:	fdc42783          	lw	a5,-36(s0)
   112c8:	0007879b          	sext.w	a5,a5
   112cc:	fae7cee3          	blt	a5,a4,11288 <print_dec_int+0x258>
   112d0:	fe842783          	lw	a5,-24(s0)
   112d4:	fff7879b          	addiw	a5,a5,-1
   112d8:	fcf42c23          	sw	a5,-40(s0)
   112dc:	03c0006f          	j	11318 <print_dec_int+0x2e8>
   112e0:	fd842783          	lw	a5,-40(s0)
   112e4:	ff078793          	addi	a5,a5,-16
   112e8:	008787b3          	add	a5,a5,s0
   112ec:	fc87c783          	lbu	a5,-56(a5)
   112f0:	0007871b          	sext.w	a4,a5
   112f4:	fa843783          	ld	a5,-88(s0)
   112f8:	00070513          	mv	a0,a4
   112fc:	000780e7          	jalr	a5
   11300:	fe442783          	lw	a5,-28(s0)
   11304:	0017879b          	addiw	a5,a5,1
   11308:	fef42223          	sw	a5,-28(s0)
   1130c:	fd842783          	lw	a5,-40(s0)
   11310:	fff7879b          	addiw	a5,a5,-1
   11314:	fcf42c23          	sw	a5,-40(s0)
   11318:	fd842783          	lw	a5,-40(s0)
   1131c:	0007879b          	sext.w	a5,a5
   11320:	fc07d0e3          	bgez	a5,112e0 <print_dec_int+0x2b0>
   11324:	fe442783          	lw	a5,-28(s0)
   11328:	00078513          	mv	a0,a5
   1132c:	06813083          	ld	ra,104(sp)
   11330:	06013403          	ld	s0,96(sp)
   11334:	07010113          	addi	sp,sp,112
   11338:	00008067          	ret

000000000001133c <vprintfmt>:
   1133c:	f4010113          	addi	sp,sp,-192
   11340:	0a113c23          	sd	ra,184(sp)
   11344:	0a813823          	sd	s0,176(sp)
   11348:	0c010413          	addi	s0,sp,192
   1134c:	f4a43c23          	sd	a0,-168(s0)
   11350:	f4b43823          	sd	a1,-176(s0)
   11354:	f4c43423          	sd	a2,-184(s0)
   11358:	f8043023          	sd	zero,-128(s0)
   1135c:	f8043423          	sd	zero,-120(s0)
   11360:	fe042623          	sw	zero,-20(s0)
   11364:	7b40006f          	j	11b18 <vprintfmt+0x7dc>
   11368:	f8044783          	lbu	a5,-128(s0)
   1136c:	74078663          	beqz	a5,11ab8 <vprintfmt+0x77c>
   11370:	f5043783          	ld	a5,-176(s0)
   11374:	0007c783          	lbu	a5,0(a5)
   11378:	00078713          	mv	a4,a5
   1137c:	02300793          	li	a5,35
   11380:	00f71863          	bne	a4,a5,11390 <vprintfmt+0x54>
   11384:	00100793          	li	a5,1
   11388:	f8f40123          	sb	a5,-126(s0)
   1138c:	7800006f          	j	11b0c <vprintfmt+0x7d0>
   11390:	f5043783          	ld	a5,-176(s0)
   11394:	0007c783          	lbu	a5,0(a5)
   11398:	00078713          	mv	a4,a5
   1139c:	03000793          	li	a5,48
   113a0:	00f71863          	bne	a4,a5,113b0 <vprintfmt+0x74>
   113a4:	00100793          	li	a5,1
   113a8:	f8f401a3          	sb	a5,-125(s0)
   113ac:	7600006f          	j	11b0c <vprintfmt+0x7d0>
   113b0:	f5043783          	ld	a5,-176(s0)
   113b4:	0007c783          	lbu	a5,0(a5)
   113b8:	00078713          	mv	a4,a5
   113bc:	06c00793          	li	a5,108
   113c0:	04f70063          	beq	a4,a5,11400 <vprintfmt+0xc4>
   113c4:	f5043783          	ld	a5,-176(s0)
   113c8:	0007c783          	lbu	a5,0(a5)
   113cc:	00078713          	mv	a4,a5
   113d0:	07a00793          	li	a5,122
   113d4:	02f70663          	beq	a4,a5,11400 <vprintfmt+0xc4>
   113d8:	f5043783          	ld	a5,-176(s0)
   113dc:	0007c783          	lbu	a5,0(a5)
   113e0:	00078713          	mv	a4,a5
   113e4:	07400793          	li	a5,116
   113e8:	00f70c63          	beq	a4,a5,11400 <vprintfmt+0xc4>
   113ec:	f5043783          	ld	a5,-176(s0)
   113f0:	0007c783          	lbu	a5,0(a5)
   113f4:	00078713          	mv	a4,a5
   113f8:	06a00793          	li	a5,106
   113fc:	00f71863          	bne	a4,a5,1140c <vprintfmt+0xd0>
   11400:	00100793          	li	a5,1
   11404:	f8f400a3          	sb	a5,-127(s0)
   11408:	7040006f          	j	11b0c <vprintfmt+0x7d0>
   1140c:	f5043783          	ld	a5,-176(s0)
   11410:	0007c783          	lbu	a5,0(a5)
   11414:	00078713          	mv	a4,a5
   11418:	02b00793          	li	a5,43
   1141c:	00f71863          	bne	a4,a5,1142c <vprintfmt+0xf0>
   11420:	00100793          	li	a5,1
   11424:	f8f402a3          	sb	a5,-123(s0)
   11428:	6e40006f          	j	11b0c <vprintfmt+0x7d0>
   1142c:	f5043783          	ld	a5,-176(s0)
   11430:	0007c783          	lbu	a5,0(a5)
   11434:	00078713          	mv	a4,a5
   11438:	02000793          	li	a5,32
   1143c:	00f71863          	bne	a4,a5,1144c <vprintfmt+0x110>
   11440:	00100793          	li	a5,1
   11444:	f8f40223          	sb	a5,-124(s0)
   11448:	6c40006f          	j	11b0c <vprintfmt+0x7d0>
   1144c:	f5043783          	ld	a5,-176(s0)
   11450:	0007c783          	lbu	a5,0(a5)
   11454:	00078713          	mv	a4,a5
   11458:	02a00793          	li	a5,42
   1145c:	00f71e63          	bne	a4,a5,11478 <vprintfmt+0x13c>
   11460:	f4843783          	ld	a5,-184(s0)
   11464:	00878713          	addi	a4,a5,8
   11468:	f4e43423          	sd	a4,-184(s0)
   1146c:	0007a783          	lw	a5,0(a5)
   11470:	f8f42423          	sw	a5,-120(s0)
   11474:	6980006f          	j	11b0c <vprintfmt+0x7d0>
   11478:	f5043783          	ld	a5,-176(s0)
   1147c:	0007c783          	lbu	a5,0(a5)
   11480:	00078713          	mv	a4,a5
   11484:	03000793          	li	a5,48
   11488:	04e7f863          	bgeu	a5,a4,114d8 <vprintfmt+0x19c>
   1148c:	f5043783          	ld	a5,-176(s0)
   11490:	0007c783          	lbu	a5,0(a5)
   11494:	00078713          	mv	a4,a5
   11498:	03900793          	li	a5,57
   1149c:	02e7ee63          	bltu	a5,a4,114d8 <vprintfmt+0x19c>
   114a0:	f5043783          	ld	a5,-176(s0)
   114a4:	f5040713          	addi	a4,s0,-176
   114a8:	00a00613          	li	a2,10
   114ac:	00070593          	mv	a1,a4
   114b0:	00078513          	mv	a0,a5
   114b4:	00000097          	auipc	ra,0x0
   114b8:	884080e7          	jalr	-1916(ra) # 10d38 <strtol>
   114bc:	00050793          	mv	a5,a0
   114c0:	0007879b          	sext.w	a5,a5
   114c4:	f8f42423          	sw	a5,-120(s0)
   114c8:	f5043783          	ld	a5,-176(s0)
   114cc:	fff78793          	addi	a5,a5,-1
   114d0:	f4f43823          	sd	a5,-176(s0)
   114d4:	6380006f          	j	11b0c <vprintfmt+0x7d0>
   114d8:	f5043783          	ld	a5,-176(s0)
   114dc:	0007c783          	lbu	a5,0(a5)
   114e0:	00078713          	mv	a4,a5
   114e4:	02e00793          	li	a5,46
   114e8:	06f71a63          	bne	a4,a5,1155c <vprintfmt+0x220>
   114ec:	f5043783          	ld	a5,-176(s0)
   114f0:	00178793          	addi	a5,a5,1
   114f4:	f4f43823          	sd	a5,-176(s0)
   114f8:	f5043783          	ld	a5,-176(s0)
   114fc:	0007c783          	lbu	a5,0(a5)
   11500:	00078713          	mv	a4,a5
   11504:	02a00793          	li	a5,42
   11508:	00f71e63          	bne	a4,a5,11524 <vprintfmt+0x1e8>
   1150c:	f4843783          	ld	a5,-184(s0)
   11510:	00878713          	addi	a4,a5,8
   11514:	f4e43423          	sd	a4,-184(s0)
   11518:	0007a783          	lw	a5,0(a5)
   1151c:	f8f42623          	sw	a5,-116(s0)
   11520:	5ec0006f          	j	11b0c <vprintfmt+0x7d0>
   11524:	f5043783          	ld	a5,-176(s0)
   11528:	f5040713          	addi	a4,s0,-176
   1152c:	00a00613          	li	a2,10
   11530:	00070593          	mv	a1,a4
   11534:	00078513          	mv	a0,a5
   11538:	00000097          	auipc	ra,0x0
   1153c:	800080e7          	jalr	-2048(ra) # 10d38 <strtol>
   11540:	00050793          	mv	a5,a0
   11544:	0007879b          	sext.w	a5,a5
   11548:	f8f42623          	sw	a5,-116(s0)
   1154c:	f5043783          	ld	a5,-176(s0)
   11550:	fff78793          	addi	a5,a5,-1
   11554:	f4f43823          	sd	a5,-176(s0)
   11558:	5b40006f          	j	11b0c <vprintfmt+0x7d0>
   1155c:	f5043783          	ld	a5,-176(s0)
   11560:	0007c783          	lbu	a5,0(a5)
   11564:	00078713          	mv	a4,a5
   11568:	07800793          	li	a5,120
   1156c:	02f70663          	beq	a4,a5,11598 <vprintfmt+0x25c>
   11570:	f5043783          	ld	a5,-176(s0)
   11574:	0007c783          	lbu	a5,0(a5)
   11578:	00078713          	mv	a4,a5
   1157c:	05800793          	li	a5,88
   11580:	00f70c63          	beq	a4,a5,11598 <vprintfmt+0x25c>
   11584:	f5043783          	ld	a5,-176(s0)
   11588:	0007c783          	lbu	a5,0(a5)
   1158c:	00078713          	mv	a4,a5
   11590:	07000793          	li	a5,112
   11594:	30f71263          	bne	a4,a5,11898 <vprintfmt+0x55c>
   11598:	f5043783          	ld	a5,-176(s0)
   1159c:	0007c783          	lbu	a5,0(a5)
   115a0:	00078713          	mv	a4,a5
   115a4:	07000793          	li	a5,112
   115a8:	00f70663          	beq	a4,a5,115b4 <vprintfmt+0x278>
   115ac:	f8144783          	lbu	a5,-127(s0)
   115b0:	00078663          	beqz	a5,115bc <vprintfmt+0x280>
   115b4:	00100793          	li	a5,1
   115b8:	0080006f          	j	115c0 <vprintfmt+0x284>
   115bc:	00000793          	li	a5,0
   115c0:	faf403a3          	sb	a5,-89(s0)
   115c4:	fa744783          	lbu	a5,-89(s0)
   115c8:	0017f793          	andi	a5,a5,1
   115cc:	faf403a3          	sb	a5,-89(s0)
   115d0:	fa744783          	lbu	a5,-89(s0)
   115d4:	0ff7f793          	zext.b	a5,a5
   115d8:	00078c63          	beqz	a5,115f0 <vprintfmt+0x2b4>
   115dc:	f4843783          	ld	a5,-184(s0)
   115e0:	00878713          	addi	a4,a5,8
   115e4:	f4e43423          	sd	a4,-184(s0)
   115e8:	0007b783          	ld	a5,0(a5)
   115ec:	01c0006f          	j	11608 <vprintfmt+0x2cc>
   115f0:	f4843783          	ld	a5,-184(s0)
   115f4:	00878713          	addi	a4,a5,8
   115f8:	f4e43423          	sd	a4,-184(s0)
   115fc:	0007a783          	lw	a5,0(a5)
   11600:	02079793          	slli	a5,a5,0x20
   11604:	0207d793          	srli	a5,a5,0x20
   11608:	fef43023          	sd	a5,-32(s0)
   1160c:	f8c42783          	lw	a5,-116(s0)
   11610:	02079463          	bnez	a5,11638 <vprintfmt+0x2fc>
   11614:	fe043783          	ld	a5,-32(s0)
   11618:	02079063          	bnez	a5,11638 <vprintfmt+0x2fc>
   1161c:	f5043783          	ld	a5,-176(s0)
   11620:	0007c783          	lbu	a5,0(a5)
   11624:	00078713          	mv	a4,a5
   11628:	07000793          	li	a5,112
   1162c:	00f70663          	beq	a4,a5,11638 <vprintfmt+0x2fc>
   11630:	f8040023          	sb	zero,-128(s0)
   11634:	4d80006f          	j	11b0c <vprintfmt+0x7d0>
   11638:	f5043783          	ld	a5,-176(s0)
   1163c:	0007c783          	lbu	a5,0(a5)
   11640:	00078713          	mv	a4,a5
   11644:	07000793          	li	a5,112
   11648:	00f70a63          	beq	a4,a5,1165c <vprintfmt+0x320>
   1164c:	f8244783          	lbu	a5,-126(s0)
   11650:	00078a63          	beqz	a5,11664 <vprintfmt+0x328>
   11654:	fe043783          	ld	a5,-32(s0)
   11658:	00078663          	beqz	a5,11664 <vprintfmt+0x328>
   1165c:	00100793          	li	a5,1
   11660:	0080006f          	j	11668 <vprintfmt+0x32c>
   11664:	00000793          	li	a5,0
   11668:	faf40323          	sb	a5,-90(s0)
   1166c:	fa644783          	lbu	a5,-90(s0)
   11670:	0017f793          	andi	a5,a5,1
   11674:	faf40323          	sb	a5,-90(s0)
   11678:	fc042e23          	sw	zero,-36(s0)
   1167c:	f5043783          	ld	a5,-176(s0)
   11680:	0007c783          	lbu	a5,0(a5)
   11684:	00078713          	mv	a4,a5
   11688:	05800793          	li	a5,88
   1168c:	00f71863          	bne	a4,a5,1169c <vprintfmt+0x360>
   11690:	00001797          	auipc	a5,0x1
   11694:	99078793          	addi	a5,a5,-1648 # 12020 <upperxdigits.1>
   11698:	00c0006f          	j	116a4 <vprintfmt+0x368>
   1169c:	00001797          	auipc	a5,0x1
   116a0:	99c78793          	addi	a5,a5,-1636 # 12038 <lowerxdigits.0>
   116a4:	f8f43c23          	sd	a5,-104(s0)
   116a8:	fe043783          	ld	a5,-32(s0)
   116ac:	00f7f793          	andi	a5,a5,15
   116b0:	f9843703          	ld	a4,-104(s0)
   116b4:	00f70733          	add	a4,a4,a5
   116b8:	fdc42783          	lw	a5,-36(s0)
   116bc:	0017869b          	addiw	a3,a5,1
   116c0:	fcd42e23          	sw	a3,-36(s0)
   116c4:	00074703          	lbu	a4,0(a4)
   116c8:	ff078793          	addi	a5,a5,-16
   116cc:	008787b3          	add	a5,a5,s0
   116d0:	f8e78023          	sb	a4,-128(a5)
   116d4:	fe043783          	ld	a5,-32(s0)
   116d8:	0047d793          	srli	a5,a5,0x4
   116dc:	fef43023          	sd	a5,-32(s0)
   116e0:	fe043783          	ld	a5,-32(s0)
   116e4:	fc0792e3          	bnez	a5,116a8 <vprintfmt+0x36c>
   116e8:	f8c42783          	lw	a5,-116(s0)
   116ec:	00078713          	mv	a4,a5
   116f0:	fff00793          	li	a5,-1
   116f4:	02f71663          	bne	a4,a5,11720 <vprintfmt+0x3e4>
   116f8:	f8344783          	lbu	a5,-125(s0)
   116fc:	02078263          	beqz	a5,11720 <vprintfmt+0x3e4>
   11700:	f8842703          	lw	a4,-120(s0)
   11704:	fa644783          	lbu	a5,-90(s0)
   11708:	0007879b          	sext.w	a5,a5
   1170c:	0017979b          	slliw	a5,a5,0x1
   11710:	0007879b          	sext.w	a5,a5
   11714:	40f707bb          	subw	a5,a4,a5
   11718:	0007879b          	sext.w	a5,a5
   1171c:	f8f42623          	sw	a5,-116(s0)
   11720:	f8842703          	lw	a4,-120(s0)
   11724:	fa644783          	lbu	a5,-90(s0)
   11728:	0007879b          	sext.w	a5,a5
   1172c:	0017979b          	slliw	a5,a5,0x1
   11730:	0007879b          	sext.w	a5,a5
   11734:	40f707bb          	subw	a5,a4,a5
   11738:	0007871b          	sext.w	a4,a5
   1173c:	fdc42783          	lw	a5,-36(s0)
   11740:	f8f42a23          	sw	a5,-108(s0)
   11744:	f8c42783          	lw	a5,-116(s0)
   11748:	f8f42823          	sw	a5,-112(s0)
   1174c:	f9442783          	lw	a5,-108(s0)
   11750:	00078593          	mv	a1,a5
   11754:	f9042783          	lw	a5,-112(s0)
   11758:	00078613          	mv	a2,a5
   1175c:	0006069b          	sext.w	a3,a2
   11760:	0005879b          	sext.w	a5,a1
   11764:	00f6d463          	bge	a3,a5,1176c <vprintfmt+0x430>
   11768:	00058613          	mv	a2,a1
   1176c:	0006079b          	sext.w	a5,a2
   11770:	40f707bb          	subw	a5,a4,a5
   11774:	fcf42c23          	sw	a5,-40(s0)
   11778:	0280006f          	j	117a0 <vprintfmt+0x464>
   1177c:	f5843783          	ld	a5,-168(s0)
   11780:	02000513          	li	a0,32
   11784:	000780e7          	jalr	a5
   11788:	fec42783          	lw	a5,-20(s0)
   1178c:	0017879b          	addiw	a5,a5,1
   11790:	fef42623          	sw	a5,-20(s0)
   11794:	fd842783          	lw	a5,-40(s0)
   11798:	fff7879b          	addiw	a5,a5,-1
   1179c:	fcf42c23          	sw	a5,-40(s0)
   117a0:	fd842783          	lw	a5,-40(s0)
   117a4:	0007879b          	sext.w	a5,a5
   117a8:	fcf04ae3          	bgtz	a5,1177c <vprintfmt+0x440>
   117ac:	fa644783          	lbu	a5,-90(s0)
   117b0:	0ff7f793          	zext.b	a5,a5
   117b4:	04078463          	beqz	a5,117fc <vprintfmt+0x4c0>
   117b8:	f5843783          	ld	a5,-168(s0)
   117bc:	03000513          	li	a0,48
   117c0:	000780e7          	jalr	a5
   117c4:	f5043783          	ld	a5,-176(s0)
   117c8:	0007c783          	lbu	a5,0(a5)
   117cc:	00078713          	mv	a4,a5
   117d0:	05800793          	li	a5,88
   117d4:	00f71663          	bne	a4,a5,117e0 <vprintfmt+0x4a4>
   117d8:	05800793          	li	a5,88
   117dc:	0080006f          	j	117e4 <vprintfmt+0x4a8>
   117e0:	07800793          	li	a5,120
   117e4:	f5843703          	ld	a4,-168(s0)
   117e8:	00078513          	mv	a0,a5
   117ec:	000700e7          	jalr	a4
   117f0:	fec42783          	lw	a5,-20(s0)
   117f4:	0027879b          	addiw	a5,a5,2
   117f8:	fef42623          	sw	a5,-20(s0)
   117fc:	fdc42783          	lw	a5,-36(s0)
   11800:	fcf42a23          	sw	a5,-44(s0)
   11804:	0280006f          	j	1182c <vprintfmt+0x4f0>
   11808:	f5843783          	ld	a5,-168(s0)
   1180c:	03000513          	li	a0,48
   11810:	000780e7          	jalr	a5
   11814:	fec42783          	lw	a5,-20(s0)
   11818:	0017879b          	addiw	a5,a5,1
   1181c:	fef42623          	sw	a5,-20(s0)
   11820:	fd442783          	lw	a5,-44(s0)
   11824:	0017879b          	addiw	a5,a5,1
   11828:	fcf42a23          	sw	a5,-44(s0)
   1182c:	f8c42703          	lw	a4,-116(s0)
   11830:	fd442783          	lw	a5,-44(s0)
   11834:	0007879b          	sext.w	a5,a5
   11838:	fce7c8e3          	blt	a5,a4,11808 <vprintfmt+0x4cc>
   1183c:	fdc42783          	lw	a5,-36(s0)
   11840:	fff7879b          	addiw	a5,a5,-1
   11844:	fcf42823          	sw	a5,-48(s0)
   11848:	03c0006f          	j	11884 <vprintfmt+0x548>
   1184c:	fd042783          	lw	a5,-48(s0)
   11850:	ff078793          	addi	a5,a5,-16
   11854:	008787b3          	add	a5,a5,s0
   11858:	f807c783          	lbu	a5,-128(a5)
   1185c:	0007871b          	sext.w	a4,a5
   11860:	f5843783          	ld	a5,-168(s0)
   11864:	00070513          	mv	a0,a4
   11868:	000780e7          	jalr	a5
   1186c:	fec42783          	lw	a5,-20(s0)
   11870:	0017879b          	addiw	a5,a5,1
   11874:	fef42623          	sw	a5,-20(s0)
   11878:	fd042783          	lw	a5,-48(s0)
   1187c:	fff7879b          	addiw	a5,a5,-1
   11880:	fcf42823          	sw	a5,-48(s0)
   11884:	fd042783          	lw	a5,-48(s0)
   11888:	0007879b          	sext.w	a5,a5
   1188c:	fc07d0e3          	bgez	a5,1184c <vprintfmt+0x510>
   11890:	f8040023          	sb	zero,-128(s0)
   11894:	2780006f          	j	11b0c <vprintfmt+0x7d0>
   11898:	f5043783          	ld	a5,-176(s0)
   1189c:	0007c783          	lbu	a5,0(a5)
   118a0:	00078713          	mv	a4,a5
   118a4:	06400793          	li	a5,100
   118a8:	02f70663          	beq	a4,a5,118d4 <vprintfmt+0x598>
   118ac:	f5043783          	ld	a5,-176(s0)
   118b0:	0007c783          	lbu	a5,0(a5)
   118b4:	00078713          	mv	a4,a5
   118b8:	06900793          	li	a5,105
   118bc:	00f70c63          	beq	a4,a5,118d4 <vprintfmt+0x598>
   118c0:	f5043783          	ld	a5,-176(s0)
   118c4:	0007c783          	lbu	a5,0(a5)
   118c8:	00078713          	mv	a4,a5
   118cc:	07500793          	li	a5,117
   118d0:	08f71263          	bne	a4,a5,11954 <vprintfmt+0x618>
   118d4:	f8144783          	lbu	a5,-127(s0)
   118d8:	00078c63          	beqz	a5,118f0 <vprintfmt+0x5b4>
   118dc:	f4843783          	ld	a5,-184(s0)
   118e0:	00878713          	addi	a4,a5,8
   118e4:	f4e43423          	sd	a4,-184(s0)
   118e8:	0007b783          	ld	a5,0(a5)
   118ec:	0140006f          	j	11900 <vprintfmt+0x5c4>
   118f0:	f4843783          	ld	a5,-184(s0)
   118f4:	00878713          	addi	a4,a5,8
   118f8:	f4e43423          	sd	a4,-184(s0)
   118fc:	0007a783          	lw	a5,0(a5)
   11900:	faf43423          	sd	a5,-88(s0)
   11904:	fa843583          	ld	a1,-88(s0)
   11908:	f5043783          	ld	a5,-176(s0)
   1190c:	0007c783          	lbu	a5,0(a5)
   11910:	0007871b          	sext.w	a4,a5
   11914:	07500793          	li	a5,117
   11918:	40f707b3          	sub	a5,a4,a5
   1191c:	00f037b3          	snez	a5,a5
   11920:	0ff7f793          	zext.b	a5,a5
   11924:	f8040713          	addi	a4,s0,-128
   11928:	00070693          	mv	a3,a4
   1192c:	00078613          	mv	a2,a5
   11930:	f5843503          	ld	a0,-168(s0)
   11934:	fffff097          	auipc	ra,0xfffff
   11938:	6fc080e7          	jalr	1788(ra) # 11030 <print_dec_int>
   1193c:	00050793          	mv	a5,a0
   11940:	fec42703          	lw	a4,-20(s0)
   11944:	00f707bb          	addw	a5,a4,a5
   11948:	fef42623          	sw	a5,-20(s0)
   1194c:	f8040023          	sb	zero,-128(s0)
   11950:	1bc0006f          	j	11b0c <vprintfmt+0x7d0>
   11954:	f5043783          	ld	a5,-176(s0)
   11958:	0007c783          	lbu	a5,0(a5)
   1195c:	00078713          	mv	a4,a5
   11960:	06e00793          	li	a5,110
   11964:	04f71c63          	bne	a4,a5,119bc <vprintfmt+0x680>
   11968:	f8144783          	lbu	a5,-127(s0)
   1196c:	02078463          	beqz	a5,11994 <vprintfmt+0x658>
   11970:	f4843783          	ld	a5,-184(s0)
   11974:	00878713          	addi	a4,a5,8
   11978:	f4e43423          	sd	a4,-184(s0)
   1197c:	0007b783          	ld	a5,0(a5)
   11980:	faf43823          	sd	a5,-80(s0)
   11984:	fec42703          	lw	a4,-20(s0)
   11988:	fb043783          	ld	a5,-80(s0)
   1198c:	00e7b023          	sd	a4,0(a5)
   11990:	0240006f          	j	119b4 <vprintfmt+0x678>
   11994:	f4843783          	ld	a5,-184(s0)
   11998:	00878713          	addi	a4,a5,8
   1199c:	f4e43423          	sd	a4,-184(s0)
   119a0:	0007b783          	ld	a5,0(a5)
   119a4:	faf43c23          	sd	a5,-72(s0)
   119a8:	fb843783          	ld	a5,-72(s0)
   119ac:	fec42703          	lw	a4,-20(s0)
   119b0:	00e7a023          	sw	a4,0(a5)
   119b4:	f8040023          	sb	zero,-128(s0)
   119b8:	1540006f          	j	11b0c <vprintfmt+0x7d0>
   119bc:	f5043783          	ld	a5,-176(s0)
   119c0:	0007c783          	lbu	a5,0(a5)
   119c4:	00078713          	mv	a4,a5
   119c8:	07300793          	li	a5,115
   119cc:	04f71063          	bne	a4,a5,11a0c <vprintfmt+0x6d0>
   119d0:	f4843783          	ld	a5,-184(s0)
   119d4:	00878713          	addi	a4,a5,8
   119d8:	f4e43423          	sd	a4,-184(s0)
   119dc:	0007b783          	ld	a5,0(a5)
   119e0:	fcf43023          	sd	a5,-64(s0)
   119e4:	fc043583          	ld	a1,-64(s0)
   119e8:	f5843503          	ld	a0,-168(s0)
   119ec:	fffff097          	auipc	ra,0xfffff
   119f0:	5bc080e7          	jalr	1468(ra) # 10fa8 <puts_wo_nl>
   119f4:	00050793          	mv	a5,a0
   119f8:	fec42703          	lw	a4,-20(s0)
   119fc:	00f707bb          	addw	a5,a4,a5
   11a00:	fef42623          	sw	a5,-20(s0)
   11a04:	f8040023          	sb	zero,-128(s0)
   11a08:	1040006f          	j	11b0c <vprintfmt+0x7d0>
   11a0c:	f5043783          	ld	a5,-176(s0)
   11a10:	0007c783          	lbu	a5,0(a5)
   11a14:	00078713          	mv	a4,a5
   11a18:	06300793          	li	a5,99
   11a1c:	02f71e63          	bne	a4,a5,11a58 <vprintfmt+0x71c>
   11a20:	f4843783          	ld	a5,-184(s0)
   11a24:	00878713          	addi	a4,a5,8
   11a28:	f4e43423          	sd	a4,-184(s0)
   11a2c:	0007a783          	lw	a5,0(a5)
   11a30:	fcf42623          	sw	a5,-52(s0)
   11a34:	fcc42703          	lw	a4,-52(s0)
   11a38:	f5843783          	ld	a5,-168(s0)
   11a3c:	00070513          	mv	a0,a4
   11a40:	000780e7          	jalr	a5
   11a44:	fec42783          	lw	a5,-20(s0)
   11a48:	0017879b          	addiw	a5,a5,1
   11a4c:	fef42623          	sw	a5,-20(s0)
   11a50:	f8040023          	sb	zero,-128(s0)
   11a54:	0b80006f          	j	11b0c <vprintfmt+0x7d0>
   11a58:	f5043783          	ld	a5,-176(s0)
   11a5c:	0007c783          	lbu	a5,0(a5)
   11a60:	00078713          	mv	a4,a5
   11a64:	02500793          	li	a5,37
   11a68:	02f71263          	bne	a4,a5,11a8c <vprintfmt+0x750>
   11a6c:	f5843783          	ld	a5,-168(s0)
   11a70:	02500513          	li	a0,37
   11a74:	000780e7          	jalr	a5
   11a78:	fec42783          	lw	a5,-20(s0)
   11a7c:	0017879b          	addiw	a5,a5,1
   11a80:	fef42623          	sw	a5,-20(s0)
   11a84:	f8040023          	sb	zero,-128(s0)
   11a88:	0840006f          	j	11b0c <vprintfmt+0x7d0>
   11a8c:	f5043783          	ld	a5,-176(s0)
   11a90:	0007c783          	lbu	a5,0(a5)
   11a94:	0007871b          	sext.w	a4,a5
   11a98:	f5843783          	ld	a5,-168(s0)
   11a9c:	00070513          	mv	a0,a4
   11aa0:	000780e7          	jalr	a5
   11aa4:	fec42783          	lw	a5,-20(s0)
   11aa8:	0017879b          	addiw	a5,a5,1
   11aac:	fef42623          	sw	a5,-20(s0)
   11ab0:	f8040023          	sb	zero,-128(s0)
   11ab4:	0580006f          	j	11b0c <vprintfmt+0x7d0>
   11ab8:	f5043783          	ld	a5,-176(s0)
   11abc:	0007c783          	lbu	a5,0(a5)
   11ac0:	00078713          	mv	a4,a5
   11ac4:	02500793          	li	a5,37
   11ac8:	02f71063          	bne	a4,a5,11ae8 <vprintfmt+0x7ac>
   11acc:	f8043023          	sd	zero,-128(s0)
   11ad0:	f8043423          	sd	zero,-120(s0)
   11ad4:	00100793          	li	a5,1
   11ad8:	f8f40023          	sb	a5,-128(s0)
   11adc:	fff00793          	li	a5,-1
   11ae0:	f8f42623          	sw	a5,-116(s0)
   11ae4:	0280006f          	j	11b0c <vprintfmt+0x7d0>
   11ae8:	f5043783          	ld	a5,-176(s0)
   11aec:	0007c783          	lbu	a5,0(a5)
   11af0:	0007871b          	sext.w	a4,a5
   11af4:	f5843783          	ld	a5,-168(s0)
   11af8:	00070513          	mv	a0,a4
   11afc:	000780e7          	jalr	a5
   11b00:	fec42783          	lw	a5,-20(s0)
   11b04:	0017879b          	addiw	a5,a5,1
   11b08:	fef42623          	sw	a5,-20(s0)
   11b0c:	f5043783          	ld	a5,-176(s0)
   11b10:	00178793          	addi	a5,a5,1
   11b14:	f4f43823          	sd	a5,-176(s0)
   11b18:	f5043783          	ld	a5,-176(s0)
   11b1c:	0007c783          	lbu	a5,0(a5)
   11b20:	840794e3          	bnez	a5,11368 <vprintfmt+0x2c>
   11b24:	fec42783          	lw	a5,-20(s0)
   11b28:	00078513          	mv	a0,a5
   11b2c:	0b813083          	ld	ra,184(sp)
   11b30:	0b013403          	ld	s0,176(sp)
   11b34:	0c010113          	addi	sp,sp,192
   11b38:	00008067          	ret

0000000000011b3c <printf>:
   11b3c:	f8010113          	addi	sp,sp,-128
   11b40:	02113c23          	sd	ra,56(sp)
   11b44:	02813823          	sd	s0,48(sp)
   11b48:	04010413          	addi	s0,sp,64
   11b4c:	fca43423          	sd	a0,-56(s0)
   11b50:	00b43423          	sd	a1,8(s0)
   11b54:	00c43823          	sd	a2,16(s0)
   11b58:	00d43c23          	sd	a3,24(s0)
   11b5c:	02e43023          	sd	a4,32(s0)
   11b60:	02f43423          	sd	a5,40(s0)
   11b64:	03043823          	sd	a6,48(s0)
   11b68:	03143c23          	sd	a7,56(s0)
   11b6c:	fe042623          	sw	zero,-20(s0)
   11b70:	04040793          	addi	a5,s0,64
   11b74:	fcf43023          	sd	a5,-64(s0)
   11b78:	fc043783          	ld	a5,-64(s0)
   11b7c:	fc878793          	addi	a5,a5,-56
   11b80:	fcf43823          	sd	a5,-48(s0)
   11b84:	fd043783          	ld	a5,-48(s0)
   11b88:	00078613          	mv	a2,a5
   11b8c:	fc843583          	ld	a1,-56(s0)
   11b90:	fffff517          	auipc	a0,0xfffff
   11b94:	0e050513          	addi	a0,a0,224 # 10c70 <putc>
   11b98:	fffff097          	auipc	ra,0xfffff
   11b9c:	7a4080e7          	jalr	1956(ra) # 1133c <vprintfmt>
   11ba0:	00050793          	mv	a5,a0
   11ba4:	fef42623          	sw	a5,-20(s0)
   11ba8:	00100793          	li	a5,1
   11bac:	fef43023          	sd	a5,-32(s0)
   11bb0:	00002797          	auipc	a5,0x2
   11bb4:	45878793          	addi	a5,a5,1112 # 14008 <tail>
   11bb8:	0007a783          	lw	a5,0(a5)
   11bbc:	0017871b          	addiw	a4,a5,1
   11bc0:	0007069b          	sext.w	a3,a4
   11bc4:	00002717          	auipc	a4,0x2
   11bc8:	44470713          	addi	a4,a4,1092 # 14008 <tail>
   11bcc:	00d72023          	sw	a3,0(a4)
   11bd0:	00002717          	auipc	a4,0x2
   11bd4:	44070713          	addi	a4,a4,1088 # 14010 <buffer>
   11bd8:	00f707b3          	add	a5,a4,a5
   11bdc:	00078023          	sb	zero,0(a5)
   11be0:	00002797          	auipc	a5,0x2
   11be4:	42878793          	addi	a5,a5,1064 # 14008 <tail>
   11be8:	0007a603          	lw	a2,0(a5)
   11bec:	fe043703          	ld	a4,-32(s0)
   11bf0:	00002697          	auipc	a3,0x2
   11bf4:	42068693          	addi	a3,a3,1056 # 14010 <buffer>
   11bf8:	fd843783          	ld	a5,-40(s0)
   11bfc:	04000893          	li	a7,64
   11c00:	00070513          	mv	a0,a4
   11c04:	00068593          	mv	a1,a3
   11c08:	00060613          	mv	a2,a2
   11c0c:	00000073          	ecall
   11c10:	00050793          	mv	a5,a0
   11c14:	fcf43c23          	sd	a5,-40(s0)
   11c18:	00002797          	auipc	a5,0x2
   11c1c:	3f078793          	addi	a5,a5,1008 # 14008 <tail>
   11c20:	0007a023          	sw	zero,0(a5)
   11c24:	fec42783          	lw	a5,-20(s0)
   11c28:	00078513          	mv	a0,a5
   11c2c:	03813083          	ld	ra,56(sp)
   11c30:	03013403          	ld	s0,48(sp)
   11c34:	08010113          	addi	sp,sp,128
   11c38:	00008067          	ret

0000000000011c3c <strlen>:
   11c3c:	fd010113          	addi	sp,sp,-48
   11c40:	02813423          	sd	s0,40(sp)
   11c44:	03010413          	addi	s0,sp,48
   11c48:	fca43c23          	sd	a0,-40(s0)
   11c4c:	fe042623          	sw	zero,-20(s0)
   11c50:	0100006f          	j	11c60 <strlen+0x24>
   11c54:	fec42783          	lw	a5,-20(s0)
   11c58:	0017879b          	addiw	a5,a5,1
   11c5c:	fef42623          	sw	a5,-20(s0)
   11c60:	fd843783          	ld	a5,-40(s0)
   11c64:	00178713          	addi	a4,a5,1
   11c68:	fce43c23          	sd	a4,-40(s0)
   11c6c:	0007c783          	lbu	a5,0(a5)
   11c70:	fe0792e3          	bnez	a5,11c54 <strlen+0x18>
   11c74:	fec42783          	lw	a5,-20(s0)
   11c78:	00078513          	mv	a0,a5
   11c7c:	02813403          	ld	s0,40(sp)
   11c80:	03010113          	addi	sp,sp,48
   11c84:	00008067          	ret

0000000000011c88 <write>:
   11c88:	fb010113          	addi	sp,sp,-80
   11c8c:	04813423          	sd	s0,72(sp)
   11c90:	05010413          	addi	s0,sp,80
   11c94:	00050693          	mv	a3,a0
   11c98:	fcb43023          	sd	a1,-64(s0)
   11c9c:	fac43c23          	sd	a2,-72(s0)
   11ca0:	fcd42623          	sw	a3,-52(s0)
   11ca4:	00010693          	mv	a3,sp
   11ca8:	00068593          	mv	a1,a3
   11cac:	fb843683          	ld	a3,-72(s0)
   11cb0:	00168693          	addi	a3,a3,1
   11cb4:	00068613          	mv	a2,a3
   11cb8:	fff60613          	addi	a2,a2,-1
   11cbc:	fec43023          	sd	a2,-32(s0)
   11cc0:	00068e13          	mv	t3,a3
   11cc4:	00000e93          	li	t4,0
   11cc8:	03de5613          	srli	a2,t3,0x3d
   11ccc:	003e9893          	slli	a7,t4,0x3
   11cd0:	011668b3          	or	a7,a2,a7
   11cd4:	003e1813          	slli	a6,t3,0x3
   11cd8:	00068313          	mv	t1,a3
   11cdc:	00000393          	li	t2,0
   11ce0:	03d35613          	srli	a2,t1,0x3d
   11ce4:	00339793          	slli	a5,t2,0x3
   11ce8:	00f667b3          	or	a5,a2,a5
   11cec:	00331713          	slli	a4,t1,0x3
   11cf0:	00f68793          	addi	a5,a3,15
   11cf4:	0047d793          	srli	a5,a5,0x4
   11cf8:	00479793          	slli	a5,a5,0x4
   11cfc:	40f10133          	sub	sp,sp,a5
   11d00:	00010793          	mv	a5,sp
   11d04:	00078793          	mv	a5,a5
   11d08:	fcf43c23          	sd	a5,-40(s0)
   11d0c:	fe042623          	sw	zero,-20(s0)
   11d10:	0300006f          	j	11d40 <write+0xb8>
   11d14:	fec42783          	lw	a5,-20(s0)
   11d18:	fc043703          	ld	a4,-64(s0)
   11d1c:	00f707b3          	add	a5,a4,a5
   11d20:	0007c703          	lbu	a4,0(a5)
   11d24:	fd843683          	ld	a3,-40(s0)
   11d28:	fec42783          	lw	a5,-20(s0)
   11d2c:	00f687b3          	add	a5,a3,a5
   11d30:	00e78023          	sb	a4,0(a5)
   11d34:	fec42783          	lw	a5,-20(s0)
   11d38:	0017879b          	addiw	a5,a5,1
   11d3c:	fef42623          	sw	a5,-20(s0)
   11d40:	fec42783          	lw	a5,-20(s0)
   11d44:	fb843703          	ld	a4,-72(s0)
   11d48:	fce7e6e3          	bltu	a5,a4,11d14 <write+0x8c>
   11d4c:	fd843703          	ld	a4,-40(s0)
   11d50:	fb843783          	ld	a5,-72(s0)
   11d54:	00f707b3          	add	a5,a4,a5
   11d58:	00078023          	sb	zero,0(a5)
   11d5c:	fcc42703          	lw	a4,-52(s0)
   11d60:	fd843683          	ld	a3,-40(s0)
   11d64:	fb843603          	ld	a2,-72(s0)
   11d68:	fd043783          	ld	a5,-48(s0)
   11d6c:	04000893          	li	a7,64
   11d70:	00070513          	mv	a0,a4
   11d74:	00068593          	mv	a1,a3
   11d78:	00060613          	mv	a2,a2
   11d7c:	00000073          	ecall
   11d80:	00050793          	mv	a5,a0
   11d84:	fcf43823          	sd	a5,-48(s0)
   11d88:	fd043783          	ld	a5,-48(s0)
   11d8c:	0007879b          	sext.w	a5,a5
   11d90:	00058113          	mv	sp,a1
   11d94:	00078513          	mv	a0,a5
   11d98:	fb040113          	addi	sp,s0,-80
   11d9c:	04813403          	ld	s0,72(sp)
   11da0:	05010113          	addi	sp,sp,80
   11da4:	00008067          	ret

0000000000011da8 <read>:
   11da8:	fc010113          	addi	sp,sp,-64
   11dac:	02813c23          	sd	s0,56(sp)
   11db0:	04010413          	addi	s0,sp,64
   11db4:	00050793          	mv	a5,a0
   11db8:	fcb43823          	sd	a1,-48(s0)
   11dbc:	fcc43423          	sd	a2,-56(s0)
   11dc0:	fcf42e23          	sw	a5,-36(s0)
   11dc4:	fdc42703          	lw	a4,-36(s0)
   11dc8:	fd043683          	ld	a3,-48(s0)
   11dcc:	fc843603          	ld	a2,-56(s0)
   11dd0:	fe843783          	ld	a5,-24(s0)
   11dd4:	03f00893          	li	a7,63
   11dd8:	00070513          	mv	a0,a4
   11ddc:	00068593          	mv	a1,a3
   11de0:	00060613          	mv	a2,a2
   11de4:	00000073          	ecall
   11de8:	00050793          	mv	a5,a0
   11dec:	fef43423          	sd	a5,-24(s0)
   11df0:	fe843783          	ld	a5,-24(s0)
   11df4:	0007879b          	sext.w	a5,a5
   11df8:	00078513          	mv	a0,a5
   11dfc:	03813403          	ld	s0,56(sp)
   11e00:	04010113          	addi	sp,sp,64
   11e04:	00008067          	ret

0000000000011e08 <sys_openat>:
   11e08:	fd010113          	addi	sp,sp,-48
   11e0c:	02813423          	sd	s0,40(sp)
   11e10:	03010413          	addi	s0,sp,48
   11e14:	00050793          	mv	a5,a0
   11e18:	fcb43823          	sd	a1,-48(s0)
   11e1c:	00060713          	mv	a4,a2
   11e20:	fcf42e23          	sw	a5,-36(s0)
   11e24:	00070793          	mv	a5,a4
   11e28:	fcf42c23          	sw	a5,-40(s0)
   11e2c:	fdc42703          	lw	a4,-36(s0)
   11e30:	fd842603          	lw	a2,-40(s0)
   11e34:	fd043683          	ld	a3,-48(s0)
   11e38:	fe843783          	ld	a5,-24(s0)
   11e3c:	04000893          	li	a7,64
   11e40:	00070513          	mv	a0,a4
   11e44:	00068593          	mv	a1,a3
   11e48:	00060613          	mv	a2,a2
   11e4c:	00000073          	ecall
   11e50:	00050793          	mv	a5,a0
   11e54:	fef43423          	sd	a5,-24(s0)
   11e58:	fe843783          	ld	a5,-24(s0)
   11e5c:	0007879b          	sext.w	a5,a5
   11e60:	00078513          	mv	a0,a5
   11e64:	02813403          	ld	s0,40(sp)
   11e68:	03010113          	addi	sp,sp,48
   11e6c:	00008067          	ret

0000000000011e70 <open>:
   11e70:	fe010113          	addi	sp,sp,-32
   11e74:	00113c23          	sd	ra,24(sp)
   11e78:	00813823          	sd	s0,16(sp)
   11e7c:	02010413          	addi	s0,sp,32
   11e80:	fea43423          	sd	a0,-24(s0)
   11e84:	00058793          	mv	a5,a1
   11e88:	fef42223          	sw	a5,-28(s0)
   11e8c:	fe442783          	lw	a5,-28(s0)
   11e90:	00078613          	mv	a2,a5
   11e94:	fe843583          	ld	a1,-24(s0)
   11e98:	f9c00513          	li	a0,-100
   11e9c:	00000097          	auipc	ra,0x0
   11ea0:	f6c080e7          	jalr	-148(ra) # 11e08 <sys_openat>
   11ea4:	00050793          	mv	a5,a0
   11ea8:	00078513          	mv	a0,a5
   11eac:	01813083          	ld	ra,24(sp)
   11eb0:	01013403          	ld	s0,16(sp)
   11eb4:	02010113          	addi	sp,sp,32
   11eb8:	00008067          	ret

0000000000011ebc <close>:
   11ebc:	fd010113          	addi	sp,sp,-48
   11ec0:	02813423          	sd	s0,40(sp)
   11ec4:	03010413          	addi	s0,sp,48
   11ec8:	00050793          	mv	a5,a0
   11ecc:	fcf42e23          	sw	a5,-36(s0)
   11ed0:	fdc42703          	lw	a4,-36(s0)
   11ed4:	fe843783          	ld	a5,-24(s0)
   11ed8:	04000893          	li	a7,64
   11edc:	00070513          	mv	a0,a4
   11ee0:	00000073          	ecall
   11ee4:	00050793          	mv	a5,a0
   11ee8:	fef43423          	sd	a5,-24(s0)
   11eec:	fe843783          	ld	a5,-24(s0)
   11ef0:	0007879b          	sext.w	a5,a5
   11ef4:	00078513          	mv	a0,a5
   11ef8:	02813403          	ld	s0,40(sp)
   11efc:	03010113          	addi	sp,sp,48
   11f00:	00008067          	ret

0000000000011f04 <lseek>:
   11f04:	fd010113          	addi	sp,sp,-48
   11f08:	02813423          	sd	s0,40(sp)
   11f0c:	03010413          	addi	s0,sp,48
   11f10:	00050793          	mv	a5,a0
   11f14:	00058693          	mv	a3,a1
   11f18:	00060713          	mv	a4,a2
   11f1c:	fcf42e23          	sw	a5,-36(s0)
   11f20:	00068793          	mv	a5,a3
   11f24:	fcf42c23          	sw	a5,-40(s0)
   11f28:	00070793          	mv	a5,a4
   11f2c:	fcf42a23          	sw	a5,-44(s0)
   11f30:	fdc42703          	lw	a4,-36(s0)
   11f34:	fd842683          	lw	a3,-40(s0)
   11f38:	fd442603          	lw	a2,-44(s0)
   11f3c:	fe843783          	ld	a5,-24(s0)
   11f40:	0ac00893          	li	a7,172
   11f44:	00070513          	mv	a0,a4
   11f48:	00068593          	mv	a1,a3
   11f4c:	00060613          	mv	a2,a2
   11f50:	00000073          	ecall
   11f54:	00050793          	mv	a5,a0
   11f58:	fef43423          	sd	a5,-24(s0)
   11f5c:	fe843783          	ld	a5,-24(s0)
   11f60:	0007879b          	sext.w	a5,a5
   11f64:	00078513          	mv	a0,a5
   11f68:	02813403          	ld	s0,40(sp)
   11f6c:	03010113          	addi	sp,sp,48
   11f70:	00008067          	ret
