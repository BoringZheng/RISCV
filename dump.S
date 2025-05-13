
kernel.elf:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_start>:
    80000000:	00002117          	auipc	sp,0x2
    80000004:	ab010113          	addi	sp,sp,-1360 # 80001ab0 <procs>
    80000008:	008000ef          	jal	ra,80000010 <main>
    8000000c:	0000006f          	jal	zero,8000000c <_start+0xc>

0000000080000010 <main>:
    80000010:	ff010113          	addi	sp,sp,-16
    80000014:	00113423          	sd	ra,8(sp)
    80000018:	020000ef          	jal	ra,80000038 <paging_init>
    8000001c:	25c000ef          	jal	ra,80000278 <trap_init>
    80000020:	268000ef          	jal	ra,80000288 <timer_init>
    80000024:	11c000ef          	jal	ra,80000140 <proc_init>
    80000028:	1c8000ef          	jal	ra,800001f0 <scheduler>
    8000002c:	00813083          	ld	ra,8(sp)
    80000030:	01010113          	addi	sp,sp,16
    80000034:	00008067          	jalr	zero,0(ra)

0000000080000038 <paging_init>:
    80000038:	ff010113          	addi	sp,sp,-16
    8000003c:	00113423          	sd	ra,8(sp)
    80000040:	00813023          	sd	s0,0(sp)
    80000044:	3b0000ef          	jal	ra,800003f4 <alloc_page>
    80000048:	00050413          	addi	s0,a0,0
    8000004c:	00050793          	addi	a5,a0,0
    80000050:	00001737          	lui	a4,0x1
    80000054:	00e50733          	add	a4,a0,a4
    80000058:	0007b023          	sd	zero,0(a5)
    8000005c:	00878793          	addi	a5,a5,8
    80000060:	fee79ce3          	bne	a5,a4,80000058 <paging_init+0x20>
    80000064:	01a00693          	addi	a3,zero,26
    80000068:	00100613          	addi	a2,zero,1
    8000006c:	01f61613          	slli	a2,a2,0x1f
    80000070:	00060593          	addi	a1,a2,0
    80000074:	00040513          	addi	a0,s0,0
    80000078:	3fc000ef          	jal	ra,80000474 <map_page>
    8000007c:	00040513          	addi	a0,s0,0
    80000080:	4e4000ef          	jal	ra,80000564 <switch_pagetable>
    80000084:	18002473          	csrrs	s0,satp,zero
    80000088:	00001517          	auipc	a0,0x1
    8000008c:	95850513          	addi	a0,a0,-1704 # 800009e0 <switch_context+0x304>
    80000090:	2fc000ef          	jal	ra,8000038c <puts>
    80000094:	00040513          	addi	a0,s0,0
    80000098:	314000ef          	jal	ra,800003ac <print_hex>
    8000009c:	00a00513          	addi	a0,zero,10
    800000a0:	2e0000ef          	jal	ra,80000380 <putchar>
    800000a4:	00813083          	ld	ra,8(sp)
    800000a8:	00013403          	ld	s0,0(sp)
    800000ac:	01010113          	addi	sp,sp,16
    800000b0:	00008067          	jalr	zero,0(ra)

00000000800000b4 <proc0_run>:
    800000b4:	10500073          	wfi
    800000b8:	ffdff06f          	jal	zero,800000b4 <proc0_run>

00000000800000bc <proc_a_entry>:
    800000bc:	ff010113          	addi	sp,sp,-16
    800000c0:	00113423          	sd	ra,8(sp)
    800000c4:	034000ef          	jal	ra,800000f8 <process_a>
    800000c8:	10500073          	wfi
    800000cc:	ffdff06f          	jal	zero,800000c8 <proc_a_entry+0xc>

00000000800000d0 <proc_b_entry>:
    800000d0:	ff010113          	addi	sp,sp,-16
    800000d4:	00113423          	sd	ra,8(sp)
    800000d8:	044000ef          	jal	ra,8000011c <process_b>
    800000dc:	10500073          	wfi
    800000e0:	ffdff06f          	jal	zero,800000dc <proc_b_entry+0xc>

00000000800000e4 <scheduler_entry>:
    800000e4:	ff010113          	addi	sp,sp,-16
    800000e8:	00113423          	sd	ra,8(sp)
    800000ec:	104000ef          	jal	ra,800001f0 <scheduler>
    800000f0:	10500073          	wfi
    800000f4:	ffdff06f          	jal	zero,800000f0 <scheduler_entry+0xc>

00000000800000f8 <process_a>:
    800000f8:	ff010113          	addi	sp,sp,-16
    800000fc:	00113423          	sd	ra,8(sp)
    80000100:	00813023          	sd	s0,0(sp)
    80000104:	00001417          	auipc	s0,0x1
    80000108:	8ec40413          	addi	s0,s0,-1812 # 800009f0 <switch_context+0x314>
    8000010c:	00040513          	addi	a0,s0,0
    80000110:	27c000ef          	jal	ra,8000038c <puts>
    80000114:	00000073          	ecall
    80000118:	ff5ff06f          	jal	zero,8000010c <process_a+0x14>

000000008000011c <process_b>:
    8000011c:	ff010113          	addi	sp,sp,-16
    80000120:	00113423          	sd	ra,8(sp)
    80000124:	00813023          	sd	s0,0(sp)
    80000128:	00001417          	auipc	s0,0x1
    8000012c:	8d040413          	addi	s0,s0,-1840 # 800009f8 <switch_context+0x31c>
    80000130:	00040513          	addi	a0,s0,0
    80000134:	258000ef          	jal	ra,8000038c <puts>
    80000138:	00000073          	ecall
    8000013c:	ff5ff06f          	jal	zero,80000130 <process_b+0x14>

0000000080000140 <proc_init>:
    80000140:	00002797          	auipc	a5,0x2
    80000144:	97078793          	addi	a5,a5,-1680 # 80001ab0 <procs>
    80000148:	0007a023          	sw	zero,0(a5)
    8000014c:	00100713          	addi	a4,zero,1
    80000150:	00e7a223          	sw	a4,4(a5)
    80000154:	00000697          	auipc	a3,0x0
    80000158:	f6068693          	addi	a3,a3,-160 # 800000b4 <proc0_run>
    8000015c:	00d7b423          	sd	a3,8(a5)
    80000160:	00005697          	auipc	a3,0x5
    80000164:	b4068693          	addi	a3,a3,-1216 # 80004ca0 <kernel_stack>
    80000168:	00d7b823          	sd	a3,16(a5)
    8000016c:	00004697          	auipc	a3,0x4
    80000170:	b3468693          	addi	a3,a3,-1228 # 80003ca0 <kstack0>
    80000174:	06d7bc23          	sd	a3,120(a5)
    80000178:	08e7a023          	sw	a4,128(a5)
    8000017c:	08e7a223          	sw	a4,132(a5)
    80000180:	00000697          	auipc	a3,0x0
    80000184:	f3c68693          	addi	a3,a3,-196 # 800000bc <proc_a_entry>
    80000188:	08d7b423          	sd	a3,136(a5)
    8000018c:	00004697          	auipc	a3,0x4
    80000190:	b1468693          	addi	a3,a3,-1260 # 80003ca0 <kstack0>
    80000194:	08d7b823          	sd	a3,144(a5)
    80000198:	00003697          	auipc	a3,0x3
    8000019c:	b0868693          	addi	a3,a3,-1272 # 80002ca0 <kstack1>
    800001a0:	0ed7bc23          	sd	a3,248(a5)
    800001a4:	00200693          	addi	a3,zero,2
    800001a8:	10d7a023          	sw	a3,256(a5)
    800001ac:	10e7a223          	sw	a4,260(a5)
    800001b0:	00000717          	auipc	a4,0x0
    800001b4:	f2070713          	addi	a4,a4,-224 # 800000d0 <proc_b_entry>
    800001b8:	10e7b423          	sd	a4,264(a5)
    800001bc:	00003717          	auipc	a4,0x3
    800001c0:	ae470713          	addi	a4,a4,-1308 # 80002ca0 <kstack1>
    800001c4:	10e7b823          	sd	a4,272(a5)
    800001c8:	00002717          	auipc	a4,0x2
    800001cc:	ad870713          	addi	a4,a4,-1320 # 80001ca0 <kstack2>
    800001d0:	16e7bc23          	sd	a4,376(a5)
    800001d4:	00006717          	auipc	a4,0x6
    800001d8:	acc70713          	addi	a4,a4,-1332 # 80005ca0 <page_used>
    800001dc:	18e7b423          	sd	a4,392(a5)
    800001e0:	00000717          	auipc	a4,0x0
    800001e4:	f0470713          	addi	a4,a4,-252 # 800000e4 <scheduler_entry>
    800001e8:	18e7b023          	sd	a4,384(a5)
    800001ec:	00008067          	jalr	zero,0(ra)

00000000800001f0 <scheduler>:
    800001f0:	fd010113          	addi	sp,sp,-48
    800001f4:	02113423          	sd	ra,40(sp)
    800001f8:	02813023          	sd	s0,32(sp)
    800001fc:	00913c23          	sd	s1,24(sp)
    80000200:	01213823          	sd	s2,16(sp)
    80000204:	01313423          	sd	s3,8(sp)
    80000208:	00002497          	auipc	s1,0x2
    8000020c:	a2848493          	addi	s1,s1,-1496 # 80001c30 <kernel_context>
    80000210:	00100913          	addi	s2,zero,1
    80000214:	00006997          	auipc	s3,0x6
    80000218:	d8c98993          	addi	s3,s3,-628 # 80005fa0 <current_proc>
    8000021c:	00002417          	auipc	s0,0x2
    80000220:	89440413          	addi	s0,s0,-1900 # 80001ab0 <procs>
    80000224:	00442783          	lw	a5,4(s0)
    80000228:	01278863          	beq	a5,s2,80000238 <scheduler+0x48>
    8000022c:	08040413          	addi	s0,s0,128
    80000230:	fe941ae3          	bne	s0,s1,80000224 <scheduler+0x34>
    80000234:	fe9ff06f          	jal	zero,8000021c <scheduler+0x2c>
    80000238:	0089b023          	sd	s0,0(s3)
    8000023c:	00840593          	addi	a1,s0,8
    80000240:	00048513          	addi	a0,s1,0
    80000244:	498000ef          	jal	ra,800006dc <switch_context>
    80000248:	fe5ff06f          	jal	zero,8000022c <scheduler+0x3c>

000000008000024c <yield>:
    8000024c:	ff010113          	addi	sp,sp,-16
    80000250:	00113423          	sd	ra,8(sp)
    80000254:	00002597          	auipc	a1,0x2
    80000258:	9dc58593          	addi	a1,a1,-1572 # 80001c30 <kernel_context>
    8000025c:	00006517          	auipc	a0,0x6
    80000260:	d4453503          	ld	a0,-700(a0) # 80005fa0 <current_proc>
    80000264:	00850513          	addi	a0,a0,8
    80000268:	474000ef          	jal	ra,800006dc <switch_context>
    8000026c:	00813083          	ld	ra,8(sp)
    80000270:	01010113          	addi	sp,sp,16
    80000274:	00008067          	jalr	zero,0(ra)

0000000080000278 <trap_init>:
    80000278:	00000797          	auipc	a5,0x0
    8000027c:	0f078793          	addi	a5,a5,240 # 80000368 <__kernelvec>
    80000280:	30579073          	csrrw	zero,mtvec,a5
    80000284:	00008067          	jalr	zero,0(ra)

0000000080000288 <timer_init>:
    80000288:	0200c7b7          	lui	a5,0x200c
    8000028c:	ff878793          	addi	a5,a5,-8 # 200bff8 <_start-0x7dff4008>
    80000290:	0007b783          	ld	a5,0(a5)
    80000294:	000f4737          	lui	a4,0xf4
    80000298:	24070713          	addi	a4,a4,576 # f4240 <_start-0x7ff0bdc0>
    8000029c:	00e787b3          	add	a5,a5,a4
    800002a0:	02004737          	lui	a4,0x2004
    800002a4:	00f73023          	sd	a5,0(a4) # 2004000 <_start-0x7dffc000>
    800002a8:	08000793          	addi	a5,zero,128
    800002ac:	3047a073          	csrrs	zero,mie,a5
    800002b0:	00800793          	addi	a5,zero,8
    800002b4:	3007a073          	csrrs	zero,mstatus,a5
    800002b8:	00008067          	jalr	zero,0(ra)

00000000800002bc <trap_handler>:
    800002bc:	fe010113          	addi	sp,sp,-32
    800002c0:	00113c23          	sd	ra,24(sp)
    800002c4:	00813823          	sd	s0,16(sp)
    800002c8:	00913423          	sd	s1,8(sp)
    800002cc:	34202473          	csrrs	s0,mcause,zero
    800002d0:	341024f3          	csrrs	s1,mepc,zero
    800002d4:	0ff47793          	andi	a5,s0,255
    800002d8:	08044063          	blt	s0,zero,80000358 <trap_handler+0x9c>
    800002dc:	00b00713          	addi	a4,zero,11
    800002e0:	04e78c63          	beq	a5,a4,80000338 <trap_handler+0x7c>
    800002e4:	00000517          	auipc	a0,0x0
    800002e8:	71c50513          	addi	a0,a0,1820 # 80000a00 <switch_context+0x324>
    800002ec:	0a0000ef          	jal	ra,8000038c <puts>
    800002f0:	00000517          	auipc	a0,0x0
    800002f4:	73050513          	addi	a0,a0,1840 # 80000a20 <switch_context+0x344>
    800002f8:	094000ef          	jal	ra,8000038c <puts>
    800002fc:	00040513          	addi	a0,s0,0
    80000300:	0ac000ef          	jal	ra,800003ac <print_hex>
    80000304:	00000517          	auipc	a0,0x0
    80000308:	72450513          	addi	a0,a0,1828 # 80000a28 <switch_context+0x34c>
    8000030c:	080000ef          	jal	ra,8000038c <puts>
    80000310:	00000517          	auipc	a0,0x0
    80000314:	72050513          	addi	a0,a0,1824 # 80000a30 <switch_context+0x354>
    80000318:	074000ef          	jal	ra,8000038c <puts>
    8000031c:	00048513          	addi	a0,s1,0
    80000320:	08c000ef          	jal	ra,800003ac <print_hex>
    80000324:	00000517          	auipc	a0,0x0
    80000328:	70450513          	addi	a0,a0,1796 # 80000a28 <switch_context+0x34c>
    8000032c:	060000ef          	jal	ra,8000038c <puts>
    80000330:	10500073          	wfi
    80000334:	ffdff06f          	jal	zero,80000330 <trap_handler+0x74>
    80000338:	00448493          	addi	s1,s1,4
    8000033c:	34149073          	csrrw	zero,mepc,s1
    80000340:	f0dff0ef          	jal	ra,8000024c <yield>
    80000344:	01813083          	ld	ra,24(sp)
    80000348:	01013403          	ld	s0,16(sp)
    8000034c:	00813483          	ld	s1,8(sp)
    80000350:	02010113          	addi	sp,sp,32
    80000354:	00008067          	jalr	zero,0(ra)
    80000358:	00700713          	addi	a4,zero,7
    8000035c:	f8e794e3          	bne	a5,a4,800002e4 <trap_handler+0x28>
    80000360:	eedff0ef          	jal	ra,8000024c <yield>
    80000364:	fe1ff06f          	jal	zero,80000344 <trap_handler+0x88>

0000000080000368 <__kernelvec>:
    80000368:	f8010113          	addi	sp,sp,-128
    8000036c:	00113023          	sd	ra,0(sp)
    80000370:	f4dff0ef          	jal	ra,800002bc <trap_handler>
    80000374:	00013083          	ld	ra,0(sp)
    80000378:	08010113          	addi	sp,sp,128
    8000037c:	30200073          	mret

0000000080000380 <putchar>:
    80000380:	100007b7          	lui	a5,0x10000
    80000384:	00a78023          	sb	a0,0(a5) # 10000000 <_start-0x70000000>
    80000388:	00008067          	jalr	zero,0(ra)

000000008000038c <puts>:
    8000038c:	00054783          	lbu	a5,0(a0)
    80000390:	00078c63          	beq	a5,zero,800003a8 <puts+0x1c>
    80000394:	10000737          	lui	a4,0x10000
    80000398:	00150513          	addi	a0,a0,1
    8000039c:	00f70023          	sb	a5,0(a4) # 10000000 <_start-0x70000000>
    800003a0:	00054783          	lbu	a5,0(a0)
    800003a4:	fe079ae3          	bne	a5,zero,80000398 <puts+0xc>
    800003a8:	00008067          	jalr	zero,0(ra)

00000000800003ac <print_hex>:
    800003ac:	03c00713          	addi	a4,zero,60
    800003b0:	00000597          	auipc	a1,0x0
    800003b4:	68858593          	addi	a1,a1,1672 # 80000a38 <switch_context+0x35c>
    800003b8:	10000637          	lui	a2,0x10000
    800003bc:	ffc00693          	addi	a3,zero,-4
    800003c0:	00e557b3          	srl	a5,a0,a4
    800003c4:	00f7f793          	andi	a5,a5,15
    800003c8:	00b787b3          	add	a5,a5,a1
    800003cc:	0007c783          	lbu	a5,0(a5)
    800003d0:	00f60023          	sb	a5,0(a2) # 10000000 <_start-0x70000000>
    800003d4:	ffc7071b          	addiw	a4,a4,-4
    800003d8:	fed714e3          	bne	a4,a3,800003c0 <print_hex+0x14>
    800003dc:	100007b7          	lui	a5,0x10000
    800003e0:	00d00713          	addi	a4,zero,13
    800003e4:	00e78023          	sb	a4,0(a5) # 10000000 <_start-0x70000000>
    800003e8:	00a00713          	addi	a4,zero,10
    800003ec:	00e78023          	sb	a4,0(a5)
    800003f0:	00008067          	jalr	zero,0(ra)

00000000800003f4 <alloc_page>:
    800003f4:	00006717          	auipc	a4,0x6
    800003f8:	8ac70713          	addi	a4,a4,-1876 # 80005ca0 <page_used>
    800003fc:	00000793          	addi	a5,zero,0
    80000400:	04000613          	addi	a2,zero,64
    80000404:	00072683          	lw	a3,0(a4)
    80000408:	00068c63          	beq	a3,zero,80000420 <alloc_page+0x2c>
    8000040c:	0017879b          	addiw	a5,a5,1
    80000410:	00470713          	addi	a4,a4,4
    80000414:	fec798e3          	bne	a5,a2,80000404 <alloc_page+0x10>
    80000418:	00000513          	addi	a0,zero,0
    8000041c:	00008067          	jalr	zero,0(ra)
    80000420:	00006717          	auipc	a4,0x6
    80000424:	88070713          	addi	a4,a4,-1920 # 80005ca0 <page_used>
    80000428:	00279693          	slli	a3,a5,0x2
    8000042c:	00d706b3          	add	a3,a4,a3
    80000430:	00100613          	addi	a2,zero,1
    80000434:	00c6a023          	sw	a2,0(a3)
    80000438:	00c7951b          	slliw	a0,a5,0xc
    8000043c:	802006b7          	lui	a3,0x80200
    80000440:	00d5053b          	addw	a0,a0,a3
    80000444:	02051513          	slli	a0,a0,0x20
    80000448:	02055513          	srli	a0,a0,0x20
    8000044c:	00379793          	slli	a5,a5,0x3
    80000450:	00f70733          	add	a4,a4,a5
    80000454:	10a73023          	sd	a0,256(a4)
    80000458:	00050793          	addi	a5,a0,0
    8000045c:	00001737          	lui	a4,0x1
    80000460:	00e50733          	add	a4,a0,a4
    80000464:	00078023          	sb	zero,0(a5)
    80000468:	00178793          	addi	a5,a5,1
    8000046c:	fee79ce3          	bne	a5,a4,80000464 <alloc_page+0x70>
    80000470:	00008067          	jalr	zero,0(ra)

0000000080000474 <map_page>:
    80000474:	fc010113          	addi	sp,sp,-64
    80000478:	02113c23          	sd	ra,56(sp)
    8000047c:	02813823          	sd	s0,48(sp)
    80000480:	02913423          	sd	s1,40(sp)
    80000484:	03213023          	sd	s2,32(sp)
    80000488:	01313c23          	sd	s3,24(sp)
    8000048c:	01413823          	sd	s4,16(sp)
    80000490:	01513423          	sd	s5,8(sp)
    80000494:	00058413          	addi	s0,a1,0
    80000498:	00060993          	addi	s3,a2,0
    8000049c:	00068493          	addi	s1,a3,0 # ffffffff80200000 <current_proc+0xffffffff001fa060>
    800004a0:	01e00913          	addi	s2,zero,30
    800004a4:	00c00a13          	addi	s4,zero,12
    800004a8:	01245ab3          	srl	s5,s0,s2
    800004ac:	1ffafa93          	andi	s5,s5,511
    800004b0:	003a9a93          	slli	s5,s5,0x3
    800004b4:	01550ab3          	add	s5,a0,s5
    800004b8:	000ab503          	ld	a0,0(s5)
    800004bc:	00157793          	andi	a5,a0,1
    800004c0:	06078263          	beq	a5,zero,80000524 <map_page+0xb0>
    800004c4:	00a55513          	srli	a0,a0,0xa
    800004c8:	00c51513          	slli	a0,a0,0xc
    800004cc:	ff79091b          	addiw	s2,s2,-9
    800004d0:	fd491ce3          	bne	s2,s4,800004a8 <map_page+0x34>
    800004d4:	00c45793          	srli	a5,s0,0xc
    800004d8:	1ff7f793          	andi	a5,a5,511
    800004dc:	00379793          	slli	a5,a5,0x3
    800004e0:	00f50533          	add	a0,a0,a5
    800004e4:	3ff4f793          	andi	a5,s1,1023
    800004e8:	0017e793          	ori	a5,a5,1
    800004ec:	fffff737          	lui	a4,0xfffff
    800004f0:	00e9f9b3          	and	s3,s3,a4
    800004f4:	0137e7b3          	or	a5,a5,s3
    800004f8:	00f53023          	sd	a5,0(a0)
    800004fc:	00000513          	addi	a0,zero,0
    80000500:	03813083          	ld	ra,56(sp)
    80000504:	03013403          	ld	s0,48(sp)
    80000508:	02813483          	ld	s1,40(sp)
    8000050c:	02013903          	ld	s2,32(sp)
    80000510:	01813983          	ld	s3,24(sp)
    80000514:	01013a03          	ld	s4,16(sp)
    80000518:	00813a83          	ld	s5,8(sp)
    8000051c:	04010113          	addi	sp,sp,64
    80000520:	00008067          	jalr	zero,0(ra)
    80000524:	ed1ff0ef          	jal	ra,800003f4 <alloc_page>
    80000528:	02050a63          	beq	a0,zero,8000055c <map_page+0xe8>
    8000052c:	00050693          	addi	a3,a0,0
    80000530:	00001737          	lui	a4,0x1
    80000534:	00e50733          	add	a4,a0,a4
    80000538:	00050793          	addi	a5,a0,0
    8000053c:	0007b023          	sd	zero,0(a5)
    80000540:	00878793          	addi	a5,a5,8
    80000544:	fee79ce3          	bne	a5,a4,8000053c <map_page+0xc8>
    80000548:	fffff7b7          	lui	a5,0xfffff
    8000054c:	00f6f7b3          	and	a5,a3,a5
    80000550:	0017e793          	ori	a5,a5,1
    80000554:	00fab023          	sd	a5,0(s5)
    80000558:	f75ff06f          	jal	zero,800004cc <map_page+0x58>
    8000055c:	fff00513          	addi	a0,zero,-1
    80000560:	fa1ff06f          	jal	zero,80000500 <map_page+0x8c>

0000000080000564 <switch_pagetable>:
    80000564:	00c55513          	srli	a0,a0,0xc
    80000568:	fff00793          	addi	a5,zero,-1
    8000056c:	0147d713          	srli	a4,a5,0x14
    80000570:	00e57533          	and	a0,a0,a4
    80000574:	03f79793          	slli	a5,a5,0x3f
    80000578:	00f56533          	or	a0,a0,a5
    8000057c:	18051073          	csrrw	zero,satp,a0
    80000580:	12000073          	sfence.vma	zero,zero
    80000584:	00008067          	jalr	zero,0(ra)

0000000080000588 <test_mapping_rw>:
    80000588:	ff010113          	addi	sp,sp,-16
    8000058c:	00113423          	sd	ra,8(sp)
    80000590:	00813023          	sd	s0,0(sp)
    80000594:	e61ff0ef          	jal	ra,800003f4 <alloc_page>
    80000598:	00050413          	addi	s0,a0,0
    8000059c:	e59ff0ef          	jal	ra,800003f4 <alloc_page>
    800005a0:	00050613          	addi	a2,a0,0
    800005a4:	01b00693          	addi	a3,zero,27
    800005a8:	400005b7          	lui	a1,0x40000
    800005ac:	00040513          	addi	a0,s0,0
    800005b0:	ec5ff0ef          	jal	ra,80000474 <map_page>
    800005b4:	01b00693          	addi	a3,zero,27
    800005b8:	00100613          	addi	a2,zero,1
    800005bc:	01f61613          	slli	a2,a2,0x1f
    800005c0:	00060593          	addi	a1,a2,0
    800005c4:	00040513          	addi	a0,s0,0
    800005c8:	eadff0ef          	jal	ra,80000474 <map_page>
    800005cc:	00040513          	addi	a0,s0,0
    800005d0:	f95ff0ef          	jal	ra,80000564 <switch_pagetable>
    800005d4:	40000737          	lui	a4,0x40000
    800005d8:	000037b7          	lui	a5,0x3
    800005dc:	03978793          	addi	a5,a5,57 # 3039 <_start-0x7fffcfc7>
    800005e0:	00f72023          	sw	a5,0(a4) # 40000000 <_start-0x40000000>
    800005e4:	00072703          	lw	a4,0(a4)
    800005e8:	0007071b          	addiw	a4,a4,0
    800005ec:	02f70063          	beq	a4,a5,8000060c <test_mapping_rw+0x84>
    800005f0:	00000517          	auipc	a0,0x0
    800005f4:	48850513          	addi	a0,a0,1160 # 80000a78 <switch_context+0x39c>
    800005f8:	d95ff0ef          	jal	ra,8000038c <puts>
    800005fc:	00813083          	ld	ra,8(sp)
    80000600:	00013403          	ld	s0,0(sp)
    80000604:	01010113          	addi	sp,sp,16
    80000608:	00008067          	jalr	zero,0(ra)
    8000060c:	00000517          	auipc	a0,0x0
    80000610:	44450513          	addi	a0,a0,1092 # 80000a50 <switch_context+0x374>
    80000614:	d79ff0ef          	jal	ra,8000038c <puts>
    80000618:	fe5ff06f          	jal	zero,800005fc <test_mapping_rw+0x74>

000000008000061c <test_invalid_access>:
    8000061c:	401007b7          	lui	a5,0x40100
    80000620:	00100713          	addi	a4,zero,1
    80000624:	00e7a023          	sw	a4,0(a5) # 40100000 <_start-0x3ff00000>
    80000628:	00008067          	jalr	zero,0(ra)

000000008000062c <dump_pagetable>:
    8000062c:	fc010113          	addi	sp,sp,-64
    80000630:	02113c23          	sd	ra,56(sp)
    80000634:	02813823          	sd	s0,48(sp)
    80000638:	02913423          	sd	s1,40(sp)
    8000063c:	03213023          	sd	s2,32(sp)
    80000640:	01313c23          	sd	s3,24(sp)
    80000644:	01413823          	sd	s4,16(sp)
    80000648:	01513423          	sd	s5,8(sp)
    8000064c:	00050413          	addi	s0,a0,0
    80000650:	00000493          	addi	s1,zero,0
    80000654:	00000a97          	auipc	s5,0x0
    80000658:	44ca8a93          	addi	s5,s5,1100 # 80000aa0 <switch_context+0x3c4>
    8000065c:	00000a17          	auipc	s4,0x0
    80000660:	44ca0a13          	addi	s4,s4,1100 # 80000aa8 <switch_context+0x3cc>
    80000664:	00000997          	auipc	s3,0x0
    80000668:	3c498993          	addi	s3,s3,964 # 80000a28 <switch_context+0x34c>
    8000066c:	20000913          	addi	s2,zero,512
    80000670:	0100006f          	jal	zero,80000680 <dump_pagetable+0x54>
    80000674:	00148493          	addi	s1,s1,1
    80000678:	00840413          	addi	s0,s0,8
    8000067c:	03248e63          	beq	s1,s2,800006b8 <dump_pagetable+0x8c>
    80000680:	00043783          	ld	a5,0(s0)
    80000684:	0017f793          	andi	a5,a5,1
    80000688:	fe0786e3          	beq	a5,zero,80000674 <dump_pagetable+0x48>
    8000068c:	000a8513          	addi	a0,s5,0
    80000690:	cfdff0ef          	jal	ra,8000038c <puts>
    80000694:	00048513          	addi	a0,s1,0
    80000698:	d15ff0ef          	jal	ra,800003ac <print_hex>
    8000069c:	000a0513          	addi	a0,s4,0
    800006a0:	cedff0ef          	jal	ra,8000038c <puts>
    800006a4:	00043503          	ld	a0,0(s0)
    800006a8:	d05ff0ef          	jal	ra,800003ac <print_hex>
    800006ac:	00098513          	addi	a0,s3,0
    800006b0:	cddff0ef          	jal	ra,8000038c <puts>
    800006b4:	fc1ff06f          	jal	zero,80000674 <dump_pagetable+0x48>
    800006b8:	03813083          	ld	ra,56(sp)
    800006bc:	03013403          	ld	s0,48(sp)
    800006c0:	02813483          	ld	s1,40(sp)
    800006c4:	02013903          	ld	s2,32(sp)
    800006c8:	01813983          	ld	s3,24(sp)
    800006cc:	01013a03          	ld	s4,16(sp)
    800006d0:	00813a83          	ld	s5,8(sp)
    800006d4:	04010113          	addi	sp,sp,64
    800006d8:	00008067          	jalr	zero,0(ra)

00000000800006dc <switch_context>:
    800006dc:	00153023          	sd	ra,0(a0)
    800006e0:	00253423          	sd	sp,8(a0)
    800006e4:	00853823          	sd	s0,16(a0)
    800006e8:	00953c23          	sd	s1,24(a0)
    800006ec:	03253023          	sd	s2,32(a0)
    800006f0:	03353423          	sd	s3,40(a0)
    800006f4:	03453823          	sd	s4,48(a0)
    800006f8:	03553c23          	sd	s5,56(a0)
    800006fc:	05653023          	sd	s6,64(a0)
    80000700:	05753423          	sd	s7,72(a0)
    80000704:	05853823          	sd	s8,80(a0)
    80000708:	05953c23          	sd	s9,88(a0)
    8000070c:	07a53023          	sd	s10,96(a0)
    80000710:	07b53423          	sd	s11,104(a0)
    80000714:	0005b083          	ld	ra,0(a1) # 40000000 <_start-0x40000000>
    80000718:	0085b103          	ld	sp,8(a1)
    8000071c:	0105b403          	ld	s0,16(a1)
    80000720:	0185b483          	ld	s1,24(a1)
    80000724:	0205b903          	ld	s2,32(a1)
    80000728:	0285b983          	ld	s3,40(a1)
    8000072c:	0305ba03          	ld	s4,48(a1)
    80000730:	0385ba83          	ld	s5,56(a1)
    80000734:	0405bb03          	ld	s6,64(a1)
    80000738:	0485bb83          	ld	s7,72(a1)
    8000073c:	0505bc03          	ld	s8,80(a1)
    80000740:	0585bc83          	ld	s9,88(a1)
    80000744:	0605bd03          	ld	s10,96(a1)
    80000748:	0685bd83          	ld	s11,104(a1)
    8000074c:	00008067          	jalr	zero,0(ra)

Disassembly of section .eh_frame:

0000000080000750 <.eh_frame>:
    80000750:	0010                	.insn	2, 0x0010
    80000752:	0000                	.insn	2, 0x
    80000754:	0000                	.insn	2, 0x
    80000756:	0000                	.insn	2, 0x
    80000758:	00527a03          	.insn	4, 0x00527a03
    8000075c:	7c01                	.insn	2, 0x7c01
    8000075e:	0101                	.insn	2, 0x0101
    80000760:	00020d1b          	addiw	s10,tp,0 # 0 <_start-0x80000000>
    80000764:	0018                	.insn	2, 0x0018
    80000766:	0000                	.insn	2, 0x
    80000768:	0018                	.insn	2, 0x0018
    8000076a:	0000                	.insn	2, 0x
    8000076c:	f8a4                	.insn	2, 0xf8a4
    8000076e:	ffff                	.insn	2, 0xffff
    80000770:	0028                	.insn	2, 0x0028
    80000772:	0000                	.insn	2, 0x
    80000774:	4400                	.insn	2, 0x4400
    80000776:	100e                	.insn	2, 0x100e
    80000778:	8144                	.insn	2, 0x8144
    8000077a:	5802                	.insn	2, 0x5802
    8000077c:	44c1                	.insn	2, 0x44c1
    8000077e:	000e                	.insn	2, 0x000e
    80000780:	0024                	.insn	2, 0x0024
    80000782:	0000                	.insn	2, 0x
    80000784:	0034                	.insn	2, 0x0034
    80000786:	0000                	.insn	2, 0x
    80000788:	f8b0                	.insn	2, 0xf8b0
    8000078a:	ffff                	.insn	2, 0xffff
    8000078c:	007c                	.insn	2, 0x007c
    8000078e:	0000                	.insn	2, 0x
    80000790:	4400                	.insn	2, 0x4400
    80000792:	100e                	.insn	2, 0x100e
    80000794:	8148                	.insn	2, 0x8148
    80000796:	8802                	.insn	2, 0x8802
    80000798:	0204                	.insn	2, 0x0204
    8000079a:	c164                	.insn	2, 0xc164
    8000079c:	c844                	.insn	2, 0xc844
    8000079e:	0e44                	.insn	2, 0x0e44
	...
    800007a8:	0010                	.insn	2, 0x0010
    800007aa:	0000                	.insn	2, 0x
    800007ac:	005c                	.insn	2, 0x005c
    800007ae:	0000                	.insn	2, 0x
    800007b0:	f904                	.insn	2, 0xf904
    800007b2:	ffff                	.insn	2, 0xffff
    800007b4:	0008                	.insn	2, 0x0008
    800007b6:	0000                	.insn	2, 0x
    800007b8:	0000                	.insn	2, 0x
    800007ba:	0000                	.insn	2, 0x
    800007bc:	0010                	.insn	2, 0x0010
    800007be:	0000                	.insn	2, 0x
    800007c0:	0070                	.insn	2, 0x0070
    800007c2:	0000                	.insn	2, 0x
    800007c4:	f8f8                	.insn	2, 0xf8f8
    800007c6:	ffff                	.insn	2, 0xffff
    800007c8:	0014                	.insn	2, 0x0014
    800007ca:	0000                	.insn	2, 0x
    800007cc:	0000                	.insn	2, 0x
    800007ce:	0000                	.insn	2, 0x
    800007d0:	0010                	.insn	2, 0x0010
    800007d2:	0000                	.insn	2, 0x
    800007d4:	0084                	.insn	2, 0x0084
    800007d6:	0000                	.insn	2, 0x
    800007d8:	f8f8                	.insn	2, 0xf8f8
    800007da:	ffff                	.insn	2, 0xffff
    800007dc:	0014                	.insn	2, 0x0014
    800007de:	0000                	.insn	2, 0x
    800007e0:	0000                	.insn	2, 0x
    800007e2:	0000                	.insn	2, 0x
    800007e4:	0010                	.insn	2, 0x0010
    800007e6:	0000                	.insn	2, 0x
    800007e8:	0098                	.insn	2, 0x0098
    800007ea:	0000                	.insn	2, 0x
    800007ec:	f8f8                	.insn	2, 0xf8f8
    800007ee:	ffff                	.insn	2, 0xffff
    800007f0:	0014                	.insn	2, 0x0014
    800007f2:	0000                	.insn	2, 0x
    800007f4:	0000                	.insn	2, 0x
    800007f6:	0000                	.insn	2, 0x
    800007f8:	0018                	.insn	2, 0x0018
    800007fa:	0000                	.insn	2, 0x
    800007fc:	00ac                	.insn	2, 0x00ac
    800007fe:	0000                	.insn	2, 0x
    80000800:	f8f8                	.insn	2, 0xf8f8
    80000802:	ffff                	.insn	2, 0xffff
    80000804:	0024                	.insn	2, 0x0024
    80000806:	0000                	.insn	2, 0x
    80000808:	4400                	.insn	2, 0x4400
    8000080a:	100e                	.insn	2, 0x100e
    8000080c:	8148                	.insn	2, 0x8148
    8000080e:	8802                	.insn	2, 0x8802
    80000810:	0004                	.insn	2, 0x0004
    80000812:	0000                	.insn	2, 0x
    80000814:	0018                	.insn	2, 0x0018
    80000816:	0000                	.insn	2, 0x
    80000818:	00c8                	.insn	2, 0x00c8
    8000081a:	0000                	.insn	2, 0x
    8000081c:	f900                	.insn	2, 0xf900
    8000081e:	ffff                	.insn	2, 0xffff
    80000820:	0024                	.insn	2, 0x0024
    80000822:	0000                	.insn	2, 0x
    80000824:	4400                	.insn	2, 0x4400
    80000826:	100e                	.insn	2, 0x100e
    80000828:	8148                	.insn	2, 0x8148
    8000082a:	8802                	.insn	2, 0x8802
    8000082c:	0004                	.insn	2, 0x0004
    8000082e:	0000                	.insn	2, 0x
    80000830:	0010                	.insn	2, 0x0010
    80000832:	0000                	.insn	2, 0x
    80000834:	00e4                	.insn	2, 0x00e4
    80000836:	0000                	.insn	2, 0x
    80000838:	f908                	.insn	2, 0xf908
    8000083a:	ffff                	.insn	2, 0xffff
    8000083c:	00b0                	.insn	2, 0x00b0
    8000083e:	0000                	.insn	2, 0x
    80000840:	0000                	.insn	2, 0x
    80000842:	0000                	.insn	2, 0x
    80000844:	001c                	.insn	2, 0x001c
    80000846:	0000                	.insn	2, 0x
    80000848:	00f8                	.insn	2, 0x00f8
    8000084a:	0000                	.insn	2, 0x
    8000084c:	f9a4                	.insn	2, 0xf9a4
    8000084e:	ffff                	.insn	2, 0xffff
    80000850:	005c                	.insn	2, 0x005c
    80000852:	0000                	.insn	2, 0x
    80000854:	4400                	.insn	2, 0x4400
    80000856:	300e                	.insn	2, 0x300e
    80000858:	8154                	.insn	2, 0x8154
    8000085a:	8802                	.insn	2, 0x8802
    8000085c:	8904                	.insn	2, 0x8904
    8000085e:	9206                	.insn	2, 0x9206
    80000860:	9308                	.insn	2, 0x9308
    80000862:	000a                	.insn	2, 0x000a
    80000864:	0018                	.insn	2, 0x0018
    80000866:	0000                	.insn	2, 0x
    80000868:	0118                	.insn	2, 0x0118
    8000086a:	0000                	.insn	2, 0x
    8000086c:	f9e0                	.insn	2, 0xf9e0
    8000086e:	ffff                	.insn	2, 0xffff
    80000870:	002c                	.insn	2, 0x002c
    80000872:	0000                	.insn	2, 0x
    80000874:	4400                	.insn	2, 0x4400
    80000876:	100e                	.insn	2, 0x100e
    80000878:	8144                	.insn	2, 0x8144
    8000087a:	5c02                	.insn	2, 0x5c02
    8000087c:	44c1                	.insn	2, 0x44c1
    8000087e:	000e                	.insn	2, 0x000e
    80000880:	0010                	.insn	2, 0x0010
    80000882:	0000                	.insn	2, 0x
    80000884:	0134                	.insn	2, 0x0134
    80000886:	0000                	.insn	2, 0x
    80000888:	f9f0                	.insn	2, 0xf9f0
    8000088a:	ffff                	.insn	2, 0xffff
    8000088c:	0010                	.insn	2, 0x0010
    8000088e:	0000                	.insn	2, 0x
    80000890:	0000                	.insn	2, 0x
    80000892:	0000                	.insn	2, 0x
    80000894:	0010                	.insn	2, 0x0010
    80000896:	0000                	.insn	2, 0x
    80000898:	0148                	.insn	2, 0x0148
    8000089a:	0000                	.insn	2, 0x
    8000089c:	f9ec                	.insn	2, 0xf9ec
    8000089e:	ffff                	.insn	2, 0xffff
    800008a0:	0034                	.insn	2, 0x0034
    800008a2:	0000                	.insn	2, 0x
    800008a4:	0000                	.insn	2, 0x
    800008a6:	0000                	.insn	2, 0x
    800008a8:	0024                	.insn	2, 0x0024
    800008aa:	0000                	.insn	2, 0x
    800008ac:	015c                	.insn	2, 0x015c
    800008ae:	0000                	.insn	2, 0x
    800008b0:	fa0c                	.insn	2, 0xfa0c
    800008b2:	ffff                	.insn	2, 0xffff
    800008b4:	00ac                	.insn	2, 0x00ac
    800008b6:	0000                	.insn	2, 0x
    800008b8:	4400                	.insn	2, 0x4400
    800008ba:	200e                	.insn	2, 0x200e
    800008bc:	814c                	.insn	2, 0x814c
    800008be:	8802                	.insn	2, 0x8802
    800008c0:	8904                	.insn	2, 0x8904
    800008c2:	0206                	.insn	2, 0x0206
    800008c4:	0a7c                	.insn	2, 0x0a7c
    800008c6:	44c1                	.insn	2, 0x44c1
    800008c8:	44c8                	.insn	2, 0x44c8
    800008ca:	44c9                	.insn	2, 0x44c9
    800008cc:	000e                	.insn	2, 0x000e
    800008ce:	0b44                	.insn	2, 0x0b44
    800008d0:	0010                	.insn	2, 0x0010
    800008d2:	0000                	.insn	2, 0x
    800008d4:	0184                	.insn	2, 0x0184
    800008d6:	0000                	.insn	2, 0x
    800008d8:	faa8                	.insn	2, 0xfaa8
    800008da:	ffff                	.insn	2, 0xffff
    800008dc:	000c                	.insn	2, 0x000c
    800008de:	0000                	.insn	2, 0x
    800008e0:	0000                	.insn	2, 0x
    800008e2:	0000                	.insn	2, 0x
    800008e4:	0010                	.insn	2, 0x0010
    800008e6:	0000                	.insn	2, 0x
    800008e8:	0198                	.insn	2, 0x0198
    800008ea:	0000                	.insn	2, 0x
    800008ec:	faa0                	.insn	2, 0xfaa0
    800008ee:	ffff                	.insn	2, 0xffff
    800008f0:	0020                	.insn	2, 0x0020
    800008f2:	0000                	.insn	2, 0x
    800008f4:	0000                	.insn	2, 0x
    800008f6:	0000                	.insn	2, 0x
    800008f8:	0014                	.insn	2, 0x0014
    800008fa:	0000                	.insn	2, 0x
    800008fc:	01ac                	.insn	2, 0x01ac
    800008fe:	0000                	.insn	2, 0x
    80000900:	faac                	.insn	2, 0xfaac
    80000902:	ffff                	.insn	2, 0xffff
    80000904:	0048                	.insn	2, 0x0048
	...
    8000090e:	0000                	.insn	2, 0x
    80000910:	0010                	.insn	2, 0x0010
    80000912:	0000                	.insn	2, 0x
    80000914:	01c4                	.insn	2, 0x01c4
    80000916:	0000                	.insn	2, 0x
    80000918:	fadc                	.insn	2, 0xfadc
    8000091a:	ffff                	.insn	2, 0xffff
    8000091c:	0080                	.insn	2, 0x0080
    8000091e:	0000                	.insn	2, 0x
    80000920:	0000                	.insn	2, 0x
    80000922:	0000                	.insn	2, 0x
    80000924:	0034                	.insn	2, 0x0034
    80000926:	0000                	.insn	2, 0x
    80000928:	01d8                	.insn	2, 0x01d8
    8000092a:	0000                	.insn	2, 0x
    8000092c:	fb48                	.insn	2, 0xfb48
    8000092e:	ffff                	.insn	2, 0xffff
    80000930:	00f0                	.insn	2, 0x00f0
    80000932:	0000                	.insn	2, 0x
    80000934:	4400                	.insn	2, 0x4400
    80000936:	400e                	.insn	2, 0x400e
    80000938:	815c                	.insn	2, 0x815c
    8000093a:	8802                	.insn	2, 0x8802
    8000093c:	8904                	.insn	2, 0x8904
    8000093e:	9206                	.insn	2, 0x9206
    80000940:	9308                	.insn	2, 0x9308
    80000942:	940a                	.insn	2, 0x940a
    80000944:	950c                	.insn	2, 0x950c
    80000946:	020e                	.insn	2, 0x020e
    80000948:	0a70                	.insn	2, 0x0a70
    8000094a:	44c1                	.insn	2, 0x44c1
    8000094c:	44c8                	.insn	2, 0x44c8
    8000094e:	44c9                	.insn	2, 0x44c9
    80000950:	44d2                	.insn	2, 0x44d2
    80000952:	44d444d3          	.insn	4, 0x44d444d3
    80000956:	44d5                	.insn	2, 0x44d5
    80000958:	000e                	.insn	2, 0x000e
    8000095a:	0b44                	.insn	2, 0x0b44
    8000095c:	0010                	.insn	2, 0x0010
    8000095e:	0000                	.insn	2, 0x
    80000960:	0210                	.insn	2, 0x0210
    80000962:	0000                	.insn	2, 0x
    80000964:	fc00                	.insn	2, 0xfc00
    80000966:	ffff                	.insn	2, 0xffff
    80000968:	0024                	.insn	2, 0x0024
    8000096a:	0000                	.insn	2, 0x
    8000096c:	0000                	.insn	2, 0x
    8000096e:	0000                	.insn	2, 0x
    80000970:	0020                	.insn	2, 0x0020
    80000972:	0000                	.insn	2, 0x
    80000974:	0224                	.insn	2, 0x0224
    80000976:	0000                	.insn	2, 0x
    80000978:	fc10                	.insn	2, 0xfc10
    8000097a:	ffff                	.insn	2, 0xffff
    8000097c:	0094                	.insn	2, 0x0094
    8000097e:	0000                	.insn	2, 0x
    80000980:	4400                	.insn	2, 0x4400
    80000982:	100e                	.insn	2, 0x100e
    80000984:	8148                	.insn	2, 0x8148
    80000986:	8802                	.insn	2, 0x8802
    80000988:	0204                	.insn	2, 0x0204
    8000098a:	0a6c                	.insn	2, 0x0a6c
    8000098c:	44c1                	.insn	2, 0x44c1
    8000098e:	44c8                	.insn	2, 0x44c8
    80000990:	000e                	.insn	2, 0x000e
    80000992:	0b44                	.insn	2, 0x0b44
    80000994:	0010                	.insn	2, 0x0010
    80000996:	0000                	.insn	2, 0x
    80000998:	0248                	.insn	2, 0x0248
    8000099a:	0000                	.insn	2, 0x
    8000099c:	fc80                	.insn	2, 0xfc80
    8000099e:	ffff                	.insn	2, 0xffff
    800009a0:	0010                	.insn	2, 0x0010
    800009a2:	0000                	.insn	2, 0x
    800009a4:	0000                	.insn	2, 0x
    800009a6:	0000                	.insn	2, 0x
    800009a8:	0034                	.insn	2, 0x0034
    800009aa:	0000                	.insn	2, 0x
    800009ac:	025c                	.insn	2, 0x025c
    800009ae:	0000                	.insn	2, 0x
    800009b0:	fc7c                	.insn	2, 0xfc7c
    800009b2:	ffff                	.insn	2, 0xffff
    800009b4:	00b0                	.insn	2, 0x00b0
    800009b6:	0000                	.insn	2, 0x
    800009b8:	4400                	.insn	2, 0x4400
    800009ba:	400e                	.insn	2, 0x400e
    800009bc:	815c                	.insn	2, 0x815c
    800009be:	8802                	.insn	2, 0x8802
    800009c0:	8904                	.insn	2, 0x8904
    800009c2:	9206                	.insn	2, 0x9206
    800009c4:	9308                	.insn	2, 0x9308
    800009c6:	940a                	.insn	2, 0x940a
    800009c8:	950c                	.insn	2, 0x950c
    800009ca:	020e                	.insn	2, 0x020e
    800009cc:	c170                	.insn	2, 0xc170
    800009ce:	c844                	.insn	2, 0xc844
    800009d0:	c944                	.insn	2, 0xc944
    800009d2:	d244                	.insn	2, 0xd244
    800009d4:	d344                	.insn	2, 0xd344
    800009d6:	d444                	.insn	2, 0xd444
    800009d8:	d544                	.insn	2, 0xd544
    800009da:	0e44                	.insn	2, 0x0e44
    800009dc:	0000                	.insn	2, 0x
	...

Disassembly of section .rodata.str1.8:

00000000800009e0 <.rodata.str1.8>:
    800009e0:	50544153          	.insn	4, 0x50544153
    800009e4:	203a                	.insn	2, 0x203a
    800009e6:	7830                	.insn	2, 0x7830
	...
    800009f0:	0041                	.insn	2, 0x0041
    800009f2:	0000                	.insn	2, 0x
    800009f4:	0000                	.insn	2, 0x
    800009f6:	0000                	.insn	2, 0x
    800009f8:	0042                	.insn	2, 0x0042
    800009fa:	0000                	.insn	2, 0x
    800009fc:	0000                	.insn	2, 0x
    800009fe:	0000                	.insn	2, 0x
    80000a00:	6172745b          	.insn	4, 0x6172745b
    80000a04:	5d70                	.insn	2, 0x5d70
    80000a06:	7320                	.insn	2, 0x7320
    80000a08:	7274                	.insn	2, 0x7274
    80000a0a:	6e61                	.insn	2, 0x6e61
    80000a0c:	69206567          	.insn	4, 0x69206567
    80000a10:	746e                	.insn	2, 0x746e
    80000a12:	7265                	.insn	2, 0x7265
    80000a14:	7572                	.insn	2, 0x7572
    80000a16:	7470                	.insn	2, 0x7470
    80000a18:	0a21                	.insn	2, 0x0a21
    80000a1a:	0000                	.insn	2, 0x
    80000a1c:	0000                	.insn	2, 0x
    80000a1e:	0000                	.insn	2, 0x
    80000a20:	636d                	.insn	2, 0x636d
    80000a22:	7561                	.insn	2, 0x7561
    80000a24:	003a6573          	csrrsi	a0,fcsr,20
    80000a28:	000a                	.insn	2, 0x000a
    80000a2a:	0000                	.insn	2, 0x
    80000a2c:	0000                	.insn	2, 0x
    80000a2e:	0000                	.insn	2, 0x
    80000a30:	656d                	.insn	2, 0x656d
    80000a32:	6370                	.insn	2, 0x6370
    80000a34:	003a                	.insn	2, 0x003a
    80000a36:	0000                	.insn	2, 0x
    80000a38:	3130                	.insn	2, 0x3130
    80000a3a:	3332                	.insn	2, 0x3332
    80000a3c:	3534                	.insn	2, 0x3534
    80000a3e:	3736                	.insn	2, 0x3736
    80000a40:	3938                	.insn	2, 0x3938
    80000a42:	4241                	.insn	2, 0x4241
    80000a44:	46454443          	.insn	4, 0x46454443
	...
    80000a50:	654d                	.insn	2, 0x654d
    80000a52:	6f6d                	.insn	2, 0x6f6d
    80000a54:	7972                	.insn	2, 0x7972
    80000a56:	6d20                	.insn	2, 0x6d20
    80000a58:	7061                	.insn	2, 0x7061
    80000a5a:	6970                	.insn	2, 0x6970
    80000a5c:	676e                	.insn	2, 0x676e
    80000a5e:	6120                	.insn	2, 0x6120
    80000a60:	646e                	.insn	2, 0x646e
    80000a62:	7720                	.insn	2, 0x7720
    80000a64:	6972                	.insn	2, 0x6972
    80000a66:	6574                	.insn	2, 0x6574
    80000a68:	7420                	.insn	2, 0x7420
    80000a6a:	7365                	.insn	2, 0x7365
    80000a6c:	2074                	.insn	2, 0x2074
    80000a6e:	6170                	.insn	2, 0x6170
    80000a70:	64657373          	csrrci	t1,hviprio1,10
    80000a74:	000a                	.insn	2, 0x000a
    80000a76:	0000                	.insn	2, 0x
    80000a78:	654d                	.insn	2, 0x654d
    80000a7a:	6f6d                	.insn	2, 0x6f6d
    80000a7c:	7972                	.insn	2, 0x7972
    80000a7e:	6d20                	.insn	2, 0x6d20
    80000a80:	7061                	.insn	2, 0x7061
    80000a82:	6970                	.insn	2, 0x6970
    80000a84:	676e                	.insn	2, 0x676e
    80000a86:	6120                	.insn	2, 0x6120
    80000a88:	646e                	.insn	2, 0x646e
    80000a8a:	7720                	.insn	2, 0x7720
    80000a8c:	6972                	.insn	2, 0x6972
    80000a8e:	6574                	.insn	2, 0x6574
    80000a90:	7420                	.insn	2, 0x7420
    80000a92:	7365                	.insn	2, 0x7365
    80000a94:	2074                	.insn	2, 0x2074
    80000a96:	6166                	.insn	2, 0x6166
    80000a98:	6c69                	.insn	2, 0x6c69
    80000a9a:	6465                	.insn	2, 0x6465
    80000a9c:	000a                	.insn	2, 0x000a
    80000a9e:	0000                	.insn	2, 0x
    80000aa0:	5450                	.insn	2, 0x5450
    80000aa2:	5b45                	.insn	2, 0x5b45
    80000aa4:	0000                	.insn	2, 0x
    80000aa6:	0000                	.insn	2, 0x
    80000aa8:	3a5d                	.insn	2, 0x3a5d
    80000aaa:	0020                	.insn	2, 0x0020

Disassembly of section .riscv.attributes:

0000000000000000 <.riscv.attributes>:
   0:	5141                	.insn	2, 0x5141
   2:	0000                	.insn	2, 0x
   4:	7200                	.insn	2, 0x7200
   6:	7369                	.insn	2, 0x7369
   8:	01007663          	bgeu	zero,a6,14 <_start-0x7fffffec>
   c:	00000047          	fmsub.s	ft0,ft0,ft0,ft0,rne
  10:	1004                	.insn	2, 0x1004
  12:	7205                	.insn	2, 0x7205
  14:	3676                	.insn	2, 0x3676
  16:	6934                	.insn	2, 0x6934
  18:	7032                	.insn	2, 0x7032
  1a:	5f31                	.insn	2, 0x5f31
  1c:	326d                	.insn	2, 0x326d
  1e:	3070                	.insn	2, 0x3070
  20:	615f 7032 5f31      	.insn	6, 0x5f317032615f
  26:	3266                	.insn	2, 0x3266
  28:	3270                	.insn	2, 0x3270
  2a:	645f 7032 5f32      	.insn	6, 0x5f327032645f
  30:	697a                	.insn	2, 0x697a
  32:	32727363          	bgeu	tp,t2,358 <_start-0x7ffffca8>
  36:	3070                	.insn	2, 0x3070
  38:	7a5f 6669 6e65      	.insn	6, 0x6e6566697a5f
  3e:	32696563          	bltu	s2,t1,368 <_start-0x7ffffc98>
  42:	3070                	.insn	2, 0x3070
  44:	7a5f 6d6d 6c75      	.insn	6, 0x6c756d6d7a5f
  4a:	7031                	.insn	2, 0x7031
  4c:	0030                	.insn	2, 0x0030
  4e:	0108                	.insn	2, 0x0108
  50:	0b0a                	.insn	2, 0x0b0a

Disassembly of section .comment:

0000000000000000 <.comment>:
   0:	3a434347          	fmsub.d	ft6,ft6,ft4,ft7,rmm
   4:	2820                	.insn	2, 0x2820
   6:	6255                	.insn	2, 0x6255
   8:	6e75                	.insn	2, 0x6e75
   a:	7574                	.insn	2, 0x7574
   c:	3120                	.insn	2, 0x3120
   e:	2e332e33          	.insn	4, 0x2e332e33
  12:	2d30                	.insn	2, 0x2d30
  14:	7536                	.insn	2, 0x7536
  16:	7562                	.insn	2, 0x7562
  18:	746e                	.insn	2, 0x746e
  1a:	3275                	.insn	2, 0x3275
  1c:	327e                	.insn	2, 0x327e
  1e:	2e34                	.insn	2, 0x2e34
  20:	3430                	.insn	2, 0x3430
  22:	2029                	.insn	2, 0x2029
  24:	3331                	.insn	2, 0x3331
  26:	332e                	.insn	2, 0x332e
  28:	302e                	.insn	2, 0x302e
	...
