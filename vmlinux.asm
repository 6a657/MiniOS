
../../vmlinux:     file format elf64-littleriscv


Disassembly of section .text:

ffffffe000200000 <_skernel>:
    .extern print_int

    .section .text.init
    .globl _start
_start:
    la sp, boot_stack_top
ffffffe000200000:	0000c117          	auipc	sp,0xc
ffffffe000200004:	00010113          	mv	sp,sp
    call setup_vm
ffffffe000200008:	365010ef          	jal	ffffffe000201b6c <setup_vm>
    call relocate
ffffffe00020000c:	048000ef          	jal	ffffffe000200054 <relocate>
    call print_int
ffffffe000200010:	2ad000ef          	jal	ffffffe000200abc <print_int>
    call mm_init
ffffffe000200014:	275000ef          	jal	ffffffe000200a88 <mm_init>
    call setup_vm_final
ffffffe000200018:	3f1010ef          	jal	ffffffe000201c08 <setup_vm_final>
    
    la t0, _traps
ffffffe00020001c:	00000297          	auipc	t0,0x0
ffffffe000200020:	07c28293          	addi	t0,t0,124 # ffffffe000200098 <_traps>
    csrw stvec, t0
ffffffe000200024:	10529073          	csrw	stvec,t0
    li t1, 1<<5
ffffffe000200028:	02000313          	li	t1,32
    csrs sie, t1
ffffffe00020002c:	10432073          	csrs	sie,t1
    rdtime a0
ffffffe000200030:	c0102573          	rdtime	a0
    li a1,10000000
ffffffe000200034:	009895b7          	lui	a1,0x989
ffffffe000200038:	6805859b          	addiw	a1,a1,1664 # 989680 <OPENSBI_SIZE+0x789680>
    add a0,a0,a1
ffffffe00020003c:	00b50533          	add	a0,a0,a1
    add a1,x0,x0
ffffffe000200040:	000005b3          	add	a1,zero,zero
    call sbi_set_timer
ffffffe000200044:	760010ef          	jal	ffffffe0002017a4 <sbi_set_timer>
    #call schedule
    
    #li t2, 1<<1
    # csrs sstatus, t2
    li a0,2024
ffffffe000200048:	7e800513          	li	a0,2024

    call task_init
ffffffe00020004c:	491000ef          	jal	ffffffe000200cdc <task_init>
    j start_kernel
ffffffe000200050:	7f10106f          	j	ffffffe000202040 <start_kernel>

ffffffe000200054 <relocate>:

relocate:
    # set ra = ra + PA2VA_OFFSET
    # set sp = sp + PA2VA_OFFSET (If you have set the sp before)
    li t0, 0xffffffdf80000000
ffffffe000200054:	fbf0029b          	addiw	t0,zero,-65
ffffffe000200058:	01f29293          	slli	t0,t0,0x1f
    add ra, ra, t0
ffffffe00020005c:	005080b3          	add	ra,ra,t0
    add sp, sp, t0
ffffffe000200060:	00510133          	add	sp,sp,t0
    
    la t1, if
ffffffe000200064:	00000317          	auipc	t1,0x0
ffffffe000200068:	03030313          	addi	t1,t1,48 # ffffffe000200094 <if>
    add t1,t1,t0
ffffffe00020006c:	00530333          	add	t1,t1,t0
    csrw stvec, t1
ffffffe000200070:	10531073          	csrw	stvec,t1
    sfence.vma zero, zero
ffffffe000200074:	12000073          	sfence.vma
    # set satp with early_pgtbl
    li t0, 0x8000000000000000
ffffffe000200078:	fff0029b          	addiw	t0,zero,-1
ffffffe00020007c:	03f29293          	slli	t0,t0,0x3f
    la t1, early_pgtbl
ffffffe000200080:	0000d317          	auipc	t1,0xd
ffffffe000200084:	f8030313          	addi	t1,t1,-128 # ffffffe00020d000 <early_pgtbl>
    srli t1, t1, 12
ffffffe000200088:	00c35313          	srli	t1,t1,0xc
    or t1, t1, t0
ffffffe00020008c:	00536333          	or	t1,t1,t0
    csrw satp, t1
ffffffe000200090:	18031073          	csrw	satp,t1

ffffffe000200094 <if>:
    if:
    ret
ffffffe000200094:	00008067          	ret

ffffffe000200098 <_traps>:
    .section .text.entry
    .align 2
    .globl _traps

_traps:
    csrrw sp, sscratch, sp
ffffffe000200098:	14011173          	csrrw	sp,sscratch,sp
    bne sp, x0, switch_to_kernel
ffffffe00020009c:	00011463          	bnez	sp,ffffffe0002000a4 <switch_to_kernel>
    csrrw sp, sscratch, sp
ffffffe0002000a0:	14011173          	csrrw	sp,sscratch,sp

ffffffe0002000a4 <switch_to_kernel>:
switch_to_kernel:
    addi sp, sp, -264
ffffffe0002000a4:	ef810113          	addi	sp,sp,-264 # ffffffe00020bef8 <_sbss+0xef8>
    sd x1, 0(sp)
ffffffe0002000a8:	00113023          	sd	ra,0(sp)
    sd x2, 8(sp)
ffffffe0002000ac:	00213423          	sd	sp,8(sp)
    sd x3, 16(sp)
ffffffe0002000b0:	00313823          	sd	gp,16(sp)
    sd x4, 24(sp)
ffffffe0002000b4:	00413c23          	sd	tp,24(sp)
    sd x5, 32(sp)
ffffffe0002000b8:	02513023          	sd	t0,32(sp)
    sd x6, 40(sp)
ffffffe0002000bc:	02613423          	sd	t1,40(sp)
    sd x7, 48(sp)
ffffffe0002000c0:	02713823          	sd	t2,48(sp)
    sd x8, 56(sp)
ffffffe0002000c4:	02813c23          	sd	s0,56(sp)
    sd x9, 64(sp)
ffffffe0002000c8:	04913023          	sd	s1,64(sp)
    sd x10, 72(sp)
ffffffe0002000cc:	04a13423          	sd	a0,72(sp)
    sd x11, 80(sp)
ffffffe0002000d0:	04b13823          	sd	a1,80(sp)
    sd x12, 88(sp)
ffffffe0002000d4:	04c13c23          	sd	a2,88(sp)
    sd x13, 96(sp)
ffffffe0002000d8:	06d13023          	sd	a3,96(sp)
    sd x14, 104(sp)
ffffffe0002000dc:	06e13423          	sd	a4,104(sp)
    sd x15, 112(sp)
ffffffe0002000e0:	06f13823          	sd	a5,112(sp)
    sd x16, 120(sp)
ffffffe0002000e4:	07013c23          	sd	a6,120(sp)
    sd x17, 128(sp)
ffffffe0002000e8:	09113023          	sd	a7,128(sp)
    sd x18, 136(sp)
ffffffe0002000ec:	09213423          	sd	s2,136(sp)
    sd x19, 144(sp)
ffffffe0002000f0:	09313823          	sd	s3,144(sp)
    sd x20, 152(sp)
ffffffe0002000f4:	09413c23          	sd	s4,152(sp)
    sd x21, 160(sp)
ffffffe0002000f8:	0b513023          	sd	s5,160(sp)
    sd x22, 168(sp)
ffffffe0002000fc:	0b613423          	sd	s6,168(sp)
    sd x23, 176(sp)
ffffffe000200100:	0b713823          	sd	s7,176(sp)
    sd x24, 184(sp)
ffffffe000200104:	0b813c23          	sd	s8,184(sp)
    sd x25, 192(sp)
ffffffe000200108:	0d913023          	sd	s9,192(sp)
    sd x26, 200(sp)
ffffffe00020010c:	0da13423          	sd	s10,200(sp)
    sd x27, 208(sp)
ffffffe000200110:	0db13823          	sd	s11,208(sp)
    sd x28, 216(sp)
ffffffe000200114:	0dc13c23          	sd	t3,216(sp)
    sd x29, 224(sp)
ffffffe000200118:	0fd13023          	sd	t4,224(sp)
    sd x30, 232(sp)
ffffffe00020011c:	0fe13423          	sd	t5,232(sp)
    sd x31, 240(sp)
ffffffe000200120:	0ff13823          	sd	t6,240(sp)
    csrr t0, sepc
ffffffe000200124:	141022f3          	csrr	t0,sepc
    sd t0, 248(sp)
ffffffe000200128:	0e513c23          	sd	t0,248(sp)

    mv a2, sp
ffffffe00020012c:	00010613          	mv	a2,sp
    csrr a0, scause 
ffffffe000200130:	14202573          	csrr	a0,scause
    csrr a1, sepc  
ffffffe000200134:	141025f3          	csrr	a1,sepc
    call trap_handler
ffffffe000200138:	1bd010ef          	jal	ffffffe000201af4 <trap_handler>

    ld t0, 248(sp)
ffffffe00020013c:	0f813283          	ld	t0,248(sp)
    csrw sepc, t0
ffffffe000200140:	14129073          	csrw	sepc,t0
    ld x1, 0(sp)
ffffffe000200144:	00013083          	ld	ra,0(sp)
    ld x2, 8(sp)
ffffffe000200148:	00813103          	ld	sp,8(sp)
    ld x3, 16(sp)
ffffffe00020014c:	01013183          	ld	gp,16(sp)
    ld x4, 24(sp)
ffffffe000200150:	01813203          	ld	tp,24(sp)
    ld x5, 32(sp)
ffffffe000200154:	02013283          	ld	t0,32(sp)
    ld x6, 40(sp)
ffffffe000200158:	02813303          	ld	t1,40(sp)
    ld x7, 48(sp)
ffffffe00020015c:	03013383          	ld	t2,48(sp)
    ld x8, 56(sp)
ffffffe000200160:	03813403          	ld	s0,56(sp)
    ld x9, 64(sp)
ffffffe000200164:	04013483          	ld	s1,64(sp)
    ld x10, 72(sp)
ffffffe000200168:	04813503          	ld	a0,72(sp)
    ld x11, 80(sp)
ffffffe00020016c:	05013583          	ld	a1,80(sp)
    ld x12, 88(sp)
ffffffe000200170:	05813603          	ld	a2,88(sp)
    ld x13, 96(sp)
ffffffe000200174:	06013683          	ld	a3,96(sp)
    ld x14, 104(sp)
ffffffe000200178:	06813703          	ld	a4,104(sp)
    ld x15, 112(sp)
ffffffe00020017c:	07013783          	ld	a5,112(sp)
    ld x16, 120(sp)
ffffffe000200180:	07813803          	ld	a6,120(sp)
    ld x17, 128(sp)
ffffffe000200184:	08013883          	ld	a7,128(sp)
    ld x18, 136(sp)
ffffffe000200188:	08813903          	ld	s2,136(sp)
    ld x19, 144(sp)
ffffffe00020018c:	09013983          	ld	s3,144(sp)
    ld x20, 152(sp)
ffffffe000200190:	09813a03          	ld	s4,152(sp)
    ld x21, 160(sp)
ffffffe000200194:	0a013a83          	ld	s5,160(sp)
    ld x22, 168(sp)
ffffffe000200198:	0a813b03          	ld	s6,168(sp)
    ld x23, 176(sp)
ffffffe00020019c:	0b013b83          	ld	s7,176(sp)
    ld x24, 184(sp)
ffffffe0002001a0:	0b813c03          	ld	s8,184(sp)
    ld x25, 192(sp)
ffffffe0002001a4:	0c013c83          	ld	s9,192(sp)
    ld x26, 200(sp)
ffffffe0002001a8:	0c813d03          	ld	s10,200(sp)
    ld x27, 208(sp)
ffffffe0002001ac:	0d013d83          	ld	s11,208(sp)
    ld x28, 216(sp)
ffffffe0002001b0:	0d813e03          	ld	t3,216(sp)
    ld x29, 224(sp)
ffffffe0002001b4:	0e013e83          	ld	t4,224(sp)
    ld x30, 232(sp)
ffffffe0002001b8:	0e813f03          	ld	t5,232(sp)
    ld x31, 240(sp)
ffffffe0002001bc:	0f013f83          	ld	t6,240(sp)
    addi sp, sp, 264
ffffffe0002001c0:	10810113          	addi	sp,sp,264
    csrrw sp, sscratch, sp
ffffffe0002001c4:	14011173          	csrrw	sp,sscratch,sp
    bne sp, x0, switch_to_user
ffffffe0002001c8:	00011463          	bnez	sp,ffffffe0002001d0 <switch_to_user>
    csrrw sp, sscratch, sp
ffffffe0002001cc:	14011173          	csrrw	sp,sscratch,sp

ffffffe0002001d0 <switch_to_user>:
switch_to_user:
    sret
ffffffe0002001d0:	10200073          	sret

ffffffe0002001d4 <__dummy>:

   
    .globl __dummy
__dummy:
    csrr t0, sscratch
ffffffe0002001d4:	140022f3          	csrr	t0,sscratch
    csrw sscratch, sp
ffffffe0002001d8:	14011073          	csrw	sscratch,sp
    addi sp, t0, 0
ffffffe0002001dc:	00028113          	mv	sp,t0
    #csrw sepc, x0
    #la t0,dummy
    #sd t0, 32(a1)
    #csrw sepc,t0
    sret
ffffffe0002001e0:	10200073          	sret

ffffffe0002001e4 <__switch_to>:



    .globl __switch_to
__switch_to:
    sd ra, 32(a0)
ffffffe0002001e4:	02153023          	sd	ra,32(a0)
    sd sp, 40(a0)
ffffffe0002001e8:	02253423          	sd	sp,40(a0)
    sd s0, 48(a0)
ffffffe0002001ec:	02853823          	sd	s0,48(a0)
    sd s1, 56(a0) 
ffffffe0002001f0:	02953c23          	sd	s1,56(a0)
    sd s2, 64(a0) 
ffffffe0002001f4:	05253023          	sd	s2,64(a0)
    sd s3, 72(a0)  
ffffffe0002001f8:	05353423          	sd	s3,72(a0)
    sd s4, 80(a0)
ffffffe0002001fc:	05453823          	sd	s4,80(a0)
    sd s5, 88(a0) 
ffffffe000200200:	05553c23          	sd	s5,88(a0)
    sd s6, 96(a0) 
ffffffe000200204:	07653023          	sd	s6,96(a0)
    sd s7, 104(a0)  
ffffffe000200208:	07753423          	sd	s7,104(a0)
    sd s8, 112(a0) 
ffffffe00020020c:	07853823          	sd	s8,112(a0)
    sd s9, 120(a0)  
ffffffe000200210:	07953c23          	sd	s9,120(a0)
    sd s10, 128(a0) 
ffffffe000200214:	09a53023          	sd	s10,128(a0)
    sd s11, 136(a0)
ffffffe000200218:	09b53423          	sd	s11,136(a0)
    csrr t1, sepc
ffffffe00020021c:	14102373          	csrr	t1,sepc
    sd t1, 144(a0)
ffffffe000200220:	08653823          	sd	t1,144(a0)
    csrr t1, sstatus
ffffffe000200224:	10002373          	csrr	t1,sstatus
    sd t1, 152(a0)
ffffffe000200228:	08653c23          	sd	t1,152(a0)
    csrr t1, sscratch
ffffffe00020022c:	14002373          	csrr	t1,sscratch
    sd t1, 160(a0)
ffffffe000200230:	0a653023          	sd	t1,160(a0)


    ld ra, 32(a1)
ffffffe000200234:	0205b083          	ld	ra,32(a1)
    ld sp, 40(a1)
ffffffe000200238:	0285b103          	ld	sp,40(a1)
    ld s0, 48(a1)
ffffffe00020023c:	0305b403          	ld	s0,48(a1)
    ld s1, 56(a1)  
ffffffe000200240:	0385b483          	ld	s1,56(a1)
    ld s2, 64(a1) 
ffffffe000200244:	0405b903          	ld	s2,64(a1)
    ld s3, 72(a1) 
ffffffe000200248:	0485b983          	ld	s3,72(a1)
    ld s4, 80(a1)  
ffffffe00020024c:	0505ba03          	ld	s4,80(a1)
    ld s5, 88(a1)  
ffffffe000200250:	0585ba83          	ld	s5,88(a1)
    ld s6, 96(a1) 
ffffffe000200254:	0605bb03          	ld	s6,96(a1)
    ld s7, 104(a1)  
ffffffe000200258:	0685bb83          	ld	s7,104(a1)
    ld s8, 112(a1)   
ffffffe00020025c:	0705bc03          	ld	s8,112(a1)
    ld s9, 120(a1) 
ffffffe000200260:	0785bc83          	ld	s9,120(a1)
    ld s10, 128(a1) 
ffffffe000200264:	0805bd03          	ld	s10,128(a1)
    ld s11, 136(a1) 
ffffffe000200268:	0885bd83          	ld	s11,136(a1)
    ld t1, 144(a1)
ffffffe00020026c:	0905b303          	ld	t1,144(a1)
    csrw sepc, t1
ffffffe000200270:	14131073          	csrw	sepc,t1
    ld t1, 152(a1)
ffffffe000200274:	0985b303          	ld	t1,152(a1)
    csrw sstatus, t1
ffffffe000200278:	10031073          	csrw	sstatus,t1
    ld t1, 160(a1)
ffffffe00020027c:	0a05b303          	ld	t1,160(a1)
    csrw sscratch, t1
ffffffe000200280:	14031073          	csrw	sscratch,t1
    ld t1, 168(a1)
ffffffe000200284:	0a85b303          	ld	t1,168(a1)
    li t0, 0xffffffdf80000000
ffffffe000200288:	fbf0029b          	addiw	t0,zero,-65
ffffffe00020028c:	01f29293          	slli	t0,t0,0x1f
    sub t1, t1, t0
ffffffe000200290:	40530333          	sub	t1,t1,t0
    srli t1, t1, 12
ffffffe000200294:	00c35313          	srli	t1,t1,0xc
    li t0, 0x8000000000000000
ffffffe000200298:	fff0029b          	addiw	t0,zero,-1
ffffffe00020029c:	03f29293          	slli	t0,t0,0x3f
    or t1, t1, t0
ffffffe0002002a0:	00536333          	or	t1,t1,t0
    csrw satp, t1
ffffffe0002002a4:	18031073          	csrw	satp,t1
    
    sfence.vma zero, zero
ffffffe0002002a8:	12000073          	sfence.vma

    ret
ffffffe0002002ac:	00008067          	ret

ffffffe0002002b0 <get_cycles>:
#include "defs.h"

// QEMU 中时钟的频率是 10MHz，也就是 1 秒钟相当于 10000000 个时钟周期
uint64_t TIMECLOCK = 10000000;

uint64_t get_cycles() {
ffffffe0002002b0:	fe010113          	addi	sp,sp,-32
ffffffe0002002b4:	00813c23          	sd	s0,24(sp)
ffffffe0002002b8:	02010413          	addi	s0,sp,32
     uint64_t cycles;
    __asm__ volatile (
ffffffe0002002bc:	c01027f3          	rdtime	a5
ffffffe0002002c0:	fef43423          	sd	a5,-24(s0)
        "rdtime %[cycles]"
        : [cycles] "=r" (cycles)  
        :  
        : "memory"  
    );
    return cycles;
ffffffe0002002c4:	fe843783          	ld	a5,-24(s0)
}
ffffffe0002002c8:	00078513          	mv	a0,a5
ffffffe0002002cc:	01813403          	ld	s0,24(sp)
ffffffe0002002d0:	02010113          	addi	sp,sp,32
ffffffe0002002d4:	00008067          	ret

ffffffe0002002d8 <clock_set_next_event>:

void clock_set_next_event() {
ffffffe0002002d8:	fe010113          	addi	sp,sp,-32
ffffffe0002002dc:	00113c23          	sd	ra,24(sp)
ffffffe0002002e0:	00813823          	sd	s0,16(sp)
ffffffe0002002e4:	02010413          	addi	s0,sp,32
    uint64_t next = get_cycles() + TIMECLOCK;
ffffffe0002002e8:	fc9ff0ef          	jal	ffffffe0002002b0 <get_cycles>
ffffffe0002002ec:	00050713          	mv	a4,a0
ffffffe0002002f0:	00007797          	auipc	a5,0x7
ffffffe0002002f4:	d1078793          	addi	a5,a5,-752 # ffffffe000207000 <TIMECLOCK>
ffffffe0002002f8:	0007b783          	ld	a5,0(a5)
ffffffe0002002fc:	00f707b3          	add	a5,a4,a5
ffffffe000200300:	fef43423          	sd	a5,-24(s0)
    sbi_set_timer(next);
ffffffe000200304:	fe843503          	ld	a0,-24(s0)
ffffffe000200308:	49c010ef          	jal	ffffffe0002017a4 <sbi_set_timer>
}
ffffffe00020030c:	00000013          	nop
ffffffe000200310:	01813083          	ld	ra,24(sp)
ffffffe000200314:	01013403          	ld	s0,16(sp)
ffffffe000200318:	02010113          	addi	sp,sp,32
ffffffe00020031c:	00008067          	ret

ffffffe000200320 <fixsize>:
#define MAX(a, b) ((a) > (b) ? (a) : (b))

void *free_page_start = &_ekernel;
struct buddy buddy;

static uint64_t fixsize(uint64_t size) {
ffffffe000200320:	fe010113          	addi	sp,sp,-32
ffffffe000200324:	00813c23          	sd	s0,24(sp)
ffffffe000200328:	02010413          	addi	s0,sp,32
ffffffe00020032c:	fea43423          	sd	a0,-24(s0)
    size --;
ffffffe000200330:	fe843783          	ld	a5,-24(s0)
ffffffe000200334:	fff78793          	addi	a5,a5,-1
ffffffe000200338:	fef43423          	sd	a5,-24(s0)
    size |= size >> 1;
ffffffe00020033c:	fe843783          	ld	a5,-24(s0)
ffffffe000200340:	0017d793          	srli	a5,a5,0x1
ffffffe000200344:	fe843703          	ld	a4,-24(s0)
ffffffe000200348:	00f767b3          	or	a5,a4,a5
ffffffe00020034c:	fef43423          	sd	a5,-24(s0)
    size |= size >> 2;
ffffffe000200350:	fe843783          	ld	a5,-24(s0)
ffffffe000200354:	0027d793          	srli	a5,a5,0x2
ffffffe000200358:	fe843703          	ld	a4,-24(s0)
ffffffe00020035c:	00f767b3          	or	a5,a4,a5
ffffffe000200360:	fef43423          	sd	a5,-24(s0)
    size |= size >> 4;
ffffffe000200364:	fe843783          	ld	a5,-24(s0)
ffffffe000200368:	0047d793          	srli	a5,a5,0x4
ffffffe00020036c:	fe843703          	ld	a4,-24(s0)
ffffffe000200370:	00f767b3          	or	a5,a4,a5
ffffffe000200374:	fef43423          	sd	a5,-24(s0)
    size |= size >> 8;
ffffffe000200378:	fe843783          	ld	a5,-24(s0)
ffffffe00020037c:	0087d793          	srli	a5,a5,0x8
ffffffe000200380:	fe843703          	ld	a4,-24(s0)
ffffffe000200384:	00f767b3          	or	a5,a4,a5
ffffffe000200388:	fef43423          	sd	a5,-24(s0)
    size |= size >> 16;
ffffffe00020038c:	fe843783          	ld	a5,-24(s0)
ffffffe000200390:	0107d793          	srli	a5,a5,0x10
ffffffe000200394:	fe843703          	ld	a4,-24(s0)
ffffffe000200398:	00f767b3          	or	a5,a4,a5
ffffffe00020039c:	fef43423          	sd	a5,-24(s0)
    size |= size >> 32;
ffffffe0002003a0:	fe843783          	ld	a5,-24(s0)
ffffffe0002003a4:	0207d793          	srli	a5,a5,0x20
ffffffe0002003a8:	fe843703          	ld	a4,-24(s0)
ffffffe0002003ac:	00f767b3          	or	a5,a4,a5
ffffffe0002003b0:	fef43423          	sd	a5,-24(s0)
    return size + 1;
ffffffe0002003b4:	fe843783          	ld	a5,-24(s0)
ffffffe0002003b8:	00178793          	addi	a5,a5,1
}
ffffffe0002003bc:	00078513          	mv	a0,a5
ffffffe0002003c0:	01813403          	ld	s0,24(sp)
ffffffe0002003c4:	02010113          	addi	sp,sp,32
ffffffe0002003c8:	00008067          	ret

ffffffe0002003cc <buddy_init>:

void buddy_init() {
ffffffe0002003cc:	fd010113          	addi	sp,sp,-48
ffffffe0002003d0:	02113423          	sd	ra,40(sp)
ffffffe0002003d4:	02813023          	sd	s0,32(sp)
ffffffe0002003d8:	03010413          	addi	s0,sp,48
    uint64_t buddy_size = (uint64_t)PHY_SIZE / PGSIZE;
ffffffe0002003dc:	000087b7          	lui	a5,0x8
ffffffe0002003e0:	fef43423          	sd	a5,-24(s0)

    if (!IS_POWER_OF_2(buddy_size))
ffffffe0002003e4:	fe843783          	ld	a5,-24(s0)
ffffffe0002003e8:	fff78713          	addi	a4,a5,-1 # 7fff <PGSIZE+0x6fff>
ffffffe0002003ec:	fe843783          	ld	a5,-24(s0)
ffffffe0002003f0:	00f777b3          	and	a5,a4,a5
ffffffe0002003f4:	00078863          	beqz	a5,ffffffe000200404 <buddy_init+0x38>
        buddy_size = fixsize(buddy_size);
ffffffe0002003f8:	fe843503          	ld	a0,-24(s0)
ffffffe0002003fc:	f25ff0ef          	jal	ffffffe000200320 <fixsize>
ffffffe000200400:	fea43423          	sd	a0,-24(s0)

    buddy.size = buddy_size;
ffffffe000200404:	0000c797          	auipc	a5,0xc
ffffffe000200408:	c3478793          	addi	a5,a5,-972 # ffffffe00020c038 <buddy>
ffffffe00020040c:	fe843703          	ld	a4,-24(s0)
ffffffe000200410:	00e7b023          	sd	a4,0(a5)
    buddy.bitmap = free_page_start;
ffffffe000200414:	00007797          	auipc	a5,0x7
ffffffe000200418:	bf478793          	addi	a5,a5,-1036 # ffffffe000207008 <free_page_start>
ffffffe00020041c:	0007b703          	ld	a4,0(a5)
ffffffe000200420:	0000c797          	auipc	a5,0xc
ffffffe000200424:	c1878793          	addi	a5,a5,-1000 # ffffffe00020c038 <buddy>
ffffffe000200428:	00e7b423          	sd	a4,8(a5)
    free_page_start += 2 * buddy.size * sizeof(*buddy.bitmap);
ffffffe00020042c:	00007797          	auipc	a5,0x7
ffffffe000200430:	bdc78793          	addi	a5,a5,-1060 # ffffffe000207008 <free_page_start>
ffffffe000200434:	0007b703          	ld	a4,0(a5)
ffffffe000200438:	0000c797          	auipc	a5,0xc
ffffffe00020043c:	c0078793          	addi	a5,a5,-1024 # ffffffe00020c038 <buddy>
ffffffe000200440:	0007b783          	ld	a5,0(a5)
ffffffe000200444:	00479793          	slli	a5,a5,0x4
ffffffe000200448:	00f70733          	add	a4,a4,a5
ffffffe00020044c:	00007797          	auipc	a5,0x7
ffffffe000200450:	bbc78793          	addi	a5,a5,-1092 # ffffffe000207008 <free_page_start>
ffffffe000200454:	00e7b023          	sd	a4,0(a5)
    memset(buddy.bitmap, 0, 2 * buddy.size * sizeof(*buddy.bitmap));
ffffffe000200458:	0000c797          	auipc	a5,0xc
ffffffe00020045c:	be078793          	addi	a5,a5,-1056 # ffffffe00020c038 <buddy>
ffffffe000200460:	0087b703          	ld	a4,8(a5)
ffffffe000200464:	0000c797          	auipc	a5,0xc
ffffffe000200468:	bd478793          	addi	a5,a5,-1068 # ffffffe00020c038 <buddy>
ffffffe00020046c:	0007b783          	ld	a5,0(a5)
ffffffe000200470:	00479793          	slli	a5,a5,0x4
ffffffe000200474:	00078613          	mv	a2,a5
ffffffe000200478:	00000593          	li	a1,0
ffffffe00020047c:	00070513          	mv	a0,a4
ffffffe000200480:	40d020ef          	jal	ffffffe00020308c <memset>

    uint64_t node_size = buddy.size * 2;
ffffffe000200484:	0000c797          	auipc	a5,0xc
ffffffe000200488:	bb478793          	addi	a5,a5,-1100 # ffffffe00020c038 <buddy>
ffffffe00020048c:	0007b783          	ld	a5,0(a5)
ffffffe000200490:	00179793          	slli	a5,a5,0x1
ffffffe000200494:	fef43023          	sd	a5,-32(s0)
    for (uint64_t i = 0; i < 2 * buddy.size - 1; ++i) {
ffffffe000200498:	fc043c23          	sd	zero,-40(s0)
ffffffe00020049c:	0500006f          	j	ffffffe0002004ec <buddy_init+0x120>
        if (IS_POWER_OF_2(i + 1))
ffffffe0002004a0:	fd843783          	ld	a5,-40(s0)
ffffffe0002004a4:	00178713          	addi	a4,a5,1
ffffffe0002004a8:	fd843783          	ld	a5,-40(s0)
ffffffe0002004ac:	00f777b3          	and	a5,a4,a5
ffffffe0002004b0:	00079863          	bnez	a5,ffffffe0002004c0 <buddy_init+0xf4>
            node_size /= 2;
ffffffe0002004b4:	fe043783          	ld	a5,-32(s0)
ffffffe0002004b8:	0017d793          	srli	a5,a5,0x1
ffffffe0002004bc:	fef43023          	sd	a5,-32(s0)
        buddy.bitmap[i] = node_size;
ffffffe0002004c0:	0000c797          	auipc	a5,0xc
ffffffe0002004c4:	b7878793          	addi	a5,a5,-1160 # ffffffe00020c038 <buddy>
ffffffe0002004c8:	0087b703          	ld	a4,8(a5)
ffffffe0002004cc:	fd843783          	ld	a5,-40(s0)
ffffffe0002004d0:	00379793          	slli	a5,a5,0x3
ffffffe0002004d4:	00f707b3          	add	a5,a4,a5
ffffffe0002004d8:	fe043703          	ld	a4,-32(s0)
ffffffe0002004dc:	00e7b023          	sd	a4,0(a5)
    for (uint64_t i = 0; i < 2 * buddy.size - 1; ++i) {
ffffffe0002004e0:	fd843783          	ld	a5,-40(s0)
ffffffe0002004e4:	00178793          	addi	a5,a5,1
ffffffe0002004e8:	fcf43c23          	sd	a5,-40(s0)
ffffffe0002004ec:	0000c797          	auipc	a5,0xc
ffffffe0002004f0:	b4c78793          	addi	a5,a5,-1204 # ffffffe00020c038 <buddy>
ffffffe0002004f4:	0007b783          	ld	a5,0(a5)
ffffffe0002004f8:	00179793          	slli	a5,a5,0x1
ffffffe0002004fc:	fff78793          	addi	a5,a5,-1
ffffffe000200500:	fd843703          	ld	a4,-40(s0)
ffffffe000200504:	f8f76ee3          	bltu	a4,a5,ffffffe0002004a0 <buddy_init+0xd4>
    }

    for (uint64_t pfn = 0; (uint64_t)PFN2PHYS(pfn) < VA2PA((uint64_t)free_page_start); ++pfn) {
ffffffe000200508:	fc043823          	sd	zero,-48(s0)
ffffffe00020050c:	0180006f          	j	ffffffe000200524 <buddy_init+0x158>
        buddy_alloc(1);
ffffffe000200510:	00100513          	li	a0,1
ffffffe000200514:	1fc000ef          	jal	ffffffe000200710 <buddy_alloc>
    for (uint64_t pfn = 0; (uint64_t)PFN2PHYS(pfn) < VA2PA((uint64_t)free_page_start); ++pfn) {
ffffffe000200518:	fd043783          	ld	a5,-48(s0)
ffffffe00020051c:	00178793          	addi	a5,a5,1
ffffffe000200520:	fcf43823          	sd	a5,-48(s0)
ffffffe000200524:	fd043783          	ld	a5,-48(s0)
ffffffe000200528:	00c79713          	slli	a4,a5,0xc
ffffffe00020052c:	00100793          	li	a5,1
ffffffe000200530:	01f79793          	slli	a5,a5,0x1f
ffffffe000200534:	00f70733          	add	a4,a4,a5
ffffffe000200538:	00007797          	auipc	a5,0x7
ffffffe00020053c:	ad078793          	addi	a5,a5,-1328 # ffffffe000207008 <free_page_start>
ffffffe000200540:	0007b783          	ld	a5,0(a5)
ffffffe000200544:	00078693          	mv	a3,a5
ffffffe000200548:	04100793          	li	a5,65
ffffffe00020054c:	01f79793          	slli	a5,a5,0x1f
ffffffe000200550:	00f687b3          	add	a5,a3,a5
ffffffe000200554:	faf76ee3          	bltu	a4,a5,ffffffe000200510 <buddy_init+0x144>
    }

    printk("...buddy_init done!\n");
ffffffe000200558:	00005517          	auipc	a0,0x5
ffffffe00020055c:	ab050513          	addi	a0,a0,-1360 # ffffffe000205008 <_PA2VA_OFFSET+0x8>
ffffffe000200560:	20d020ef          	jal	ffffffe000202f6c <printk>
    return;
ffffffe000200564:	00000013          	nop
}
ffffffe000200568:	02813083          	ld	ra,40(sp)
ffffffe00020056c:	02013403          	ld	s0,32(sp)
ffffffe000200570:	03010113          	addi	sp,sp,48
ffffffe000200574:	00008067          	ret

ffffffe000200578 <buddy_free>:

void buddy_free(uint64_t pfn) {
ffffffe000200578:	fc010113          	addi	sp,sp,-64
ffffffe00020057c:	02813c23          	sd	s0,56(sp)
ffffffe000200580:	04010413          	addi	s0,sp,64
ffffffe000200584:	fca43423          	sd	a0,-56(s0)
    uint64_t node_size, index = 0;
ffffffe000200588:	fe043023          	sd	zero,-32(s0)
    uint64_t left_longest, right_longest;

    node_size = 1;
ffffffe00020058c:	00100793          	li	a5,1
ffffffe000200590:	fef43423          	sd	a5,-24(s0)
    index = pfn + buddy.size - 1;
ffffffe000200594:	0000c797          	auipc	a5,0xc
ffffffe000200598:	aa478793          	addi	a5,a5,-1372 # ffffffe00020c038 <buddy>
ffffffe00020059c:	0007b703          	ld	a4,0(a5)
ffffffe0002005a0:	fc843783          	ld	a5,-56(s0)
ffffffe0002005a4:	00f707b3          	add	a5,a4,a5
ffffffe0002005a8:	fff78793          	addi	a5,a5,-1
ffffffe0002005ac:	fef43023          	sd	a5,-32(s0)

    for (; buddy.bitmap[index]; index = PARENT(index)) {
ffffffe0002005b0:	02c0006f          	j	ffffffe0002005dc <buddy_free+0x64>
        node_size *= 2;
ffffffe0002005b4:	fe843783          	ld	a5,-24(s0)
ffffffe0002005b8:	00179793          	slli	a5,a5,0x1
ffffffe0002005bc:	fef43423          	sd	a5,-24(s0)
        if (index == 0)
ffffffe0002005c0:	fe043783          	ld	a5,-32(s0)
ffffffe0002005c4:	02078e63          	beqz	a5,ffffffe000200600 <buddy_free+0x88>
    for (; buddy.bitmap[index]; index = PARENT(index)) {
ffffffe0002005c8:	fe043783          	ld	a5,-32(s0)
ffffffe0002005cc:	00178793          	addi	a5,a5,1
ffffffe0002005d0:	0017d793          	srli	a5,a5,0x1
ffffffe0002005d4:	fff78793          	addi	a5,a5,-1
ffffffe0002005d8:	fef43023          	sd	a5,-32(s0)
ffffffe0002005dc:	0000c797          	auipc	a5,0xc
ffffffe0002005e0:	a5c78793          	addi	a5,a5,-1444 # ffffffe00020c038 <buddy>
ffffffe0002005e4:	0087b703          	ld	a4,8(a5)
ffffffe0002005e8:	fe043783          	ld	a5,-32(s0)
ffffffe0002005ec:	00379793          	slli	a5,a5,0x3
ffffffe0002005f0:	00f707b3          	add	a5,a4,a5
ffffffe0002005f4:	0007b783          	ld	a5,0(a5)
ffffffe0002005f8:	fa079ee3          	bnez	a5,ffffffe0002005b4 <buddy_free+0x3c>
ffffffe0002005fc:	0080006f          	j	ffffffe000200604 <buddy_free+0x8c>
            break;
ffffffe000200600:	00000013          	nop
    }

    buddy.bitmap[index] = node_size;
ffffffe000200604:	0000c797          	auipc	a5,0xc
ffffffe000200608:	a3478793          	addi	a5,a5,-1484 # ffffffe00020c038 <buddy>
ffffffe00020060c:	0087b703          	ld	a4,8(a5)
ffffffe000200610:	fe043783          	ld	a5,-32(s0)
ffffffe000200614:	00379793          	slli	a5,a5,0x3
ffffffe000200618:	00f707b3          	add	a5,a4,a5
ffffffe00020061c:	fe843703          	ld	a4,-24(s0)
ffffffe000200620:	00e7b023          	sd	a4,0(a5)

    while (index) {
ffffffe000200624:	0d00006f          	j	ffffffe0002006f4 <buddy_free+0x17c>
        index = PARENT(index);
ffffffe000200628:	fe043783          	ld	a5,-32(s0)
ffffffe00020062c:	00178793          	addi	a5,a5,1
ffffffe000200630:	0017d793          	srli	a5,a5,0x1
ffffffe000200634:	fff78793          	addi	a5,a5,-1
ffffffe000200638:	fef43023          	sd	a5,-32(s0)
        node_size *= 2;
ffffffe00020063c:	fe843783          	ld	a5,-24(s0)
ffffffe000200640:	00179793          	slli	a5,a5,0x1
ffffffe000200644:	fef43423          	sd	a5,-24(s0)

        left_longest = buddy.bitmap[LEFT_LEAF(index)];
ffffffe000200648:	0000c797          	auipc	a5,0xc
ffffffe00020064c:	9f078793          	addi	a5,a5,-1552 # ffffffe00020c038 <buddy>
ffffffe000200650:	0087b703          	ld	a4,8(a5)
ffffffe000200654:	fe043783          	ld	a5,-32(s0)
ffffffe000200658:	00479793          	slli	a5,a5,0x4
ffffffe00020065c:	00878793          	addi	a5,a5,8
ffffffe000200660:	00f707b3          	add	a5,a4,a5
ffffffe000200664:	0007b783          	ld	a5,0(a5)
ffffffe000200668:	fcf43c23          	sd	a5,-40(s0)
        right_longest = buddy.bitmap[RIGHT_LEAF(index)];
ffffffe00020066c:	0000c797          	auipc	a5,0xc
ffffffe000200670:	9cc78793          	addi	a5,a5,-1588 # ffffffe00020c038 <buddy>
ffffffe000200674:	0087b703          	ld	a4,8(a5)
ffffffe000200678:	fe043783          	ld	a5,-32(s0)
ffffffe00020067c:	00178793          	addi	a5,a5,1
ffffffe000200680:	00479793          	slli	a5,a5,0x4
ffffffe000200684:	00f707b3          	add	a5,a4,a5
ffffffe000200688:	0007b783          	ld	a5,0(a5)
ffffffe00020068c:	fcf43823          	sd	a5,-48(s0)

        if (left_longest + right_longest == node_size) 
ffffffe000200690:	fd843703          	ld	a4,-40(s0)
ffffffe000200694:	fd043783          	ld	a5,-48(s0)
ffffffe000200698:	00f707b3          	add	a5,a4,a5
ffffffe00020069c:	fe843703          	ld	a4,-24(s0)
ffffffe0002006a0:	02f71463          	bne	a4,a5,ffffffe0002006c8 <buddy_free+0x150>
            buddy.bitmap[index] = node_size;
ffffffe0002006a4:	0000c797          	auipc	a5,0xc
ffffffe0002006a8:	99478793          	addi	a5,a5,-1644 # ffffffe00020c038 <buddy>
ffffffe0002006ac:	0087b703          	ld	a4,8(a5)
ffffffe0002006b0:	fe043783          	ld	a5,-32(s0)
ffffffe0002006b4:	00379793          	slli	a5,a5,0x3
ffffffe0002006b8:	00f707b3          	add	a5,a4,a5
ffffffe0002006bc:	fe843703          	ld	a4,-24(s0)
ffffffe0002006c0:	00e7b023          	sd	a4,0(a5)
ffffffe0002006c4:	0300006f          	j	ffffffe0002006f4 <buddy_free+0x17c>
        else
            buddy.bitmap[index] = MAX(left_longest, right_longest);
ffffffe0002006c8:	0000c797          	auipc	a5,0xc
ffffffe0002006cc:	97078793          	addi	a5,a5,-1680 # ffffffe00020c038 <buddy>
ffffffe0002006d0:	0087b703          	ld	a4,8(a5)
ffffffe0002006d4:	fe043783          	ld	a5,-32(s0)
ffffffe0002006d8:	00379793          	slli	a5,a5,0x3
ffffffe0002006dc:	00f706b3          	add	a3,a4,a5
ffffffe0002006e0:	fd843703          	ld	a4,-40(s0)
ffffffe0002006e4:	fd043783          	ld	a5,-48(s0)
ffffffe0002006e8:	00e7f463          	bgeu	a5,a4,ffffffe0002006f0 <buddy_free+0x178>
ffffffe0002006ec:	00070793          	mv	a5,a4
ffffffe0002006f0:	00f6b023          	sd	a5,0(a3)
    while (index) {
ffffffe0002006f4:	fe043783          	ld	a5,-32(s0)
ffffffe0002006f8:	f20798e3          	bnez	a5,ffffffe000200628 <buddy_free+0xb0>
    }
}
ffffffe0002006fc:	00000013          	nop
ffffffe000200700:	00000013          	nop
ffffffe000200704:	03813403          	ld	s0,56(sp)
ffffffe000200708:	04010113          	addi	sp,sp,64
ffffffe00020070c:	00008067          	ret

ffffffe000200710 <buddy_alloc>:

uint64_t buddy_alloc(uint64_t nrpages) {
ffffffe000200710:	fc010113          	addi	sp,sp,-64
ffffffe000200714:	02113c23          	sd	ra,56(sp)
ffffffe000200718:	02813823          	sd	s0,48(sp)
ffffffe00020071c:	04010413          	addi	s0,sp,64
ffffffe000200720:	fca43423          	sd	a0,-56(s0)
    uint64_t index = 0;
ffffffe000200724:	fe043423          	sd	zero,-24(s0)
    uint64_t node_size;
    uint64_t pfn = 0;
ffffffe000200728:	fc043c23          	sd	zero,-40(s0)

    if (nrpages <= 0)
ffffffe00020072c:	fc843783          	ld	a5,-56(s0)
ffffffe000200730:	00079863          	bnez	a5,ffffffe000200740 <buddy_alloc+0x30>
        nrpages = 1;
ffffffe000200734:	00100793          	li	a5,1
ffffffe000200738:	fcf43423          	sd	a5,-56(s0)
ffffffe00020073c:	0240006f          	j	ffffffe000200760 <buddy_alloc+0x50>
    else if (!IS_POWER_OF_2(nrpages))
ffffffe000200740:	fc843783          	ld	a5,-56(s0)
ffffffe000200744:	fff78713          	addi	a4,a5,-1
ffffffe000200748:	fc843783          	ld	a5,-56(s0)
ffffffe00020074c:	00f777b3          	and	a5,a4,a5
ffffffe000200750:	00078863          	beqz	a5,ffffffe000200760 <buddy_alloc+0x50>
        nrpages = fixsize(nrpages);
ffffffe000200754:	fc843503          	ld	a0,-56(s0)
ffffffe000200758:	bc9ff0ef          	jal	ffffffe000200320 <fixsize>
ffffffe00020075c:	fca43423          	sd	a0,-56(s0)

    if (buddy.bitmap[index] < nrpages)
ffffffe000200760:	0000c797          	auipc	a5,0xc
ffffffe000200764:	8d878793          	addi	a5,a5,-1832 # ffffffe00020c038 <buddy>
ffffffe000200768:	0087b703          	ld	a4,8(a5)
ffffffe00020076c:	fe843783          	ld	a5,-24(s0)
ffffffe000200770:	00379793          	slli	a5,a5,0x3
ffffffe000200774:	00f707b3          	add	a5,a4,a5
ffffffe000200778:	0007b783          	ld	a5,0(a5)
ffffffe00020077c:	fc843703          	ld	a4,-56(s0)
ffffffe000200780:	00e7f663          	bgeu	a5,a4,ffffffe00020078c <buddy_alloc+0x7c>
        return 0;
ffffffe000200784:	00000793          	li	a5,0
ffffffe000200788:	1480006f          	j	ffffffe0002008d0 <buddy_alloc+0x1c0>

    for(node_size = buddy.size; node_size != nrpages; node_size /= 2 ) {
ffffffe00020078c:	0000c797          	auipc	a5,0xc
ffffffe000200790:	8ac78793          	addi	a5,a5,-1876 # ffffffe00020c038 <buddy>
ffffffe000200794:	0007b783          	ld	a5,0(a5)
ffffffe000200798:	fef43023          	sd	a5,-32(s0)
ffffffe00020079c:	05c0006f          	j	ffffffe0002007f8 <buddy_alloc+0xe8>
        if (buddy.bitmap[LEFT_LEAF(index)] >= nrpages)
ffffffe0002007a0:	0000c797          	auipc	a5,0xc
ffffffe0002007a4:	89878793          	addi	a5,a5,-1896 # ffffffe00020c038 <buddy>
ffffffe0002007a8:	0087b703          	ld	a4,8(a5)
ffffffe0002007ac:	fe843783          	ld	a5,-24(s0)
ffffffe0002007b0:	00479793          	slli	a5,a5,0x4
ffffffe0002007b4:	00878793          	addi	a5,a5,8
ffffffe0002007b8:	00f707b3          	add	a5,a4,a5
ffffffe0002007bc:	0007b783          	ld	a5,0(a5)
ffffffe0002007c0:	fc843703          	ld	a4,-56(s0)
ffffffe0002007c4:	00e7ec63          	bltu	a5,a4,ffffffe0002007dc <buddy_alloc+0xcc>
            index = LEFT_LEAF(index);
ffffffe0002007c8:	fe843783          	ld	a5,-24(s0)
ffffffe0002007cc:	00179793          	slli	a5,a5,0x1
ffffffe0002007d0:	00178793          	addi	a5,a5,1
ffffffe0002007d4:	fef43423          	sd	a5,-24(s0)
ffffffe0002007d8:	0140006f          	j	ffffffe0002007ec <buddy_alloc+0xdc>
        else
            index = RIGHT_LEAF(index);
ffffffe0002007dc:	fe843783          	ld	a5,-24(s0)
ffffffe0002007e0:	00178793          	addi	a5,a5,1
ffffffe0002007e4:	00179793          	slli	a5,a5,0x1
ffffffe0002007e8:	fef43423          	sd	a5,-24(s0)
    for(node_size = buddy.size; node_size != nrpages; node_size /= 2 ) {
ffffffe0002007ec:	fe043783          	ld	a5,-32(s0)
ffffffe0002007f0:	0017d793          	srli	a5,a5,0x1
ffffffe0002007f4:	fef43023          	sd	a5,-32(s0)
ffffffe0002007f8:	fe043703          	ld	a4,-32(s0)
ffffffe0002007fc:	fc843783          	ld	a5,-56(s0)
ffffffe000200800:	faf710e3          	bne	a4,a5,ffffffe0002007a0 <buddy_alloc+0x90>
    }

    buddy.bitmap[index] = 0;
ffffffe000200804:	0000c797          	auipc	a5,0xc
ffffffe000200808:	83478793          	addi	a5,a5,-1996 # ffffffe00020c038 <buddy>
ffffffe00020080c:	0087b703          	ld	a4,8(a5)
ffffffe000200810:	fe843783          	ld	a5,-24(s0)
ffffffe000200814:	00379793          	slli	a5,a5,0x3
ffffffe000200818:	00f707b3          	add	a5,a4,a5
ffffffe00020081c:	0007b023          	sd	zero,0(a5)
    pfn = (index + 1) * node_size - buddy.size;
ffffffe000200820:	fe843783          	ld	a5,-24(s0)
ffffffe000200824:	00178713          	addi	a4,a5,1
ffffffe000200828:	fe043783          	ld	a5,-32(s0)
ffffffe00020082c:	02f70733          	mul	a4,a4,a5
ffffffe000200830:	0000c797          	auipc	a5,0xc
ffffffe000200834:	80878793          	addi	a5,a5,-2040 # ffffffe00020c038 <buddy>
ffffffe000200838:	0007b783          	ld	a5,0(a5)
ffffffe00020083c:	40f707b3          	sub	a5,a4,a5
ffffffe000200840:	fcf43c23          	sd	a5,-40(s0)

    while (index) {
ffffffe000200844:	0800006f          	j	ffffffe0002008c4 <buddy_alloc+0x1b4>
        index = PARENT(index);
ffffffe000200848:	fe843783          	ld	a5,-24(s0)
ffffffe00020084c:	00178793          	addi	a5,a5,1
ffffffe000200850:	0017d793          	srli	a5,a5,0x1
ffffffe000200854:	fff78793          	addi	a5,a5,-1
ffffffe000200858:	fef43423          	sd	a5,-24(s0)
        buddy.bitmap[index] = 
            MAX(buddy.bitmap[LEFT_LEAF(index)], buddy.bitmap[RIGHT_LEAF(index)]);
ffffffe00020085c:	0000b797          	auipc	a5,0xb
ffffffe000200860:	7dc78793          	addi	a5,a5,2012 # ffffffe00020c038 <buddy>
ffffffe000200864:	0087b703          	ld	a4,8(a5)
ffffffe000200868:	fe843783          	ld	a5,-24(s0)
ffffffe00020086c:	00178793          	addi	a5,a5,1
ffffffe000200870:	00479793          	slli	a5,a5,0x4
ffffffe000200874:	00f707b3          	add	a5,a4,a5
ffffffe000200878:	0007b603          	ld	a2,0(a5)
ffffffe00020087c:	0000b797          	auipc	a5,0xb
ffffffe000200880:	7bc78793          	addi	a5,a5,1980 # ffffffe00020c038 <buddy>
ffffffe000200884:	0087b703          	ld	a4,8(a5)
ffffffe000200888:	fe843783          	ld	a5,-24(s0)
ffffffe00020088c:	00479793          	slli	a5,a5,0x4
ffffffe000200890:	00878793          	addi	a5,a5,8
ffffffe000200894:	00f707b3          	add	a5,a4,a5
ffffffe000200898:	0007b703          	ld	a4,0(a5)
        buddy.bitmap[index] = 
ffffffe00020089c:	0000b797          	auipc	a5,0xb
ffffffe0002008a0:	79c78793          	addi	a5,a5,1948 # ffffffe00020c038 <buddy>
ffffffe0002008a4:	0087b683          	ld	a3,8(a5)
ffffffe0002008a8:	fe843783          	ld	a5,-24(s0)
ffffffe0002008ac:	00379793          	slli	a5,a5,0x3
ffffffe0002008b0:	00f686b3          	add	a3,a3,a5
            MAX(buddy.bitmap[LEFT_LEAF(index)], buddy.bitmap[RIGHT_LEAF(index)]);
ffffffe0002008b4:	00060793          	mv	a5,a2
ffffffe0002008b8:	00e7f463          	bgeu	a5,a4,ffffffe0002008c0 <buddy_alloc+0x1b0>
ffffffe0002008bc:	00070793          	mv	a5,a4
        buddy.bitmap[index] = 
ffffffe0002008c0:	00f6b023          	sd	a5,0(a3)
    while (index) {
ffffffe0002008c4:	fe843783          	ld	a5,-24(s0)
ffffffe0002008c8:	f80790e3          	bnez	a5,ffffffe000200848 <buddy_alloc+0x138>
    }
    
    return pfn;
ffffffe0002008cc:	fd843783          	ld	a5,-40(s0)
}
ffffffe0002008d0:	00078513          	mv	a0,a5
ffffffe0002008d4:	03813083          	ld	ra,56(sp)
ffffffe0002008d8:	03013403          	ld	s0,48(sp)
ffffffe0002008dc:	04010113          	addi	sp,sp,64
ffffffe0002008e0:	00008067          	ret

ffffffe0002008e4 <alloc_pages>:


void *alloc_pages(uint64_t nrpages) {
ffffffe0002008e4:	fd010113          	addi	sp,sp,-48
ffffffe0002008e8:	02113423          	sd	ra,40(sp)
ffffffe0002008ec:	02813023          	sd	s0,32(sp)
ffffffe0002008f0:	03010413          	addi	s0,sp,48
ffffffe0002008f4:	fca43c23          	sd	a0,-40(s0)
    uint64_t pfn = buddy_alloc(nrpages);
ffffffe0002008f8:	fd843503          	ld	a0,-40(s0)
ffffffe0002008fc:	e15ff0ef          	jal	ffffffe000200710 <buddy_alloc>
ffffffe000200900:	fea43423          	sd	a0,-24(s0)
    if (pfn == 0)
ffffffe000200904:	fe843783          	ld	a5,-24(s0)
ffffffe000200908:	00079663          	bnez	a5,ffffffe000200914 <alloc_pages+0x30>
        return 0;
ffffffe00020090c:	00000793          	li	a5,0
ffffffe000200910:	0180006f          	j	ffffffe000200928 <alloc_pages+0x44>
    return (void *)(PA2VA(PFN2PHYS(pfn)));
ffffffe000200914:	fe843783          	ld	a5,-24(s0)
ffffffe000200918:	00c79713          	slli	a4,a5,0xc
ffffffe00020091c:	fff00793          	li	a5,-1
ffffffe000200920:	02579793          	slli	a5,a5,0x25
ffffffe000200924:	00f707b3          	add	a5,a4,a5
}
ffffffe000200928:	00078513          	mv	a0,a5
ffffffe00020092c:	02813083          	ld	ra,40(sp)
ffffffe000200930:	02013403          	ld	s0,32(sp)
ffffffe000200934:	03010113          	addi	sp,sp,48
ffffffe000200938:	00008067          	ret

ffffffe00020093c <alloc_page>:

void *alloc_page() {
ffffffe00020093c:	ff010113          	addi	sp,sp,-16
ffffffe000200940:	00113423          	sd	ra,8(sp)
ffffffe000200944:	00813023          	sd	s0,0(sp)
ffffffe000200948:	01010413          	addi	s0,sp,16
    return alloc_pages(1);
ffffffe00020094c:	00100513          	li	a0,1
ffffffe000200950:	f95ff0ef          	jal	ffffffe0002008e4 <alloc_pages>
ffffffe000200954:	00050793          	mv	a5,a0
}
ffffffe000200958:	00078513          	mv	a0,a5
ffffffe00020095c:	00813083          	ld	ra,8(sp)
ffffffe000200960:	00013403          	ld	s0,0(sp)
ffffffe000200964:	01010113          	addi	sp,sp,16
ffffffe000200968:	00008067          	ret

ffffffe00020096c <free_pages>:

void free_pages(void *va) {
ffffffe00020096c:	fe010113          	addi	sp,sp,-32
ffffffe000200970:	00113c23          	sd	ra,24(sp)
ffffffe000200974:	00813823          	sd	s0,16(sp)
ffffffe000200978:	02010413          	addi	s0,sp,32
ffffffe00020097c:	fea43423          	sd	a0,-24(s0)
    buddy_free(PHYS2PFN(VA2PA((uint64_t)va)));
ffffffe000200980:	fe843703          	ld	a4,-24(s0)
ffffffe000200984:	00100793          	li	a5,1
ffffffe000200988:	02579793          	slli	a5,a5,0x25
ffffffe00020098c:	00f707b3          	add	a5,a4,a5
ffffffe000200990:	00c7d793          	srli	a5,a5,0xc
ffffffe000200994:	00078513          	mv	a0,a5
ffffffe000200998:	be1ff0ef          	jal	ffffffe000200578 <buddy_free>
}
ffffffe00020099c:	00000013          	nop
ffffffe0002009a0:	01813083          	ld	ra,24(sp)
ffffffe0002009a4:	01013403          	ld	s0,16(sp)
ffffffe0002009a8:	02010113          	addi	sp,sp,32
ffffffe0002009ac:	00008067          	ret

ffffffe0002009b0 <kalloc>:

void *kalloc() {
ffffffe0002009b0:	ff010113          	addi	sp,sp,-16
ffffffe0002009b4:	00113423          	sd	ra,8(sp)
ffffffe0002009b8:	00813023          	sd	s0,0(sp)
ffffffe0002009bc:	01010413          	addi	s0,sp,16
    // r = kmem.freelist;
    // kmem.freelist = r->next;
    
    // memset((void *)r, 0x0, PGSIZE);
    // return (void *)r;
    return alloc_page();
ffffffe0002009c0:	f7dff0ef          	jal	ffffffe00020093c <alloc_page>
ffffffe0002009c4:	00050793          	mv	a5,a0
}
ffffffe0002009c8:	00078513          	mv	a0,a5
ffffffe0002009cc:	00813083          	ld	ra,8(sp)
ffffffe0002009d0:	00013403          	ld	s0,0(sp)
ffffffe0002009d4:	01010113          	addi	sp,sp,16
ffffffe0002009d8:	00008067          	ret

ffffffe0002009dc <kfree>:

void kfree(void *addr) {
ffffffe0002009dc:	fe010113          	addi	sp,sp,-32
ffffffe0002009e0:	00113c23          	sd	ra,24(sp)
ffffffe0002009e4:	00813823          	sd	s0,16(sp)
ffffffe0002009e8:	02010413          	addi	s0,sp,32
ffffffe0002009ec:	fea43423          	sd	a0,-24(s0)
    // memset(addr, 0x0, (uint64_t)PGSIZE);

    // r = (struct run *)addr;
    // r->next = kmem.freelist;
    // kmem.freelist = r;
    free_pages(addr);
ffffffe0002009f0:	fe843503          	ld	a0,-24(s0)
ffffffe0002009f4:	f79ff0ef          	jal	ffffffe00020096c <free_pages>

    return;
ffffffe0002009f8:	00000013          	nop
}
ffffffe0002009fc:	01813083          	ld	ra,24(sp)
ffffffe000200a00:	01013403          	ld	s0,16(sp)
ffffffe000200a04:	02010113          	addi	sp,sp,32
ffffffe000200a08:	00008067          	ret

ffffffe000200a0c <kfreerange>:

void kfreerange(char *start, char *end) {
ffffffe000200a0c:	fd010113          	addi	sp,sp,-48
ffffffe000200a10:	02113423          	sd	ra,40(sp)
ffffffe000200a14:	02813023          	sd	s0,32(sp)
ffffffe000200a18:	03010413          	addi	s0,sp,48
ffffffe000200a1c:	fca43c23          	sd	a0,-40(s0)
ffffffe000200a20:	fcb43823          	sd	a1,-48(s0)
    char *addr = (char *)PGROUNDUP((uintptr_t)start);
ffffffe000200a24:	fd843703          	ld	a4,-40(s0)
ffffffe000200a28:	000017b7          	lui	a5,0x1
ffffffe000200a2c:	fff78793          	addi	a5,a5,-1 # fff <PGSIZE-0x1>
ffffffe000200a30:	00f70733          	add	a4,a4,a5
ffffffe000200a34:	fffff7b7          	lui	a5,0xfffff
ffffffe000200a38:	00f777b3          	and	a5,a4,a5
ffffffe000200a3c:	fef43423          	sd	a5,-24(s0)
    for (; (uintptr_t)(addr) + PGSIZE <= (uintptr_t)end; addr += PGSIZE) {
ffffffe000200a40:	01c0006f          	j	ffffffe000200a5c <kfreerange+0x50>
        kfree((void *)addr);
ffffffe000200a44:	fe843503          	ld	a0,-24(s0)
ffffffe000200a48:	f95ff0ef          	jal	ffffffe0002009dc <kfree>
    for (; (uintptr_t)(addr) + PGSIZE <= (uintptr_t)end; addr += PGSIZE) {
ffffffe000200a4c:	fe843703          	ld	a4,-24(s0)
ffffffe000200a50:	000017b7          	lui	a5,0x1
ffffffe000200a54:	00f707b3          	add	a5,a4,a5
ffffffe000200a58:	fef43423          	sd	a5,-24(s0)
ffffffe000200a5c:	fe843703          	ld	a4,-24(s0)
ffffffe000200a60:	000017b7          	lui	a5,0x1
ffffffe000200a64:	00f70733          	add	a4,a4,a5
ffffffe000200a68:	fd043783          	ld	a5,-48(s0)
ffffffe000200a6c:	fce7fce3          	bgeu	a5,a4,ffffffe000200a44 <kfreerange+0x38>
    }
}
ffffffe000200a70:	00000013          	nop
ffffffe000200a74:	00000013          	nop
ffffffe000200a78:	02813083          	ld	ra,40(sp)
ffffffe000200a7c:	02013403          	ld	s0,32(sp)
ffffffe000200a80:	03010113          	addi	sp,sp,48
ffffffe000200a84:	00008067          	ret

ffffffe000200a88 <mm_init>:

void mm_init(void) {
ffffffe000200a88:	ff010113          	addi	sp,sp,-16
ffffffe000200a8c:	00113423          	sd	ra,8(sp)
ffffffe000200a90:	00813023          	sd	s0,0(sp)
ffffffe000200a94:	01010413          	addi	s0,sp,16
    // kfreerange(_ekernel, (char *)PHY_END+PA2VA_OFFSET);
    buddy_init();
ffffffe000200a98:	935ff0ef          	jal	ffffffe0002003cc <buddy_init>
    printk("...mm_init done!\n");
ffffffe000200a9c:	00004517          	auipc	a0,0x4
ffffffe000200aa0:	58450513          	addi	a0,a0,1412 # ffffffe000205020 <_PA2VA_OFFSET+0x20>
ffffffe000200aa4:	4c8020ef          	jal	ffffffe000202f6c <printk>
}
ffffffe000200aa8:	00000013          	nop
ffffffe000200aac:	00813083          	ld	ra,8(sp)
ffffffe000200ab0:	00013403          	ld	s0,0(sp)
ffffffe000200ab4:	01010113          	addi	sp,sp,16
ffffffe000200ab8:	00008067          	ret

ffffffe000200abc <print_int>:
struct task_struct *task[NR_TASKS]; // 线程数组，所有的线程都保存在此]
int first = 1;
extern char _sramdisk[];
extern char _eramdisk[];
extern uint64_t swapper_pg_dir[];
void print_int(){
ffffffe000200abc:	ff010113          	addi	sp,sp,-16
ffffffe000200ac0:	00113423          	sd	ra,8(sp)
ffffffe000200ac4:	00813023          	sd	s0,0(sp)
ffffffe000200ac8:	01010413          	addi	s0,sp,16
  printk("int\n");
ffffffe000200acc:	00004517          	auipc	a0,0x4
ffffffe000200ad0:	56c50513          	addi	a0,a0,1388 # ffffffe000205038 <_PA2VA_OFFSET+0x38>
ffffffe000200ad4:	498020ef          	jal	ffffffe000202f6c <printk>
}
ffffffe000200ad8:	00000013          	nop
ffffffe000200adc:	00813083          	ld	ra,8(sp)
ffffffe000200ae0:	00013403          	ld	s0,0(sp)
ffffffe000200ae4:	01010113          	addi	sp,sp,16
ffffffe000200ae8:	00008067          	ret

ffffffe000200aec <load_program>:

void load_program(struct task_struct *task) {
ffffffe000200aec:	f9010113          	addi	sp,sp,-112
ffffffe000200af0:	06113423          	sd	ra,104(sp)
ffffffe000200af4:	06813023          	sd	s0,96(sp)
ffffffe000200af8:	07010413          	addi	s0,sp,112
ffffffe000200afc:	f8a43c23          	sd	a0,-104(s0)
    Elf64_Ehdr *ehdr = (Elf64_Ehdr *)_sramdisk;
ffffffe000200b00:	00007797          	auipc	a5,0x7
ffffffe000200b04:	50078793          	addi	a5,a5,1280 # ffffffe000208000 <_sramdisk>
ffffffe000200b08:	fef43023          	sd	a5,-32(s0)
    Elf64_Phdr *phdrs = (Elf64_Phdr *)(_sramdisk + ehdr->e_phoff);
ffffffe000200b0c:	fe043783          	ld	a5,-32(s0)
ffffffe000200b10:	0207b703          	ld	a4,32(a5)
ffffffe000200b14:	00007797          	auipc	a5,0x7
ffffffe000200b18:	4ec78793          	addi	a5,a5,1260 # ffffffe000208000 <_sramdisk>
ffffffe000200b1c:	00f707b3          	add	a5,a4,a5
ffffffe000200b20:	fcf43c23          	sd	a5,-40(s0)
    for (int i = 0; i < ehdr->e_phnum; ++i) {
ffffffe000200b24:	fe042623          	sw	zero,-20(s0)
ffffffe000200b28:	1780006f          	j	ffffffe000200ca0 <load_program+0x1b4>
        Elf64_Phdr *phdr = phdrs + i;
ffffffe000200b2c:	fec42703          	lw	a4,-20(s0)
ffffffe000200b30:	00070793          	mv	a5,a4
ffffffe000200b34:	00379793          	slli	a5,a5,0x3
ffffffe000200b38:	40e787b3          	sub	a5,a5,a4
ffffffe000200b3c:	00379793          	slli	a5,a5,0x3
ffffffe000200b40:	00078713          	mv	a4,a5
ffffffe000200b44:	fd843783          	ld	a5,-40(s0)
ffffffe000200b48:	00e787b3          	add	a5,a5,a4
ffffffe000200b4c:	fcf43823          	sd	a5,-48(s0)
        if (phdr->p_type == PT_LOAD) { 
ffffffe000200b50:	fd043783          	ld	a5,-48(s0)
ffffffe000200b54:	0007a783          	lw	a5,0(a5)
ffffffe000200b58:	00078713          	mv	a4,a5
ffffffe000200b5c:	00100793          	li	a5,1
ffffffe000200b60:	12f71a63          	bne	a4,a5,ffffffe000200c94 <load_program+0x1a8>
            uint64_t va_start = phdr->p_vaddr; 
ffffffe000200b64:	fd043783          	ld	a5,-48(s0)
ffffffe000200b68:	0107b783          	ld	a5,16(a5)
ffffffe000200b6c:	fcf43423          	sd	a5,-56(s0)
            uint64_t sz = phdr->p_memsz;
ffffffe000200b70:	fd043783          	ld	a5,-48(s0)
ffffffe000200b74:	0287b783          	ld	a5,40(a5)
ffffffe000200b78:	fcf43023          	sd	a5,-64(s0)
            uint64_t m = sz%PGSIZE==0?0:1;
ffffffe000200b7c:	fc043703          	ld	a4,-64(s0)
ffffffe000200b80:	000017b7          	lui	a5,0x1
ffffffe000200b84:	fff78793          	addi	a5,a5,-1 # fff <PGSIZE-0x1>
ffffffe000200b88:	00f777b3          	and	a5,a4,a5
ffffffe000200b8c:	00f037b3          	snez	a5,a5
ffffffe000200b90:	0ff7f793          	zext.b	a5,a5
ffffffe000200b94:	faf43c23          	sd	a5,-72(s0)
            char* pa = (char*)((char*)ehdr+phdr->p_offset);
ffffffe000200b98:	fd043783          	ld	a5,-48(s0)
ffffffe000200b9c:	0087b783          	ld	a5,8(a5)
ffffffe000200ba0:	fe043703          	ld	a4,-32(s0)
ffffffe000200ba4:	00f707b3          	add	a5,a4,a5
ffffffe000200ba8:	faf43823          	sd	a5,-80(s0)
            char* mem = (char*)alloc_pages(sz/PGSIZE+m);
ffffffe000200bac:	fc043783          	ld	a5,-64(s0)
ffffffe000200bb0:	00c7d713          	srli	a4,a5,0xc
ffffffe000200bb4:	fb843783          	ld	a5,-72(s0)
ffffffe000200bb8:	00f707b3          	add	a5,a4,a5
ffffffe000200bbc:	00078513          	mv	a0,a5
ffffffe000200bc0:	d25ff0ef          	jal	ffffffe0002008e4 <alloc_pages>
ffffffe000200bc4:	faa43423          	sd	a0,-88(s0)
            for(int i=0;i<(sz/PGSIZE+m)*PGSIZE;i++){
ffffffe000200bc8:	fe042423          	sw	zero,-24(s0)
ffffffe000200bcc:	06c0006f          	j	ffffffe000200c38 <load_program+0x14c>
              if(i<phdr->p_filesz){
ffffffe000200bd0:	fe842703          	lw	a4,-24(s0)
ffffffe000200bd4:	fd043783          	ld	a5,-48(s0)
ffffffe000200bd8:	0207b783          	ld	a5,32(a5)
ffffffe000200bdc:	02f77a63          	bgeu	a4,a5,ffffffe000200c10 <load_program+0x124>
                mem[i+phdr->p_offset] = pa[i];
ffffffe000200be0:	fe842783          	lw	a5,-24(s0)
ffffffe000200be4:	fb043703          	ld	a4,-80(s0)
ffffffe000200be8:	00f70733          	add	a4,a4,a5
ffffffe000200bec:	fe842683          	lw	a3,-24(s0)
ffffffe000200bf0:	fd043783          	ld	a5,-48(s0)
ffffffe000200bf4:	0087b783          	ld	a5,8(a5)
ffffffe000200bf8:	00f687b3          	add	a5,a3,a5
ffffffe000200bfc:	fa843683          	ld	a3,-88(s0)
ffffffe000200c00:	00f687b3          	add	a5,a3,a5
ffffffe000200c04:	00074703          	lbu	a4,0(a4)
ffffffe000200c08:	00e78023          	sb	a4,0(a5)
ffffffe000200c0c:	0200006f          	j	ffffffe000200c2c <load_program+0x140>
              }else{
                mem[i+phdr->p_offset] = 0;
ffffffe000200c10:	fe842703          	lw	a4,-24(s0)
ffffffe000200c14:	fd043783          	ld	a5,-48(s0)
ffffffe000200c18:	0087b783          	ld	a5,8(a5)
ffffffe000200c1c:	00f707b3          	add	a5,a4,a5
ffffffe000200c20:	fa843703          	ld	a4,-88(s0)
ffffffe000200c24:	00f707b3          	add	a5,a4,a5
ffffffe000200c28:	00078023          	sb	zero,0(a5)
            for(int i=0;i<(sz/PGSIZE+m)*PGSIZE;i++){
ffffffe000200c2c:	fe842783          	lw	a5,-24(s0)
ffffffe000200c30:	0017879b          	addiw	a5,a5,1
ffffffe000200c34:	fef42423          	sw	a5,-24(s0)
ffffffe000200c38:	fe842703          	lw	a4,-24(s0)
ffffffe000200c3c:	fc043783          	ld	a5,-64(s0)
ffffffe000200c40:	00c7d693          	srli	a3,a5,0xc
ffffffe000200c44:	fb843783          	ld	a5,-72(s0)
ffffffe000200c48:	00f687b3          	add	a5,a3,a5
ffffffe000200c4c:	00c79793          	slli	a5,a5,0xc
ffffffe000200c50:	f8f760e3          	bltu	a4,a5,ffffffe000200bd0 <load_program+0xe4>
              }
            }
            create_mapping((uint64_t*)task->pgd, va_start, (uint64_t)mem - PA2VA_OFFSET, (sz/PGSIZE+m)*PGSIZE, 0x1f);
ffffffe000200c54:	f9843783          	ld	a5,-104(s0)
ffffffe000200c58:	0a87b503          	ld	a0,168(a5)
ffffffe000200c5c:	fa843703          	ld	a4,-88(s0)
ffffffe000200c60:	04100793          	li	a5,65
ffffffe000200c64:	01f79793          	slli	a5,a5,0x1f
ffffffe000200c68:	00f70633          	add	a2,a4,a5
ffffffe000200c6c:	fc043783          	ld	a5,-64(s0)
ffffffe000200c70:	00c7d713          	srli	a4,a5,0xc
ffffffe000200c74:	fb843783          	ld	a5,-72(s0)
ffffffe000200c78:	00f707b3          	add	a5,a4,a5
ffffffe000200c7c:	00c79793          	slli	a5,a5,0xc
ffffffe000200c80:	01f00713          	li	a4,31
ffffffe000200c84:	00078693          	mv	a3,a5
ffffffe000200c88:	fc843583          	ld	a1,-56(s0)
ffffffe000200c8c:	158010ef          	jal	ffffffe000201de4 <create_mapping>
            int dummy = 0;
ffffffe000200c90:	fa042223          	sw	zero,-92(s0)
    for (int i = 0; i < ehdr->e_phnum; ++i) {
ffffffe000200c94:	fec42783          	lw	a5,-20(s0)
ffffffe000200c98:	0017879b          	addiw	a5,a5,1
ffffffe000200c9c:	fef42623          	sw	a5,-20(s0)
ffffffe000200ca0:	fe043783          	ld	a5,-32(s0)
ffffffe000200ca4:	0387d783          	lhu	a5,56(a5)
ffffffe000200ca8:	0007871b          	sext.w	a4,a5
ffffffe000200cac:	fec42783          	lw	a5,-20(s0)
ffffffe000200cb0:	0007879b          	sext.w	a5,a5
ffffffe000200cb4:	e6e7cce3          	blt	a5,a4,ffffffe000200b2c <load_program+0x40>
        }
        
    }
    task->thread.sepc = ehdr->e_entry;
ffffffe000200cb8:	fe043783          	ld	a5,-32(s0)
ffffffe000200cbc:	0187b703          	ld	a4,24(a5)
ffffffe000200cc0:	f9843783          	ld	a5,-104(s0)
ffffffe000200cc4:	08e7b823          	sd	a4,144(a5)
}
ffffffe000200cc8:	00000013          	nop
ffffffe000200ccc:	06813083          	ld	ra,104(sp)
ffffffe000200cd0:	06013403          	ld	s0,96(sp)
ffffffe000200cd4:	07010113          	addi	sp,sp,112
ffffffe000200cd8:	00008067          	ret

ffffffe000200cdc <task_init>:

void task_init() {
ffffffe000200cdc:	fc010113          	addi	sp,sp,-64
ffffffe000200ce0:	02113c23          	sd	ra,56(sp)
ffffffe000200ce4:	02813823          	sd	s0,48(sp)
ffffffe000200ce8:	02913423          	sd	s1,40(sp)
ffffffe000200cec:	04010413          	addi	s0,sp,64
    srand(2024);
ffffffe000200cf0:	7e800513          	li	a0,2024
ffffffe000200cf4:	2f8020ef          	jal	ffffffe000202fec <srand>
    // 3. 由于 idle 不参与调度，可以将其 counter / priority 设置为 0
    // 4. 设置 idle 的 pid 为 0
    // 5. 将 current 和 task[0] 指向 idle

    /* YOUR CODE HERE */
    idle = (struct task_struct *)kalloc();   
ffffffe000200cf8:	cb9ff0ef          	jal	ffffffe0002009b0 <kalloc>
ffffffe000200cfc:	00050713          	mv	a4,a0
ffffffe000200d00:	0000b797          	auipc	a5,0xb
ffffffe000200d04:	30878793          	addi	a5,a5,776 # ffffffe00020c008 <idle>
ffffffe000200d08:	00e7b023          	sd	a4,0(a5)
    idle->state = TASK_RUNNING;             
ffffffe000200d0c:	0000b797          	auipc	a5,0xb
ffffffe000200d10:	2fc78793          	addi	a5,a5,764 # ffffffe00020c008 <idle>
ffffffe000200d14:	0007b783          	ld	a5,0(a5)
ffffffe000200d18:	0007b023          	sd	zero,0(a5)
    idle->counter = 0;                     
ffffffe000200d1c:	0000b797          	auipc	a5,0xb
ffffffe000200d20:	2ec78793          	addi	a5,a5,748 # ffffffe00020c008 <idle>
ffffffe000200d24:	0007b783          	ld	a5,0(a5)
ffffffe000200d28:	0007b423          	sd	zero,8(a5)
    idle->priority = 0;         
ffffffe000200d2c:	0000b797          	auipc	a5,0xb
ffffffe000200d30:	2dc78793          	addi	a5,a5,732 # ffffffe00020c008 <idle>
ffffffe000200d34:	0007b783          	ld	a5,0(a5)
ffffffe000200d38:	0007b823          	sd	zero,16(a5)
    idle->pid = 0;         
ffffffe000200d3c:	0000b797          	auipc	a5,0xb
ffffffe000200d40:	2cc78793          	addi	a5,a5,716 # ffffffe00020c008 <idle>
ffffffe000200d44:	0007b783          	ld	a5,0(a5)
ffffffe000200d48:	0007bc23          	sd	zero,24(a5)
    current = idle;        
ffffffe000200d4c:	0000b797          	auipc	a5,0xb
ffffffe000200d50:	2bc78793          	addi	a5,a5,700 # ffffffe00020c008 <idle>
ffffffe000200d54:	0007b703          	ld	a4,0(a5)
ffffffe000200d58:	0000b797          	auipc	a5,0xb
ffffffe000200d5c:	2b878793          	addi	a5,a5,696 # ffffffe00020c010 <current>
ffffffe000200d60:	00e7b023          	sd	a4,0(a5)
    task[0] = idle;     
ffffffe000200d64:	0000b797          	auipc	a5,0xb
ffffffe000200d68:	2a478793          	addi	a5,a5,676 # ffffffe00020c008 <idle>
ffffffe000200d6c:	0007b703          	ld	a4,0(a5)
ffffffe000200d70:	0000b797          	auipc	a5,0xb
ffffffe000200d74:	2d878793          	addi	a5,a5,728 # ffffffe00020c048 <task>
ffffffe000200d78:	00e7b023          	sd	a4,0(a5)
    // 3. 为 task[1] ~ task[NR_TASKS - 1] 设置 thread_struct 中的 ra 和 sp
    //     - ra 设置为 __dummy（见 4.2.2）的地址
    //     - sp 设置为该线程申请的物理页的高地址

    /* YOUR CODE HERE */
    for (int i = 1; i <= 1; i++) {
ffffffe000200d7c:	00100793          	li	a5,1
ffffffe000200d80:	fcf42e23          	sw	a5,-36(s0)
ffffffe000200d84:	2a40006f          	j	ffffffe000201028 <task_init+0x34c>
        
        task[i] = (struct task_struct *)kalloc();
ffffffe000200d88:	c29ff0ef          	jal	ffffffe0002009b0 <kalloc>
ffffffe000200d8c:	00050693          	mv	a3,a0
ffffffe000200d90:	0000b717          	auipc	a4,0xb
ffffffe000200d94:	2b870713          	addi	a4,a4,696 # ffffffe00020c048 <task>
ffffffe000200d98:	fdc42783          	lw	a5,-36(s0)
ffffffe000200d9c:	00379793          	slli	a5,a5,0x3
ffffffe000200da0:	00f707b3          	add	a5,a4,a5
ffffffe000200da4:	00d7b023          	sd	a3,0(a5)
        task[i]->state = TASK_RUNNING;
ffffffe000200da8:	0000b717          	auipc	a4,0xb
ffffffe000200dac:	2a070713          	addi	a4,a4,672 # ffffffe00020c048 <task>
ffffffe000200db0:	fdc42783          	lw	a5,-36(s0)
ffffffe000200db4:	00379793          	slli	a5,a5,0x3
ffffffe000200db8:	00f707b3          	add	a5,a4,a5
ffffffe000200dbc:	0007b783          	ld	a5,0(a5)
ffffffe000200dc0:	0007b023          	sd	zero,0(a5)
        task[i]->counter = 0;
ffffffe000200dc4:	0000b717          	auipc	a4,0xb
ffffffe000200dc8:	28470713          	addi	a4,a4,644 # ffffffe00020c048 <task>
ffffffe000200dcc:	fdc42783          	lw	a5,-36(s0)
ffffffe000200dd0:	00379793          	slli	a5,a5,0x3
ffffffe000200dd4:	00f707b3          	add	a5,a4,a5
ffffffe000200dd8:	0007b783          	ld	a5,0(a5)
ffffffe000200ddc:	0007b423          	sd	zero,8(a5)
        task[i]->pid = i;
ffffffe000200de0:	0000b717          	auipc	a4,0xb
ffffffe000200de4:	26870713          	addi	a4,a4,616 # ffffffe00020c048 <task>
ffffffe000200de8:	fdc42783          	lw	a5,-36(s0)
ffffffe000200dec:	00379793          	slli	a5,a5,0x3
ffffffe000200df0:	00f707b3          	add	a5,a4,a5
ffffffe000200df4:	0007b783          	ld	a5,0(a5)
ffffffe000200df8:	fdc42703          	lw	a4,-36(s0)
ffffffe000200dfc:	00e7bc23          	sd	a4,24(a5)
        task[i]->priority = PRIORITY_MIN + (rand() % (PRIORITY_MAX - PRIORITY_MIN + 1));
ffffffe000200e00:	230020ef          	jal	ffffffe000203030 <rand>
ffffffe000200e04:	00050793          	mv	a5,a0
ffffffe000200e08:	00078713          	mv	a4,a5
ffffffe000200e0c:	00a00793          	li	a5,10
ffffffe000200e10:	02f767bb          	remw	a5,a4,a5
ffffffe000200e14:	0007879b          	sext.w	a5,a5
ffffffe000200e18:	0017879b          	addiw	a5,a5,1
ffffffe000200e1c:	0007869b          	sext.w	a3,a5
ffffffe000200e20:	0000b717          	auipc	a4,0xb
ffffffe000200e24:	22870713          	addi	a4,a4,552 # ffffffe00020c048 <task>
ffffffe000200e28:	fdc42783          	lw	a5,-36(s0)
ffffffe000200e2c:	00379793          	slli	a5,a5,0x3
ffffffe000200e30:	00f707b3          	add	a5,a4,a5
ffffffe000200e34:	0007b783          	ld	a5,0(a5)
ffffffe000200e38:	00068713          	mv	a4,a3
ffffffe000200e3c:	00e7b823          	sd	a4,16(a5)
        //printk("SET [PID = %d PRIORITY = %d COUNTER = %d]\n", task[i]->pid, task[i]->priority, task[i]->counter);
        
        task[i]->thread.ra = (uint64_t)__dummy;
ffffffe000200e40:	0000b717          	auipc	a4,0xb
ffffffe000200e44:	20870713          	addi	a4,a4,520 # ffffffe00020c048 <task>
ffffffe000200e48:	fdc42783          	lw	a5,-36(s0)
ffffffe000200e4c:	00379793          	slli	a5,a5,0x3
ffffffe000200e50:	00f707b3          	add	a5,a4,a5
ffffffe000200e54:	0007b783          	ld	a5,0(a5)
ffffffe000200e58:	fffff717          	auipc	a4,0xfffff
ffffffe000200e5c:	37c70713          	addi	a4,a4,892 # ffffffe0002001d4 <__dummy>
ffffffe000200e60:	02e7b023          	sd	a4,32(a5)
        task[i]->thread.sp = (uint64_t)task[i] + PGSIZE;
ffffffe000200e64:	0000b717          	auipc	a4,0xb
ffffffe000200e68:	1e470713          	addi	a4,a4,484 # ffffffe00020c048 <task>
ffffffe000200e6c:	fdc42783          	lw	a5,-36(s0)
ffffffe000200e70:	00379793          	slli	a5,a5,0x3
ffffffe000200e74:	00f707b3          	add	a5,a4,a5
ffffffe000200e78:	0007b783          	ld	a5,0(a5)
ffffffe000200e7c:	00078693          	mv	a3,a5
ffffffe000200e80:	0000b717          	auipc	a4,0xb
ffffffe000200e84:	1c870713          	addi	a4,a4,456 # ffffffe00020c048 <task>
ffffffe000200e88:	fdc42783          	lw	a5,-36(s0)
ffffffe000200e8c:	00379793          	slli	a5,a5,0x3
ffffffe000200e90:	00f707b3          	add	a5,a4,a5
ffffffe000200e94:	0007b783          	ld	a5,0(a5)
ffffffe000200e98:	00001737          	lui	a4,0x1
ffffffe000200e9c:	00e68733          	add	a4,a3,a4
ffffffe000200ea0:	02e7b423          	sd	a4,40(a5)

        task[i]->thread.sepc = USER_START;
ffffffe000200ea4:	0000b717          	auipc	a4,0xb
ffffffe000200ea8:	1a470713          	addi	a4,a4,420 # ffffffe00020c048 <task>
ffffffe000200eac:	fdc42783          	lw	a5,-36(s0)
ffffffe000200eb0:	00379793          	slli	a5,a5,0x3
ffffffe000200eb4:	00f707b3          	add	a5,a4,a5
ffffffe000200eb8:	0007b783          	ld	a5,0(a5)
ffffffe000200ebc:	0807b823          	sd	zero,144(a5)
        task[i]->thread.sstatus |=  (1 << 5) | (1 << 18);
ffffffe000200ec0:	0000b717          	auipc	a4,0xb
ffffffe000200ec4:	18870713          	addi	a4,a4,392 # ffffffe00020c048 <task>
ffffffe000200ec8:	fdc42783          	lw	a5,-36(s0)
ffffffe000200ecc:	00379793          	slli	a5,a5,0x3
ffffffe000200ed0:	00f707b3          	add	a5,a4,a5
ffffffe000200ed4:	0007b783          	ld	a5,0(a5)
ffffffe000200ed8:	0987b683          	ld	a3,152(a5)
ffffffe000200edc:	0000b717          	auipc	a4,0xb
ffffffe000200ee0:	16c70713          	addi	a4,a4,364 # ffffffe00020c048 <task>
ffffffe000200ee4:	fdc42783          	lw	a5,-36(s0)
ffffffe000200ee8:	00379793          	slli	a5,a5,0x3
ffffffe000200eec:	00f707b3          	add	a5,a4,a5
ffffffe000200ef0:	0007b783          	ld	a5,0(a5)
ffffffe000200ef4:	00040737          	lui	a4,0x40
ffffffe000200ef8:	02070713          	addi	a4,a4,32 # 40020 <PGSIZE+0x3f020>
ffffffe000200efc:	00e6e733          	or	a4,a3,a4
ffffffe000200f00:	08e7bc23          	sd	a4,152(a5)
        task[i]->thread.sscratch = USER_END;
ffffffe000200f04:	0000b717          	auipc	a4,0xb
ffffffe000200f08:	14470713          	addi	a4,a4,324 # ffffffe00020c048 <task>
ffffffe000200f0c:	fdc42783          	lw	a5,-36(s0)
ffffffe000200f10:	00379793          	slli	a5,a5,0x3
ffffffe000200f14:	00f707b3          	add	a5,a4,a5
ffffffe000200f18:	0007b783          	ld	a5,0(a5)
ffffffe000200f1c:	00100713          	li	a4,1
ffffffe000200f20:	02671713          	slli	a4,a4,0x26
ffffffe000200f24:	0ae7b023          	sd	a4,160(a5)
        
        uint64_t* pagetable = (uint64_t*)alloc_page();
ffffffe000200f28:	a15ff0ef          	jal	ffffffe00020093c <alloc_page>
ffffffe000200f2c:	fca43823          	sd	a0,-48(s0)
        for(int i = 0; i < 512; i++){
ffffffe000200f30:	fc042c23          	sw	zero,-40(s0)
ffffffe000200f34:	03c0006f          	j	ffffffe000200f70 <task_init+0x294>
         pagetable[i] = swapper_pg_dir[i]; 
ffffffe000200f38:	fd842783          	lw	a5,-40(s0)
ffffffe000200f3c:	00379793          	slli	a5,a5,0x3
ffffffe000200f40:	fd043703          	ld	a4,-48(s0)
ffffffe000200f44:	00f707b3          	add	a5,a4,a5
ffffffe000200f48:	0000d697          	auipc	a3,0xd
ffffffe000200f4c:	0b868693          	addi	a3,a3,184 # ffffffe00020e000 <swapper_pg_dir>
ffffffe000200f50:	fd842703          	lw	a4,-40(s0)
ffffffe000200f54:	00371713          	slli	a4,a4,0x3
ffffffe000200f58:	00e68733          	add	a4,a3,a4
ffffffe000200f5c:	00073703          	ld	a4,0(a4)
ffffffe000200f60:	00e7b023          	sd	a4,0(a5)
        for(int i = 0; i < 512; i++){
ffffffe000200f64:	fd842783          	lw	a5,-40(s0)
ffffffe000200f68:	0017879b          	addiw	a5,a5,1
ffffffe000200f6c:	fcf42c23          	sw	a5,-40(s0)
ffffffe000200f70:	fd842783          	lw	a5,-40(s0)
ffffffe000200f74:	0007871b          	sext.w	a4,a5
ffffffe000200f78:	1ff00793          	li	a5,511
ffffffe000200f7c:	fae7dee3          	bge	a5,a4,ffffffe000200f38 <task_init+0x25c>
        }
        task[i]->pgd = pagetable;
ffffffe000200f80:	0000b717          	auipc	a4,0xb
ffffffe000200f84:	0c870713          	addi	a4,a4,200 # ffffffe00020c048 <task>
ffffffe000200f88:	fdc42783          	lw	a5,-36(s0)
ffffffe000200f8c:	00379793          	slli	a5,a5,0x3
ffffffe000200f90:	00f707b3          	add	a5,a4,a5
ffffffe000200f94:	0007b783          	ld	a5,0(a5)
ffffffe000200f98:	fd043703          	ld	a4,-48(s0)
ffffffe000200f9c:	0ae7b423          	sd	a4,168(a5)
        task[i]->files = file_init();
ffffffe000200fa0:	0000b717          	auipc	a4,0xb
ffffffe000200fa4:	0a870713          	addi	a4,a4,168 # ffffffe00020c048 <task>
ffffffe000200fa8:	fdc42783          	lw	a5,-36(s0)
ffffffe000200fac:	00379793          	slli	a5,a5,0x3
ffffffe000200fb0:	00f707b3          	add	a5,a4,a5
ffffffe000200fb4:	0007b483          	ld	s1,0(a5)
ffffffe000200fb8:	5e0020ef          	jal	ffffffe000203598 <file_init>
ffffffe000200fbc:	00050793          	mv	a5,a0
ffffffe000200fc0:	0af4b823          	sd	a5,176(s1)
        //char* uapp = (char*)alloc_pages(uapp_size);
        //for(int i=0;i<PGSIZE*uapp_size;i++){
        //  uapp[i] = _sramdisk[i];
        //}
        //create_mapping((uint64_t*)pagetable, USER_START, (uint64_t)uapp-PA2VA_OFFSET, (uint64_t)(_eramdisk-_sramdisk), 31);
        load_program(task[i]);
ffffffe000200fc4:	0000b717          	auipc	a4,0xb
ffffffe000200fc8:	08470713          	addi	a4,a4,132 # ffffffe00020c048 <task>
ffffffe000200fcc:	fdc42783          	lw	a5,-36(s0)
ffffffe000200fd0:	00379793          	slli	a5,a5,0x3
ffffffe000200fd4:	00f707b3          	add	a5,a4,a5
ffffffe000200fd8:	0007b783          	ld	a5,0(a5)
ffffffe000200fdc:	00078513          	mv	a0,a5
ffffffe000200fe0:	b0dff0ef          	jal	ffffffe000200aec <load_program>
        
        uint64_t* u_mode_stack = (uint64_t*)alloc_page();
ffffffe000200fe4:	959ff0ef          	jal	ffffffe00020093c <alloc_page>
ffffffe000200fe8:	fca43423          	sd	a0,-56(s0)
        create_mapping((uint64_t*)pagetable, (uint64_t)USER_END-PGSIZE, (uint64_t)u_mode_stack-PA2VA_OFFSET, PGSIZE, 23);
ffffffe000200fec:	fc843703          	ld	a4,-56(s0)
ffffffe000200ff0:	04100793          	li	a5,65
ffffffe000200ff4:	01f79793          	slli	a5,a5,0x1f
ffffffe000200ff8:	00f707b3          	add	a5,a4,a5
ffffffe000200ffc:	01700713          	li	a4,23
ffffffe000201000:	000016b7          	lui	a3,0x1
ffffffe000201004:	00078613          	mv	a2,a5
ffffffe000201008:	040007b7          	lui	a5,0x4000
ffffffe00020100c:	fff78793          	addi	a5,a5,-1 # 3ffffff <OPENSBI_SIZE+0x3dfffff>
ffffffe000201010:	00c79593          	slli	a1,a5,0xc
ffffffe000201014:	fd043503          	ld	a0,-48(s0)
ffffffe000201018:	5cd000ef          	jal	ffffffe000201de4 <create_mapping>
    for (int i = 1; i <= 1; i++) {
ffffffe00020101c:	fdc42783          	lw	a5,-36(s0)
ffffffe000201020:	0017879b          	addiw	a5,a5,1
ffffffe000201024:	fcf42e23          	sw	a5,-36(s0)
ffffffe000201028:	fdc42783          	lw	a5,-36(s0)
ffffffe00020102c:	0007871b          	sext.w	a4,a5
ffffffe000201030:	00100793          	li	a5,1
ffffffe000201034:	d4e7dae3          	bge	a5,a4,ffffffe000200d88 <task_init+0xac>

    }

    printk("...task_init done!\n");
ffffffe000201038:	00004517          	auipc	a0,0x4
ffffffe00020103c:	00850513          	addi	a0,a0,8 # ffffffe000205040 <_PA2VA_OFFSET+0x40>
ffffffe000201040:	72d010ef          	jal	ffffffe000202f6c <printk>
}
ffffffe000201044:	00000013          	nop
ffffffe000201048:	03813083          	ld	ra,56(sp)
ffffffe00020104c:	03013403          	ld	s0,48(sp)
ffffffe000201050:	02813483          	ld	s1,40(sp)
ffffffe000201054:	04010113          	addi	sp,sp,64
ffffffe000201058:	00008067          	ret

ffffffe00020105c <dummy>:
int tasks_output_index = 0;
char expected_output[] = "2222222222111111133334222222222211111113";
#include "sbi.h"
#endif

void dummy() {
ffffffe00020105c:	fd010113          	addi	sp,sp,-48
ffffffe000201060:	02113423          	sd	ra,40(sp)
ffffffe000201064:	02813023          	sd	s0,32(sp)
ffffffe000201068:	03010413          	addi	s0,sp,48
    uint64_t MOD = 1000000007;
ffffffe00020106c:	3b9ad7b7          	lui	a5,0x3b9ad
ffffffe000201070:	a0778793          	addi	a5,a5,-1529 # 3b9aca07 <PHY_SIZE+0x339aca07>
ffffffe000201074:	fcf43c23          	sd	a5,-40(s0)
    uint64_t auto_inc_local_var = 0;
ffffffe000201078:	fe043423          	sd	zero,-24(s0)
    int last_counter = -1;
ffffffe00020107c:	fff00793          	li	a5,-1
ffffffe000201080:	fef42223          	sw	a5,-28(s0)
    while (1) {
        
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
ffffffe000201084:	fe442783          	lw	a5,-28(s0)
ffffffe000201088:	0007871b          	sext.w	a4,a5
ffffffe00020108c:	fff00793          	li	a5,-1
ffffffe000201090:	00f70e63          	beq	a4,a5,ffffffe0002010ac <dummy+0x50>
ffffffe000201094:	0000b797          	auipc	a5,0xb
ffffffe000201098:	f7c78793          	addi	a5,a5,-132 # ffffffe00020c010 <current>
ffffffe00020109c:	0007b783          	ld	a5,0(a5)
ffffffe0002010a0:	0087b703          	ld	a4,8(a5)
ffffffe0002010a4:	fe442783          	lw	a5,-28(s0)
ffffffe0002010a8:	fcf70ee3          	beq	a4,a5,ffffffe000201084 <dummy+0x28>
ffffffe0002010ac:	0000b797          	auipc	a5,0xb
ffffffe0002010b0:	f6478793          	addi	a5,a5,-156 # ffffffe00020c010 <current>
ffffffe0002010b4:	0007b783          	ld	a5,0(a5)
ffffffe0002010b8:	0087b783          	ld	a5,8(a5)
ffffffe0002010bc:	fc0784e3          	beqz	a5,ffffffe000201084 <dummy+0x28>
           // if (current->counter == 1) {
           //     --(current->counter);   // forced the counter to be zero if this thread is going to be scheduled
           // }                           // in case that the new counter is also 1, leading the information not printed.
            last_counter = current->counter;
ffffffe0002010c0:	0000b797          	auipc	a5,0xb
ffffffe0002010c4:	f5078793          	addi	a5,a5,-176 # ffffffe00020c010 <current>
ffffffe0002010c8:	0007b783          	ld	a5,0(a5)
ffffffe0002010cc:	0087b783          	ld	a5,8(a5)
ffffffe0002010d0:	fef42223          	sw	a5,-28(s0)
            auto_inc_local_var = (auto_inc_local_var + 1) % MOD;
ffffffe0002010d4:	fe843783          	ld	a5,-24(s0)
ffffffe0002010d8:	00178713          	addi	a4,a5,1
ffffffe0002010dc:	fd843783          	ld	a5,-40(s0)
ffffffe0002010e0:	02f777b3          	remu	a5,a4,a5
ffffffe0002010e4:	fef43423          	sd	a5,-24(s0)
            printk("[PID = %d] is running. auto_inc_local_var = %d, counter = %d\n", current->pid, auto_inc_local_var, current->counter);
ffffffe0002010e8:	0000b797          	auipc	a5,0xb
ffffffe0002010ec:	f2878793          	addi	a5,a5,-216 # ffffffe00020c010 <current>
ffffffe0002010f0:	0007b783          	ld	a5,0(a5)
ffffffe0002010f4:	0187b703          	ld	a4,24(a5)
ffffffe0002010f8:	0000b797          	auipc	a5,0xb
ffffffe0002010fc:	f1878793          	addi	a5,a5,-232 # ffffffe00020c010 <current>
ffffffe000201100:	0007b783          	ld	a5,0(a5)
ffffffe000201104:	0087b783          	ld	a5,8(a5)
ffffffe000201108:	00078693          	mv	a3,a5
ffffffe00020110c:	fe843603          	ld	a2,-24(s0)
ffffffe000201110:	00070593          	mv	a1,a4
ffffffe000201114:	00004517          	auipc	a0,0x4
ffffffe000201118:	f4450513          	addi	a0,a0,-188 # ffffffe000205058 <_PA2VA_OFFSET+0x58>
ffffffe00020111c:	651010ef          	jal	ffffffe000202f6c <printk>
            printk("[PID = %d] Thread space begin at %lx\n",current->pid, current);
ffffffe000201120:	0000b797          	auipc	a5,0xb
ffffffe000201124:	ef078793          	addi	a5,a5,-272 # ffffffe00020c010 <current>
ffffffe000201128:	0007b783          	ld	a5,0(a5)
ffffffe00020112c:	0187b703          	ld	a4,24(a5)
ffffffe000201130:	0000b797          	auipc	a5,0xb
ffffffe000201134:	ee078793          	addi	a5,a5,-288 # ffffffe00020c010 <current>
ffffffe000201138:	0007b783          	ld	a5,0(a5)
ffffffe00020113c:	00078613          	mv	a2,a5
ffffffe000201140:	00070593          	mv	a1,a4
ffffffe000201144:	00004517          	auipc	a0,0x4
ffffffe000201148:	f5450513          	addi	a0,a0,-172 # ffffffe000205098 <_PA2VA_OFFSET+0x98>
ffffffe00020114c:	621010ef          	jal	ffffffe000202f6c <printk>
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
ffffffe000201150:	f35ff06f          	j	ffffffe000201084 <dummy+0x28>

ffffffe000201154 <switch_to>:
    }
}

extern void __switch_to(struct task_struct *prev, struct task_struct *next);

void switch_to(struct task_struct *next) {
ffffffe000201154:	fd010113          	addi	sp,sp,-48
ffffffe000201158:	02113423          	sd	ra,40(sp)
ffffffe00020115c:	02813023          	sd	s0,32(sp)
ffffffe000201160:	03010413          	addi	s0,sp,48
ffffffe000201164:	fca43c23          	sd	a0,-40(s0)
    // YOUR CODE HERE
   
    if(current == next){
ffffffe000201168:	0000b797          	auipc	a5,0xb
ffffffe00020116c:	ea878793          	addi	a5,a5,-344 # ffffffe00020c010 <current>
ffffffe000201170:	0007b783          	ld	a5,0(a5)
ffffffe000201174:	fd843703          	ld	a4,-40(s0)
ffffffe000201178:	04f70a63          	beq	a4,a5,ffffffe0002011cc <switch_to+0x78>
    
    }else{
        printk("switch to [PID = %d COUNTER = %d]!!!\n",next->pid,next->counter);
ffffffe00020117c:	fd843783          	ld	a5,-40(s0)
ffffffe000201180:	0187b703          	ld	a4,24(a5)
ffffffe000201184:	fd843783          	ld	a5,-40(s0)
ffffffe000201188:	0087b783          	ld	a5,8(a5)
ffffffe00020118c:	00078613          	mv	a2,a5
ffffffe000201190:	00070593          	mv	a1,a4
ffffffe000201194:	00004517          	auipc	a0,0x4
ffffffe000201198:	f2c50513          	addi	a0,a0,-212 # ffffffe0002050c0 <_PA2VA_OFFSET+0xc0>
ffffffe00020119c:	5d1010ef          	jal	ffffffe000202f6c <printk>
        struct task_struct *temp = current;
ffffffe0002011a0:	0000b797          	auipc	a5,0xb
ffffffe0002011a4:	e7078793          	addi	a5,a5,-400 # ffffffe00020c010 <current>
ffffffe0002011a8:	0007b783          	ld	a5,0(a5)
ffffffe0002011ac:	fef43423          	sd	a5,-24(s0)
        current = next;
ffffffe0002011b0:	0000b797          	auipc	a5,0xb
ffffffe0002011b4:	e6078793          	addi	a5,a5,-416 # ffffffe00020c010 <current>
ffffffe0002011b8:	fd843703          	ld	a4,-40(s0)
ffffffe0002011bc:	00e7b023          	sd	a4,0(a5)
        __switch_to(temp,next);
ffffffe0002011c0:	fd843583          	ld	a1,-40(s0)
ffffffe0002011c4:	fe843503          	ld	a0,-24(s0)
ffffffe0002011c8:	81cff0ef          	jal	ffffffe0002001e4 <__switch_to>
    }
}
ffffffe0002011cc:	00000013          	nop
ffffffe0002011d0:	02813083          	ld	ra,40(sp)
ffffffe0002011d4:	02013403          	ld	s0,32(sp)
ffffffe0002011d8:	03010113          	addi	sp,sp,48
ffffffe0002011dc:	00008067          	ret

ffffffe0002011e0 <schedule>:

void schedule() {
ffffffe0002011e0:	fd010113          	addi	sp,sp,-48
ffffffe0002011e4:	02113423          	sd	ra,40(sp)
ffffffe0002011e8:	02813023          	sd	s0,32(sp)
ffffffe0002011ec:	03010413          	addi	s0,sp,48
    //printk("schedule\n");
    struct task_struct *next = idle;
ffffffe0002011f0:	0000b797          	auipc	a5,0xb
ffffffe0002011f4:	e1878793          	addi	a5,a5,-488 # ffffffe00020c008 <idle>
ffffffe0002011f8:	0007b783          	ld	a5,0(a5)
ffffffe0002011fc:	fef43423          	sd	a5,-24(s0)
    uint64_t max_counter = 0;       
ffffffe000201200:	fe043023          	sd	zero,-32(s0)
    int all_zero = 1;       
ffffffe000201204:	00100793          	li	a5,1
ffffffe000201208:	fcf42e23          	sw	a5,-36(s0)
    for (int i = 0; i < NR_TASKS; i++) {
ffffffe00020120c:	fc042c23          	sw	zero,-40(s0)
ffffffe000201210:	0c80006f          	j	ffffffe0002012d8 <schedule+0xf8>
        if (task[i]->state != TASK_RUNNING) {
ffffffe000201214:	0000b717          	auipc	a4,0xb
ffffffe000201218:	e3470713          	addi	a4,a4,-460 # ffffffe00020c048 <task>
ffffffe00020121c:	fd842783          	lw	a5,-40(s0)
ffffffe000201220:	00379793          	slli	a5,a5,0x3
ffffffe000201224:	00f707b3          	add	a5,a4,a5
ffffffe000201228:	0007b783          	ld	a5,0(a5)
ffffffe00020122c:	0007b783          	ld	a5,0(a5)
ffffffe000201230:	08079c63          	bnez	a5,ffffffe0002012c8 <schedule+0xe8>
            continue; 
        }

        if (task[i]->counter > 0 && all_zero) {
ffffffe000201234:	0000b717          	auipc	a4,0xb
ffffffe000201238:	e1470713          	addi	a4,a4,-492 # ffffffe00020c048 <task>
ffffffe00020123c:	fd842783          	lw	a5,-40(s0)
ffffffe000201240:	00379793          	slli	a5,a5,0x3
ffffffe000201244:	00f707b3          	add	a5,a4,a5
ffffffe000201248:	0007b783          	ld	a5,0(a5)
ffffffe00020124c:	0087b783          	ld	a5,8(a5)
ffffffe000201250:	00078a63          	beqz	a5,ffffffe000201264 <schedule+0x84>
ffffffe000201254:	fdc42783          	lw	a5,-36(s0)
ffffffe000201258:	0007879b          	sext.w	a5,a5
ffffffe00020125c:	00078463          	beqz	a5,ffffffe000201264 <schedule+0x84>
            all_zero = 0; 
ffffffe000201260:	fc042e23          	sw	zero,-36(s0)
        }

        if (task[i]->counter > max_counter) {
ffffffe000201264:	0000b717          	auipc	a4,0xb
ffffffe000201268:	de470713          	addi	a4,a4,-540 # ffffffe00020c048 <task>
ffffffe00020126c:	fd842783          	lw	a5,-40(s0)
ffffffe000201270:	00379793          	slli	a5,a5,0x3
ffffffe000201274:	00f707b3          	add	a5,a4,a5
ffffffe000201278:	0007b783          	ld	a5,0(a5)
ffffffe00020127c:	0087b783          	ld	a5,8(a5)
ffffffe000201280:	fe043703          	ld	a4,-32(s0)
ffffffe000201284:	04f77463          	bgeu	a4,a5,ffffffe0002012cc <schedule+0xec>
            max_counter = task[i]->counter;
ffffffe000201288:	0000b717          	auipc	a4,0xb
ffffffe00020128c:	dc070713          	addi	a4,a4,-576 # ffffffe00020c048 <task>
ffffffe000201290:	fd842783          	lw	a5,-40(s0)
ffffffe000201294:	00379793          	slli	a5,a5,0x3
ffffffe000201298:	00f707b3          	add	a5,a4,a5
ffffffe00020129c:	0007b783          	ld	a5,0(a5)
ffffffe0002012a0:	0087b783          	ld	a5,8(a5)
ffffffe0002012a4:	fef43023          	sd	a5,-32(s0)
            next = task[i];
ffffffe0002012a8:	0000b717          	auipc	a4,0xb
ffffffe0002012ac:	da070713          	addi	a4,a4,-608 # ffffffe00020c048 <task>
ffffffe0002012b0:	fd842783          	lw	a5,-40(s0)
ffffffe0002012b4:	00379793          	slli	a5,a5,0x3
ffffffe0002012b8:	00f707b3          	add	a5,a4,a5
ffffffe0002012bc:	0007b783          	ld	a5,0(a5)
ffffffe0002012c0:	fef43423          	sd	a5,-24(s0)
ffffffe0002012c4:	0080006f          	j	ffffffe0002012cc <schedule+0xec>
            continue; 
ffffffe0002012c8:	00000013          	nop
    for (int i = 0; i < NR_TASKS; i++) {
ffffffe0002012cc:	fd842783          	lw	a5,-40(s0)
ffffffe0002012d0:	0017879b          	addiw	a5,a5,1
ffffffe0002012d4:	fcf42c23          	sw	a5,-40(s0)
ffffffe0002012d8:	fd842783          	lw	a5,-40(s0)
ffffffe0002012dc:	0007871b          	sext.w	a4,a5
ffffffe0002012e0:	00100793          	li	a5,1
ffffffe0002012e4:	f2e7d8e3          	bge	a5,a4,ffffffe000201214 <schedule+0x34>
        }
    }
    if (all_zero==1) {
ffffffe0002012e8:	fdc42783          	lw	a5,-36(s0)
ffffffe0002012ec:	0007871b          	sext.w	a4,a5
ffffffe0002012f0:	00100793          	li	a5,1
ffffffe0002012f4:	08f71663          	bne	a4,a5,ffffffe000201380 <schedule+0x1a0>
        for (int i = 1; i < NR_TASKS; i++) {
ffffffe0002012f8:	00100793          	li	a5,1
ffffffe0002012fc:	fcf42a23          	sw	a5,-44(s0)
ffffffe000201300:	0680006f          	j	ffffffe000201368 <schedule+0x188>
            if (task[i]->state == TASK_RUNNING) {
ffffffe000201304:	0000b717          	auipc	a4,0xb
ffffffe000201308:	d4470713          	addi	a4,a4,-700 # ffffffe00020c048 <task>
ffffffe00020130c:	fd442783          	lw	a5,-44(s0)
ffffffe000201310:	00379793          	slli	a5,a5,0x3
ffffffe000201314:	00f707b3          	add	a5,a4,a5
ffffffe000201318:	0007b783          	ld	a5,0(a5)
ffffffe00020131c:	0007b783          	ld	a5,0(a5)
ffffffe000201320:	02079e63          	bnez	a5,ffffffe00020135c <schedule+0x17c>
                //printk("SET [PID = %d PRIORITY = %d COUNTER = %d]\n", task[i]->pid, task[i]->priority, task[i]->counter);
                task[i]->counter = task[i]->priority;
ffffffe000201324:	0000b717          	auipc	a4,0xb
ffffffe000201328:	d2470713          	addi	a4,a4,-732 # ffffffe00020c048 <task>
ffffffe00020132c:	fd442783          	lw	a5,-44(s0)
ffffffe000201330:	00379793          	slli	a5,a5,0x3
ffffffe000201334:	00f707b3          	add	a5,a4,a5
ffffffe000201338:	0007b703          	ld	a4,0(a5)
ffffffe00020133c:	0000b697          	auipc	a3,0xb
ffffffe000201340:	d0c68693          	addi	a3,a3,-756 # ffffffe00020c048 <task>
ffffffe000201344:	fd442783          	lw	a5,-44(s0)
ffffffe000201348:	00379793          	slli	a5,a5,0x3
ffffffe00020134c:	00f687b3          	add	a5,a3,a5
ffffffe000201350:	0007b783          	ld	a5,0(a5)
ffffffe000201354:	01073703          	ld	a4,16(a4)
ffffffe000201358:	00e7b423          	sd	a4,8(a5)
        for (int i = 1; i < NR_TASKS; i++) {
ffffffe00020135c:	fd442783          	lw	a5,-44(s0)
ffffffe000201360:	0017879b          	addiw	a5,a5,1
ffffffe000201364:	fcf42a23          	sw	a5,-44(s0)
ffffffe000201368:	fd442783          	lw	a5,-44(s0)
ffffffe00020136c:	0007871b          	sext.w	a4,a5
ffffffe000201370:	00100793          	li	a5,1
ffffffe000201374:	f8e7d8e3          	bge	a5,a4,ffffffe000201304 <schedule+0x124>
            }
        }
        schedule();
ffffffe000201378:	e69ff0ef          	jal	ffffffe0002011e0 <schedule>
    }else{
        switch_to(next);
    }
}
ffffffe00020137c:	00c0006f          	j	ffffffe000201388 <schedule+0x1a8>
        switch_to(next);
ffffffe000201380:	fe843503          	ld	a0,-24(s0)
ffffffe000201384:	dd1ff0ef          	jal	ffffffe000201154 <switch_to>
}
ffffffe000201388:	00000013          	nop
ffffffe00020138c:	02813083          	ld	ra,40(sp)
ffffffe000201390:	02013403          	ld	s0,32(sp)
ffffffe000201394:	03010113          	addi	sp,sp,48
ffffffe000201398:	00008067          	ret

ffffffe00020139c <do_timer>:


void do_timer() {
ffffffe00020139c:	ff010113          	addi	sp,sp,-16
ffffffe0002013a0:	00113423          	sd	ra,8(sp)
ffffffe0002013a4:	00813023          	sd	s0,0(sp)
ffffffe0002013a8:	01010413          	addi	s0,sp,16
    //printk("do_timer!!!\n");
    if (current == idle || current->counter == 0) {
ffffffe0002013ac:	0000b797          	auipc	a5,0xb
ffffffe0002013b0:	c6478793          	addi	a5,a5,-924 # ffffffe00020c010 <current>
ffffffe0002013b4:	0007b703          	ld	a4,0(a5)
ffffffe0002013b8:	0000b797          	auipc	a5,0xb
ffffffe0002013bc:	c5078793          	addi	a5,a5,-944 # ffffffe00020c008 <idle>
ffffffe0002013c0:	0007b783          	ld	a5,0(a5)
ffffffe0002013c4:	00f70c63          	beq	a4,a5,ffffffe0002013dc <do_timer+0x40>
ffffffe0002013c8:	0000b797          	auipc	a5,0xb
ffffffe0002013cc:	c4878793          	addi	a5,a5,-952 # ffffffe00020c010 <current>
ffffffe0002013d0:	0007b783          	ld	a5,0(a5)
ffffffe0002013d4:	0087b783          	ld	a5,8(a5)
ffffffe0002013d8:	00079663          	bnez	a5,ffffffe0002013e4 <do_timer+0x48>
        schedule();
ffffffe0002013dc:	e05ff0ef          	jal	ffffffe0002011e0 <schedule>
        current->counter -= 1;
        if(current->counter==0){
          schedule();
        }
    }
}
ffffffe0002013e0:	0400006f          	j	ffffffe000201420 <do_timer+0x84>
        current->counter -= 1;
ffffffe0002013e4:	0000b797          	auipc	a5,0xb
ffffffe0002013e8:	c2c78793          	addi	a5,a5,-980 # ffffffe00020c010 <current>
ffffffe0002013ec:	0007b783          	ld	a5,0(a5)
ffffffe0002013f0:	0087b703          	ld	a4,8(a5)
ffffffe0002013f4:	0000b797          	auipc	a5,0xb
ffffffe0002013f8:	c1c78793          	addi	a5,a5,-996 # ffffffe00020c010 <current>
ffffffe0002013fc:	0007b783          	ld	a5,0(a5)
ffffffe000201400:	fff70713          	addi	a4,a4,-1
ffffffe000201404:	00e7b423          	sd	a4,8(a5)
        if(current->counter==0){
ffffffe000201408:	0000b797          	auipc	a5,0xb
ffffffe00020140c:	c0878793          	addi	a5,a5,-1016 # ffffffe00020c010 <current>
ffffffe000201410:	0007b783          	ld	a5,0(a5)
ffffffe000201414:	0087b783          	ld	a5,8(a5)
ffffffe000201418:	00079463          	bnez	a5,ffffffe000201420 <do_timer+0x84>
          schedule();
ffffffe00020141c:	dc5ff0ef          	jal	ffffffe0002011e0 <schedule>
}
ffffffe000201420:	00000013          	nop
ffffffe000201424:	00813083          	ld	ra,8(sp)
ffffffe000201428:	00013403          	ld	s0,0(sp)
ffffffe00020142c:	01010113          	addi	sp,sp,16
ffffffe000201430:	00008067          	ret

ffffffe000201434 <sbi_ecall>:
#include "sbi.h"
#include "printk.h"

struct sbiret sbi_ecall(uint64_t eid, uint64_t fid,
                        uint64_t arg0, uint64_t arg1, uint64_t arg2,
                        uint64_t arg3, uint64_t arg4, uint64_t arg5) {
ffffffe000201434:	f7010113          	addi	sp,sp,-144
ffffffe000201438:	08813423          	sd	s0,136(sp)
ffffffe00020143c:	08913023          	sd	s1,128(sp)
ffffffe000201440:	07213c23          	sd	s2,120(sp)
ffffffe000201444:	07313823          	sd	s3,112(sp)
ffffffe000201448:	09010413          	addi	s0,sp,144
ffffffe00020144c:	faa43423          	sd	a0,-88(s0)
ffffffe000201450:	fab43023          	sd	a1,-96(s0)
ffffffe000201454:	f8c43c23          	sd	a2,-104(s0)
ffffffe000201458:	f8d43823          	sd	a3,-112(s0)
ffffffe00020145c:	f8e43423          	sd	a4,-120(s0)
ffffffe000201460:	f8f43023          	sd	a5,-128(s0)
ffffffe000201464:	f7043c23          	sd	a6,-136(s0)
ffffffe000201468:	f7143823          	sd	a7,-144(s0)
    uint64_t error,value;
    struct sbiret ret;

    __asm__ volatile (   
ffffffe00020146c:	fa843e03          	ld	t3,-88(s0)
ffffffe000201470:	fa043e83          	ld	t4,-96(s0)
ffffffe000201474:	f9843f03          	ld	t5,-104(s0)
ffffffe000201478:	f9043f83          	ld	t6,-112(s0)
ffffffe00020147c:	f8843283          	ld	t0,-120(s0)
ffffffe000201480:	f8043483          	ld	s1,-128(s0)
ffffffe000201484:	f7843903          	ld	s2,-136(s0)
ffffffe000201488:	f7043983          	ld	s3,-144(s0)
ffffffe00020148c:	000e0893          	mv	a7,t3
ffffffe000201490:	000e8813          	mv	a6,t4
ffffffe000201494:	000f0513          	mv	a0,t5
ffffffe000201498:	000f8593          	mv	a1,t6
ffffffe00020149c:	00028613          	mv	a2,t0
ffffffe0002014a0:	00048693          	mv	a3,s1
ffffffe0002014a4:	00090713          	mv	a4,s2
ffffffe0002014a8:	00098793          	mv	a5,s3
ffffffe0002014ac:	00000073          	ecall
ffffffe0002014b0:	00050e93          	mv	t4,a0
ffffffe0002014b4:	00058e13          	mv	t3,a1
ffffffe0002014b8:	fdd43c23          	sd	t4,-40(s0)
ffffffe0002014bc:	fdc43823          	sd	t3,-48(s0)
        : [error] "=r" (error), [value] "=r" (value)  
        : [eid] "r" (eid), [fid] "r" (fid), [arg0] "r" (arg0), [arg1] "r" (arg1),
          [arg2] "r" (arg2), [arg3] "r" (arg3), [arg4] "r" (arg4), [arg5] "r" (arg5)
        : "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7", "memory" 
    );
    ret.error = error;
ffffffe0002014c0:	fd843783          	ld	a5,-40(s0)
ffffffe0002014c4:	faf43823          	sd	a5,-80(s0)
    ret.value = value;
ffffffe0002014c8:	fd043783          	ld	a5,-48(s0)
ffffffe0002014cc:	faf43c23          	sd	a5,-72(s0)
    return ret;
ffffffe0002014d0:	fb043783          	ld	a5,-80(s0)
ffffffe0002014d4:	fcf43023          	sd	a5,-64(s0)
ffffffe0002014d8:	fb843783          	ld	a5,-72(s0)
ffffffe0002014dc:	fcf43423          	sd	a5,-56(s0)
ffffffe0002014e0:	fc043703          	ld	a4,-64(s0)
ffffffe0002014e4:	fc843783          	ld	a5,-56(s0)
ffffffe0002014e8:	00070313          	mv	t1,a4
ffffffe0002014ec:	00078393          	mv	t2,a5
ffffffe0002014f0:	00030713          	mv	a4,t1
ffffffe0002014f4:	00038793          	mv	a5,t2
}
ffffffe0002014f8:	00070513          	mv	a0,a4
ffffffe0002014fc:	00078593          	mv	a1,a5
ffffffe000201500:	08813403          	ld	s0,136(sp)
ffffffe000201504:	08013483          	ld	s1,128(sp)
ffffffe000201508:	07813903          	ld	s2,120(sp)
ffffffe00020150c:	07013983          	ld	s3,112(sp)
ffffffe000201510:	09010113          	addi	sp,sp,144
ffffffe000201514:	00008067          	ret

ffffffe000201518 <sbi_debug_console_write_byte>:

struct sbiret sbi_debug_console_write_byte(uint8_t byte) {
ffffffe000201518:	fb010113          	addi	sp,sp,-80
ffffffe00020151c:	04113423          	sd	ra,72(sp)
ffffffe000201520:	04813023          	sd	s0,64(sp)
ffffffe000201524:	03213c23          	sd	s2,56(sp)
ffffffe000201528:	03313823          	sd	s3,48(sp)
ffffffe00020152c:	05010413          	addi	s0,sp,80
ffffffe000201530:	00050793          	mv	a5,a0
ffffffe000201534:	faf40fa3          	sb	a5,-65(s0)
    const uint64_t EID = 0x4442434e;
ffffffe000201538:	444247b7          	lui	a5,0x44424
ffffffe00020153c:	34e78793          	addi	a5,a5,846 # 4442434e <PHY_SIZE+0x3c42434e>
ffffffe000201540:	fcf43c23          	sd	a5,-40(s0)
    const uint64_t FID = 2;
ffffffe000201544:	00200793          	li	a5,2
ffffffe000201548:	fcf43823          	sd	a5,-48(s0)
    return sbi_ecall(EID, FID, byte, 0, 0, 0, 0, 0);
ffffffe00020154c:	fbf44603          	lbu	a2,-65(s0)
ffffffe000201550:	00000893          	li	a7,0
ffffffe000201554:	00000813          	li	a6,0
ffffffe000201558:	00000793          	li	a5,0
ffffffe00020155c:	00000713          	li	a4,0
ffffffe000201560:	00000693          	li	a3,0
ffffffe000201564:	fd043583          	ld	a1,-48(s0)
ffffffe000201568:	fd843503          	ld	a0,-40(s0)
ffffffe00020156c:	ec9ff0ef          	jal	ffffffe000201434 <sbi_ecall>
ffffffe000201570:	00050713          	mv	a4,a0
ffffffe000201574:	00058793          	mv	a5,a1
ffffffe000201578:	fce43023          	sd	a4,-64(s0)
ffffffe00020157c:	fcf43423          	sd	a5,-56(s0)
ffffffe000201580:	fc043703          	ld	a4,-64(s0)
ffffffe000201584:	fc843783          	ld	a5,-56(s0)
ffffffe000201588:	00070913          	mv	s2,a4
ffffffe00020158c:	00078993          	mv	s3,a5
ffffffe000201590:	00090713          	mv	a4,s2
ffffffe000201594:	00098793          	mv	a5,s3
}
ffffffe000201598:	00070513          	mv	a0,a4
ffffffe00020159c:	00078593          	mv	a1,a5
ffffffe0002015a0:	04813083          	ld	ra,72(sp)
ffffffe0002015a4:	04013403          	ld	s0,64(sp)
ffffffe0002015a8:	03813903          	ld	s2,56(sp)
ffffffe0002015ac:	03013983          	ld	s3,48(sp)
ffffffe0002015b0:	05010113          	addi	sp,sp,80
ffffffe0002015b4:	00008067          	ret

ffffffe0002015b8 <sbi_system_reset>:

struct sbiret sbi_system_reset(uint32_t reset_type, uint32_t reset_reason) {
ffffffe0002015b8:	fb010113          	addi	sp,sp,-80
ffffffe0002015bc:	04113423          	sd	ra,72(sp)
ffffffe0002015c0:	04813023          	sd	s0,64(sp)
ffffffe0002015c4:	03213c23          	sd	s2,56(sp)
ffffffe0002015c8:	03313823          	sd	s3,48(sp)
ffffffe0002015cc:	05010413          	addi	s0,sp,80
ffffffe0002015d0:	00050793          	mv	a5,a0
ffffffe0002015d4:	00058713          	mv	a4,a1
ffffffe0002015d8:	faf42e23          	sw	a5,-68(s0)
ffffffe0002015dc:	00070793          	mv	a5,a4
ffffffe0002015e0:	faf42c23          	sw	a5,-72(s0)
    const uint64_t EID = 0x53525354;
ffffffe0002015e4:	535257b7          	lui	a5,0x53525
ffffffe0002015e8:	35478793          	addi	a5,a5,852 # 53525354 <PHY_SIZE+0x4b525354>
ffffffe0002015ec:	fcf43c23          	sd	a5,-40(s0)
    const uint64_t FID = 0;
ffffffe0002015f0:	fc043823          	sd	zero,-48(s0)
    return sbi_ecall(EID, FID, (uint64_t)reset_type, (uint64_t)reset_reason, 0, 0, 0, 0);
ffffffe0002015f4:	fbc46603          	lwu	a2,-68(s0)
ffffffe0002015f8:	fb846683          	lwu	a3,-72(s0)
ffffffe0002015fc:	00000893          	li	a7,0
ffffffe000201600:	00000813          	li	a6,0
ffffffe000201604:	00000793          	li	a5,0
ffffffe000201608:	00000713          	li	a4,0
ffffffe00020160c:	fd043583          	ld	a1,-48(s0)
ffffffe000201610:	fd843503          	ld	a0,-40(s0)
ffffffe000201614:	e21ff0ef          	jal	ffffffe000201434 <sbi_ecall>
ffffffe000201618:	00050713          	mv	a4,a0
ffffffe00020161c:	00058793          	mv	a5,a1
ffffffe000201620:	fce43023          	sd	a4,-64(s0)
ffffffe000201624:	fcf43423          	sd	a5,-56(s0)
ffffffe000201628:	fc043703          	ld	a4,-64(s0)
ffffffe00020162c:	fc843783          	ld	a5,-56(s0)
ffffffe000201630:	00070913          	mv	s2,a4
ffffffe000201634:	00078993          	mv	s3,a5
ffffffe000201638:	00090713          	mv	a4,s2
ffffffe00020163c:	00098793          	mv	a5,s3
}
ffffffe000201640:	00070513          	mv	a0,a4
ffffffe000201644:	00078593          	mv	a1,a5
ffffffe000201648:	04813083          	ld	ra,72(sp)
ffffffe00020164c:	04013403          	ld	s0,64(sp)
ffffffe000201650:	03813903          	ld	s2,56(sp)
ffffffe000201654:	03013983          	ld	s3,48(sp)
ffffffe000201658:	05010113          	addi	sp,sp,80
ffffffe00020165c:	00008067          	ret

ffffffe000201660 <sbi_debug_console_read>:

struct sbiret sbi_debug_console_read(uint64_t num_bytes, uint64_t base_addr_lo, uint64_t base_addr_hi){
ffffffe000201660:	fa010113          	addi	sp,sp,-96
ffffffe000201664:	04113c23          	sd	ra,88(sp)
ffffffe000201668:	04813823          	sd	s0,80(sp)
ffffffe00020166c:	05213423          	sd	s2,72(sp)
ffffffe000201670:	05313023          	sd	s3,64(sp)
ffffffe000201674:	06010413          	addi	s0,sp,96
ffffffe000201678:	faa43c23          	sd	a0,-72(s0)
ffffffe00020167c:	fab43823          	sd	a1,-80(s0)
ffffffe000201680:	fac43423          	sd	a2,-88(s0)
    const uint64_t EID = 0x4442434e;
ffffffe000201684:	444247b7          	lui	a5,0x44424
ffffffe000201688:	34e78793          	addi	a5,a5,846 # 4442434e <PHY_SIZE+0x3c42434e>
ffffffe00020168c:	fcf43c23          	sd	a5,-40(s0)
    const uint64_t FID = 1;
ffffffe000201690:	00100793          	li	a5,1
ffffffe000201694:	fcf43823          	sd	a5,-48(s0)
    return sbi_ecall(EID, FID, (uint64_t)num_bytes, (uint64_t)base_addr_lo, (uint64_t)base_addr_hi, 0, 0, 0);
ffffffe000201698:	00000893          	li	a7,0
ffffffe00020169c:	00000813          	li	a6,0
ffffffe0002016a0:	00000793          	li	a5,0
ffffffe0002016a4:	fa843703          	ld	a4,-88(s0)
ffffffe0002016a8:	fb043683          	ld	a3,-80(s0)
ffffffe0002016ac:	fb843603          	ld	a2,-72(s0)
ffffffe0002016b0:	fd043583          	ld	a1,-48(s0)
ffffffe0002016b4:	fd843503          	ld	a0,-40(s0)
ffffffe0002016b8:	d7dff0ef          	jal	ffffffe000201434 <sbi_ecall>
ffffffe0002016bc:	00050713          	mv	a4,a0
ffffffe0002016c0:	00058793          	mv	a5,a1
ffffffe0002016c4:	fce43023          	sd	a4,-64(s0)
ffffffe0002016c8:	fcf43423          	sd	a5,-56(s0)
ffffffe0002016cc:	fc043703          	ld	a4,-64(s0)
ffffffe0002016d0:	fc843783          	ld	a5,-56(s0)
ffffffe0002016d4:	00070913          	mv	s2,a4
ffffffe0002016d8:	00078993          	mv	s3,a5
ffffffe0002016dc:	00090713          	mv	a4,s2
ffffffe0002016e0:	00098793          	mv	a5,s3
}
ffffffe0002016e4:	00070513          	mv	a0,a4
ffffffe0002016e8:	00078593          	mv	a1,a5
ffffffe0002016ec:	05813083          	ld	ra,88(sp)
ffffffe0002016f0:	05013403          	ld	s0,80(sp)
ffffffe0002016f4:	04813903          	ld	s2,72(sp)
ffffffe0002016f8:	04013983          	ld	s3,64(sp)
ffffffe0002016fc:	06010113          	addi	sp,sp,96
ffffffe000201700:	00008067          	ret

ffffffe000201704 <sbi_debug_console_write>:

struct sbiret sbi_debug_console_write(unsigned long num,unsigned long lo, unsigned long hi) {
ffffffe000201704:	fa010113          	addi	sp,sp,-96
ffffffe000201708:	04113c23          	sd	ra,88(sp)
ffffffe00020170c:	04813823          	sd	s0,80(sp)
ffffffe000201710:	05213423          	sd	s2,72(sp)
ffffffe000201714:	05313023          	sd	s3,64(sp)
ffffffe000201718:	06010413          	addi	s0,sp,96
ffffffe00020171c:	faa43c23          	sd	a0,-72(s0)
ffffffe000201720:	fab43823          	sd	a1,-80(s0)
ffffffe000201724:	fac43423          	sd	a2,-88(s0)
    const uint64_t EID = 0x4442434e;
ffffffe000201728:	444247b7          	lui	a5,0x44424
ffffffe00020172c:	34e78793          	addi	a5,a5,846 # 4442434e <PHY_SIZE+0x3c42434e>
ffffffe000201730:	fcf43c23          	sd	a5,-40(s0)
    const uint64_t FID = 0;
ffffffe000201734:	fc043823          	sd	zero,-48(s0)
    return sbi_ecall(EID, FID, (uint64_t)num, (uint64_t)lo, (uint64_t)hi, 0, 0, 0);
ffffffe000201738:	00000893          	li	a7,0
ffffffe00020173c:	00000813          	li	a6,0
ffffffe000201740:	00000793          	li	a5,0
ffffffe000201744:	fa843703          	ld	a4,-88(s0)
ffffffe000201748:	fb043683          	ld	a3,-80(s0)
ffffffe00020174c:	fb843603          	ld	a2,-72(s0)
ffffffe000201750:	fd043583          	ld	a1,-48(s0)
ffffffe000201754:	fd843503          	ld	a0,-40(s0)
ffffffe000201758:	cddff0ef          	jal	ffffffe000201434 <sbi_ecall>
ffffffe00020175c:	00050713          	mv	a4,a0
ffffffe000201760:	00058793          	mv	a5,a1
ffffffe000201764:	fce43023          	sd	a4,-64(s0)
ffffffe000201768:	fcf43423          	sd	a5,-56(s0)
ffffffe00020176c:	fc043703          	ld	a4,-64(s0)
ffffffe000201770:	fc843783          	ld	a5,-56(s0)
ffffffe000201774:	00070913          	mv	s2,a4
ffffffe000201778:	00078993          	mv	s3,a5
ffffffe00020177c:	00090713          	mv	a4,s2
ffffffe000201780:	00098793          	mv	a5,s3
}
ffffffe000201784:	00070513          	mv	a0,a4
ffffffe000201788:	00078593          	mv	a1,a5
ffffffe00020178c:	05813083          	ld	ra,88(sp)
ffffffe000201790:	05013403          	ld	s0,80(sp)
ffffffe000201794:	04813903          	ld	s2,72(sp)
ffffffe000201798:	04013983          	ld	s3,64(sp)
ffffffe00020179c:	06010113          	addi	sp,sp,96
ffffffe0002017a0:	00008067          	ret

ffffffe0002017a4 <sbi_set_timer>:

struct sbiret sbi_set_timer(uint64_t stime_value) {
ffffffe0002017a4:	fb010113          	addi	sp,sp,-80
ffffffe0002017a8:	04113423          	sd	ra,72(sp)
ffffffe0002017ac:	04813023          	sd	s0,64(sp)
ffffffe0002017b0:	03213c23          	sd	s2,56(sp)
ffffffe0002017b4:	03313823          	sd	s3,48(sp)
ffffffe0002017b8:	05010413          	addi	s0,sp,80
ffffffe0002017bc:	faa43c23          	sd	a0,-72(s0)
    const uint64_t EID = 0x54494d45;
ffffffe0002017c0:	544957b7          	lui	a5,0x54495
ffffffe0002017c4:	d4578793          	addi	a5,a5,-699 # 54494d45 <PHY_SIZE+0x4c494d45>
ffffffe0002017c8:	fcf43c23          	sd	a5,-40(s0)
    const uint64_t FID = 0;
ffffffe0002017cc:	fc043823          	sd	zero,-48(s0)
    return sbi_ecall(EID, FID, stime_value, 0, 0, 0, 0, 0);
ffffffe0002017d0:	00000893          	li	a7,0
ffffffe0002017d4:	00000813          	li	a6,0
ffffffe0002017d8:	00000793          	li	a5,0
ffffffe0002017dc:	00000713          	li	a4,0
ffffffe0002017e0:	00000693          	li	a3,0
ffffffe0002017e4:	fb843603          	ld	a2,-72(s0)
ffffffe0002017e8:	fd043583          	ld	a1,-48(s0)
ffffffe0002017ec:	fd843503          	ld	a0,-40(s0)
ffffffe0002017f0:	c45ff0ef          	jal	ffffffe000201434 <sbi_ecall>
ffffffe0002017f4:	00050713          	mv	a4,a0
ffffffe0002017f8:	00058793          	mv	a5,a1
ffffffe0002017fc:	fce43023          	sd	a4,-64(s0)
ffffffe000201800:	fcf43423          	sd	a5,-56(s0)
ffffffe000201804:	fc043703          	ld	a4,-64(s0)
ffffffe000201808:	fc843783          	ld	a5,-56(s0)
ffffffe00020180c:	00070913          	mv	s2,a4
ffffffe000201810:	00078993          	mv	s3,a5
ffffffe000201814:	00090713          	mv	a4,s2
ffffffe000201818:	00098793          	mv	a5,s3
}
ffffffe00020181c:	00070513          	mv	a0,a4
ffffffe000201820:	00078593          	mv	a1,a5
ffffffe000201824:	04813083          	ld	ra,72(sp)
ffffffe000201828:	04013403          	ld	s0,64(sp)
ffffffe00020182c:	03813903          	ld	s2,56(sp)
ffffffe000201830:	03013983          	ld	s3,48(sp)
ffffffe000201834:	05010113          	addi	sp,sp,80
ffffffe000201838:	00008067          	ret

ffffffe00020183c <getpid>:
#include "syscall.h"
#include "printk.h"
#include "proc.h"
extern struct task_struct* current;
void getpid(struct pt_regs* regs){
ffffffe00020183c:	fe010113          	addi	sp,sp,-32
ffffffe000201840:	00813c23          	sd	s0,24(sp)
ffffffe000201844:	02010413          	addi	s0,sp,32
ffffffe000201848:	fea43423          	sd	a0,-24(s0)
  regs->a0 = current->pid;
ffffffe00020184c:	0000a797          	auipc	a5,0xa
ffffffe000201850:	7c478793          	addi	a5,a5,1988 # ffffffe00020c010 <current>
ffffffe000201854:	0007b783          	ld	a5,0(a5)
ffffffe000201858:	0187b703          	ld	a4,24(a5)
ffffffe00020185c:	fe843783          	ld	a5,-24(s0)
ffffffe000201860:	04e7b423          	sd	a4,72(a5)
}
ffffffe000201864:	00000013          	nop
ffffffe000201868:	01813403          	ld	s0,24(sp)
ffffffe00020186c:	02010113          	addi	sp,sp,32
ffffffe000201870:	00008067          	ret

ffffffe000201874 <write>:
uint64_t write(uint64_t fd, const char* buf, uint64_t count){
ffffffe000201874:	fc010113          	addi	sp,sp,-64
ffffffe000201878:	02113c23          	sd	ra,56(sp)
ffffffe00020187c:	02813823          	sd	s0,48(sp)
ffffffe000201880:	04010413          	addi	s0,sp,64
ffffffe000201884:	fca43c23          	sd	a0,-40(s0)
ffffffe000201888:	fcb43823          	sd	a1,-48(s0)
ffffffe00020188c:	fcc43423          	sd	a2,-56(s0)
  if(fd == 1){
ffffffe000201890:	fd843703          	ld	a4,-40(s0)
ffffffe000201894:	00100793          	li	a5,1
ffffffe000201898:	04f71863          	bne	a4,a5,ffffffe0002018e8 <write+0x74>
    for(int i=0;i<count;i++){
ffffffe00020189c:	fe042623          	sw	zero,-20(s0)
ffffffe0002018a0:	0340006f          	j	ffffffe0002018d4 <write+0x60>
      printk("%c",buf[i]);
ffffffe0002018a4:	fec42783          	lw	a5,-20(s0)
ffffffe0002018a8:	fd043703          	ld	a4,-48(s0)
ffffffe0002018ac:	00f707b3          	add	a5,a4,a5
ffffffe0002018b0:	0007c783          	lbu	a5,0(a5)
ffffffe0002018b4:	0007879b          	sext.w	a5,a5
ffffffe0002018b8:	00078593          	mv	a1,a5
ffffffe0002018bc:	00004517          	auipc	a0,0x4
ffffffe0002018c0:	82c50513          	addi	a0,a0,-2004 # ffffffe0002050e8 <_PA2VA_OFFSET+0xe8>
ffffffe0002018c4:	6a8010ef          	jal	ffffffe000202f6c <printk>
    for(int i=0;i<count;i++){
ffffffe0002018c8:	fec42783          	lw	a5,-20(s0)
ffffffe0002018cc:	0017879b          	addiw	a5,a5,1
ffffffe0002018d0:	fef42623          	sw	a5,-20(s0)
ffffffe0002018d4:	fec42783          	lw	a5,-20(s0)
ffffffe0002018d8:	fc843703          	ld	a4,-56(s0)
ffffffe0002018dc:	fce7e4e3          	bltu	a5,a4,ffffffe0002018a4 <write+0x30>
    }
    return count;
ffffffe0002018e0:	fc843783          	ld	a5,-56(s0)
ffffffe0002018e4:	0080006f          	j	ffffffe0002018ec <write+0x78>
  }else{
    return -1;
ffffffe0002018e8:	fff00793          	li	a5,-1
  }
}
ffffffe0002018ec:	00078513          	mv	a0,a5
ffffffe0002018f0:	03813083          	ld	ra,56(sp)
ffffffe0002018f4:	03013403          	ld	s0,48(sp)
ffffffe0002018f8:	04010113          	addi	sp,sp,64
ffffffe0002018fc:	00008067          	ret

ffffffe000201900 <sys_write>:

int64_t sys_write(uint64_t fd, const char *buf, uint64_t len) {
ffffffe000201900:	fc010113          	addi	sp,sp,-64
ffffffe000201904:	02113c23          	sd	ra,56(sp)
ffffffe000201908:	02813823          	sd	s0,48(sp)
ffffffe00020190c:	04010413          	addi	s0,sp,64
ffffffe000201910:	fca43c23          	sd	a0,-40(s0)
ffffffe000201914:	fcb43823          	sd	a1,-48(s0)
ffffffe000201918:	fcc43423          	sd	a2,-56(s0)
    int64_t ret;
    struct file *file = &(current->files->fd_array[fd]);
ffffffe00020191c:	0000a797          	auipc	a5,0xa
ffffffe000201920:	6f478793          	addi	a5,a5,1780 # ffffffe00020c010 <current>
ffffffe000201924:	0007b783          	ld	a5,0(a5)
ffffffe000201928:	0b07b683          	ld	a3,176(a5)
ffffffe00020192c:	fd843703          	ld	a4,-40(s0)
ffffffe000201930:	00070793          	mv	a5,a4
ffffffe000201934:	00479793          	slli	a5,a5,0x4
ffffffe000201938:	00e787b3          	add	a5,a5,a4
ffffffe00020193c:	00379793          	slli	a5,a5,0x3
ffffffe000201940:	00f687b3          	add	a5,a3,a5
ffffffe000201944:	fef43423          	sd	a5,-24(s0)
    if (file->opened == 0) {
ffffffe000201948:	fe843783          	ld	a5,-24(s0)
ffffffe00020194c:	0007a783          	lw	a5,0(a5)
ffffffe000201950:	00079c63          	bnez	a5,ffffffe000201968 <sys_write+0x68>
        printk("file not opened\n");
ffffffe000201954:	00003517          	auipc	a0,0x3
ffffffe000201958:	79c50513          	addi	a0,a0,1948 # ffffffe0002050f0 <_PA2VA_OFFSET+0xf0>
ffffffe00020195c:	610010ef          	jal	ffffffe000202f6c <printk>
        return ERROR_FILE_NOT_OPEN;
ffffffe000201960:	0ff00793          	li	a5,255
ffffffe000201964:	06c0006f          	j	ffffffe0002019d0 <sys_write+0xd0>
    } else {
        // check perms and call write function of file
      if (!(file->perms & FILE_WRITABLE)) {
ffffffe000201968:	fe843783          	ld	a5,-24(s0)
ffffffe00020196c:	0047a783          	lw	a5,4(a5)
ffffffe000201970:	0027f793          	andi	a5,a5,2
ffffffe000201974:	0007879b          	sext.w	a5,a5
ffffffe000201978:	00079c63          	bnez	a5,ffffffe000201990 <sys_write+0x90>
        printk("file not writable\n");
ffffffe00020197c:	00003517          	auipc	a0,0x3
ffffffe000201980:	78c50513          	addi	a0,a0,1932 # ffffffe000205108 <_PA2VA_OFFSET+0x108>
ffffffe000201984:	5e8010ef          	jal	ffffffe000202f6c <printk>
        return -1;
ffffffe000201988:	fff00793          	li	a5,-1
ffffffe00020198c:	0440006f          	j	ffffffe0002019d0 <sys_write+0xd0>
      }
      if (file->write != NULL) {
ffffffe000201990:	fe843783          	ld	a5,-24(s0)
ffffffe000201994:	0287b783          	ld	a5,40(a5)
ffffffe000201998:	02078463          	beqz	a5,ffffffe0002019c0 <sys_write+0xc0>
        ret = file->write(file, buf, len); 
ffffffe00020199c:	fe843783          	ld	a5,-24(s0)
ffffffe0002019a0:	0287b783          	ld	a5,40(a5)
ffffffe0002019a4:	fc843603          	ld	a2,-56(s0)
ffffffe0002019a8:	fd043583          	ld	a1,-48(s0)
ffffffe0002019ac:	fe843503          	ld	a0,-24(s0)
ffffffe0002019b0:	000780e7          	jalr	a5
ffffffe0002019b4:	fea43023          	sd	a0,-32(s0)
      } else {
        printk("no write function implemented\n");
        return -1;
      }
    }
    return ret;
ffffffe0002019b8:	fe043783          	ld	a5,-32(s0)
ffffffe0002019bc:	0140006f          	j	ffffffe0002019d0 <sys_write+0xd0>
        printk("no write function implemented\n");
ffffffe0002019c0:	00003517          	auipc	a0,0x3
ffffffe0002019c4:	76050513          	addi	a0,a0,1888 # ffffffe000205120 <_PA2VA_OFFSET+0x120>
ffffffe0002019c8:	5a4010ef          	jal	ffffffe000202f6c <printk>
        return -1;
ffffffe0002019cc:	fff00793          	li	a5,-1
}
ffffffe0002019d0:	00078513          	mv	a0,a5
ffffffe0002019d4:	03813083          	ld	ra,56(sp)
ffffffe0002019d8:	03013403          	ld	s0,48(sp)
ffffffe0002019dc:	04010113          	addi	sp,sp,64
ffffffe0002019e0:	00008067          	ret

ffffffe0002019e4 <syscall>:

void syscall(struct pt_regs* regs) {
ffffffe0002019e4:	fe010113          	addi	sp,sp,-32
ffffffe0002019e8:	00113c23          	sd	ra,24(sp)
ffffffe0002019ec:	00813823          	sd	s0,16(sp)
ffffffe0002019f0:	02010413          	addi	s0,sp,32
ffffffe0002019f4:	fea43423          	sd	a0,-24(s0)
    if (regs->a7 == SYS_WRITE) {
ffffffe0002019f8:	fe843783          	ld	a5,-24(s0)
ffffffe0002019fc:	0807b703          	ld	a4,128(a5)
ffffffe000201a00:	04000793          	li	a5,64
ffffffe000201a04:	04f71263          	bne	a4,a5,ffffffe000201a48 <syscall+0x64>
      regs->a0 = sys_write(regs->a0, (const char *)regs->a1, regs->a2);
ffffffe000201a08:	fe843783          	ld	a5,-24(s0)
ffffffe000201a0c:	0487b703          	ld	a4,72(a5)
ffffffe000201a10:	fe843783          	ld	a5,-24(s0)
ffffffe000201a14:	0507b783          	ld	a5,80(a5)
ffffffe000201a18:	00078693          	mv	a3,a5
ffffffe000201a1c:	fe843783          	ld	a5,-24(s0)
ffffffe000201a20:	0587b783          	ld	a5,88(a5)
ffffffe000201a24:	00078613          	mv	a2,a5
ffffffe000201a28:	00068593          	mv	a1,a3
ffffffe000201a2c:	00070513          	mv	a0,a4
ffffffe000201a30:	ed1ff0ef          	jal	ffffffe000201900 <sys_write>
ffffffe000201a34:	00050793          	mv	a5,a0
ffffffe000201a38:	00078713          	mv	a4,a5
ffffffe000201a3c:	fe843783          	ld	a5,-24(s0)
ffffffe000201a40:	04e7b423          	sd	a4,72(a5)
ffffffe000201a44:	0880006f          	j	ffffffe000201acc <syscall+0xe8>
    } else if (regs->a7 == SYS_GETPID) {
ffffffe000201a48:	fe843783          	ld	a5,-24(s0)
ffffffe000201a4c:	0807b703          	ld	a4,128(a5)
ffffffe000201a50:	0ac00793          	li	a5,172
ffffffe000201a54:	00f71863          	bne	a4,a5,ffffffe000201a64 <syscall+0x80>
      getpid(regs);
ffffffe000201a58:	fe843503          	ld	a0,-24(s0)
ffffffe000201a5c:	de1ff0ef          	jal	ffffffe00020183c <getpid>
ffffffe000201a60:	06c0006f          	j	ffffffe000201acc <syscall+0xe8>
    } else if (regs->a7 == SYS_READ){
ffffffe000201a64:	fe843783          	ld	a5,-24(s0)
ffffffe000201a68:	0807b703          	ld	a4,128(a5)
ffffffe000201a6c:	03f00793          	li	a5,63
ffffffe000201a70:	04f71263          	bne	a4,a5,ffffffe000201ab4 <syscall+0xd0>
      regs->a0 = stdin_read(regs->a0, (const char *)regs->a1, regs->a2);
ffffffe000201a74:	fe843783          	ld	a5,-24(s0)
ffffffe000201a78:	0487b703          	ld	a4,72(a5)
ffffffe000201a7c:	fe843783          	ld	a5,-24(s0)
ffffffe000201a80:	0507b783          	ld	a5,80(a5)
ffffffe000201a84:	00078693          	mv	a3,a5
ffffffe000201a88:	fe843783          	ld	a5,-24(s0)
ffffffe000201a8c:	0587b783          	ld	a5,88(a5)
ffffffe000201a90:	00078613          	mv	a2,a5
ffffffe000201a94:	00068593          	mv	a1,a3
ffffffe000201a98:	00070513          	mv	a0,a4
ffffffe000201a9c:	785010ef          	jal	ffffffe000203a20 <stdin_read>
ffffffe000201aa0:	00050793          	mv	a5,a0
ffffffe000201aa4:	00078713          	mv	a4,a5
ffffffe000201aa8:	fe843783          	ld	a5,-24(s0)
ffffffe000201aac:	04e7b423          	sd	a4,72(a5)
ffffffe000201ab0:	01c0006f          	j	ffffffe000201acc <syscall+0xe8>
    } else{
      printk("syscall index = %lld\n", regs->a7);
ffffffe000201ab4:	fe843783          	ld	a5,-24(s0)
ffffffe000201ab8:	0807b783          	ld	a5,128(a5)
ffffffe000201abc:	00078593          	mv	a1,a5
ffffffe000201ac0:	00003517          	auipc	a0,0x3
ffffffe000201ac4:	68050513          	addi	a0,a0,1664 # ffffffe000205140 <_PA2VA_OFFSET+0x140>
ffffffe000201ac8:	4a4010ef          	jal	ffffffe000202f6c <printk>
    }
    regs->sepc += 4;
ffffffe000201acc:	fe843783          	ld	a5,-24(s0)
ffffffe000201ad0:	0f87b783          	ld	a5,248(a5)
ffffffe000201ad4:	00478713          	addi	a4,a5,4
ffffffe000201ad8:	fe843783          	ld	a5,-24(s0)
ffffffe000201adc:	0ee7bc23          	sd	a4,248(a5)
    return;
ffffffe000201ae0:	00000013          	nop
}
ffffffe000201ae4:	01813083          	ld	ra,24(sp)
ffffffe000201ae8:	01013403          	ld	s0,16(sp)
ffffffe000201aec:	02010113          	addi	sp,sp,32
ffffffe000201af0:	00008067          	ret

ffffffe000201af4 <trap_handler>:
#include"printk.h"
#include"proc.h"
void clock_set_next_event();
extern void syscall();

void trap_handler(uint64_t scause, uint64_t sepc, struct pt_regs *regs){
ffffffe000201af4:	fd010113          	addi	sp,sp,-48
ffffffe000201af8:	02113423          	sd	ra,40(sp)
ffffffe000201afc:	02813023          	sd	s0,32(sp)
ffffffe000201b00:	03010413          	addi	s0,sp,48
ffffffe000201b04:	fea43423          	sd	a0,-24(s0)
ffffffe000201b08:	feb43023          	sd	a1,-32(s0)
ffffffe000201b0c:	fcc43c23          	sd	a2,-40(s0)
  if(scause & (1ul<<63)){
ffffffe000201b10:	fe843783          	ld	a5,-24(s0)
ffffffe000201b14:	0007de63          	bgez	a5,ffffffe000201b30 <trap_handler+0x3c>
    if(scause & (5ul)){
ffffffe000201b18:	fe843783          	ld	a5,-24(s0)
ffffffe000201b1c:	0057f793          	andi	a5,a5,5
ffffffe000201b20:	02078c63          	beqz	a5,ffffffe000201b58 <trap_handler+0x64>
     // printk("clock trap happen\n");  
      clock_set_next_event();
ffffffe000201b24:	fb4fe0ef          	jal	ffffffe0002002d8 <clock_set_next_event>
      do_timer();
ffffffe000201b28:	875ff0ef          	jal	ffffffe00020139c <do_timer>
    syscall(regs);
  }
  else{
    printk("exception: %lld\n", scause);
  }
}
ffffffe000201b2c:	02c0006f          	j	ffffffe000201b58 <trap_handler+0x64>
  }else if(scause == 8){
ffffffe000201b30:	fe843703          	ld	a4,-24(s0)
ffffffe000201b34:	00800793          	li	a5,8
ffffffe000201b38:	00f71863          	bne	a4,a5,ffffffe000201b48 <trap_handler+0x54>
    syscall(regs);
ffffffe000201b3c:	fd843503          	ld	a0,-40(s0)
ffffffe000201b40:	ea5ff0ef          	jal	ffffffe0002019e4 <syscall>
}
ffffffe000201b44:	0140006f          	j	ffffffe000201b58 <trap_handler+0x64>
    printk("exception: %lld\n", scause);
ffffffe000201b48:	fe843583          	ld	a1,-24(s0)
ffffffe000201b4c:	00003517          	auipc	a0,0x3
ffffffe000201b50:	60c50513          	addi	a0,a0,1548 # ffffffe000205158 <_PA2VA_OFFSET+0x158>
ffffffe000201b54:	418010ef          	jal	ffffffe000202f6c <printk>
}
ffffffe000201b58:	00000013          	nop
ffffffe000201b5c:	02813083          	ld	ra,40(sp)
ffffffe000201b60:	02013403          	ld	s0,32(sp)
ffffffe000201b64:	03010113          	addi	sp,sp,48
ffffffe000201b68:	00008067          	ret

ffffffe000201b6c <setup_vm>:
#include "printk.h"
#include "stdlib.h"
const uint64_t _PA2VA_OFFSET = (VM_START - PHY_START);
uint64_t early_pgtbl[512] __attribute__((__aligned__(0x1000)));

void setup_vm() {
ffffffe000201b6c:	fd010113          	addi	sp,sp,-48
ffffffe000201b70:	02113423          	sd	ra,40(sp)
ffffffe000201b74:	02813023          	sd	s0,32(sp)
ffffffe000201b78:	03010413          	addi	s0,sp,48
    printk("setup_vm begin!!!\n");
ffffffe000201b7c:	00003517          	auipc	a0,0x3
ffffffe000201b80:	5f450513          	addi	a0,a0,1524 # ffffffe000205170 <_PA2VA_OFFSET+0x170>
ffffffe000201b84:	3e8010ef          	jal	ffffffe000202f6c <printk>

    uint64_t pa = PHY_START;
ffffffe000201b88:	00100793          	li	a5,1
ffffffe000201b8c:	01f79793          	slli	a5,a5,0x1f
ffffffe000201b90:	fef43423          	sd	a5,-24(s0)
    uint64_t va1 = PHY_START;       
ffffffe000201b94:	00100793          	li	a5,1
ffffffe000201b98:	01f79793          	slli	a5,a5,0x1f
ffffffe000201b9c:	fef43023          	sd	a5,-32(s0)
    uint64_t va2 = VM_START; 
ffffffe000201ba0:	fff00793          	li	a5,-1
ffffffe000201ba4:	02579793          	slli	a5,a5,0x25
ffffffe000201ba8:	fcf43c23          	sd	a5,-40(s0)
    uint64_t pte_flags = 0xF; 
ffffffe000201bac:	00f00793          	li	a5,15
ffffffe000201bb0:	fcf43823          	sd	a5,-48(s0)
    
    //early_pgtbl[(va1 >> 30LL) & 0x1FF] = ((pa >> 30LL) << 28LL) | pte_flags;
    early_pgtbl[(va2 >> 30LL) & 0x1FF] = ((pa >> 30LL) << 28LL) | pte_flags;
ffffffe000201bb4:	fe843783          	ld	a5,-24(s0)
ffffffe000201bb8:	01e7d793          	srli	a5,a5,0x1e
ffffffe000201bbc:	01c79693          	slli	a3,a5,0x1c
ffffffe000201bc0:	fd843783          	ld	a5,-40(s0)
ffffffe000201bc4:	01e7d793          	srli	a5,a5,0x1e
ffffffe000201bc8:	1ff7f793          	andi	a5,a5,511
ffffffe000201bcc:	fd043703          	ld	a4,-48(s0)
ffffffe000201bd0:	00e6e733          	or	a4,a3,a4
ffffffe000201bd4:	0000b697          	auipc	a3,0xb
ffffffe000201bd8:	42c68693          	addi	a3,a3,1068 # ffffffe00020d000 <early_pgtbl>
ffffffe000201bdc:	00379793          	slli	a5,a5,0x3
ffffffe000201be0:	00f687b3          	add	a5,a3,a5
ffffffe000201be4:	00e7b023          	sd	a4,0(a5)
    
    printk("setup_vm done!!!\n");
ffffffe000201be8:	00003517          	auipc	a0,0x3
ffffffe000201bec:	5a050513          	addi	a0,a0,1440 # ffffffe000205188 <_PA2VA_OFFSET+0x188>
ffffffe000201bf0:	37c010ef          	jal	ffffffe000202f6c <printk>
}
ffffffe000201bf4:	00000013          	nop
ffffffe000201bf8:	02813083          	ld	ra,40(sp)
ffffffe000201bfc:	02013403          	ld	s0,32(sp)
ffffffe000201c00:	03010113          	addi	sp,sp,48
ffffffe000201c04:	00008067          	ret

ffffffe000201c08 <setup_vm_final>:

uint64_t  swapper_pg_dir[512] __attribute__((__aligned__(0x1000)));
extern char _stext[];
extern char _srodata[];
extern char _sdata[];
void setup_vm_final(void) {  
ffffffe000201c08:	f9010113          	addi	sp,sp,-112
ffffffe000201c0c:	06113423          	sd	ra,104(sp)
ffffffe000201c10:	06813023          	sd	s0,96(sp)
ffffffe000201c14:	07010413          	addi	s0,sp,112
    printk("setup_vm_final begin!!!\n");  
ffffffe000201c18:	00003517          	auipc	a0,0x3
ffffffe000201c1c:	58850513          	addi	a0,a0,1416 # ffffffe0002051a0 <_PA2VA_OFFSET+0x1a0>
ffffffe000201c20:	34c010ef          	jal	ffffffe000202f6c <printk>
    uint64_t kernel_va = VM_START + OPENSBI_SIZE;  
ffffffe000201c24:	f00017b7          	lui	a5,0xf0001
ffffffe000201c28:	00979793          	slli	a5,a5,0x9
ffffffe000201c2c:	fef43423          	sd	a5,-24(s0)
    uint64_t kernel_pa = PHY_START + OPENSBI_SIZE;  
ffffffe000201c30:	40100793          	li	a5,1025
ffffffe000201c34:	01579793          	slli	a5,a5,0x15
ffffffe000201c38:	fef43023          	sd	a5,-32(s0)
    uint64_t kernel_len = (uint64_t)_srodata - (uint64_t)_stext;  
ffffffe000201c3c:	00003717          	auipc	a4,0x3
ffffffe000201c40:	3c470713          	addi	a4,a4,964 # ffffffe000205000 <_PA2VA_OFFSET>
ffffffe000201c44:	ffffe797          	auipc	a5,0xffffe
ffffffe000201c48:	3bc78793          	addi	a5,a5,956 # ffffffe000200000 <_skernel>
ffffffe000201c4c:	40f707b3          	sub	a5,a4,a5
ffffffe000201c50:	fcf43c23          	sd	a5,-40(s0)

    uint64_t rodata_va = kernel_va + kernel_len;  
ffffffe000201c54:	fe843703          	ld	a4,-24(s0)
ffffffe000201c58:	fd843783          	ld	a5,-40(s0)
ffffffe000201c5c:	00f707b3          	add	a5,a4,a5
ffffffe000201c60:	fcf43823          	sd	a5,-48(s0)
    uint64_t rodata_pa = kernel_pa + kernel_len;  
ffffffe000201c64:	fe043703          	ld	a4,-32(s0)
ffffffe000201c68:	fd843783          	ld	a5,-40(s0)
ffffffe000201c6c:	00f707b3          	add	a5,a4,a5
ffffffe000201c70:	fcf43423          	sd	a5,-56(s0)
    uint64_t rodata_len = (uint64_t)_sdata - (uint64_t)_srodata;  
ffffffe000201c74:	00005717          	auipc	a4,0x5
ffffffe000201c78:	38c70713          	addi	a4,a4,908 # ffffffe000207000 <TIMECLOCK>
ffffffe000201c7c:	00003797          	auipc	a5,0x3
ffffffe000201c80:	38478793          	addi	a5,a5,900 # ffffffe000205000 <_PA2VA_OFFSET>
ffffffe000201c84:	40f707b3          	sub	a5,a4,a5
ffffffe000201c88:	fcf43023          	sd	a5,-64(s0)

    uint64_t mem_va = (uint64_t)_sdata;  
ffffffe000201c8c:	00005797          	auipc	a5,0x5
ffffffe000201c90:	37478793          	addi	a5,a5,884 # ffffffe000207000 <TIMECLOCK>
ffffffe000201c94:	faf43c23          	sd	a5,-72(s0)
    uint64_t mem_pa = (uint64_t)_sdata - PA2VA_OFFSET;  
ffffffe000201c98:	00005717          	auipc	a4,0x5
ffffffe000201c9c:	36870713          	addi	a4,a4,872 # ffffffe000207000 <TIMECLOCK>
ffffffe000201ca0:	04100793          	li	a5,65
ffffffe000201ca4:	01f79793          	slli	a5,a5,0x1f
ffffffe000201ca8:	00f707b3          	add	a5,a4,a5
ffffffe000201cac:	faf43823          	sd	a5,-80(s0)
    uint64_t mem_len = PHY_SIZE - kernel_len - rodata_len - OPENSBI_SIZE;  
ffffffe000201cb0:	fd843703          	ld	a4,-40(s0)
ffffffe000201cb4:	fc043783          	ld	a5,-64(s0)
ffffffe000201cb8:	00f707b3          	add	a5,a4,a5
ffffffe000201cbc:	07e00737          	lui	a4,0x7e00
ffffffe000201cc0:	40f707b3          	sub	a5,a4,a5
ffffffe000201cc4:	faf43423          	sd	a5,-88(s0)

    printk("text: %lx--%lx X|-|R|V\n", kernel_va, kernel_va+ kernel_len);  
ffffffe000201cc8:	fe843703          	ld	a4,-24(s0)
ffffffe000201ccc:	fd843783          	ld	a5,-40(s0)
ffffffe000201cd0:	00f707b3          	add	a5,a4,a5
ffffffe000201cd4:	00078613          	mv	a2,a5
ffffffe000201cd8:	fe843583          	ld	a1,-24(s0)
ffffffe000201cdc:	00003517          	auipc	a0,0x3
ffffffe000201ce0:	4e450513          	addi	a0,a0,1252 # ffffffe0002051c0 <_PA2VA_OFFSET+0x1c0>
ffffffe000201ce4:	288010ef          	jal	ffffffe000202f6c <printk>
    create_mapping(swapper_pg_dir, kernel_va, kernel_pa, kernel_len, 0xB);  
ffffffe000201ce8:	00b00713          	li	a4,11
ffffffe000201cec:	fd843683          	ld	a3,-40(s0)
ffffffe000201cf0:	fe043603          	ld	a2,-32(s0)
ffffffe000201cf4:	fe843583          	ld	a1,-24(s0)
ffffffe000201cf8:	0000c517          	auipc	a0,0xc
ffffffe000201cfc:	30850513          	addi	a0,a0,776 # ffffffe00020e000 <swapper_pg_dir>
ffffffe000201d00:	0e4000ef          	jal	ffffffe000201de4 <create_mapping>
    printk("rodata: %lx--%lx -|-|R|V\n", rodata_va, rodata_va+rodata_len);  
ffffffe000201d04:	fd043703          	ld	a4,-48(s0)
ffffffe000201d08:	fc043783          	ld	a5,-64(s0)
ffffffe000201d0c:	00f707b3          	add	a5,a4,a5
ffffffe000201d10:	00078613          	mv	a2,a5
ffffffe000201d14:	fd043583          	ld	a1,-48(s0)
ffffffe000201d18:	00003517          	auipc	a0,0x3
ffffffe000201d1c:	4c050513          	addi	a0,a0,1216 # ffffffe0002051d8 <_PA2VA_OFFSET+0x1d8>
ffffffe000201d20:	24c010ef          	jal	ffffffe000202f6c <printk>
    create_mapping(swapper_pg_dir, rodata_va, rodata_pa, rodata_len, 0x3);  
ffffffe000201d24:	00300713          	li	a4,3
ffffffe000201d28:	fc043683          	ld	a3,-64(s0)
ffffffe000201d2c:	fc843603          	ld	a2,-56(s0)
ffffffe000201d30:	fd043583          	ld	a1,-48(s0)
ffffffe000201d34:	0000c517          	auipc	a0,0xc
ffffffe000201d38:	2cc50513          	addi	a0,a0,716 # ffffffe00020e000 <swapper_pg_dir>
ffffffe000201d3c:	0a8000ef          	jal	ffffffe000201de4 <create_mapping>
    printk("mem: %lx--%lx -|W|R|V\n", mem_va, mem_va+mem_len);  
ffffffe000201d40:	fb843703          	ld	a4,-72(s0)
ffffffe000201d44:	fa843783          	ld	a5,-88(s0)
ffffffe000201d48:	00f707b3          	add	a5,a4,a5
ffffffe000201d4c:	00078613          	mv	a2,a5
ffffffe000201d50:	fb843583          	ld	a1,-72(s0)
ffffffe000201d54:	00003517          	auipc	a0,0x3
ffffffe000201d58:	4a450513          	addi	a0,a0,1188 # ffffffe0002051f8 <_PA2VA_OFFSET+0x1f8>
ffffffe000201d5c:	210010ef          	jal	ffffffe000202f6c <printk>
    create_mapping(swapper_pg_dir, mem_va, mem_pa, mem_len, 0x7);  
ffffffe000201d60:	00700713          	li	a4,7
ffffffe000201d64:	fa843683          	ld	a3,-88(s0)
ffffffe000201d68:	fb043603          	ld	a2,-80(s0)
ffffffe000201d6c:	fb843583          	ld	a1,-72(s0)
ffffffe000201d70:	0000c517          	auipc	a0,0xc
ffffffe000201d74:	29050513          	addi	a0,a0,656 # ffffffe00020e000 <swapper_pg_dir>
ffffffe000201d78:	06c000ef          	jal	ffffffe000201de4 <create_mapping>
 
    uint64_t pg_dir_pa = (uint64_t)swapper_pg_dir - PA2VA_OFFSET;  
ffffffe000201d7c:	0000c717          	auipc	a4,0xc
ffffffe000201d80:	28470713          	addi	a4,a4,644 # ffffffe00020e000 <swapper_pg_dir>
ffffffe000201d84:	04100793          	li	a5,65
ffffffe000201d88:	01f79793          	slli	a5,a5,0x1f
ffffffe000201d8c:	00f707b3          	add	a5,a4,a5
ffffffe000201d90:	faf43023          	sd	a5,-96(s0)
    uint64_t satp_val = ((pg_dir_pa >> 12) & 0xfffffffffff) | 0x8000000000000000;  
ffffffe000201d94:	fa043783          	ld	a5,-96(s0)
ffffffe000201d98:	00c7d713          	srli	a4,a5,0xc
ffffffe000201d9c:	fff00793          	li	a5,-1
ffffffe000201da0:	0147d793          	srli	a5,a5,0x14
ffffffe000201da4:	00f77733          	and	a4,a4,a5
ffffffe000201da8:	fff00793          	li	a5,-1
ffffffe000201dac:	03f79793          	slli	a5,a5,0x3f
ffffffe000201db0:	00f767b3          	or	a5,a4,a5
ffffffe000201db4:	f8f43c23          	sd	a5,-104(s0)
    asm volatile("csrw satp, %0"::"r"(satp_val));  
ffffffe000201db8:	f9843783          	ld	a5,-104(s0)
ffffffe000201dbc:	18079073          	csrw	satp,a5
    asm volatile("sfence.vma zero, zero");  
ffffffe000201dc0:	12000073          	sfence.vma

    printk("setup_vm_final done!!!\n");  
ffffffe000201dc4:	00003517          	auipc	a0,0x3
ffffffe000201dc8:	44c50513          	addi	a0,a0,1100 # ffffffe000205210 <_PA2VA_OFFSET+0x210>
ffffffe000201dcc:	1a0010ef          	jal	ffffffe000202f6c <printk>
    return;  
ffffffe000201dd0:	00000013          	nop
}  
ffffffe000201dd4:	06813083          	ld	ra,104(sp)
ffffffe000201dd8:	06013403          	ld	s0,96(sp)
ffffffe000201ddc:	07010113          	addi	sp,sp,112
ffffffe000201de0:	00008067          	ret

ffffffe000201de4 <create_mapping>:

void create_mapping(uint64_t *pgtbl, uint64_t va, uint64_t pa, uint64_t sz, uint64_t perm) {
ffffffe000201de4:	f5010113          	addi	sp,sp,-176
ffffffe000201de8:	0a113423          	sd	ra,168(sp)
ffffffe000201dec:	0a813023          	sd	s0,160(sp)
ffffffe000201df0:	0b010413          	addi	s0,sp,176
ffffffe000201df4:	f6a43c23          	sd	a0,-136(s0)
ffffffe000201df8:	f6b43823          	sd	a1,-144(s0)
ffffffe000201dfc:	f6c43423          	sd	a2,-152(s0)
ffffffe000201e00:	f6d43023          	sd	a3,-160(s0)
ffffffe000201e04:	f4e43c23          	sd	a4,-168(s0)
    printk("create_mapping begin!!!\n");
ffffffe000201e08:	00003517          	auipc	a0,0x3
ffffffe000201e0c:	42050513          	addi	a0,a0,1056 # ffffffe000205228 <_PA2VA_OFFSET+0x228>
ffffffe000201e10:	15c010ef          	jal	ffffffe000202f6c <printk>
    uint64_t _va = va;
ffffffe000201e14:	f7043783          	ld	a5,-144(s0)
ffffffe000201e18:	fef43423          	sd	a5,-24(s0)
    uint64_t _pa = pa;
ffffffe000201e1c:	f6843783          	ld	a5,-152(s0)
ffffffe000201e20:	fef43023          	sd	a5,-32(s0)
    const uint64_t offset = 0xffffffdf80000000;
ffffffe000201e24:	fbf00793          	li	a5,-65
ffffffe000201e28:	01f79793          	slli	a5,a5,0x1f
ffffffe000201e2c:	fcf43c23          	sd	a5,-40(s0)
    while (_va < va+sz) {
ffffffe000201e30:	1dc0006f          	j	ffffffe00020200c <create_mapping+0x228>
        uint64_t vpn[3];
        vpn[2] = (_va >> 30) & 0x1FF;
ffffffe000201e34:	fe843783          	ld	a5,-24(s0)
ffffffe000201e38:	01e7d793          	srli	a5,a5,0x1e
ffffffe000201e3c:	1ff7f793          	andi	a5,a5,511
ffffffe000201e40:	f8f43c23          	sd	a5,-104(s0)
        vpn[1] = (_va >> 21) & 0x1FF;
ffffffe000201e44:	fe843783          	ld	a5,-24(s0)
ffffffe000201e48:	0157d793          	srli	a5,a5,0x15
ffffffe000201e4c:	1ff7f793          	andi	a5,a5,511
ffffffe000201e50:	f8f43823          	sd	a5,-112(s0)
        vpn[0] = (_va >> 12) & 0x1FF;
ffffffe000201e54:	fe843783          	ld	a5,-24(s0)
ffffffe000201e58:	00c7d793          	srli	a5,a5,0xc
ffffffe000201e5c:	1ff7f793          	andi	a5,a5,511
ffffffe000201e60:	f8f43423          	sd	a5,-120(s0)
        uint64_t* _pgtbl = pgtbl+offset;
ffffffe000201e64:	fd843783          	ld	a5,-40(s0)
ffffffe000201e68:	00379793          	slli	a5,a5,0x3
ffffffe000201e6c:	f7843703          	ld	a4,-136(s0)
ffffffe000201e70:	00f707b3          	add	a5,a4,a5
ffffffe000201e74:	fcf43823          	sd	a5,-48(s0)
        if ((pgtbl[vpn[2]] & 1) == 0) {
ffffffe000201e78:	f9843783          	ld	a5,-104(s0)
ffffffe000201e7c:	00379793          	slli	a5,a5,0x3
ffffffe000201e80:	f7843703          	ld	a4,-136(s0)
ffffffe000201e84:	00f707b3          	add	a5,a4,a5
ffffffe000201e88:	0007b783          	ld	a5,0(a5)
ffffffe000201e8c:	0017f793          	andi	a5,a5,1
ffffffe000201e90:	04079463          	bnez	a5,ffffffe000201ed8 <create_mapping+0xf4>
            uint64_t* new_page = (uint64_t*)kalloc();
ffffffe000201e94:	b1dfe0ef          	jal	ffffffe0002009b0 <kalloc>
ffffffe000201e98:	00050793          	mv	a5,a0
ffffffe000201e9c:	fcf43423          	sd	a5,-56(s0)
            uint64_t entry_value = (((uint64_t)new_page - PA2VA_OFFSET) >> 12) << 10;
ffffffe000201ea0:	fc843703          	ld	a4,-56(s0)
ffffffe000201ea4:	04100793          	li	a5,65
ffffffe000201ea8:	01f79793          	slli	a5,a5,0x1f
ffffffe000201eac:	00f707b3          	add	a5,a4,a5
ffffffe000201eb0:	00c7d793          	srli	a5,a5,0xc
ffffffe000201eb4:	00a79793          	slli	a5,a5,0xa
ffffffe000201eb8:	fcf43023          	sd	a5,-64(s0)
            pgtbl[vpn[2]] = entry_value | 1;
ffffffe000201ebc:	f9843783          	ld	a5,-104(s0)
ffffffe000201ec0:	00379793          	slli	a5,a5,0x3
ffffffe000201ec4:	f7843703          	ld	a4,-136(s0)
ffffffe000201ec8:	00f707b3          	add	a5,a4,a5
ffffffe000201ecc:	fc043703          	ld	a4,-64(s0)
ffffffe000201ed0:	00176713          	ori	a4,a4,1
ffffffe000201ed4:	00e7b023          	sd	a4,0(a5)
        }
        uint64_t* pgtbl1 = ((pgtbl[vpn[2]] >> 10) << 12)+offset;
ffffffe000201ed8:	f9843783          	ld	a5,-104(s0)
ffffffe000201edc:	00379793          	slli	a5,a5,0x3
ffffffe000201ee0:	f7843703          	ld	a4,-136(s0)
ffffffe000201ee4:	00f707b3          	add	a5,a4,a5
ffffffe000201ee8:	0007b783          	ld	a5,0(a5)
ffffffe000201eec:	00a7d793          	srli	a5,a5,0xa
ffffffe000201ef0:	00c79713          	slli	a4,a5,0xc
ffffffe000201ef4:	fd843783          	ld	a5,-40(s0)
ffffffe000201ef8:	00f707b3          	add	a5,a4,a5
ffffffe000201efc:	faf43c23          	sd	a5,-72(s0)
        if ((pgtbl1[vpn[1]] & 1) == 0) {
ffffffe000201f00:	f9043783          	ld	a5,-112(s0)
ffffffe000201f04:	00379793          	slli	a5,a5,0x3
ffffffe000201f08:	fb843703          	ld	a4,-72(s0)
ffffffe000201f0c:	00f707b3          	add	a5,a4,a5
ffffffe000201f10:	0007b783          	ld	a5,0(a5)
ffffffe000201f14:	0017f793          	andi	a5,a5,1
ffffffe000201f18:	04079463          	bnez	a5,ffffffe000201f60 <create_mapping+0x17c>
            uint64_t* new_page = (uint64_t*)kalloc();
ffffffe000201f1c:	a95fe0ef          	jal	ffffffe0002009b0 <kalloc>
ffffffe000201f20:	00050793          	mv	a5,a0
ffffffe000201f24:	faf43823          	sd	a5,-80(s0)
            uint64_t entry_value = (((uint64_t)new_page - PA2VA_OFFSET) >> 12) << 10;
ffffffe000201f28:	fb043703          	ld	a4,-80(s0)
ffffffe000201f2c:	04100793          	li	a5,65
ffffffe000201f30:	01f79793          	slli	a5,a5,0x1f
ffffffe000201f34:	00f707b3          	add	a5,a4,a5
ffffffe000201f38:	00c7d793          	srli	a5,a5,0xc
ffffffe000201f3c:	00a79793          	slli	a5,a5,0xa
ffffffe000201f40:	faf43423          	sd	a5,-88(s0)
            pgtbl1[vpn[1]] = entry_value | 1;
ffffffe000201f44:	f9043783          	ld	a5,-112(s0)
ffffffe000201f48:	00379793          	slli	a5,a5,0x3
ffffffe000201f4c:	fb843703          	ld	a4,-72(s0)
ffffffe000201f50:	00f707b3          	add	a5,a4,a5
ffffffe000201f54:	fa843703          	ld	a4,-88(s0)
ffffffe000201f58:	00176713          	ori	a4,a4,1
ffffffe000201f5c:	00e7b023          	sd	a4,0(a5)
        }
        uint64_t* pgtbl2 = ((pgtbl1[vpn[1]] >> 10) << 12)+offset;
ffffffe000201f60:	f9043783          	ld	a5,-112(s0)
ffffffe000201f64:	00379793          	slli	a5,a5,0x3
ffffffe000201f68:	fb843703          	ld	a4,-72(s0)
ffffffe000201f6c:	00f707b3          	add	a5,a4,a5
ffffffe000201f70:	0007b783          	ld	a5,0(a5)
ffffffe000201f74:	00a7d793          	srli	a5,a5,0xa
ffffffe000201f78:	00c79713          	slli	a4,a5,0xc
ffffffe000201f7c:	fd843783          	ld	a5,-40(s0)
ffffffe000201f80:	00f707b3          	add	a5,a4,a5
ffffffe000201f84:	faf43023          	sd	a5,-96(s0)
        pgtbl2[vpn[0]] = ((_pa >> 12) << 10) | perm;
ffffffe000201f88:	fe043783          	ld	a5,-32(s0)
ffffffe000201f8c:	00c7d793          	srli	a5,a5,0xc
ffffffe000201f90:	00a79693          	slli	a3,a5,0xa
ffffffe000201f94:	f8843783          	ld	a5,-120(s0)
ffffffe000201f98:	00379793          	slli	a5,a5,0x3
ffffffe000201f9c:	fa043703          	ld	a4,-96(s0)
ffffffe000201fa0:	00f707b3          	add	a5,a4,a5
ffffffe000201fa4:	f5843703          	ld	a4,-168(s0)
ffffffe000201fa8:	00e6e733          	or	a4,a3,a4
ffffffe000201fac:	00e7b023          	sd	a4,0(a5)
        if (_va-va <= 20*PGSIZE) {
ffffffe000201fb0:	fe843703          	ld	a4,-24(s0)
ffffffe000201fb4:	f7043783          	ld	a5,-144(s0)
ffffffe000201fb8:	40f70733          	sub	a4,a4,a5
ffffffe000201fbc:	000147b7          	lui	a5,0x14
ffffffe000201fc0:	02e7e663          	bltu	a5,a4,ffffffe000201fec <create_mapping+0x208>
            printk("Mapping: VA %lx -> PTE %lx\n", _va, pgtbl2[vpn[0]]);
ffffffe000201fc4:	f8843783          	ld	a5,-120(s0)
ffffffe000201fc8:	00379793          	slli	a5,a5,0x3
ffffffe000201fcc:	fa043703          	ld	a4,-96(s0)
ffffffe000201fd0:	00f707b3          	add	a5,a4,a5
ffffffe000201fd4:	0007b783          	ld	a5,0(a5) # 14000 <PGSIZE+0x13000>
ffffffe000201fd8:	00078613          	mv	a2,a5
ffffffe000201fdc:	fe843583          	ld	a1,-24(s0)
ffffffe000201fe0:	00003517          	auipc	a0,0x3
ffffffe000201fe4:	26850513          	addi	a0,a0,616 # ffffffe000205248 <_PA2VA_OFFSET+0x248>
ffffffe000201fe8:	785000ef          	jal	ffffffe000202f6c <printk>
        }
        _va += PGSIZE;
ffffffe000201fec:	fe843703          	ld	a4,-24(s0)
ffffffe000201ff0:	000017b7          	lui	a5,0x1
ffffffe000201ff4:	00f707b3          	add	a5,a4,a5
ffffffe000201ff8:	fef43423          	sd	a5,-24(s0)
        _pa += PGSIZE;
ffffffe000201ffc:	fe043703          	ld	a4,-32(s0)
ffffffe000202000:	000017b7          	lui	a5,0x1
ffffffe000202004:	00f707b3          	add	a5,a4,a5
ffffffe000202008:	fef43023          	sd	a5,-32(s0)
    while (_va < va+sz) {
ffffffe00020200c:	f7043703          	ld	a4,-144(s0)
ffffffe000202010:	f6043783          	ld	a5,-160(s0)
ffffffe000202014:	00f707b3          	add	a5,a4,a5
ffffffe000202018:	fe843703          	ld	a4,-24(s0)
ffffffe00020201c:	e0f76ce3          	bltu	a4,a5,ffffffe000201e34 <create_mapping+0x50>
    }
    printk("create_mapping done!!!\n");
ffffffe000202020:	00003517          	auipc	a0,0x3
ffffffe000202024:	24850513          	addi	a0,a0,584 # ffffffe000205268 <_PA2VA_OFFSET+0x268>
ffffffe000202028:	745000ef          	jal	ffffffe000202f6c <printk>
    return;
ffffffe00020202c:	00000013          	nop
}
ffffffe000202030:	0a813083          	ld	ra,168(sp)
ffffffe000202034:	0a013403          	ld	s0,160(sp)
ffffffe000202038:	0b010113          	addi	sp,sp,176
ffffffe00020203c:	00008067          	ret

ffffffe000202040 <start_kernel>:
#include "printk.h"

extern void test();
extern void schedule();

int start_kernel() {
ffffffe000202040:	ff010113          	addi	sp,sp,-16
ffffffe000202044:	00113423          	sd	ra,8(sp)
ffffffe000202048:	00813023          	sd	s0,0(sp)
ffffffe00020204c:	01010413          	addi	s0,sp,16
    printk("2024");
ffffffe000202050:	00003517          	auipc	a0,0x3
ffffffe000202054:	23050513          	addi	a0,a0,560 # ffffffe000205280 <_PA2VA_OFFSET+0x280>
ffffffe000202058:	715000ef          	jal	ffffffe000202f6c <printk>
    printk(" ZJU Operating System\n");
ffffffe00020205c:	00003517          	auipc	a0,0x3
ffffffe000202060:	22c50513          	addi	a0,a0,556 # ffffffe000205288 <_PA2VA_OFFSET+0x288>
ffffffe000202064:	709000ef          	jal	ffffffe000202f6c <printk>
    schedule();
ffffffe000202068:	978ff0ef          	jal	ffffffe0002011e0 <schedule>
    test();
ffffffe00020206c:	01c000ef          	jal	ffffffe000202088 <test>
    return 0;
ffffffe000202070:	00000793          	li	a5,0
}
ffffffe000202074:	00078513          	mv	a0,a5
ffffffe000202078:	00813083          	ld	ra,8(sp)
ffffffe00020207c:	00013403          	ld	s0,0(sp)
ffffffe000202080:	01010113          	addi	sp,sp,16
ffffffe000202084:	00008067          	ret

ffffffe000202088 <test>:
#include "sbi.h"
#include"printk.h"
void test() {
ffffffe000202088:	fe010113          	addi	sp,sp,-32
ffffffe00020208c:	00113c23          	sd	ra,24(sp)
ffffffe000202090:	00813823          	sd	s0,16(sp)
ffffffe000202094:	02010413          	addi	s0,sp,32
    int i = 0;
ffffffe000202098:	fe042623          	sw	zero,-20(s0)
    while (1) {
        if ((++i) % 100000000 == 0) {
ffffffe00020209c:	fec42783          	lw	a5,-20(s0)
ffffffe0002020a0:	0017879b          	addiw	a5,a5,1 # 1001 <PGSIZE+0x1>
ffffffe0002020a4:	fef42623          	sw	a5,-20(s0)
ffffffe0002020a8:	fec42783          	lw	a5,-20(s0)
ffffffe0002020ac:	00078713          	mv	a4,a5
ffffffe0002020b0:	05f5e7b7          	lui	a5,0x5f5e
ffffffe0002020b4:	1007879b          	addiw	a5,a5,256 # 5f5e100 <OPENSBI_SIZE+0x5d5e100>
ffffffe0002020b8:	02f767bb          	remw	a5,a4,a5
ffffffe0002020bc:	0007879b          	sext.w	a5,a5
ffffffe0002020c0:	fc079ee3          	bnez	a5,ffffffe00020209c <test+0x14>
            printk("kernel is running!\n");
ffffffe0002020c4:	00003517          	auipc	a0,0x3
ffffffe0002020c8:	1dc50513          	addi	a0,a0,476 # ffffffe0002052a0 <_PA2VA_OFFSET+0x2a0>
ffffffe0002020cc:	6a1000ef          	jal	ffffffe000202f6c <printk>
            i = 0;
ffffffe0002020d0:	fe042623          	sw	zero,-20(s0)
        if ((++i) % 100000000 == 0) {
ffffffe0002020d4:	fc9ff06f          	j	ffffffe00020209c <test+0x14>

ffffffe0002020d8 <putc>:
// credit: 45gfg9 <45gfg9@45gfg9.net>

#include "printk.h"
#include "sbi.h"

int putc(int c) {
ffffffe0002020d8:	fe010113          	addi	sp,sp,-32
ffffffe0002020dc:	00113c23          	sd	ra,24(sp)
ffffffe0002020e0:	00813823          	sd	s0,16(sp)
ffffffe0002020e4:	02010413          	addi	s0,sp,32
ffffffe0002020e8:	00050793          	mv	a5,a0
ffffffe0002020ec:	fef42623          	sw	a5,-20(s0)
    sbi_debug_console_write_byte(c);
ffffffe0002020f0:	fec42783          	lw	a5,-20(s0)
ffffffe0002020f4:	0ff7f793          	zext.b	a5,a5
ffffffe0002020f8:	00078513          	mv	a0,a5
ffffffe0002020fc:	c1cff0ef          	jal	ffffffe000201518 <sbi_debug_console_write_byte>
    return (char)c;
ffffffe000202100:	fec42783          	lw	a5,-20(s0)
ffffffe000202104:	0ff7f793          	zext.b	a5,a5
ffffffe000202108:	0007879b          	sext.w	a5,a5
}
ffffffe00020210c:	00078513          	mv	a0,a5
ffffffe000202110:	01813083          	ld	ra,24(sp)
ffffffe000202114:	01013403          	ld	s0,16(sp)
ffffffe000202118:	02010113          	addi	sp,sp,32
ffffffe00020211c:	00008067          	ret

ffffffe000202120 <isspace>:
    bool sign;
    int width;
    int prec;
};

int isspace(int c) {
ffffffe000202120:	fe010113          	addi	sp,sp,-32
ffffffe000202124:	00813c23          	sd	s0,24(sp)
ffffffe000202128:	02010413          	addi	s0,sp,32
ffffffe00020212c:	00050793          	mv	a5,a0
ffffffe000202130:	fef42623          	sw	a5,-20(s0)
    return c == ' ' || (c >= '\t' && c <= '\r');
ffffffe000202134:	fec42783          	lw	a5,-20(s0)
ffffffe000202138:	0007871b          	sext.w	a4,a5
ffffffe00020213c:	02000793          	li	a5,32
ffffffe000202140:	02f70263          	beq	a4,a5,ffffffe000202164 <isspace+0x44>
ffffffe000202144:	fec42783          	lw	a5,-20(s0)
ffffffe000202148:	0007871b          	sext.w	a4,a5
ffffffe00020214c:	00800793          	li	a5,8
ffffffe000202150:	00e7de63          	bge	a5,a4,ffffffe00020216c <isspace+0x4c>
ffffffe000202154:	fec42783          	lw	a5,-20(s0)
ffffffe000202158:	0007871b          	sext.w	a4,a5
ffffffe00020215c:	00d00793          	li	a5,13
ffffffe000202160:	00e7c663          	blt	a5,a4,ffffffe00020216c <isspace+0x4c>
ffffffe000202164:	00100793          	li	a5,1
ffffffe000202168:	0080006f          	j	ffffffe000202170 <isspace+0x50>
ffffffe00020216c:	00000793          	li	a5,0
}
ffffffe000202170:	00078513          	mv	a0,a5
ffffffe000202174:	01813403          	ld	s0,24(sp)
ffffffe000202178:	02010113          	addi	sp,sp,32
ffffffe00020217c:	00008067          	ret

ffffffe000202180 <strtol>:

long strtol(const char *restrict nptr, char **restrict endptr, int base) {
ffffffe000202180:	fb010113          	addi	sp,sp,-80
ffffffe000202184:	04113423          	sd	ra,72(sp)
ffffffe000202188:	04813023          	sd	s0,64(sp)
ffffffe00020218c:	05010413          	addi	s0,sp,80
ffffffe000202190:	fca43423          	sd	a0,-56(s0)
ffffffe000202194:	fcb43023          	sd	a1,-64(s0)
ffffffe000202198:	00060793          	mv	a5,a2
ffffffe00020219c:	faf42e23          	sw	a5,-68(s0)
    long ret = 0;
ffffffe0002021a0:	fe043423          	sd	zero,-24(s0)
    bool neg = false;
ffffffe0002021a4:	fe0403a3          	sb	zero,-25(s0)
    const char *p = nptr;
ffffffe0002021a8:	fc843783          	ld	a5,-56(s0)
ffffffe0002021ac:	fcf43c23          	sd	a5,-40(s0)

    while (isspace(*p)) {
ffffffe0002021b0:	0100006f          	j	ffffffe0002021c0 <strtol+0x40>
        p++;
ffffffe0002021b4:	fd843783          	ld	a5,-40(s0)
ffffffe0002021b8:	00178793          	addi	a5,a5,1
ffffffe0002021bc:	fcf43c23          	sd	a5,-40(s0)
    while (isspace(*p)) {
ffffffe0002021c0:	fd843783          	ld	a5,-40(s0)
ffffffe0002021c4:	0007c783          	lbu	a5,0(a5)
ffffffe0002021c8:	0007879b          	sext.w	a5,a5
ffffffe0002021cc:	00078513          	mv	a0,a5
ffffffe0002021d0:	f51ff0ef          	jal	ffffffe000202120 <isspace>
ffffffe0002021d4:	00050793          	mv	a5,a0
ffffffe0002021d8:	fc079ee3          	bnez	a5,ffffffe0002021b4 <strtol+0x34>
    }

    if (*p == '-') {
ffffffe0002021dc:	fd843783          	ld	a5,-40(s0)
ffffffe0002021e0:	0007c783          	lbu	a5,0(a5)
ffffffe0002021e4:	00078713          	mv	a4,a5
ffffffe0002021e8:	02d00793          	li	a5,45
ffffffe0002021ec:	00f71e63          	bne	a4,a5,ffffffe000202208 <strtol+0x88>
        neg = true;
ffffffe0002021f0:	00100793          	li	a5,1
ffffffe0002021f4:	fef403a3          	sb	a5,-25(s0)
        p++;
ffffffe0002021f8:	fd843783          	ld	a5,-40(s0)
ffffffe0002021fc:	00178793          	addi	a5,a5,1
ffffffe000202200:	fcf43c23          	sd	a5,-40(s0)
ffffffe000202204:	0240006f          	j	ffffffe000202228 <strtol+0xa8>
    } else if (*p == '+') {
ffffffe000202208:	fd843783          	ld	a5,-40(s0)
ffffffe00020220c:	0007c783          	lbu	a5,0(a5)
ffffffe000202210:	00078713          	mv	a4,a5
ffffffe000202214:	02b00793          	li	a5,43
ffffffe000202218:	00f71863          	bne	a4,a5,ffffffe000202228 <strtol+0xa8>
        p++;
ffffffe00020221c:	fd843783          	ld	a5,-40(s0)
ffffffe000202220:	00178793          	addi	a5,a5,1
ffffffe000202224:	fcf43c23          	sd	a5,-40(s0)
    }

    if (base == 0) {
ffffffe000202228:	fbc42783          	lw	a5,-68(s0)
ffffffe00020222c:	0007879b          	sext.w	a5,a5
ffffffe000202230:	06079c63          	bnez	a5,ffffffe0002022a8 <strtol+0x128>
        if (*p == '0') {
ffffffe000202234:	fd843783          	ld	a5,-40(s0)
ffffffe000202238:	0007c783          	lbu	a5,0(a5)
ffffffe00020223c:	00078713          	mv	a4,a5
ffffffe000202240:	03000793          	li	a5,48
ffffffe000202244:	04f71e63          	bne	a4,a5,ffffffe0002022a0 <strtol+0x120>
            p++;
ffffffe000202248:	fd843783          	ld	a5,-40(s0)
ffffffe00020224c:	00178793          	addi	a5,a5,1
ffffffe000202250:	fcf43c23          	sd	a5,-40(s0)
            if (*p == 'x' || *p == 'X') {
ffffffe000202254:	fd843783          	ld	a5,-40(s0)
ffffffe000202258:	0007c783          	lbu	a5,0(a5)
ffffffe00020225c:	00078713          	mv	a4,a5
ffffffe000202260:	07800793          	li	a5,120
ffffffe000202264:	00f70c63          	beq	a4,a5,ffffffe00020227c <strtol+0xfc>
ffffffe000202268:	fd843783          	ld	a5,-40(s0)
ffffffe00020226c:	0007c783          	lbu	a5,0(a5)
ffffffe000202270:	00078713          	mv	a4,a5
ffffffe000202274:	05800793          	li	a5,88
ffffffe000202278:	00f71e63          	bne	a4,a5,ffffffe000202294 <strtol+0x114>
                base = 16;
ffffffe00020227c:	01000793          	li	a5,16
ffffffe000202280:	faf42e23          	sw	a5,-68(s0)
                p++;
ffffffe000202284:	fd843783          	ld	a5,-40(s0)
ffffffe000202288:	00178793          	addi	a5,a5,1
ffffffe00020228c:	fcf43c23          	sd	a5,-40(s0)
ffffffe000202290:	0180006f          	j	ffffffe0002022a8 <strtol+0x128>
            } else {
                base = 8;
ffffffe000202294:	00800793          	li	a5,8
ffffffe000202298:	faf42e23          	sw	a5,-68(s0)
ffffffe00020229c:	00c0006f          	j	ffffffe0002022a8 <strtol+0x128>
            }
        } else {
            base = 10;
ffffffe0002022a0:	00a00793          	li	a5,10
ffffffe0002022a4:	faf42e23          	sw	a5,-68(s0)
        }
    }

    while (1) {
        int digit;
        if (*p >= '0' && *p <= '9') {
ffffffe0002022a8:	fd843783          	ld	a5,-40(s0)
ffffffe0002022ac:	0007c783          	lbu	a5,0(a5)
ffffffe0002022b0:	00078713          	mv	a4,a5
ffffffe0002022b4:	02f00793          	li	a5,47
ffffffe0002022b8:	02e7f863          	bgeu	a5,a4,ffffffe0002022e8 <strtol+0x168>
ffffffe0002022bc:	fd843783          	ld	a5,-40(s0)
ffffffe0002022c0:	0007c783          	lbu	a5,0(a5)
ffffffe0002022c4:	00078713          	mv	a4,a5
ffffffe0002022c8:	03900793          	li	a5,57
ffffffe0002022cc:	00e7ee63          	bltu	a5,a4,ffffffe0002022e8 <strtol+0x168>
            digit = *p - '0';
ffffffe0002022d0:	fd843783          	ld	a5,-40(s0)
ffffffe0002022d4:	0007c783          	lbu	a5,0(a5)
ffffffe0002022d8:	0007879b          	sext.w	a5,a5
ffffffe0002022dc:	fd07879b          	addiw	a5,a5,-48
ffffffe0002022e0:	fcf42a23          	sw	a5,-44(s0)
ffffffe0002022e4:	0800006f          	j	ffffffe000202364 <strtol+0x1e4>
        } else if (*p >= 'a' && *p <= 'z') {
ffffffe0002022e8:	fd843783          	ld	a5,-40(s0)
ffffffe0002022ec:	0007c783          	lbu	a5,0(a5)
ffffffe0002022f0:	00078713          	mv	a4,a5
ffffffe0002022f4:	06000793          	li	a5,96
ffffffe0002022f8:	02e7f863          	bgeu	a5,a4,ffffffe000202328 <strtol+0x1a8>
ffffffe0002022fc:	fd843783          	ld	a5,-40(s0)
ffffffe000202300:	0007c783          	lbu	a5,0(a5)
ffffffe000202304:	00078713          	mv	a4,a5
ffffffe000202308:	07a00793          	li	a5,122
ffffffe00020230c:	00e7ee63          	bltu	a5,a4,ffffffe000202328 <strtol+0x1a8>
            digit = *p - ('a' - 10);
ffffffe000202310:	fd843783          	ld	a5,-40(s0)
ffffffe000202314:	0007c783          	lbu	a5,0(a5)
ffffffe000202318:	0007879b          	sext.w	a5,a5
ffffffe00020231c:	fa97879b          	addiw	a5,a5,-87
ffffffe000202320:	fcf42a23          	sw	a5,-44(s0)
ffffffe000202324:	0400006f          	j	ffffffe000202364 <strtol+0x1e4>
        } else if (*p >= 'A' && *p <= 'Z') {
ffffffe000202328:	fd843783          	ld	a5,-40(s0)
ffffffe00020232c:	0007c783          	lbu	a5,0(a5)
ffffffe000202330:	00078713          	mv	a4,a5
ffffffe000202334:	04000793          	li	a5,64
ffffffe000202338:	06e7f863          	bgeu	a5,a4,ffffffe0002023a8 <strtol+0x228>
ffffffe00020233c:	fd843783          	ld	a5,-40(s0)
ffffffe000202340:	0007c783          	lbu	a5,0(a5)
ffffffe000202344:	00078713          	mv	a4,a5
ffffffe000202348:	05a00793          	li	a5,90
ffffffe00020234c:	04e7ee63          	bltu	a5,a4,ffffffe0002023a8 <strtol+0x228>
            digit = *p - ('A' - 10);
ffffffe000202350:	fd843783          	ld	a5,-40(s0)
ffffffe000202354:	0007c783          	lbu	a5,0(a5)
ffffffe000202358:	0007879b          	sext.w	a5,a5
ffffffe00020235c:	fc97879b          	addiw	a5,a5,-55
ffffffe000202360:	fcf42a23          	sw	a5,-44(s0)
        } else {
            break;
        }

        if (digit >= base) {
ffffffe000202364:	fd442783          	lw	a5,-44(s0)
ffffffe000202368:	00078713          	mv	a4,a5
ffffffe00020236c:	fbc42783          	lw	a5,-68(s0)
ffffffe000202370:	0007071b          	sext.w	a4,a4
ffffffe000202374:	0007879b          	sext.w	a5,a5
ffffffe000202378:	02f75663          	bge	a4,a5,ffffffe0002023a4 <strtol+0x224>
            break;
        }

        ret = ret * base + digit;
ffffffe00020237c:	fbc42703          	lw	a4,-68(s0)
ffffffe000202380:	fe843783          	ld	a5,-24(s0)
ffffffe000202384:	02f70733          	mul	a4,a4,a5
ffffffe000202388:	fd442783          	lw	a5,-44(s0)
ffffffe00020238c:	00f707b3          	add	a5,a4,a5
ffffffe000202390:	fef43423          	sd	a5,-24(s0)
        p++;
ffffffe000202394:	fd843783          	ld	a5,-40(s0)
ffffffe000202398:	00178793          	addi	a5,a5,1
ffffffe00020239c:	fcf43c23          	sd	a5,-40(s0)
    while (1) {
ffffffe0002023a0:	f09ff06f          	j	ffffffe0002022a8 <strtol+0x128>
            break;
ffffffe0002023a4:	00000013          	nop
    }

    if (endptr) {
ffffffe0002023a8:	fc043783          	ld	a5,-64(s0)
ffffffe0002023ac:	00078863          	beqz	a5,ffffffe0002023bc <strtol+0x23c>
        *endptr = (char *)p;
ffffffe0002023b0:	fc043783          	ld	a5,-64(s0)
ffffffe0002023b4:	fd843703          	ld	a4,-40(s0)
ffffffe0002023b8:	00e7b023          	sd	a4,0(a5)
    }

    return neg ? -ret : ret;
ffffffe0002023bc:	fe744783          	lbu	a5,-25(s0)
ffffffe0002023c0:	0ff7f793          	zext.b	a5,a5
ffffffe0002023c4:	00078863          	beqz	a5,ffffffe0002023d4 <strtol+0x254>
ffffffe0002023c8:	fe843783          	ld	a5,-24(s0)
ffffffe0002023cc:	40f007b3          	neg	a5,a5
ffffffe0002023d0:	0080006f          	j	ffffffe0002023d8 <strtol+0x258>
ffffffe0002023d4:	fe843783          	ld	a5,-24(s0)
}
ffffffe0002023d8:	00078513          	mv	a0,a5
ffffffe0002023dc:	04813083          	ld	ra,72(sp)
ffffffe0002023e0:	04013403          	ld	s0,64(sp)
ffffffe0002023e4:	05010113          	addi	sp,sp,80
ffffffe0002023e8:	00008067          	ret

ffffffe0002023ec <puts_wo_nl>:

// puts without newline
static int puts_wo_nl(int (*putch)(int), const char *s) {
ffffffe0002023ec:	fd010113          	addi	sp,sp,-48
ffffffe0002023f0:	02113423          	sd	ra,40(sp)
ffffffe0002023f4:	02813023          	sd	s0,32(sp)
ffffffe0002023f8:	03010413          	addi	s0,sp,48
ffffffe0002023fc:	fca43c23          	sd	a0,-40(s0)
ffffffe000202400:	fcb43823          	sd	a1,-48(s0)
    if (!s) {
ffffffe000202404:	fd043783          	ld	a5,-48(s0)
ffffffe000202408:	00079863          	bnez	a5,ffffffe000202418 <puts_wo_nl+0x2c>
        s = "(null)";
ffffffe00020240c:	00003797          	auipc	a5,0x3
ffffffe000202410:	eac78793          	addi	a5,a5,-340 # ffffffe0002052b8 <_PA2VA_OFFSET+0x2b8>
ffffffe000202414:	fcf43823          	sd	a5,-48(s0)
    }
    const char *p = s;
ffffffe000202418:	fd043783          	ld	a5,-48(s0)
ffffffe00020241c:	fef43423          	sd	a5,-24(s0)
    while (*p) {
ffffffe000202420:	0240006f          	j	ffffffe000202444 <puts_wo_nl+0x58>
        putch(*p++);
ffffffe000202424:	fe843783          	ld	a5,-24(s0)
ffffffe000202428:	00178713          	addi	a4,a5,1
ffffffe00020242c:	fee43423          	sd	a4,-24(s0)
ffffffe000202430:	0007c783          	lbu	a5,0(a5)
ffffffe000202434:	0007871b          	sext.w	a4,a5
ffffffe000202438:	fd843783          	ld	a5,-40(s0)
ffffffe00020243c:	00070513          	mv	a0,a4
ffffffe000202440:	000780e7          	jalr	a5
    while (*p) {
ffffffe000202444:	fe843783          	ld	a5,-24(s0)
ffffffe000202448:	0007c783          	lbu	a5,0(a5)
ffffffe00020244c:	fc079ce3          	bnez	a5,ffffffe000202424 <puts_wo_nl+0x38>
    }
    return p - s;
ffffffe000202450:	fe843703          	ld	a4,-24(s0)
ffffffe000202454:	fd043783          	ld	a5,-48(s0)
ffffffe000202458:	40f707b3          	sub	a5,a4,a5
ffffffe00020245c:	0007879b          	sext.w	a5,a5
}
ffffffe000202460:	00078513          	mv	a0,a5
ffffffe000202464:	02813083          	ld	ra,40(sp)
ffffffe000202468:	02013403          	ld	s0,32(sp)
ffffffe00020246c:	03010113          	addi	sp,sp,48
ffffffe000202470:	00008067          	ret

ffffffe000202474 <print_dec_int>:

static int print_dec_int(int (*putch)(int), unsigned long num, bool is_signed, struct fmt_flags *flags) {
ffffffe000202474:	f9010113          	addi	sp,sp,-112
ffffffe000202478:	06113423          	sd	ra,104(sp)
ffffffe00020247c:	06813023          	sd	s0,96(sp)
ffffffe000202480:	07010413          	addi	s0,sp,112
ffffffe000202484:	faa43423          	sd	a0,-88(s0)
ffffffe000202488:	fab43023          	sd	a1,-96(s0)
ffffffe00020248c:	00060793          	mv	a5,a2
ffffffe000202490:	f8d43823          	sd	a3,-112(s0)
ffffffe000202494:	f8f40fa3          	sb	a5,-97(s0)
    if (is_signed && num == 0x8000000000000000UL) {
ffffffe000202498:	f9f44783          	lbu	a5,-97(s0)
ffffffe00020249c:	0ff7f793          	zext.b	a5,a5
ffffffe0002024a0:	02078663          	beqz	a5,ffffffe0002024cc <print_dec_int+0x58>
ffffffe0002024a4:	fa043703          	ld	a4,-96(s0)
ffffffe0002024a8:	fff00793          	li	a5,-1
ffffffe0002024ac:	03f79793          	slli	a5,a5,0x3f
ffffffe0002024b0:	00f71e63          	bne	a4,a5,ffffffe0002024cc <print_dec_int+0x58>
        // special case for 0x8000000000000000
        return puts_wo_nl(putch, "-9223372036854775808");
ffffffe0002024b4:	00003597          	auipc	a1,0x3
ffffffe0002024b8:	e0c58593          	addi	a1,a1,-500 # ffffffe0002052c0 <_PA2VA_OFFSET+0x2c0>
ffffffe0002024bc:	fa843503          	ld	a0,-88(s0)
ffffffe0002024c0:	f2dff0ef          	jal	ffffffe0002023ec <puts_wo_nl>
ffffffe0002024c4:	00050793          	mv	a5,a0
ffffffe0002024c8:	2a00006f          	j	ffffffe000202768 <print_dec_int+0x2f4>
    }

    if (flags->prec == 0 && num == 0) {
ffffffe0002024cc:	f9043783          	ld	a5,-112(s0)
ffffffe0002024d0:	00c7a783          	lw	a5,12(a5)
ffffffe0002024d4:	00079a63          	bnez	a5,ffffffe0002024e8 <print_dec_int+0x74>
ffffffe0002024d8:	fa043783          	ld	a5,-96(s0)
ffffffe0002024dc:	00079663          	bnez	a5,ffffffe0002024e8 <print_dec_int+0x74>
        return 0;
ffffffe0002024e0:	00000793          	li	a5,0
ffffffe0002024e4:	2840006f          	j	ffffffe000202768 <print_dec_int+0x2f4>
    }

    bool neg = false;
ffffffe0002024e8:	fe0407a3          	sb	zero,-17(s0)

    if (is_signed && (long)num < 0) {
ffffffe0002024ec:	f9f44783          	lbu	a5,-97(s0)
ffffffe0002024f0:	0ff7f793          	zext.b	a5,a5
ffffffe0002024f4:	02078063          	beqz	a5,ffffffe000202514 <print_dec_int+0xa0>
ffffffe0002024f8:	fa043783          	ld	a5,-96(s0)
ffffffe0002024fc:	0007dc63          	bgez	a5,ffffffe000202514 <print_dec_int+0xa0>
        neg = true;
ffffffe000202500:	00100793          	li	a5,1
ffffffe000202504:	fef407a3          	sb	a5,-17(s0)
        num = -num;
ffffffe000202508:	fa043783          	ld	a5,-96(s0)
ffffffe00020250c:	40f007b3          	neg	a5,a5
ffffffe000202510:	faf43023          	sd	a5,-96(s0)
    }

    char buf[20];
    int decdigits = 0;
ffffffe000202514:	fe042423          	sw	zero,-24(s0)

    bool has_sign_char = is_signed && (neg || flags->sign || flags->spaceflag);
ffffffe000202518:	f9f44783          	lbu	a5,-97(s0)
ffffffe00020251c:	0ff7f793          	zext.b	a5,a5
ffffffe000202520:	02078863          	beqz	a5,ffffffe000202550 <print_dec_int+0xdc>
ffffffe000202524:	fef44783          	lbu	a5,-17(s0)
ffffffe000202528:	0ff7f793          	zext.b	a5,a5
ffffffe00020252c:	00079e63          	bnez	a5,ffffffe000202548 <print_dec_int+0xd4>
ffffffe000202530:	f9043783          	ld	a5,-112(s0)
ffffffe000202534:	0057c783          	lbu	a5,5(a5)
ffffffe000202538:	00079863          	bnez	a5,ffffffe000202548 <print_dec_int+0xd4>
ffffffe00020253c:	f9043783          	ld	a5,-112(s0)
ffffffe000202540:	0047c783          	lbu	a5,4(a5)
ffffffe000202544:	00078663          	beqz	a5,ffffffe000202550 <print_dec_int+0xdc>
ffffffe000202548:	00100793          	li	a5,1
ffffffe00020254c:	0080006f          	j	ffffffe000202554 <print_dec_int+0xe0>
ffffffe000202550:	00000793          	li	a5,0
ffffffe000202554:	fcf40ba3          	sb	a5,-41(s0)
ffffffe000202558:	fd744783          	lbu	a5,-41(s0)
ffffffe00020255c:	0017f793          	andi	a5,a5,1
ffffffe000202560:	fcf40ba3          	sb	a5,-41(s0)

    do {
        buf[decdigits++] = num % 10 + '0';
ffffffe000202564:	fa043703          	ld	a4,-96(s0)
ffffffe000202568:	00a00793          	li	a5,10
ffffffe00020256c:	02f777b3          	remu	a5,a4,a5
ffffffe000202570:	0ff7f713          	zext.b	a4,a5
ffffffe000202574:	fe842783          	lw	a5,-24(s0)
ffffffe000202578:	0017869b          	addiw	a3,a5,1
ffffffe00020257c:	fed42423          	sw	a3,-24(s0)
ffffffe000202580:	0307071b          	addiw	a4,a4,48
ffffffe000202584:	0ff77713          	zext.b	a4,a4
ffffffe000202588:	ff078793          	addi	a5,a5,-16
ffffffe00020258c:	008787b3          	add	a5,a5,s0
ffffffe000202590:	fce78423          	sb	a4,-56(a5)
        num /= 10;
ffffffe000202594:	fa043703          	ld	a4,-96(s0)
ffffffe000202598:	00a00793          	li	a5,10
ffffffe00020259c:	02f757b3          	divu	a5,a4,a5
ffffffe0002025a0:	faf43023          	sd	a5,-96(s0)
    } while (num);
ffffffe0002025a4:	fa043783          	ld	a5,-96(s0)
ffffffe0002025a8:	fa079ee3          	bnez	a5,ffffffe000202564 <print_dec_int+0xf0>

    if (flags->prec == -1 && flags->zeroflag) {
ffffffe0002025ac:	f9043783          	ld	a5,-112(s0)
ffffffe0002025b0:	00c7a783          	lw	a5,12(a5)
ffffffe0002025b4:	00078713          	mv	a4,a5
ffffffe0002025b8:	fff00793          	li	a5,-1
ffffffe0002025bc:	02f71063          	bne	a4,a5,ffffffe0002025dc <print_dec_int+0x168>
ffffffe0002025c0:	f9043783          	ld	a5,-112(s0)
ffffffe0002025c4:	0037c783          	lbu	a5,3(a5)
ffffffe0002025c8:	00078a63          	beqz	a5,ffffffe0002025dc <print_dec_int+0x168>
        flags->prec = flags->width;
ffffffe0002025cc:	f9043783          	ld	a5,-112(s0)
ffffffe0002025d0:	0087a703          	lw	a4,8(a5)
ffffffe0002025d4:	f9043783          	ld	a5,-112(s0)
ffffffe0002025d8:	00e7a623          	sw	a4,12(a5)
    }

    int written = 0;
ffffffe0002025dc:	fe042223          	sw	zero,-28(s0)

    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
ffffffe0002025e0:	f9043783          	ld	a5,-112(s0)
ffffffe0002025e4:	0087a703          	lw	a4,8(a5)
ffffffe0002025e8:	fe842783          	lw	a5,-24(s0)
ffffffe0002025ec:	fcf42823          	sw	a5,-48(s0)
ffffffe0002025f0:	f9043783          	ld	a5,-112(s0)
ffffffe0002025f4:	00c7a783          	lw	a5,12(a5)
ffffffe0002025f8:	fcf42623          	sw	a5,-52(s0)
ffffffe0002025fc:	fd042783          	lw	a5,-48(s0)
ffffffe000202600:	00078593          	mv	a1,a5
ffffffe000202604:	fcc42783          	lw	a5,-52(s0)
ffffffe000202608:	00078613          	mv	a2,a5
ffffffe00020260c:	0006069b          	sext.w	a3,a2
ffffffe000202610:	0005879b          	sext.w	a5,a1
ffffffe000202614:	00f6d463          	bge	a3,a5,ffffffe00020261c <print_dec_int+0x1a8>
ffffffe000202618:	00058613          	mv	a2,a1
ffffffe00020261c:	0006079b          	sext.w	a5,a2
ffffffe000202620:	40f707bb          	subw	a5,a4,a5
ffffffe000202624:	0007871b          	sext.w	a4,a5
ffffffe000202628:	fd744783          	lbu	a5,-41(s0)
ffffffe00020262c:	0007879b          	sext.w	a5,a5
ffffffe000202630:	40f707bb          	subw	a5,a4,a5
ffffffe000202634:	fef42023          	sw	a5,-32(s0)
ffffffe000202638:	0280006f          	j	ffffffe000202660 <print_dec_int+0x1ec>
        putch(' ');
ffffffe00020263c:	fa843783          	ld	a5,-88(s0)
ffffffe000202640:	02000513          	li	a0,32
ffffffe000202644:	000780e7          	jalr	a5
        ++written;
ffffffe000202648:	fe442783          	lw	a5,-28(s0)
ffffffe00020264c:	0017879b          	addiw	a5,a5,1
ffffffe000202650:	fef42223          	sw	a5,-28(s0)
    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
ffffffe000202654:	fe042783          	lw	a5,-32(s0)
ffffffe000202658:	fff7879b          	addiw	a5,a5,-1
ffffffe00020265c:	fef42023          	sw	a5,-32(s0)
ffffffe000202660:	fe042783          	lw	a5,-32(s0)
ffffffe000202664:	0007879b          	sext.w	a5,a5
ffffffe000202668:	fcf04ae3          	bgtz	a5,ffffffe00020263c <print_dec_int+0x1c8>
    }

    if (has_sign_char) {
ffffffe00020266c:	fd744783          	lbu	a5,-41(s0)
ffffffe000202670:	0ff7f793          	zext.b	a5,a5
ffffffe000202674:	04078463          	beqz	a5,ffffffe0002026bc <print_dec_int+0x248>
        putch(neg ? '-' : flags->sign ? '+' : ' ');
ffffffe000202678:	fef44783          	lbu	a5,-17(s0)
ffffffe00020267c:	0ff7f793          	zext.b	a5,a5
ffffffe000202680:	00078663          	beqz	a5,ffffffe00020268c <print_dec_int+0x218>
ffffffe000202684:	02d00793          	li	a5,45
ffffffe000202688:	01c0006f          	j	ffffffe0002026a4 <print_dec_int+0x230>
ffffffe00020268c:	f9043783          	ld	a5,-112(s0)
ffffffe000202690:	0057c783          	lbu	a5,5(a5)
ffffffe000202694:	00078663          	beqz	a5,ffffffe0002026a0 <print_dec_int+0x22c>
ffffffe000202698:	02b00793          	li	a5,43
ffffffe00020269c:	0080006f          	j	ffffffe0002026a4 <print_dec_int+0x230>
ffffffe0002026a0:	02000793          	li	a5,32
ffffffe0002026a4:	fa843703          	ld	a4,-88(s0)
ffffffe0002026a8:	00078513          	mv	a0,a5
ffffffe0002026ac:	000700e7          	jalr	a4
        ++written;
ffffffe0002026b0:	fe442783          	lw	a5,-28(s0)
ffffffe0002026b4:	0017879b          	addiw	a5,a5,1
ffffffe0002026b8:	fef42223          	sw	a5,-28(s0)
    }

    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
ffffffe0002026bc:	fe842783          	lw	a5,-24(s0)
ffffffe0002026c0:	fcf42e23          	sw	a5,-36(s0)
ffffffe0002026c4:	0280006f          	j	ffffffe0002026ec <print_dec_int+0x278>
        putch('0');
ffffffe0002026c8:	fa843783          	ld	a5,-88(s0)
ffffffe0002026cc:	03000513          	li	a0,48
ffffffe0002026d0:	000780e7          	jalr	a5
        ++written;
ffffffe0002026d4:	fe442783          	lw	a5,-28(s0)
ffffffe0002026d8:	0017879b          	addiw	a5,a5,1
ffffffe0002026dc:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
ffffffe0002026e0:	fdc42783          	lw	a5,-36(s0)
ffffffe0002026e4:	0017879b          	addiw	a5,a5,1
ffffffe0002026e8:	fcf42e23          	sw	a5,-36(s0)
ffffffe0002026ec:	f9043783          	ld	a5,-112(s0)
ffffffe0002026f0:	00c7a703          	lw	a4,12(a5)
ffffffe0002026f4:	fd744783          	lbu	a5,-41(s0)
ffffffe0002026f8:	0007879b          	sext.w	a5,a5
ffffffe0002026fc:	40f707bb          	subw	a5,a4,a5
ffffffe000202700:	0007871b          	sext.w	a4,a5
ffffffe000202704:	fdc42783          	lw	a5,-36(s0)
ffffffe000202708:	0007879b          	sext.w	a5,a5
ffffffe00020270c:	fae7cee3          	blt	a5,a4,ffffffe0002026c8 <print_dec_int+0x254>
    }

    for (int i = decdigits - 1; i >= 0; i--) {
ffffffe000202710:	fe842783          	lw	a5,-24(s0)
ffffffe000202714:	fff7879b          	addiw	a5,a5,-1
ffffffe000202718:	fcf42c23          	sw	a5,-40(s0)
ffffffe00020271c:	03c0006f          	j	ffffffe000202758 <print_dec_int+0x2e4>
        putch(buf[i]);
ffffffe000202720:	fd842783          	lw	a5,-40(s0)
ffffffe000202724:	ff078793          	addi	a5,a5,-16
ffffffe000202728:	008787b3          	add	a5,a5,s0
ffffffe00020272c:	fc87c783          	lbu	a5,-56(a5)
ffffffe000202730:	0007871b          	sext.w	a4,a5
ffffffe000202734:	fa843783          	ld	a5,-88(s0)
ffffffe000202738:	00070513          	mv	a0,a4
ffffffe00020273c:	000780e7          	jalr	a5
        ++written;
ffffffe000202740:	fe442783          	lw	a5,-28(s0)
ffffffe000202744:	0017879b          	addiw	a5,a5,1
ffffffe000202748:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits - 1; i >= 0; i--) {
ffffffe00020274c:	fd842783          	lw	a5,-40(s0)
ffffffe000202750:	fff7879b          	addiw	a5,a5,-1
ffffffe000202754:	fcf42c23          	sw	a5,-40(s0)
ffffffe000202758:	fd842783          	lw	a5,-40(s0)
ffffffe00020275c:	0007879b          	sext.w	a5,a5
ffffffe000202760:	fc07d0e3          	bgez	a5,ffffffe000202720 <print_dec_int+0x2ac>
    }

    return written;
ffffffe000202764:	fe442783          	lw	a5,-28(s0)
}
ffffffe000202768:	00078513          	mv	a0,a5
ffffffe00020276c:	06813083          	ld	ra,104(sp)
ffffffe000202770:	06013403          	ld	s0,96(sp)
ffffffe000202774:	07010113          	addi	sp,sp,112
ffffffe000202778:	00008067          	ret

ffffffe00020277c <vprintfmt>:

int vprintfmt(int (*putch)(int), const char *fmt, va_list vl) {
ffffffe00020277c:	f4010113          	addi	sp,sp,-192
ffffffe000202780:	0a113c23          	sd	ra,184(sp)
ffffffe000202784:	0a813823          	sd	s0,176(sp)
ffffffe000202788:	0c010413          	addi	s0,sp,192
ffffffe00020278c:	f4a43c23          	sd	a0,-168(s0)
ffffffe000202790:	f4b43823          	sd	a1,-176(s0)
ffffffe000202794:	f4c43423          	sd	a2,-184(s0)
    static const char lowerxdigits[] = "0123456789abcdef";
    static const char upperxdigits[] = "0123456789ABCDEF";

    struct fmt_flags flags = {};
ffffffe000202798:	f8043023          	sd	zero,-128(s0)
ffffffe00020279c:	f8043423          	sd	zero,-120(s0)

    int written = 0;
ffffffe0002027a0:	fe042623          	sw	zero,-20(s0)

    for (; *fmt; fmt++) {
ffffffe0002027a4:	7a40006f          	j	ffffffe000202f48 <vprintfmt+0x7cc>
        if (flags.in_format) {
ffffffe0002027a8:	f8044783          	lbu	a5,-128(s0)
ffffffe0002027ac:	72078e63          	beqz	a5,ffffffe000202ee8 <vprintfmt+0x76c>
            if (*fmt == '#') {
ffffffe0002027b0:	f5043783          	ld	a5,-176(s0)
ffffffe0002027b4:	0007c783          	lbu	a5,0(a5)
ffffffe0002027b8:	00078713          	mv	a4,a5
ffffffe0002027bc:	02300793          	li	a5,35
ffffffe0002027c0:	00f71863          	bne	a4,a5,ffffffe0002027d0 <vprintfmt+0x54>
                flags.sharpflag = true;
ffffffe0002027c4:	00100793          	li	a5,1
ffffffe0002027c8:	f8f40123          	sb	a5,-126(s0)
ffffffe0002027cc:	7700006f          	j	ffffffe000202f3c <vprintfmt+0x7c0>
            } else if (*fmt == '0') {
ffffffe0002027d0:	f5043783          	ld	a5,-176(s0)
ffffffe0002027d4:	0007c783          	lbu	a5,0(a5)
ffffffe0002027d8:	00078713          	mv	a4,a5
ffffffe0002027dc:	03000793          	li	a5,48
ffffffe0002027e0:	00f71863          	bne	a4,a5,ffffffe0002027f0 <vprintfmt+0x74>
                flags.zeroflag = true;
ffffffe0002027e4:	00100793          	li	a5,1
ffffffe0002027e8:	f8f401a3          	sb	a5,-125(s0)
ffffffe0002027ec:	7500006f          	j	ffffffe000202f3c <vprintfmt+0x7c0>
            } else if (*fmt == 'l' || *fmt == 'z' || *fmt == 't' || *fmt == 'j') {
ffffffe0002027f0:	f5043783          	ld	a5,-176(s0)
ffffffe0002027f4:	0007c783          	lbu	a5,0(a5)
ffffffe0002027f8:	00078713          	mv	a4,a5
ffffffe0002027fc:	06c00793          	li	a5,108
ffffffe000202800:	04f70063          	beq	a4,a5,ffffffe000202840 <vprintfmt+0xc4>
ffffffe000202804:	f5043783          	ld	a5,-176(s0)
ffffffe000202808:	0007c783          	lbu	a5,0(a5)
ffffffe00020280c:	00078713          	mv	a4,a5
ffffffe000202810:	07a00793          	li	a5,122
ffffffe000202814:	02f70663          	beq	a4,a5,ffffffe000202840 <vprintfmt+0xc4>
ffffffe000202818:	f5043783          	ld	a5,-176(s0)
ffffffe00020281c:	0007c783          	lbu	a5,0(a5)
ffffffe000202820:	00078713          	mv	a4,a5
ffffffe000202824:	07400793          	li	a5,116
ffffffe000202828:	00f70c63          	beq	a4,a5,ffffffe000202840 <vprintfmt+0xc4>
ffffffe00020282c:	f5043783          	ld	a5,-176(s0)
ffffffe000202830:	0007c783          	lbu	a5,0(a5)
ffffffe000202834:	00078713          	mv	a4,a5
ffffffe000202838:	06a00793          	li	a5,106
ffffffe00020283c:	00f71863          	bne	a4,a5,ffffffe00020284c <vprintfmt+0xd0>
                // l: long, z: size_t, t: ptrdiff_t, j: intmax_t
                flags.longflag = true;
ffffffe000202840:	00100793          	li	a5,1
ffffffe000202844:	f8f400a3          	sb	a5,-127(s0)
ffffffe000202848:	6f40006f          	j	ffffffe000202f3c <vprintfmt+0x7c0>
            } else if (*fmt == '+') {
ffffffe00020284c:	f5043783          	ld	a5,-176(s0)
ffffffe000202850:	0007c783          	lbu	a5,0(a5)
ffffffe000202854:	00078713          	mv	a4,a5
ffffffe000202858:	02b00793          	li	a5,43
ffffffe00020285c:	00f71863          	bne	a4,a5,ffffffe00020286c <vprintfmt+0xf0>
                flags.sign = true;
ffffffe000202860:	00100793          	li	a5,1
ffffffe000202864:	f8f402a3          	sb	a5,-123(s0)
ffffffe000202868:	6d40006f          	j	ffffffe000202f3c <vprintfmt+0x7c0>
            } else if (*fmt == ' ') {
ffffffe00020286c:	f5043783          	ld	a5,-176(s0)
ffffffe000202870:	0007c783          	lbu	a5,0(a5)
ffffffe000202874:	00078713          	mv	a4,a5
ffffffe000202878:	02000793          	li	a5,32
ffffffe00020287c:	00f71863          	bne	a4,a5,ffffffe00020288c <vprintfmt+0x110>
                flags.spaceflag = true;
ffffffe000202880:	00100793          	li	a5,1
ffffffe000202884:	f8f40223          	sb	a5,-124(s0)
ffffffe000202888:	6b40006f          	j	ffffffe000202f3c <vprintfmt+0x7c0>
            } else if (*fmt == '*') {
ffffffe00020288c:	f5043783          	ld	a5,-176(s0)
ffffffe000202890:	0007c783          	lbu	a5,0(a5)
ffffffe000202894:	00078713          	mv	a4,a5
ffffffe000202898:	02a00793          	li	a5,42
ffffffe00020289c:	00f71e63          	bne	a4,a5,ffffffe0002028b8 <vprintfmt+0x13c>
                flags.width = va_arg(vl, int);
ffffffe0002028a0:	f4843783          	ld	a5,-184(s0)
ffffffe0002028a4:	00878713          	addi	a4,a5,8
ffffffe0002028a8:	f4e43423          	sd	a4,-184(s0)
ffffffe0002028ac:	0007a783          	lw	a5,0(a5)
ffffffe0002028b0:	f8f42423          	sw	a5,-120(s0)
ffffffe0002028b4:	6880006f          	j	ffffffe000202f3c <vprintfmt+0x7c0>
            } else if (*fmt >= '1' && *fmt <= '9') {
ffffffe0002028b8:	f5043783          	ld	a5,-176(s0)
ffffffe0002028bc:	0007c783          	lbu	a5,0(a5)
ffffffe0002028c0:	00078713          	mv	a4,a5
ffffffe0002028c4:	03000793          	li	a5,48
ffffffe0002028c8:	04e7f663          	bgeu	a5,a4,ffffffe000202914 <vprintfmt+0x198>
ffffffe0002028cc:	f5043783          	ld	a5,-176(s0)
ffffffe0002028d0:	0007c783          	lbu	a5,0(a5)
ffffffe0002028d4:	00078713          	mv	a4,a5
ffffffe0002028d8:	03900793          	li	a5,57
ffffffe0002028dc:	02e7ec63          	bltu	a5,a4,ffffffe000202914 <vprintfmt+0x198>
                flags.width = strtol(fmt, (char **)&fmt, 10);
ffffffe0002028e0:	f5043783          	ld	a5,-176(s0)
ffffffe0002028e4:	f5040713          	addi	a4,s0,-176
ffffffe0002028e8:	00a00613          	li	a2,10
ffffffe0002028ec:	00070593          	mv	a1,a4
ffffffe0002028f0:	00078513          	mv	a0,a5
ffffffe0002028f4:	88dff0ef          	jal	ffffffe000202180 <strtol>
ffffffe0002028f8:	00050793          	mv	a5,a0
ffffffe0002028fc:	0007879b          	sext.w	a5,a5
ffffffe000202900:	f8f42423          	sw	a5,-120(s0)
                fmt--;
ffffffe000202904:	f5043783          	ld	a5,-176(s0)
ffffffe000202908:	fff78793          	addi	a5,a5,-1
ffffffe00020290c:	f4f43823          	sd	a5,-176(s0)
ffffffe000202910:	62c0006f          	j	ffffffe000202f3c <vprintfmt+0x7c0>
            } else if (*fmt == '.') {
ffffffe000202914:	f5043783          	ld	a5,-176(s0)
ffffffe000202918:	0007c783          	lbu	a5,0(a5)
ffffffe00020291c:	00078713          	mv	a4,a5
ffffffe000202920:	02e00793          	li	a5,46
ffffffe000202924:	06f71863          	bne	a4,a5,ffffffe000202994 <vprintfmt+0x218>
                fmt++;
ffffffe000202928:	f5043783          	ld	a5,-176(s0)
ffffffe00020292c:	00178793          	addi	a5,a5,1
ffffffe000202930:	f4f43823          	sd	a5,-176(s0)
                if (*fmt == '*') {
ffffffe000202934:	f5043783          	ld	a5,-176(s0)
ffffffe000202938:	0007c783          	lbu	a5,0(a5)
ffffffe00020293c:	00078713          	mv	a4,a5
ffffffe000202940:	02a00793          	li	a5,42
ffffffe000202944:	00f71e63          	bne	a4,a5,ffffffe000202960 <vprintfmt+0x1e4>
                    flags.prec = va_arg(vl, int);
ffffffe000202948:	f4843783          	ld	a5,-184(s0)
ffffffe00020294c:	00878713          	addi	a4,a5,8
ffffffe000202950:	f4e43423          	sd	a4,-184(s0)
ffffffe000202954:	0007a783          	lw	a5,0(a5)
ffffffe000202958:	f8f42623          	sw	a5,-116(s0)
ffffffe00020295c:	5e00006f          	j	ffffffe000202f3c <vprintfmt+0x7c0>
                } else {
                    flags.prec = strtol(fmt, (char **)&fmt, 10);
ffffffe000202960:	f5043783          	ld	a5,-176(s0)
ffffffe000202964:	f5040713          	addi	a4,s0,-176
ffffffe000202968:	00a00613          	li	a2,10
ffffffe00020296c:	00070593          	mv	a1,a4
ffffffe000202970:	00078513          	mv	a0,a5
ffffffe000202974:	80dff0ef          	jal	ffffffe000202180 <strtol>
ffffffe000202978:	00050793          	mv	a5,a0
ffffffe00020297c:	0007879b          	sext.w	a5,a5
ffffffe000202980:	f8f42623          	sw	a5,-116(s0)
                    fmt--;
ffffffe000202984:	f5043783          	ld	a5,-176(s0)
ffffffe000202988:	fff78793          	addi	a5,a5,-1
ffffffe00020298c:	f4f43823          	sd	a5,-176(s0)
ffffffe000202990:	5ac0006f          	j	ffffffe000202f3c <vprintfmt+0x7c0>
                }
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
ffffffe000202994:	f5043783          	ld	a5,-176(s0)
ffffffe000202998:	0007c783          	lbu	a5,0(a5)
ffffffe00020299c:	00078713          	mv	a4,a5
ffffffe0002029a0:	07800793          	li	a5,120
ffffffe0002029a4:	02f70663          	beq	a4,a5,ffffffe0002029d0 <vprintfmt+0x254>
ffffffe0002029a8:	f5043783          	ld	a5,-176(s0)
ffffffe0002029ac:	0007c783          	lbu	a5,0(a5)
ffffffe0002029b0:	00078713          	mv	a4,a5
ffffffe0002029b4:	05800793          	li	a5,88
ffffffe0002029b8:	00f70c63          	beq	a4,a5,ffffffe0002029d0 <vprintfmt+0x254>
ffffffe0002029bc:	f5043783          	ld	a5,-176(s0)
ffffffe0002029c0:	0007c783          	lbu	a5,0(a5)
ffffffe0002029c4:	00078713          	mv	a4,a5
ffffffe0002029c8:	07000793          	li	a5,112
ffffffe0002029cc:	30f71263          	bne	a4,a5,ffffffe000202cd0 <vprintfmt+0x554>
                bool is_long = *fmt == 'p' || flags.longflag;
ffffffe0002029d0:	f5043783          	ld	a5,-176(s0)
ffffffe0002029d4:	0007c783          	lbu	a5,0(a5)
ffffffe0002029d8:	00078713          	mv	a4,a5
ffffffe0002029dc:	07000793          	li	a5,112
ffffffe0002029e0:	00f70663          	beq	a4,a5,ffffffe0002029ec <vprintfmt+0x270>
ffffffe0002029e4:	f8144783          	lbu	a5,-127(s0)
ffffffe0002029e8:	00078663          	beqz	a5,ffffffe0002029f4 <vprintfmt+0x278>
ffffffe0002029ec:	00100793          	li	a5,1
ffffffe0002029f0:	0080006f          	j	ffffffe0002029f8 <vprintfmt+0x27c>
ffffffe0002029f4:	00000793          	li	a5,0
ffffffe0002029f8:	faf403a3          	sb	a5,-89(s0)
ffffffe0002029fc:	fa744783          	lbu	a5,-89(s0)
ffffffe000202a00:	0017f793          	andi	a5,a5,1
ffffffe000202a04:	faf403a3          	sb	a5,-89(s0)

                unsigned long num = is_long ? va_arg(vl, unsigned long) : va_arg(vl, unsigned int);
ffffffe000202a08:	fa744783          	lbu	a5,-89(s0)
ffffffe000202a0c:	0ff7f793          	zext.b	a5,a5
ffffffe000202a10:	00078c63          	beqz	a5,ffffffe000202a28 <vprintfmt+0x2ac>
ffffffe000202a14:	f4843783          	ld	a5,-184(s0)
ffffffe000202a18:	00878713          	addi	a4,a5,8
ffffffe000202a1c:	f4e43423          	sd	a4,-184(s0)
ffffffe000202a20:	0007b783          	ld	a5,0(a5)
ffffffe000202a24:	01c0006f          	j	ffffffe000202a40 <vprintfmt+0x2c4>
ffffffe000202a28:	f4843783          	ld	a5,-184(s0)
ffffffe000202a2c:	00878713          	addi	a4,a5,8
ffffffe000202a30:	f4e43423          	sd	a4,-184(s0)
ffffffe000202a34:	0007a783          	lw	a5,0(a5)
ffffffe000202a38:	02079793          	slli	a5,a5,0x20
ffffffe000202a3c:	0207d793          	srli	a5,a5,0x20
ffffffe000202a40:	fef43023          	sd	a5,-32(s0)

                if (flags.prec == 0 && num == 0 && *fmt != 'p') {
ffffffe000202a44:	f8c42783          	lw	a5,-116(s0)
ffffffe000202a48:	02079463          	bnez	a5,ffffffe000202a70 <vprintfmt+0x2f4>
ffffffe000202a4c:	fe043783          	ld	a5,-32(s0)
ffffffe000202a50:	02079063          	bnez	a5,ffffffe000202a70 <vprintfmt+0x2f4>
ffffffe000202a54:	f5043783          	ld	a5,-176(s0)
ffffffe000202a58:	0007c783          	lbu	a5,0(a5)
ffffffe000202a5c:	00078713          	mv	a4,a5
ffffffe000202a60:	07000793          	li	a5,112
ffffffe000202a64:	00f70663          	beq	a4,a5,ffffffe000202a70 <vprintfmt+0x2f4>
                    flags.in_format = false;
ffffffe000202a68:	f8040023          	sb	zero,-128(s0)
ffffffe000202a6c:	4d00006f          	j	ffffffe000202f3c <vprintfmt+0x7c0>
                    continue;
                }

                // 0x prefix for pointers, or, if # flag is set and non-zero
                bool prefix = *fmt == 'p' || (flags.sharpflag && num != 0);
ffffffe000202a70:	f5043783          	ld	a5,-176(s0)
ffffffe000202a74:	0007c783          	lbu	a5,0(a5)
ffffffe000202a78:	00078713          	mv	a4,a5
ffffffe000202a7c:	07000793          	li	a5,112
ffffffe000202a80:	00f70a63          	beq	a4,a5,ffffffe000202a94 <vprintfmt+0x318>
ffffffe000202a84:	f8244783          	lbu	a5,-126(s0)
ffffffe000202a88:	00078a63          	beqz	a5,ffffffe000202a9c <vprintfmt+0x320>
ffffffe000202a8c:	fe043783          	ld	a5,-32(s0)
ffffffe000202a90:	00078663          	beqz	a5,ffffffe000202a9c <vprintfmt+0x320>
ffffffe000202a94:	00100793          	li	a5,1
ffffffe000202a98:	0080006f          	j	ffffffe000202aa0 <vprintfmt+0x324>
ffffffe000202a9c:	00000793          	li	a5,0
ffffffe000202aa0:	faf40323          	sb	a5,-90(s0)
ffffffe000202aa4:	fa644783          	lbu	a5,-90(s0)
ffffffe000202aa8:	0017f793          	andi	a5,a5,1
ffffffe000202aac:	faf40323          	sb	a5,-90(s0)

                int hexdigits = 0;
ffffffe000202ab0:	fc042e23          	sw	zero,-36(s0)
                const char *xdigits = *fmt == 'X' ? upperxdigits : lowerxdigits;
ffffffe000202ab4:	f5043783          	ld	a5,-176(s0)
ffffffe000202ab8:	0007c783          	lbu	a5,0(a5)
ffffffe000202abc:	00078713          	mv	a4,a5
ffffffe000202ac0:	05800793          	li	a5,88
ffffffe000202ac4:	00f71863          	bne	a4,a5,ffffffe000202ad4 <vprintfmt+0x358>
ffffffe000202ac8:	00003797          	auipc	a5,0x3
ffffffe000202acc:	81078793          	addi	a5,a5,-2032 # ffffffe0002052d8 <upperxdigits.1>
ffffffe000202ad0:	00c0006f          	j	ffffffe000202adc <vprintfmt+0x360>
ffffffe000202ad4:	00003797          	auipc	a5,0x3
ffffffe000202ad8:	81c78793          	addi	a5,a5,-2020 # ffffffe0002052f0 <lowerxdigits.0>
ffffffe000202adc:	f8f43c23          	sd	a5,-104(s0)
                char buf[2 * sizeof(unsigned long)];

                do {
                    buf[hexdigits++] = xdigits[num & 0xf];
ffffffe000202ae0:	fe043783          	ld	a5,-32(s0)
ffffffe000202ae4:	00f7f793          	andi	a5,a5,15
ffffffe000202ae8:	f9843703          	ld	a4,-104(s0)
ffffffe000202aec:	00f70733          	add	a4,a4,a5
ffffffe000202af0:	fdc42783          	lw	a5,-36(s0)
ffffffe000202af4:	0017869b          	addiw	a3,a5,1
ffffffe000202af8:	fcd42e23          	sw	a3,-36(s0)
ffffffe000202afc:	00074703          	lbu	a4,0(a4)
ffffffe000202b00:	ff078793          	addi	a5,a5,-16
ffffffe000202b04:	008787b3          	add	a5,a5,s0
ffffffe000202b08:	f8e78023          	sb	a4,-128(a5)
                    num >>= 4;
ffffffe000202b0c:	fe043783          	ld	a5,-32(s0)
ffffffe000202b10:	0047d793          	srli	a5,a5,0x4
ffffffe000202b14:	fef43023          	sd	a5,-32(s0)
                } while (num);
ffffffe000202b18:	fe043783          	ld	a5,-32(s0)
ffffffe000202b1c:	fc0792e3          	bnez	a5,ffffffe000202ae0 <vprintfmt+0x364>

                if (flags.prec == -1 && flags.zeroflag) {
ffffffe000202b20:	f8c42783          	lw	a5,-116(s0)
ffffffe000202b24:	00078713          	mv	a4,a5
ffffffe000202b28:	fff00793          	li	a5,-1
ffffffe000202b2c:	02f71663          	bne	a4,a5,ffffffe000202b58 <vprintfmt+0x3dc>
ffffffe000202b30:	f8344783          	lbu	a5,-125(s0)
ffffffe000202b34:	02078263          	beqz	a5,ffffffe000202b58 <vprintfmt+0x3dc>
                    flags.prec = flags.width - 2 * prefix;
ffffffe000202b38:	f8842703          	lw	a4,-120(s0)
ffffffe000202b3c:	fa644783          	lbu	a5,-90(s0)
ffffffe000202b40:	0007879b          	sext.w	a5,a5
ffffffe000202b44:	0017979b          	slliw	a5,a5,0x1
ffffffe000202b48:	0007879b          	sext.w	a5,a5
ffffffe000202b4c:	40f707bb          	subw	a5,a4,a5
ffffffe000202b50:	0007879b          	sext.w	a5,a5
ffffffe000202b54:	f8f42623          	sw	a5,-116(s0)
                }

                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
ffffffe000202b58:	f8842703          	lw	a4,-120(s0)
ffffffe000202b5c:	fa644783          	lbu	a5,-90(s0)
ffffffe000202b60:	0007879b          	sext.w	a5,a5
ffffffe000202b64:	0017979b          	slliw	a5,a5,0x1
ffffffe000202b68:	0007879b          	sext.w	a5,a5
ffffffe000202b6c:	40f707bb          	subw	a5,a4,a5
ffffffe000202b70:	0007871b          	sext.w	a4,a5
ffffffe000202b74:	fdc42783          	lw	a5,-36(s0)
ffffffe000202b78:	f8f42a23          	sw	a5,-108(s0)
ffffffe000202b7c:	f8c42783          	lw	a5,-116(s0)
ffffffe000202b80:	f8f42823          	sw	a5,-112(s0)
ffffffe000202b84:	f9442783          	lw	a5,-108(s0)
ffffffe000202b88:	00078593          	mv	a1,a5
ffffffe000202b8c:	f9042783          	lw	a5,-112(s0)
ffffffe000202b90:	00078613          	mv	a2,a5
ffffffe000202b94:	0006069b          	sext.w	a3,a2
ffffffe000202b98:	0005879b          	sext.w	a5,a1
ffffffe000202b9c:	00f6d463          	bge	a3,a5,ffffffe000202ba4 <vprintfmt+0x428>
ffffffe000202ba0:	00058613          	mv	a2,a1
ffffffe000202ba4:	0006079b          	sext.w	a5,a2
ffffffe000202ba8:	40f707bb          	subw	a5,a4,a5
ffffffe000202bac:	fcf42c23          	sw	a5,-40(s0)
ffffffe000202bb0:	0280006f          	j	ffffffe000202bd8 <vprintfmt+0x45c>
                    putch(' ');
ffffffe000202bb4:	f5843783          	ld	a5,-168(s0)
ffffffe000202bb8:	02000513          	li	a0,32
ffffffe000202bbc:	000780e7          	jalr	a5
                    ++written;
ffffffe000202bc0:	fec42783          	lw	a5,-20(s0)
ffffffe000202bc4:	0017879b          	addiw	a5,a5,1
ffffffe000202bc8:	fef42623          	sw	a5,-20(s0)
                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
ffffffe000202bcc:	fd842783          	lw	a5,-40(s0)
ffffffe000202bd0:	fff7879b          	addiw	a5,a5,-1
ffffffe000202bd4:	fcf42c23          	sw	a5,-40(s0)
ffffffe000202bd8:	fd842783          	lw	a5,-40(s0)
ffffffe000202bdc:	0007879b          	sext.w	a5,a5
ffffffe000202be0:	fcf04ae3          	bgtz	a5,ffffffe000202bb4 <vprintfmt+0x438>
                }

                if (prefix) {
ffffffe000202be4:	fa644783          	lbu	a5,-90(s0)
ffffffe000202be8:	0ff7f793          	zext.b	a5,a5
ffffffe000202bec:	04078463          	beqz	a5,ffffffe000202c34 <vprintfmt+0x4b8>
                    putch('0');
ffffffe000202bf0:	f5843783          	ld	a5,-168(s0)
ffffffe000202bf4:	03000513          	li	a0,48
ffffffe000202bf8:	000780e7          	jalr	a5
                    putch(*fmt == 'X' ? 'X' : 'x');
ffffffe000202bfc:	f5043783          	ld	a5,-176(s0)
ffffffe000202c00:	0007c783          	lbu	a5,0(a5)
ffffffe000202c04:	00078713          	mv	a4,a5
ffffffe000202c08:	05800793          	li	a5,88
ffffffe000202c0c:	00f71663          	bne	a4,a5,ffffffe000202c18 <vprintfmt+0x49c>
ffffffe000202c10:	05800793          	li	a5,88
ffffffe000202c14:	0080006f          	j	ffffffe000202c1c <vprintfmt+0x4a0>
ffffffe000202c18:	07800793          	li	a5,120
ffffffe000202c1c:	f5843703          	ld	a4,-168(s0)
ffffffe000202c20:	00078513          	mv	a0,a5
ffffffe000202c24:	000700e7          	jalr	a4
                    written += 2;
ffffffe000202c28:	fec42783          	lw	a5,-20(s0)
ffffffe000202c2c:	0027879b          	addiw	a5,a5,2
ffffffe000202c30:	fef42623          	sw	a5,-20(s0)
                }

                for (int i = hexdigits; i < flags.prec; i++) {
ffffffe000202c34:	fdc42783          	lw	a5,-36(s0)
ffffffe000202c38:	fcf42a23          	sw	a5,-44(s0)
ffffffe000202c3c:	0280006f          	j	ffffffe000202c64 <vprintfmt+0x4e8>
                    putch('0');
ffffffe000202c40:	f5843783          	ld	a5,-168(s0)
ffffffe000202c44:	03000513          	li	a0,48
ffffffe000202c48:	000780e7          	jalr	a5
                    ++written;
ffffffe000202c4c:	fec42783          	lw	a5,-20(s0)
ffffffe000202c50:	0017879b          	addiw	a5,a5,1
ffffffe000202c54:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits; i < flags.prec; i++) {
ffffffe000202c58:	fd442783          	lw	a5,-44(s0)
ffffffe000202c5c:	0017879b          	addiw	a5,a5,1
ffffffe000202c60:	fcf42a23          	sw	a5,-44(s0)
ffffffe000202c64:	f8c42703          	lw	a4,-116(s0)
ffffffe000202c68:	fd442783          	lw	a5,-44(s0)
ffffffe000202c6c:	0007879b          	sext.w	a5,a5
ffffffe000202c70:	fce7c8e3          	blt	a5,a4,ffffffe000202c40 <vprintfmt+0x4c4>
                }

                for (int i = hexdigits - 1; i >= 0; i--) {
ffffffe000202c74:	fdc42783          	lw	a5,-36(s0)
ffffffe000202c78:	fff7879b          	addiw	a5,a5,-1
ffffffe000202c7c:	fcf42823          	sw	a5,-48(s0)
ffffffe000202c80:	03c0006f          	j	ffffffe000202cbc <vprintfmt+0x540>
                    putch(buf[i]);
ffffffe000202c84:	fd042783          	lw	a5,-48(s0)
ffffffe000202c88:	ff078793          	addi	a5,a5,-16
ffffffe000202c8c:	008787b3          	add	a5,a5,s0
ffffffe000202c90:	f807c783          	lbu	a5,-128(a5)
ffffffe000202c94:	0007871b          	sext.w	a4,a5
ffffffe000202c98:	f5843783          	ld	a5,-168(s0)
ffffffe000202c9c:	00070513          	mv	a0,a4
ffffffe000202ca0:	000780e7          	jalr	a5
                    ++written;
ffffffe000202ca4:	fec42783          	lw	a5,-20(s0)
ffffffe000202ca8:	0017879b          	addiw	a5,a5,1
ffffffe000202cac:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits - 1; i >= 0; i--) {
ffffffe000202cb0:	fd042783          	lw	a5,-48(s0)
ffffffe000202cb4:	fff7879b          	addiw	a5,a5,-1
ffffffe000202cb8:	fcf42823          	sw	a5,-48(s0)
ffffffe000202cbc:	fd042783          	lw	a5,-48(s0)
ffffffe000202cc0:	0007879b          	sext.w	a5,a5
ffffffe000202cc4:	fc07d0e3          	bgez	a5,ffffffe000202c84 <vprintfmt+0x508>
                }

                flags.in_format = false;
ffffffe000202cc8:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
ffffffe000202ccc:	2700006f          	j	ffffffe000202f3c <vprintfmt+0x7c0>
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
ffffffe000202cd0:	f5043783          	ld	a5,-176(s0)
ffffffe000202cd4:	0007c783          	lbu	a5,0(a5)
ffffffe000202cd8:	00078713          	mv	a4,a5
ffffffe000202cdc:	06400793          	li	a5,100
ffffffe000202ce0:	02f70663          	beq	a4,a5,ffffffe000202d0c <vprintfmt+0x590>
ffffffe000202ce4:	f5043783          	ld	a5,-176(s0)
ffffffe000202ce8:	0007c783          	lbu	a5,0(a5)
ffffffe000202cec:	00078713          	mv	a4,a5
ffffffe000202cf0:	06900793          	li	a5,105
ffffffe000202cf4:	00f70c63          	beq	a4,a5,ffffffe000202d0c <vprintfmt+0x590>
ffffffe000202cf8:	f5043783          	ld	a5,-176(s0)
ffffffe000202cfc:	0007c783          	lbu	a5,0(a5)
ffffffe000202d00:	00078713          	mv	a4,a5
ffffffe000202d04:	07500793          	li	a5,117
ffffffe000202d08:	08f71063          	bne	a4,a5,ffffffe000202d88 <vprintfmt+0x60c>
                long num = flags.longflag ? va_arg(vl, long) : va_arg(vl, int);
ffffffe000202d0c:	f8144783          	lbu	a5,-127(s0)
ffffffe000202d10:	00078c63          	beqz	a5,ffffffe000202d28 <vprintfmt+0x5ac>
ffffffe000202d14:	f4843783          	ld	a5,-184(s0)
ffffffe000202d18:	00878713          	addi	a4,a5,8
ffffffe000202d1c:	f4e43423          	sd	a4,-184(s0)
ffffffe000202d20:	0007b783          	ld	a5,0(a5)
ffffffe000202d24:	0140006f          	j	ffffffe000202d38 <vprintfmt+0x5bc>
ffffffe000202d28:	f4843783          	ld	a5,-184(s0)
ffffffe000202d2c:	00878713          	addi	a4,a5,8
ffffffe000202d30:	f4e43423          	sd	a4,-184(s0)
ffffffe000202d34:	0007a783          	lw	a5,0(a5)
ffffffe000202d38:	faf43423          	sd	a5,-88(s0)

                written += print_dec_int(putch, num, *fmt != 'u', &flags);
ffffffe000202d3c:	fa843583          	ld	a1,-88(s0)
ffffffe000202d40:	f5043783          	ld	a5,-176(s0)
ffffffe000202d44:	0007c783          	lbu	a5,0(a5)
ffffffe000202d48:	0007871b          	sext.w	a4,a5
ffffffe000202d4c:	07500793          	li	a5,117
ffffffe000202d50:	40f707b3          	sub	a5,a4,a5
ffffffe000202d54:	00f037b3          	snez	a5,a5
ffffffe000202d58:	0ff7f793          	zext.b	a5,a5
ffffffe000202d5c:	f8040713          	addi	a4,s0,-128
ffffffe000202d60:	00070693          	mv	a3,a4
ffffffe000202d64:	00078613          	mv	a2,a5
ffffffe000202d68:	f5843503          	ld	a0,-168(s0)
ffffffe000202d6c:	f08ff0ef          	jal	ffffffe000202474 <print_dec_int>
ffffffe000202d70:	00050793          	mv	a5,a0
ffffffe000202d74:	fec42703          	lw	a4,-20(s0)
ffffffe000202d78:	00f707bb          	addw	a5,a4,a5
ffffffe000202d7c:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000202d80:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
ffffffe000202d84:	1b80006f          	j	ffffffe000202f3c <vprintfmt+0x7c0>
            } else if (*fmt == 'n') {
ffffffe000202d88:	f5043783          	ld	a5,-176(s0)
ffffffe000202d8c:	0007c783          	lbu	a5,0(a5)
ffffffe000202d90:	00078713          	mv	a4,a5
ffffffe000202d94:	06e00793          	li	a5,110
ffffffe000202d98:	04f71c63          	bne	a4,a5,ffffffe000202df0 <vprintfmt+0x674>
                if (flags.longflag) {
ffffffe000202d9c:	f8144783          	lbu	a5,-127(s0)
ffffffe000202da0:	02078463          	beqz	a5,ffffffe000202dc8 <vprintfmt+0x64c>
                    long *n = va_arg(vl, long *);
ffffffe000202da4:	f4843783          	ld	a5,-184(s0)
ffffffe000202da8:	00878713          	addi	a4,a5,8
ffffffe000202dac:	f4e43423          	sd	a4,-184(s0)
ffffffe000202db0:	0007b783          	ld	a5,0(a5)
ffffffe000202db4:	faf43823          	sd	a5,-80(s0)
                    *n = written;
ffffffe000202db8:	fec42703          	lw	a4,-20(s0)
ffffffe000202dbc:	fb043783          	ld	a5,-80(s0)
ffffffe000202dc0:	00e7b023          	sd	a4,0(a5)
ffffffe000202dc4:	0240006f          	j	ffffffe000202de8 <vprintfmt+0x66c>
                } else {
                    int *n = va_arg(vl, int *);
ffffffe000202dc8:	f4843783          	ld	a5,-184(s0)
ffffffe000202dcc:	00878713          	addi	a4,a5,8
ffffffe000202dd0:	f4e43423          	sd	a4,-184(s0)
ffffffe000202dd4:	0007b783          	ld	a5,0(a5)
ffffffe000202dd8:	faf43c23          	sd	a5,-72(s0)
                    *n = written;
ffffffe000202ddc:	fb843783          	ld	a5,-72(s0)
ffffffe000202de0:	fec42703          	lw	a4,-20(s0)
ffffffe000202de4:	00e7a023          	sw	a4,0(a5)
                }
                flags.in_format = false;
ffffffe000202de8:	f8040023          	sb	zero,-128(s0)
ffffffe000202dec:	1500006f          	j	ffffffe000202f3c <vprintfmt+0x7c0>
            } else if (*fmt == 's') {
ffffffe000202df0:	f5043783          	ld	a5,-176(s0)
ffffffe000202df4:	0007c783          	lbu	a5,0(a5)
ffffffe000202df8:	00078713          	mv	a4,a5
ffffffe000202dfc:	07300793          	li	a5,115
ffffffe000202e00:	02f71e63          	bne	a4,a5,ffffffe000202e3c <vprintfmt+0x6c0>
                const char *s = va_arg(vl, const char *);
ffffffe000202e04:	f4843783          	ld	a5,-184(s0)
ffffffe000202e08:	00878713          	addi	a4,a5,8
ffffffe000202e0c:	f4e43423          	sd	a4,-184(s0)
ffffffe000202e10:	0007b783          	ld	a5,0(a5)
ffffffe000202e14:	fcf43023          	sd	a5,-64(s0)
                written += puts_wo_nl(putch, s);
ffffffe000202e18:	fc043583          	ld	a1,-64(s0)
ffffffe000202e1c:	f5843503          	ld	a0,-168(s0)
ffffffe000202e20:	dccff0ef          	jal	ffffffe0002023ec <puts_wo_nl>
ffffffe000202e24:	00050793          	mv	a5,a0
ffffffe000202e28:	fec42703          	lw	a4,-20(s0)
ffffffe000202e2c:	00f707bb          	addw	a5,a4,a5
ffffffe000202e30:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000202e34:	f8040023          	sb	zero,-128(s0)
ffffffe000202e38:	1040006f          	j	ffffffe000202f3c <vprintfmt+0x7c0>
            } else if (*fmt == 'c') {
ffffffe000202e3c:	f5043783          	ld	a5,-176(s0)
ffffffe000202e40:	0007c783          	lbu	a5,0(a5)
ffffffe000202e44:	00078713          	mv	a4,a5
ffffffe000202e48:	06300793          	li	a5,99
ffffffe000202e4c:	02f71e63          	bne	a4,a5,ffffffe000202e88 <vprintfmt+0x70c>
                int ch = va_arg(vl, int);
ffffffe000202e50:	f4843783          	ld	a5,-184(s0)
ffffffe000202e54:	00878713          	addi	a4,a5,8
ffffffe000202e58:	f4e43423          	sd	a4,-184(s0)
ffffffe000202e5c:	0007a783          	lw	a5,0(a5)
ffffffe000202e60:	fcf42623          	sw	a5,-52(s0)
                putch(ch);
ffffffe000202e64:	fcc42703          	lw	a4,-52(s0)
ffffffe000202e68:	f5843783          	ld	a5,-168(s0)
ffffffe000202e6c:	00070513          	mv	a0,a4
ffffffe000202e70:	000780e7          	jalr	a5
                ++written;
ffffffe000202e74:	fec42783          	lw	a5,-20(s0)
ffffffe000202e78:	0017879b          	addiw	a5,a5,1
ffffffe000202e7c:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000202e80:	f8040023          	sb	zero,-128(s0)
ffffffe000202e84:	0b80006f          	j	ffffffe000202f3c <vprintfmt+0x7c0>
            } else if (*fmt == '%') {
ffffffe000202e88:	f5043783          	ld	a5,-176(s0)
ffffffe000202e8c:	0007c783          	lbu	a5,0(a5)
ffffffe000202e90:	00078713          	mv	a4,a5
ffffffe000202e94:	02500793          	li	a5,37
ffffffe000202e98:	02f71263          	bne	a4,a5,ffffffe000202ebc <vprintfmt+0x740>
                putch('%');
ffffffe000202e9c:	f5843783          	ld	a5,-168(s0)
ffffffe000202ea0:	02500513          	li	a0,37
ffffffe000202ea4:	000780e7          	jalr	a5
                ++written;
ffffffe000202ea8:	fec42783          	lw	a5,-20(s0)
ffffffe000202eac:	0017879b          	addiw	a5,a5,1
ffffffe000202eb0:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000202eb4:	f8040023          	sb	zero,-128(s0)
ffffffe000202eb8:	0840006f          	j	ffffffe000202f3c <vprintfmt+0x7c0>
            } else {
                putch(*fmt);
ffffffe000202ebc:	f5043783          	ld	a5,-176(s0)
ffffffe000202ec0:	0007c783          	lbu	a5,0(a5)
ffffffe000202ec4:	0007871b          	sext.w	a4,a5
ffffffe000202ec8:	f5843783          	ld	a5,-168(s0)
ffffffe000202ecc:	00070513          	mv	a0,a4
ffffffe000202ed0:	000780e7          	jalr	a5
                ++written;
ffffffe000202ed4:	fec42783          	lw	a5,-20(s0)
ffffffe000202ed8:	0017879b          	addiw	a5,a5,1
ffffffe000202edc:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000202ee0:	f8040023          	sb	zero,-128(s0)
ffffffe000202ee4:	0580006f          	j	ffffffe000202f3c <vprintfmt+0x7c0>
            }
        } else if (*fmt == '%') {
ffffffe000202ee8:	f5043783          	ld	a5,-176(s0)
ffffffe000202eec:	0007c783          	lbu	a5,0(a5)
ffffffe000202ef0:	00078713          	mv	a4,a5
ffffffe000202ef4:	02500793          	li	a5,37
ffffffe000202ef8:	02f71063          	bne	a4,a5,ffffffe000202f18 <vprintfmt+0x79c>
            flags = (struct fmt_flags) {.in_format = true, .prec = -1};
ffffffe000202efc:	f8043023          	sd	zero,-128(s0)
ffffffe000202f00:	f8043423          	sd	zero,-120(s0)
ffffffe000202f04:	00100793          	li	a5,1
ffffffe000202f08:	f8f40023          	sb	a5,-128(s0)
ffffffe000202f0c:	fff00793          	li	a5,-1
ffffffe000202f10:	f8f42623          	sw	a5,-116(s0)
ffffffe000202f14:	0280006f          	j	ffffffe000202f3c <vprintfmt+0x7c0>
        } else {
            putch(*fmt);
ffffffe000202f18:	f5043783          	ld	a5,-176(s0)
ffffffe000202f1c:	0007c783          	lbu	a5,0(a5)
ffffffe000202f20:	0007871b          	sext.w	a4,a5
ffffffe000202f24:	f5843783          	ld	a5,-168(s0)
ffffffe000202f28:	00070513          	mv	a0,a4
ffffffe000202f2c:	000780e7          	jalr	a5
            ++written;
ffffffe000202f30:	fec42783          	lw	a5,-20(s0)
ffffffe000202f34:	0017879b          	addiw	a5,a5,1
ffffffe000202f38:	fef42623          	sw	a5,-20(s0)
    for (; *fmt; fmt++) {
ffffffe000202f3c:	f5043783          	ld	a5,-176(s0)
ffffffe000202f40:	00178793          	addi	a5,a5,1
ffffffe000202f44:	f4f43823          	sd	a5,-176(s0)
ffffffe000202f48:	f5043783          	ld	a5,-176(s0)
ffffffe000202f4c:	0007c783          	lbu	a5,0(a5)
ffffffe000202f50:	84079ce3          	bnez	a5,ffffffe0002027a8 <vprintfmt+0x2c>
        }
    }

    return written;
ffffffe000202f54:	fec42783          	lw	a5,-20(s0)
}
ffffffe000202f58:	00078513          	mv	a0,a5
ffffffe000202f5c:	0b813083          	ld	ra,184(sp)
ffffffe000202f60:	0b013403          	ld	s0,176(sp)
ffffffe000202f64:	0c010113          	addi	sp,sp,192
ffffffe000202f68:	00008067          	ret

ffffffe000202f6c <printk>:

int printk(const char* s, ...) {
ffffffe000202f6c:	f9010113          	addi	sp,sp,-112
ffffffe000202f70:	02113423          	sd	ra,40(sp)
ffffffe000202f74:	02813023          	sd	s0,32(sp)
ffffffe000202f78:	03010413          	addi	s0,sp,48
ffffffe000202f7c:	fca43c23          	sd	a0,-40(s0)
ffffffe000202f80:	00b43423          	sd	a1,8(s0)
ffffffe000202f84:	00c43823          	sd	a2,16(s0)
ffffffe000202f88:	00d43c23          	sd	a3,24(s0)
ffffffe000202f8c:	02e43023          	sd	a4,32(s0)
ffffffe000202f90:	02f43423          	sd	a5,40(s0)
ffffffe000202f94:	03043823          	sd	a6,48(s0)
ffffffe000202f98:	03143c23          	sd	a7,56(s0)
    int res = 0;
ffffffe000202f9c:	fe042623          	sw	zero,-20(s0)
    va_list vl;
    va_start(vl, s);
ffffffe000202fa0:	04040793          	addi	a5,s0,64
ffffffe000202fa4:	fcf43823          	sd	a5,-48(s0)
ffffffe000202fa8:	fd043783          	ld	a5,-48(s0)
ffffffe000202fac:	fc878793          	addi	a5,a5,-56
ffffffe000202fb0:	fef43023          	sd	a5,-32(s0)
    res = vprintfmt(putc, s, vl);
ffffffe000202fb4:	fe043783          	ld	a5,-32(s0)
ffffffe000202fb8:	00078613          	mv	a2,a5
ffffffe000202fbc:	fd843583          	ld	a1,-40(s0)
ffffffe000202fc0:	fffff517          	auipc	a0,0xfffff
ffffffe000202fc4:	11850513          	addi	a0,a0,280 # ffffffe0002020d8 <putc>
ffffffe000202fc8:	fb4ff0ef          	jal	ffffffe00020277c <vprintfmt>
ffffffe000202fcc:	00050793          	mv	a5,a0
ffffffe000202fd0:	fef42623          	sw	a5,-20(s0)
    va_end(vl);
    return res;
ffffffe000202fd4:	fec42783          	lw	a5,-20(s0)
}
ffffffe000202fd8:	00078513          	mv	a0,a5
ffffffe000202fdc:	02813083          	ld	ra,40(sp)
ffffffe000202fe0:	02013403          	ld	s0,32(sp)
ffffffe000202fe4:	07010113          	addi	sp,sp,112
ffffffe000202fe8:	00008067          	ret

ffffffe000202fec <srand>:
#include "stdint.h"
#include "stdlib.h"

static uint64_t seed;

void srand(unsigned s) {
ffffffe000202fec:	fe010113          	addi	sp,sp,-32
ffffffe000202ff0:	00813c23          	sd	s0,24(sp)
ffffffe000202ff4:	02010413          	addi	s0,sp,32
ffffffe000202ff8:	00050793          	mv	a5,a0
ffffffe000202ffc:	fef42623          	sw	a5,-20(s0)
    seed = s - 1;
ffffffe000203000:	fec42783          	lw	a5,-20(s0)
ffffffe000203004:	fff7879b          	addiw	a5,a5,-1
ffffffe000203008:	0007879b          	sext.w	a5,a5
ffffffe00020300c:	02079713          	slli	a4,a5,0x20
ffffffe000203010:	02075713          	srli	a4,a4,0x20
ffffffe000203014:	00009797          	auipc	a5,0x9
ffffffe000203018:	00478793          	addi	a5,a5,4 # ffffffe00020c018 <seed>
ffffffe00020301c:	00e7b023          	sd	a4,0(a5)
}
ffffffe000203020:	00000013          	nop
ffffffe000203024:	01813403          	ld	s0,24(sp)
ffffffe000203028:	02010113          	addi	sp,sp,32
ffffffe00020302c:	00008067          	ret

ffffffe000203030 <rand>:

int rand(void) {
ffffffe000203030:	ff010113          	addi	sp,sp,-16
ffffffe000203034:	00813423          	sd	s0,8(sp)
ffffffe000203038:	01010413          	addi	s0,sp,16
    seed = 6364136223846793005ULL * seed + 1;
ffffffe00020303c:	00009797          	auipc	a5,0x9
ffffffe000203040:	fdc78793          	addi	a5,a5,-36 # ffffffe00020c018 <seed>
ffffffe000203044:	0007b703          	ld	a4,0(a5)
ffffffe000203048:	00002797          	auipc	a5,0x2
ffffffe00020304c:	2c078793          	addi	a5,a5,704 # ffffffe000205308 <lowerxdigits.0+0x18>
ffffffe000203050:	0007b783          	ld	a5,0(a5)
ffffffe000203054:	02f707b3          	mul	a5,a4,a5
ffffffe000203058:	00178713          	addi	a4,a5,1
ffffffe00020305c:	00009797          	auipc	a5,0x9
ffffffe000203060:	fbc78793          	addi	a5,a5,-68 # ffffffe00020c018 <seed>
ffffffe000203064:	00e7b023          	sd	a4,0(a5)
    return seed >> 33;
ffffffe000203068:	00009797          	auipc	a5,0x9
ffffffe00020306c:	fb078793          	addi	a5,a5,-80 # ffffffe00020c018 <seed>
ffffffe000203070:	0007b783          	ld	a5,0(a5)
ffffffe000203074:	0217d793          	srli	a5,a5,0x21
ffffffe000203078:	0007879b          	sext.w	a5,a5
}
ffffffe00020307c:	00078513          	mv	a0,a5
ffffffe000203080:	00813403          	ld	s0,8(sp)
ffffffe000203084:	01010113          	addi	sp,sp,16
ffffffe000203088:	00008067          	ret

ffffffe00020308c <memset>:
#include "string.h"
#include "stdint.h"

void *memset(void *dest, int c, uint64_t n) {
ffffffe00020308c:	fc010113          	addi	sp,sp,-64
ffffffe000203090:	02813c23          	sd	s0,56(sp)
ffffffe000203094:	04010413          	addi	s0,sp,64
ffffffe000203098:	fca43c23          	sd	a0,-40(s0)
ffffffe00020309c:	00058793          	mv	a5,a1
ffffffe0002030a0:	fcc43423          	sd	a2,-56(s0)
ffffffe0002030a4:	fcf42a23          	sw	a5,-44(s0)
    char *s = (char *)dest;
ffffffe0002030a8:	fd843783          	ld	a5,-40(s0)
ffffffe0002030ac:	fef43023          	sd	a5,-32(s0)
    for (uint64_t i = 0; i < n; ++i) {
ffffffe0002030b0:	fe043423          	sd	zero,-24(s0)
ffffffe0002030b4:	0280006f          	j	ffffffe0002030dc <memset+0x50>
        s[i] = c;
ffffffe0002030b8:	fe043703          	ld	a4,-32(s0)
ffffffe0002030bc:	fe843783          	ld	a5,-24(s0)
ffffffe0002030c0:	00f707b3          	add	a5,a4,a5
ffffffe0002030c4:	fd442703          	lw	a4,-44(s0)
ffffffe0002030c8:	0ff77713          	zext.b	a4,a4
ffffffe0002030cc:	00e78023          	sb	a4,0(a5)
    for (uint64_t i = 0; i < n; ++i) {
ffffffe0002030d0:	fe843783          	ld	a5,-24(s0)
ffffffe0002030d4:	00178793          	addi	a5,a5,1
ffffffe0002030d8:	fef43423          	sd	a5,-24(s0)
ffffffe0002030dc:	fe843703          	ld	a4,-24(s0)
ffffffe0002030e0:	fc843783          	ld	a5,-56(s0)
ffffffe0002030e4:	fcf76ae3          	bltu	a4,a5,ffffffe0002030b8 <memset+0x2c>
    }
    return dest;
ffffffe0002030e8:	fd843783          	ld	a5,-40(s0)
}
ffffffe0002030ec:	00078513          	mv	a0,a5
ffffffe0002030f0:	03813403          	ld	s0,56(sp)
ffffffe0002030f4:	04010113          	addi	sp,sp,64
ffffffe0002030f8:	00008067          	ret

ffffffe0002030fc <cluster_to_sector>:
struct fat32_volume fat32_volume;

uint8_t fat32_buf[VIRTIO_BLK_SECTOR_SIZE];
uint8_t fat32_table_buf[VIRTIO_BLK_SECTOR_SIZE];

uint64_t cluster_to_sector(uint64_t cluster) {
ffffffe0002030fc:	fe010113          	addi	sp,sp,-32
ffffffe000203100:	00813c23          	sd	s0,24(sp)
ffffffe000203104:	02010413          	addi	s0,sp,32
ffffffe000203108:	fea43423          	sd	a0,-24(s0)
    return (cluster - 2) * fat32_volume.sec_per_cluster + fat32_volume.first_data_sec;
ffffffe00020310c:	fe843783          	ld	a5,-24(s0)
ffffffe000203110:	ffe78713          	addi	a4,a5,-2
ffffffe000203114:	0000c797          	auipc	a5,0xc
ffffffe000203118:	0ec78793          	addi	a5,a5,236 # ffffffe00020f200 <fat32_volume>
ffffffe00020311c:	0107b783          	ld	a5,16(a5)
ffffffe000203120:	02f70733          	mul	a4,a4,a5
ffffffe000203124:	0000c797          	auipc	a5,0xc
ffffffe000203128:	0dc78793          	addi	a5,a5,220 # ffffffe00020f200 <fat32_volume>
ffffffe00020312c:	0007b783          	ld	a5,0(a5)
ffffffe000203130:	00f707b3          	add	a5,a4,a5
}
ffffffe000203134:	00078513          	mv	a0,a5
ffffffe000203138:	01813403          	ld	s0,24(sp)
ffffffe00020313c:	02010113          	addi	sp,sp,32
ffffffe000203140:	00008067          	ret

ffffffe000203144 <next_cluster>:

uint32_t next_cluster(uint64_t cluster) {
ffffffe000203144:	fc010113          	addi	sp,sp,-64
ffffffe000203148:	02113c23          	sd	ra,56(sp)
ffffffe00020314c:	02813823          	sd	s0,48(sp)
ffffffe000203150:	04010413          	addi	s0,sp,64
ffffffe000203154:	fca43423          	sd	a0,-56(s0)
    uint64_t fat_offset = cluster * 4;
ffffffe000203158:	fc843783          	ld	a5,-56(s0)
ffffffe00020315c:	00279793          	slli	a5,a5,0x2
ffffffe000203160:	fef43423          	sd	a5,-24(s0)
    uint64_t fat_sector = fat32_volume.first_fat_sec + fat_offset / VIRTIO_BLK_SECTOR_SIZE;
ffffffe000203164:	0000c797          	auipc	a5,0xc
ffffffe000203168:	09c78793          	addi	a5,a5,156 # ffffffe00020f200 <fat32_volume>
ffffffe00020316c:	0087b703          	ld	a4,8(a5)
ffffffe000203170:	fe843783          	ld	a5,-24(s0)
ffffffe000203174:	0097d793          	srli	a5,a5,0x9
ffffffe000203178:	00f707b3          	add	a5,a4,a5
ffffffe00020317c:	fef43023          	sd	a5,-32(s0)
    virtio_blk_read_sector(fat_sector, fat32_table_buf);
ffffffe000203180:	0000c597          	auipc	a1,0xc
ffffffe000203184:	2a058593          	addi	a1,a1,672 # ffffffe00020f420 <fat32_table_buf>
ffffffe000203188:	fe043503          	ld	a0,-32(s0)
ffffffe00020318c:	228010ef          	jal	ffffffe0002043b4 <virtio_blk_read_sector>
    int index_in_sector = fat_offset % (VIRTIO_BLK_SECTOR_SIZE / sizeof(uint32_t));
ffffffe000203190:	fe843783          	ld	a5,-24(s0)
ffffffe000203194:	0007879b          	sext.w	a5,a5
ffffffe000203198:	07f7f793          	andi	a5,a5,127
ffffffe00020319c:	fcf42e23          	sw	a5,-36(s0)
    return *(uint32_t*)(fat32_table_buf + index_in_sector);
ffffffe0002031a0:	fdc42703          	lw	a4,-36(s0)
ffffffe0002031a4:	0000c797          	auipc	a5,0xc
ffffffe0002031a8:	27c78793          	addi	a5,a5,636 # ffffffe00020f420 <fat32_table_buf>
ffffffe0002031ac:	00f707b3          	add	a5,a4,a5
ffffffe0002031b0:	0007a783          	lw	a5,0(a5)
}
ffffffe0002031b4:	00078513          	mv	a0,a5
ffffffe0002031b8:	03813083          	ld	ra,56(sp)
ffffffe0002031bc:	03013403          	ld	s0,48(sp)
ffffffe0002031c0:	04010113          	addi	sp,sp,64
ffffffe0002031c4:	00008067          	ret

ffffffe0002031c8 <fat32_init>:

void fat32_init(uint64_t lba, uint64_t size) {
ffffffe0002031c8:	fe010113          	addi	sp,sp,-32
ffffffe0002031cc:	00113c23          	sd	ra,24(sp)
ffffffe0002031d0:	00813823          	sd	s0,16(sp)
ffffffe0002031d4:	02010413          	addi	s0,sp,32
ffffffe0002031d8:	fea43423          	sd	a0,-24(s0)
ffffffe0002031dc:	feb43023          	sd	a1,-32(s0)
    virtio_blk_read_sector(lba, (void*)&fat32_header);
ffffffe0002031e0:	0000c597          	auipc	a1,0xc
ffffffe0002031e4:	e2058593          	addi	a1,a1,-480 # ffffffe00020f000 <fat32_header>
ffffffe0002031e8:	fe843503          	ld	a0,-24(s0)
ffffffe0002031ec:	1c8010ef          	jal	ffffffe0002043b4 <virtio_blk_read_sector>
    fat32_volume.first_fat_sec = 0/* to calculate */;
ffffffe0002031f0:	0000c797          	auipc	a5,0xc
ffffffe0002031f4:	01078793          	addi	a5,a5,16 # ffffffe00020f200 <fat32_volume>
ffffffe0002031f8:	0007b423          	sd	zero,8(a5)
    fat32_volume.sec_per_cluster = 0/* to calculate */;
ffffffe0002031fc:	0000c797          	auipc	a5,0xc
ffffffe000203200:	00478793          	addi	a5,a5,4 # ffffffe00020f200 <fat32_volume>
ffffffe000203204:	0007b823          	sd	zero,16(a5)
    fat32_volume.first_data_sec = 0/* to calculate */;
ffffffe000203208:	0000c797          	auipc	a5,0xc
ffffffe00020320c:	ff878793          	addi	a5,a5,-8 # ffffffe00020f200 <fat32_volume>
ffffffe000203210:	0007b023          	sd	zero,0(a5)
    fat32_volume.fat_sz = 0/* to calculate */;
ffffffe000203214:	0000c797          	auipc	a5,0xc
ffffffe000203218:	fec78793          	addi	a5,a5,-20 # ffffffe00020f200 <fat32_volume>
ffffffe00020321c:	0007bc23          	sd	zero,24(a5)
}
ffffffe000203220:	00000013          	nop
ffffffe000203224:	01813083          	ld	ra,24(sp)
ffffffe000203228:	01013403          	ld	s0,16(sp)
ffffffe00020322c:	02010113          	addi	sp,sp,32
ffffffe000203230:	00008067          	ret

ffffffe000203234 <is_fat32>:

int is_fat32(uint64_t lba) {
ffffffe000203234:	fe010113          	addi	sp,sp,-32
ffffffe000203238:	00113c23          	sd	ra,24(sp)
ffffffe00020323c:	00813823          	sd	s0,16(sp)
ffffffe000203240:	02010413          	addi	s0,sp,32
ffffffe000203244:	fea43423          	sd	a0,-24(s0)
    virtio_blk_read_sector(lba, (void*)&fat32_header);
ffffffe000203248:	0000c597          	auipc	a1,0xc
ffffffe00020324c:	db858593          	addi	a1,a1,-584 # ffffffe00020f000 <fat32_header>
ffffffe000203250:	fe843503          	ld	a0,-24(s0)
ffffffe000203254:	160010ef          	jal	ffffffe0002043b4 <virtio_blk_read_sector>
    if (fat32_header.boot_sector_signature != 0xaa55) {
ffffffe000203258:	0000c797          	auipc	a5,0xc
ffffffe00020325c:	da878793          	addi	a5,a5,-600 # ffffffe00020f000 <fat32_header>
ffffffe000203260:	1fe7d783          	lhu	a5,510(a5)
ffffffe000203264:	0007871b          	sext.w	a4,a5
ffffffe000203268:	0000b7b7          	lui	a5,0xb
ffffffe00020326c:	a5578793          	addi	a5,a5,-1451 # aa55 <PGSIZE+0x9a55>
ffffffe000203270:	00f70663          	beq	a4,a5,ffffffe00020327c <is_fat32+0x48>
        return 0;
ffffffe000203274:	00000793          	li	a5,0
ffffffe000203278:	0080006f          	j	ffffffe000203280 <is_fat32+0x4c>
    }
    return 1;
ffffffe00020327c:	00100793          	li	a5,1
}
ffffffe000203280:	00078513          	mv	a0,a5
ffffffe000203284:	01813083          	ld	ra,24(sp)
ffffffe000203288:	01013403          	ld	s0,16(sp)
ffffffe00020328c:	02010113          	addi	sp,sp,32
ffffffe000203290:	00008067          	ret

ffffffe000203294 <next_slash>:

int next_slash(const char* path) {  // util function to be used in fat32_open_file
ffffffe000203294:	fd010113          	addi	sp,sp,-48
ffffffe000203298:	02813423          	sd	s0,40(sp)
ffffffe00020329c:	03010413          	addi	s0,sp,48
ffffffe0002032a0:	fca43c23          	sd	a0,-40(s0)
    int i = 0;
ffffffe0002032a4:	fe042623          	sw	zero,-20(s0)
    while (path[i] != '\0' && path[i] != '/') {
ffffffe0002032a8:	0100006f          	j	ffffffe0002032b8 <next_slash+0x24>
        i++;
ffffffe0002032ac:	fec42783          	lw	a5,-20(s0)
ffffffe0002032b0:	0017879b          	addiw	a5,a5,1
ffffffe0002032b4:	fef42623          	sw	a5,-20(s0)
    while (path[i] != '\0' && path[i] != '/') {
ffffffe0002032b8:	fec42783          	lw	a5,-20(s0)
ffffffe0002032bc:	fd843703          	ld	a4,-40(s0)
ffffffe0002032c0:	00f707b3          	add	a5,a4,a5
ffffffe0002032c4:	0007c783          	lbu	a5,0(a5)
ffffffe0002032c8:	02078063          	beqz	a5,ffffffe0002032e8 <next_slash+0x54>
ffffffe0002032cc:	fec42783          	lw	a5,-20(s0)
ffffffe0002032d0:	fd843703          	ld	a4,-40(s0)
ffffffe0002032d4:	00f707b3          	add	a5,a4,a5
ffffffe0002032d8:	0007c783          	lbu	a5,0(a5)
ffffffe0002032dc:	00078713          	mv	a4,a5
ffffffe0002032e0:	02f00793          	li	a5,47
ffffffe0002032e4:	fcf714e3          	bne	a4,a5,ffffffe0002032ac <next_slash+0x18>
    }
    if (path[i] == '\0') {
ffffffe0002032e8:	fec42783          	lw	a5,-20(s0)
ffffffe0002032ec:	fd843703          	ld	a4,-40(s0)
ffffffe0002032f0:	00f707b3          	add	a5,a4,a5
ffffffe0002032f4:	0007c783          	lbu	a5,0(a5)
ffffffe0002032f8:	00079663          	bnez	a5,ffffffe000203304 <next_slash+0x70>
        return -1;
ffffffe0002032fc:	fff00793          	li	a5,-1
ffffffe000203300:	0080006f          	j	ffffffe000203308 <next_slash+0x74>
    }
    return i;
ffffffe000203304:	fec42783          	lw	a5,-20(s0)
}
ffffffe000203308:	00078513          	mv	a0,a5
ffffffe00020330c:	02813403          	ld	s0,40(sp)
ffffffe000203310:	03010113          	addi	sp,sp,48
ffffffe000203314:	00008067          	ret

ffffffe000203318 <to_upper_case>:

void to_upper_case(char *str) {     // util function to be used in fat32_open_file
ffffffe000203318:	fd010113          	addi	sp,sp,-48
ffffffe00020331c:	02813423          	sd	s0,40(sp)
ffffffe000203320:	03010413          	addi	s0,sp,48
ffffffe000203324:	fca43c23          	sd	a0,-40(s0)
    for (int i = 0; str[i] != '\0'; i++) {
ffffffe000203328:	fe042623          	sw	zero,-20(s0)
ffffffe00020332c:	0700006f          	j	ffffffe00020339c <to_upper_case+0x84>
        if (str[i] >= 'a' && str[i] <= 'z') {
ffffffe000203330:	fec42783          	lw	a5,-20(s0)
ffffffe000203334:	fd843703          	ld	a4,-40(s0)
ffffffe000203338:	00f707b3          	add	a5,a4,a5
ffffffe00020333c:	0007c783          	lbu	a5,0(a5)
ffffffe000203340:	00078713          	mv	a4,a5
ffffffe000203344:	06000793          	li	a5,96
ffffffe000203348:	04e7f463          	bgeu	a5,a4,ffffffe000203390 <to_upper_case+0x78>
ffffffe00020334c:	fec42783          	lw	a5,-20(s0)
ffffffe000203350:	fd843703          	ld	a4,-40(s0)
ffffffe000203354:	00f707b3          	add	a5,a4,a5
ffffffe000203358:	0007c783          	lbu	a5,0(a5)
ffffffe00020335c:	00078713          	mv	a4,a5
ffffffe000203360:	07a00793          	li	a5,122
ffffffe000203364:	02e7e663          	bltu	a5,a4,ffffffe000203390 <to_upper_case+0x78>
            str[i] -= 32;
ffffffe000203368:	fec42783          	lw	a5,-20(s0)
ffffffe00020336c:	fd843703          	ld	a4,-40(s0)
ffffffe000203370:	00f707b3          	add	a5,a4,a5
ffffffe000203374:	0007c703          	lbu	a4,0(a5)
ffffffe000203378:	fec42783          	lw	a5,-20(s0)
ffffffe00020337c:	fd843683          	ld	a3,-40(s0)
ffffffe000203380:	00f687b3          	add	a5,a3,a5
ffffffe000203384:	fe07071b          	addiw	a4,a4,-32
ffffffe000203388:	0ff77713          	zext.b	a4,a4
ffffffe00020338c:	00e78023          	sb	a4,0(a5)
    for (int i = 0; str[i] != '\0'; i++) {
ffffffe000203390:	fec42783          	lw	a5,-20(s0)
ffffffe000203394:	0017879b          	addiw	a5,a5,1
ffffffe000203398:	fef42623          	sw	a5,-20(s0)
ffffffe00020339c:	fec42783          	lw	a5,-20(s0)
ffffffe0002033a0:	fd843703          	ld	a4,-40(s0)
ffffffe0002033a4:	00f707b3          	add	a5,a4,a5
ffffffe0002033a8:	0007c783          	lbu	a5,0(a5)
ffffffe0002033ac:	f80792e3          	bnez	a5,ffffffe000203330 <to_upper_case+0x18>
        }
    }
}
ffffffe0002033b0:	00000013          	nop
ffffffe0002033b4:	00000013          	nop
ffffffe0002033b8:	02813403          	ld	s0,40(sp)
ffffffe0002033bc:	03010113          	addi	sp,sp,48
ffffffe0002033c0:	00008067          	ret

ffffffe0002033c4 <fat32_open_file>:

struct fat32_file fat32_open_file(const char *path) {
ffffffe0002033c4:	fc010113          	addi	sp,sp,-64
ffffffe0002033c8:	02813c23          	sd	s0,56(sp)
ffffffe0002033cc:	04010413          	addi	s0,sp,64
ffffffe0002033d0:	fca43423          	sd	a0,-56(s0)
    struct fat32_file file;
    /* todo: open the file according to path */
    return file;
ffffffe0002033d4:	fd043783          	ld	a5,-48(s0)
ffffffe0002033d8:	fef43023          	sd	a5,-32(s0)
ffffffe0002033dc:	fd842783          	lw	a5,-40(s0)
ffffffe0002033e0:	fef42423          	sw	a5,-24(s0)
ffffffe0002033e4:	00000793          	li	a5,0
ffffffe0002033e8:	fe046583          	lwu	a1,-32(s0)
ffffffe0002033ec:	fff00713          	li	a4,-1
ffffffe0002033f0:	02075713          	srli	a4,a4,0x20
ffffffe0002033f4:	00e5f733          	and	a4,a1,a4
ffffffe0002033f8:	fff00593          	li	a1,-1
ffffffe0002033fc:	02059593          	slli	a1,a1,0x20
ffffffe000203400:	00b7f7b3          	and	a5,a5,a1
ffffffe000203404:	00e7e7b3          	or	a5,a5,a4
ffffffe000203408:	fe446703          	lwu	a4,-28(s0)
ffffffe00020340c:	02071713          	slli	a4,a4,0x20
ffffffe000203410:	fff00593          	li	a1,-1
ffffffe000203414:	0205d593          	srli	a1,a1,0x20
ffffffe000203418:	00b7f7b3          	and	a5,a5,a1
ffffffe00020341c:	00e7e7b3          	or	a5,a5,a4
ffffffe000203420:	00000713          	li	a4,0
ffffffe000203424:	fe846503          	lwu	a0,-24(s0)
ffffffe000203428:	fff00593          	li	a1,-1
ffffffe00020342c:	0205d593          	srli	a1,a1,0x20
ffffffe000203430:	00b575b3          	and	a1,a0,a1
ffffffe000203434:	fff00513          	li	a0,-1
ffffffe000203438:	02051513          	slli	a0,a0,0x20
ffffffe00020343c:	00a77733          	and	a4,a4,a0
ffffffe000203440:	00b76733          	or	a4,a4,a1
ffffffe000203444:	00078613          	mv	a2,a5
ffffffe000203448:	00070693          	mv	a3,a4
ffffffe00020344c:	00060713          	mv	a4,a2
ffffffe000203450:	00068793          	mv	a5,a3
}
ffffffe000203454:	00070513          	mv	a0,a4
ffffffe000203458:	00078593          	mv	a1,a5
ffffffe00020345c:	03813403          	ld	s0,56(sp)
ffffffe000203460:	04010113          	addi	sp,sp,64
ffffffe000203464:	00008067          	ret

ffffffe000203468 <fat32_lseek>:

int64_t fat32_lseek(struct file* file, int64_t offset, uint64_t whence) {
ffffffe000203468:	fd010113          	addi	sp,sp,-48
ffffffe00020346c:	02113423          	sd	ra,40(sp)
ffffffe000203470:	02813023          	sd	s0,32(sp)
ffffffe000203474:	03010413          	addi	s0,sp,48
ffffffe000203478:	fea43423          	sd	a0,-24(s0)
ffffffe00020347c:	feb43023          	sd	a1,-32(s0)
ffffffe000203480:	fcc43c23          	sd	a2,-40(s0)
    if (whence == SEEK_SET) {
ffffffe000203484:	fd843783          	ld	a5,-40(s0)
ffffffe000203488:	00079863          	bnez	a5,ffffffe000203498 <fat32_lseek+0x30>
        file->cfo = 0/* to calculate */;
ffffffe00020348c:	fe843783          	ld	a5,-24(s0)
ffffffe000203490:	0007b423          	sd	zero,8(a5)
ffffffe000203494:	0480006f          	j	ffffffe0002034dc <fat32_lseek+0x74>
    } else if (whence == SEEK_CUR) {
ffffffe000203498:	fd843703          	ld	a4,-40(s0)
ffffffe00020349c:	00100793          	li	a5,1
ffffffe0002034a0:	00f71863          	bne	a4,a5,ffffffe0002034b0 <fat32_lseek+0x48>
        file->cfo = 0/* to calculate */;
ffffffe0002034a4:	fe843783          	ld	a5,-24(s0)
ffffffe0002034a8:	0007b423          	sd	zero,8(a5)
ffffffe0002034ac:	0300006f          	j	ffffffe0002034dc <fat32_lseek+0x74>
    } else if (whence == SEEK_END) {
ffffffe0002034b0:	fd843703          	ld	a4,-40(s0)
ffffffe0002034b4:	00200793          	li	a5,2
ffffffe0002034b8:	00f71863          	bne	a4,a5,ffffffe0002034c8 <fat32_lseek+0x60>
        /* Calculate file length */
        file->cfo = 0/* to calculate */;
ffffffe0002034bc:	fe843783          	ld	a5,-24(s0)
ffffffe0002034c0:	0007b423          	sd	zero,8(a5)
ffffffe0002034c4:	0180006f          	j	ffffffe0002034dc <fat32_lseek+0x74>
    } else {
        printk("fat32_lseek: whence not implemented\n");
ffffffe0002034c8:	00002517          	auipc	a0,0x2
ffffffe0002034cc:	e4850513          	addi	a0,a0,-440 # ffffffe000205310 <lowerxdigits.0+0x20>
ffffffe0002034d0:	a9dff0ef          	jal	ffffffe000202f6c <printk>
        while (1);
ffffffe0002034d4:	00000013          	nop
ffffffe0002034d8:	ffdff06f          	j	ffffffe0002034d4 <fat32_lseek+0x6c>
    }
    return file->cfo;
ffffffe0002034dc:	fe843783          	ld	a5,-24(s0)
ffffffe0002034e0:	0087b783          	ld	a5,8(a5)
}
ffffffe0002034e4:	00078513          	mv	a0,a5
ffffffe0002034e8:	02813083          	ld	ra,40(sp)
ffffffe0002034ec:	02013403          	ld	s0,32(sp)
ffffffe0002034f0:	03010113          	addi	sp,sp,48
ffffffe0002034f4:	00008067          	ret

ffffffe0002034f8 <fat32_table_sector_of_cluster>:

uint64_t fat32_table_sector_of_cluster(uint32_t cluster) {
ffffffe0002034f8:	fe010113          	addi	sp,sp,-32
ffffffe0002034fc:	00813c23          	sd	s0,24(sp)
ffffffe000203500:	02010413          	addi	s0,sp,32
ffffffe000203504:	00050793          	mv	a5,a0
ffffffe000203508:	fef42623          	sw	a5,-20(s0)
    return fat32_volume.first_fat_sec + cluster / (VIRTIO_BLK_SECTOR_SIZE / sizeof(uint32_t));
ffffffe00020350c:	0000c797          	auipc	a5,0xc
ffffffe000203510:	cf478793          	addi	a5,a5,-780 # ffffffe00020f200 <fat32_volume>
ffffffe000203514:	0087b703          	ld	a4,8(a5)
ffffffe000203518:	fec42783          	lw	a5,-20(s0)
ffffffe00020351c:	0077d79b          	srliw	a5,a5,0x7
ffffffe000203520:	0007879b          	sext.w	a5,a5
ffffffe000203524:	02079793          	slli	a5,a5,0x20
ffffffe000203528:	0207d793          	srli	a5,a5,0x20
ffffffe00020352c:	00f707b3          	add	a5,a4,a5
}
ffffffe000203530:	00078513          	mv	a0,a5
ffffffe000203534:	01813403          	ld	s0,24(sp)
ffffffe000203538:	02010113          	addi	sp,sp,32
ffffffe00020353c:	00008067          	ret

ffffffe000203540 <fat32_read>:

int64_t fat32_read(struct file* file, void* buf, uint64_t len) {
ffffffe000203540:	fd010113          	addi	sp,sp,-48
ffffffe000203544:	02813423          	sd	s0,40(sp)
ffffffe000203548:	03010413          	addi	s0,sp,48
ffffffe00020354c:	fea43423          	sd	a0,-24(s0)
ffffffe000203550:	feb43023          	sd	a1,-32(s0)
ffffffe000203554:	fcc43c23          	sd	a2,-40(s0)
    /* todo: read content to buf, and return read length */
    return 0;
ffffffe000203558:	00000793          	li	a5,0
}
ffffffe00020355c:	00078513          	mv	a0,a5
ffffffe000203560:	02813403          	ld	s0,40(sp)
ffffffe000203564:	03010113          	addi	sp,sp,48
ffffffe000203568:	00008067          	ret

ffffffe00020356c <fat32_write>:

int64_t fat32_write(struct file* file, const void* buf, uint64_t len) {
ffffffe00020356c:	fd010113          	addi	sp,sp,-48
ffffffe000203570:	02813423          	sd	s0,40(sp)
ffffffe000203574:	03010413          	addi	s0,sp,48
ffffffe000203578:	fea43423          	sd	a0,-24(s0)
ffffffe00020357c:	feb43023          	sd	a1,-32(s0)
ffffffe000203580:	fcc43c23          	sd	a2,-40(s0)
    /* todo: fat32_write */
    return 0;
ffffffe000203584:	00000793          	li	a5,0
ffffffe000203588:	00078513          	mv	a0,a5
ffffffe00020358c:	02813403          	ld	s0,40(sp)
ffffffe000203590:	03010113          	addi	sp,sp,48
ffffffe000203594:	00008067          	ret

ffffffe000203598 <file_init>:
#include "string.h"
#include "printk.h"
#include "fat32.h"
#include "syscall.h"

struct files_struct *file_init() {
ffffffe000203598:	fe010113          	addi	sp,sp,-32
ffffffe00020359c:	00113c23          	sd	ra,24(sp)
ffffffe0002035a0:	00813823          	sd	s0,16(sp)
ffffffe0002035a4:	02010413          	addi	s0,sp,32
    // todo: alloc pages for files_struct, and initialize stdin, stdout, stderr
    struct files_struct *ret = (struct files_struct *) alloc_page();  
ffffffe0002035a8:	b94fd0ef          	jal	ffffffe00020093c <alloc_page>
ffffffe0002035ac:	fea43023          	sd	a0,-32(s0)
    memset(ret, 0, sizeof(struct files_struct));  
ffffffe0002035b0:	000017b7          	lui	a5,0x1
ffffffe0002035b4:	88078613          	addi	a2,a5,-1920 # 880 <PGSIZE-0x780>
ffffffe0002035b8:	00000593          	li	a1,0
ffffffe0002035bc:	fe043503          	ld	a0,-32(s0)
ffffffe0002035c0:	acdff0ef          	jal	ffffffe00020308c <memset>

    ret->fd_array[0].opened = 1;
ffffffe0002035c4:	fe043783          	ld	a5,-32(s0)
ffffffe0002035c8:	00100713          	li	a4,1
ffffffe0002035cc:	00e7a023          	sw	a4,0(a5)
    ret->fd_array[0].perms = FILE_READABLE;  
ffffffe0002035d0:	fe043783          	ld	a5,-32(s0)
ffffffe0002035d4:	00100713          	li	a4,1
ffffffe0002035d8:	00e7a223          	sw	a4,4(a5)
    ret->fd_array[0].cfo = 0;
ffffffe0002035dc:	fe043783          	ld	a5,-32(s0)
ffffffe0002035e0:	0007b423          	sd	zero,8(a5)
    ret->fd_array[0].lseek = NULL;  
ffffffe0002035e4:	fe043783          	ld	a5,-32(s0)
ffffffe0002035e8:	0207b023          	sd	zero,32(a5)
    ret->fd_array[0].read = stdin_read;  
ffffffe0002035ec:	fe043783          	ld	a5,-32(s0)
ffffffe0002035f0:	00000717          	auipc	a4,0x0
ffffffe0002035f4:	43070713          	addi	a4,a4,1072 # ffffffe000203a20 <stdin_read>
ffffffe0002035f8:	02e7b823          	sd	a4,48(a5)
    ret->fd_array[0].write = NULL;  
ffffffe0002035fc:	fe043783          	ld	a5,-32(s0)
ffffffe000203600:	0207b423          	sd	zero,40(a5)

    ret->fd_array[1].opened = 1;
ffffffe000203604:	fe043783          	ld	a5,-32(s0)
ffffffe000203608:	00100713          	li	a4,1
ffffffe00020360c:	08e7a423          	sw	a4,136(a5)
    ret->fd_array[1].perms = FILE_WRITABLE;  
ffffffe000203610:	fe043783          	ld	a5,-32(s0)
ffffffe000203614:	00200713          	li	a4,2
ffffffe000203618:	08e7a623          	sw	a4,140(a5)
    ret->fd_array[1].cfo = 0;
ffffffe00020361c:	fe043783          	ld	a5,-32(s0)
ffffffe000203620:	0807b823          	sd	zero,144(a5)
    ret->fd_array[1].lseek = NULL; 
ffffffe000203624:	fe043783          	ld	a5,-32(s0)
ffffffe000203628:	0a07b423          	sd	zero,168(a5)
    ret->fd_array[1].read = NULL;  
ffffffe00020362c:	fe043783          	ld	a5,-32(s0)
ffffffe000203630:	0a07bc23          	sd	zero,184(a5)
    ret->fd_array[1].write = stdout_write;  
ffffffe000203634:	fe043783          	ld	a5,-32(s0)
ffffffe000203638:	00000717          	auipc	a4,0x0
ffffffe00020363c:	46470713          	addi	a4,a4,1124 # ffffffe000203a9c <stdout_write>
ffffffe000203640:	0ae7b823          	sd	a4,176(a5)

    ret->fd_array[2].opened = 1;
ffffffe000203644:	fe043783          	ld	a5,-32(s0)
ffffffe000203648:	00100713          	li	a4,1
ffffffe00020364c:	10e7a823          	sw	a4,272(a5)
    ret->fd_array[2].perms = FILE_WRITABLE;  
ffffffe000203650:	fe043783          	ld	a5,-32(s0)
ffffffe000203654:	00200713          	li	a4,2
ffffffe000203658:	10e7aa23          	sw	a4,276(a5)
    ret->fd_array[2].cfo = 0;
ffffffe00020365c:	fe043783          	ld	a5,-32(s0)
ffffffe000203660:	1007bc23          	sd	zero,280(a5)
    ret->fd_array[2].lseek = NULL;  
ffffffe000203664:	fe043783          	ld	a5,-32(s0)
ffffffe000203668:	1207b823          	sd	zero,304(a5)
    ret->fd_array[2].read = NULL; 
ffffffe00020366c:	fe043783          	ld	a5,-32(s0)
ffffffe000203670:	1407b023          	sd	zero,320(a5)
    ret->fd_array[2].write = stderr_write;  
ffffffe000203674:	fe043783          	ld	a5,-32(s0)
ffffffe000203678:	00000717          	auipc	a4,0x0
ffffffe00020367c:	52870713          	addi	a4,a4,1320 # ffffffe000203ba0 <stderr_write>
ffffffe000203680:	12e7bc23          	sd	a4,312(a5)

    for (int i = 3; i < MAX_FILE_NUMBER; i++) {
ffffffe000203684:	00300793          	li	a5,3
ffffffe000203688:	fef42623          	sw	a5,-20(s0)
ffffffe00020368c:	0300006f          	j	ffffffe0002036bc <file_init+0x124>
        ret->fd_array[i].opened = 0;  
ffffffe000203690:	fe043683          	ld	a3,-32(s0)
ffffffe000203694:	fec42703          	lw	a4,-20(s0)
ffffffe000203698:	00070793          	mv	a5,a4
ffffffe00020369c:	00479793          	slli	a5,a5,0x4
ffffffe0002036a0:	00e787b3          	add	a5,a5,a4
ffffffe0002036a4:	00379793          	slli	a5,a5,0x3
ffffffe0002036a8:	00f687b3          	add	a5,a3,a5
ffffffe0002036ac:	0007a023          	sw	zero,0(a5)
    for (int i = 3; i < MAX_FILE_NUMBER; i++) {
ffffffe0002036b0:	fec42783          	lw	a5,-20(s0)
ffffffe0002036b4:	0017879b          	addiw	a5,a5,1
ffffffe0002036b8:	fef42623          	sw	a5,-20(s0)
ffffffe0002036bc:	fec42783          	lw	a5,-20(s0)
ffffffe0002036c0:	0007871b          	sext.w	a4,a5
ffffffe0002036c4:	00f00793          	li	a5,15
ffffffe0002036c8:	fce7d4e3          	bge	a5,a4,ffffffe000203690 <file_init+0xf8>
    }

    return ret;
ffffffe0002036cc:	fe043783          	ld	a5,-32(s0)
}
ffffffe0002036d0:	00078513          	mv	a0,a5
ffffffe0002036d4:	01813083          	ld	ra,24(sp)
ffffffe0002036d8:	01013403          	ld	s0,16(sp)
ffffffe0002036dc:	02010113          	addi	sp,sp,32
ffffffe0002036e0:	00008067          	ret

ffffffe0002036e4 <get_fs_type>:

uint32_t get_fs_type(const char *filename) {
ffffffe0002036e4:	fd010113          	addi	sp,sp,-48
ffffffe0002036e8:	02813423          	sd	s0,40(sp)
ffffffe0002036ec:	03010413          	addi	s0,sp,48
ffffffe0002036f0:	fca43c23          	sd	a0,-40(s0)
    uint32_t ret;

    return ret;
ffffffe0002036f4:	fec42783          	lw	a5,-20(s0)
}
ffffffe0002036f8:	00078513          	mv	a0,a5
ffffffe0002036fc:	02813403          	ld	s0,40(sp)
ffffffe000203700:	03010113          	addi	sp,sp,48
ffffffe000203704:	00008067          	ret

ffffffe000203708 <file_open>:

int32_t file_open(struct file* file, const char* path, int flags) {
ffffffe000203708:	fc010113          	addi	sp,sp,-64
ffffffe00020370c:	02113c23          	sd	ra,56(sp)
ffffffe000203710:	02813823          	sd	s0,48(sp)
ffffffe000203714:	02913423          	sd	s1,40(sp)
ffffffe000203718:	04010413          	addi	s0,sp,64
ffffffe00020371c:	fca43c23          	sd	a0,-40(s0)
ffffffe000203720:	fcb43823          	sd	a1,-48(s0)
ffffffe000203724:	00060793          	mv	a5,a2
ffffffe000203728:	fcf42623          	sw	a5,-52(s0)
    file->opened = 1;
ffffffe00020372c:	fd843783          	ld	a5,-40(s0)
ffffffe000203730:	00100713          	li	a4,1
ffffffe000203734:	00e7a023          	sw	a4,0(a5)
    file->perms = flags;
ffffffe000203738:	fcc42703          	lw	a4,-52(s0)
ffffffe00020373c:	fd843783          	ld	a5,-40(s0)
ffffffe000203740:	00e7a223          	sw	a4,4(a5)
    file->cfo = 0;
ffffffe000203744:	fd843783          	ld	a5,-40(s0)
ffffffe000203748:	0007b423          	sd	zero,8(a5)
    file->fs_type = get_fs_type(path);
ffffffe00020374c:	fd043503          	ld	a0,-48(s0)
ffffffe000203750:	f95ff0ef          	jal	ffffffe0002036e4 <get_fs_type>
ffffffe000203754:	00050793          	mv	a5,a0
ffffffe000203758:	0007871b          	sext.w	a4,a5
ffffffe00020375c:	fd843783          	ld	a5,-40(s0)
ffffffe000203760:	00e7a823          	sw	a4,16(a5)
    //memcpy(file->path, path, strlen(path) + 1);

    if (file->fs_type == FS_TYPE_FAT32) {
ffffffe000203764:	fd843783          	ld	a5,-40(s0)
ffffffe000203768:	0107a783          	lw	a5,16(a5)
ffffffe00020376c:	00078713          	mv	a4,a5
ffffffe000203770:	00100793          	li	a5,1
ffffffe000203774:	04f71e63          	bne	a4,a5,ffffffe0002037d0 <file_open+0xc8>
        file->lseek = fat32_lseek;
ffffffe000203778:	fd843783          	ld	a5,-40(s0)
ffffffe00020377c:	00000717          	auipc	a4,0x0
ffffffe000203780:	cec70713          	addi	a4,a4,-788 # ffffffe000203468 <fat32_lseek>
ffffffe000203784:	02e7b023          	sd	a4,32(a5)
        file->write = fat32_write;
ffffffe000203788:	fd843783          	ld	a5,-40(s0)
ffffffe00020378c:	00000717          	auipc	a4,0x0
ffffffe000203790:	de070713          	addi	a4,a4,-544 # ffffffe00020356c <fat32_write>
ffffffe000203794:	02e7b423          	sd	a4,40(a5)
        file->read = fat32_read;
ffffffe000203798:	fd843783          	ld	a5,-40(s0)
ffffffe00020379c:	00000717          	auipc	a4,0x0
ffffffe0002037a0:	da470713          	addi	a4,a4,-604 # ffffffe000203540 <fat32_read>
ffffffe0002037a4:	02e7b823          	sd	a4,48(a5)
        file->fat32_file = fat32_open_file(path);
ffffffe0002037a8:	fd843483          	ld	s1,-40(s0)
ffffffe0002037ac:	fd043503          	ld	a0,-48(s0)
ffffffe0002037b0:	c15ff0ef          	jal	ffffffe0002033c4 <fat32_open_file>
ffffffe0002037b4:	00050713          	mv	a4,a0
ffffffe0002037b8:	00058793          	mv	a5,a1
ffffffe0002037bc:	00e4aa23          	sw	a4,20(s1)
ffffffe0002037c0:	02075693          	srli	a3,a4,0x20
ffffffe0002037c4:	00d4ac23          	sw	a3,24(s1)
ffffffe0002037c8:	00f4ae23          	sw	a5,28(s1)
        return -1;
    } else {
        printk("Unknown fs type: %s\n" ,path);
        return -1;
    }
ffffffe0002037cc:	0400006f          	j	ffffffe00020380c <file_open+0x104>
    } else if (file->fs_type == FS_TYPE_EXT2) {
ffffffe0002037d0:	fd843783          	ld	a5,-40(s0)
ffffffe0002037d4:	0107a783          	lw	a5,16(a5)
ffffffe0002037d8:	00078713          	mv	a4,a5
ffffffe0002037dc:	00200793          	li	a5,2
ffffffe0002037e0:	00f71c63          	bne	a4,a5,ffffffe0002037f8 <file_open+0xf0>
        printk("Unsupport ext2\n");
ffffffe0002037e4:	00002517          	auipc	a0,0x2
ffffffe0002037e8:	b5450513          	addi	a0,a0,-1196 # ffffffe000205338 <lowerxdigits.0+0x48>
ffffffe0002037ec:	f80ff0ef          	jal	ffffffe000202f6c <printk>
        return -1;
ffffffe0002037f0:	fff00793          	li	a5,-1
ffffffe0002037f4:	0180006f          	j	ffffffe00020380c <file_open+0x104>
        printk("Unknown fs type: %s\n" ,path);
ffffffe0002037f8:	fd043583          	ld	a1,-48(s0)
ffffffe0002037fc:	00002517          	auipc	a0,0x2
ffffffe000203800:	b4c50513          	addi	a0,a0,-1204 # ffffffe000205348 <lowerxdigits.0+0x58>
ffffffe000203804:	f68ff0ef          	jal	ffffffe000202f6c <printk>
        return -1;
ffffffe000203808:	fff00793          	li	a5,-1
ffffffe00020380c:	00078513          	mv	a0,a5
ffffffe000203810:	03813083          	ld	ra,56(sp)
ffffffe000203814:	03013403          	ld	s0,48(sp)
ffffffe000203818:	02813483          	ld	s1,40(sp)
ffffffe00020381c:	04010113          	addi	sp,sp,64
ffffffe000203820:	00008067          	ret

ffffffe000203824 <mbr_init>:
#include "fat32.h"

uint8_t mbr_buf[VIRTIO_BLK_SECTOR_SIZE];
struct partition_info partitions[MBR_MAX_PARTITIONS];

void mbr_init() {
ffffffe000203824:	fd010113          	addi	sp,sp,-48
ffffffe000203828:	02113423          	sd	ra,40(sp)
ffffffe00020382c:	02813023          	sd	s0,32(sp)
ffffffe000203830:	03010413          	addi	s0,sp,48
    virtio_blk_read_sector(0, mbr_buf);
ffffffe000203834:	0000c597          	auipc	a1,0xc
ffffffe000203838:	dec58593          	addi	a1,a1,-532 # ffffffe00020f620 <mbr_buf>
ffffffe00020383c:	00000513          	li	a0,0
ffffffe000203840:	375000ef          	jal	ffffffe0002043b4 <virtio_blk_read_sector>
    struct mbr_layout *mbr = (struct mbr_layout *)mbr_buf;
ffffffe000203844:	0000c797          	auipc	a5,0xc
ffffffe000203848:	ddc78793          	addi	a5,a5,-548 # ffffffe00020f620 <mbr_buf>
ffffffe00020384c:	fef43023          	sd	a5,-32(s0)
    for (int i = 0; i < 4; i++) {
ffffffe000203850:	fe042623          	sw	zero,-20(s0)
ffffffe000203854:	0d40006f          	j	ffffffe000203928 <mbr_init+0x104>
        if (mbr->partition_table[i].type == 0x83) {
ffffffe000203858:	fe043703          	ld	a4,-32(s0)
ffffffe00020385c:	fec42783          	lw	a5,-20(s0)
ffffffe000203860:	01b78793          	addi	a5,a5,27
ffffffe000203864:	00479793          	slli	a5,a5,0x4
ffffffe000203868:	00f707b3          	add	a5,a4,a5
ffffffe00020386c:	0127c783          	lbu	a5,18(a5)
ffffffe000203870:	00078713          	mv	a4,a5
ffffffe000203874:	08300793          	li	a5,131
ffffffe000203878:	0af71263          	bne	a4,a5,ffffffe00020391c <mbr_init+0xf8>
            uint32_t lba = mbr->partition_table[i].lba_first_sector;
ffffffe00020387c:	fe043703          	ld	a4,-32(s0)
ffffffe000203880:	fec42783          	lw	a5,-20(s0)
ffffffe000203884:	01b78793          	addi	a5,a5,27
ffffffe000203888:	00479793          	slli	a5,a5,0x4
ffffffe00020388c:	00f707b3          	add	a5,a4,a5
ffffffe000203890:	0167c703          	lbu	a4,22(a5)
ffffffe000203894:	0177c683          	lbu	a3,23(a5)
ffffffe000203898:	00869693          	slli	a3,a3,0x8
ffffffe00020389c:	00e6e733          	or	a4,a3,a4
ffffffe0002038a0:	0187c683          	lbu	a3,24(a5)
ffffffe0002038a4:	01069693          	slli	a3,a3,0x10
ffffffe0002038a8:	00e6e733          	or	a4,a3,a4
ffffffe0002038ac:	0197c783          	lbu	a5,25(a5)
ffffffe0002038b0:	01879793          	slli	a5,a5,0x18
ffffffe0002038b4:	00e7e7b3          	or	a5,a5,a4
ffffffe0002038b8:	fcf42e23          	sw	a5,-36(s0)
            partition_init(i + 1, lba, mbr->partition_table[i].sector_count);
ffffffe0002038bc:	fec42783          	lw	a5,-20(s0)
ffffffe0002038c0:	0017879b          	addiw	a5,a5,1
ffffffe0002038c4:	0007851b          	sext.w	a0,a5
ffffffe0002038c8:	fdc46583          	lwu	a1,-36(s0)
ffffffe0002038cc:	fe043703          	ld	a4,-32(s0)
ffffffe0002038d0:	fec42783          	lw	a5,-20(s0)
ffffffe0002038d4:	01b78793          	addi	a5,a5,27
ffffffe0002038d8:	00479793          	slli	a5,a5,0x4
ffffffe0002038dc:	00f707b3          	add	a5,a4,a5
ffffffe0002038e0:	01a7c703          	lbu	a4,26(a5)
ffffffe0002038e4:	01b7c683          	lbu	a3,27(a5)
ffffffe0002038e8:	00869693          	slli	a3,a3,0x8
ffffffe0002038ec:	00e6e733          	or	a4,a3,a4
ffffffe0002038f0:	01c7c683          	lbu	a3,28(a5)
ffffffe0002038f4:	01069693          	slli	a3,a3,0x10
ffffffe0002038f8:	00e6e733          	or	a4,a3,a4
ffffffe0002038fc:	01d7c783          	lbu	a5,29(a5)
ffffffe000203900:	01879793          	slli	a5,a5,0x18
ffffffe000203904:	00e7e7b3          	or	a5,a5,a4
ffffffe000203908:	0007879b          	sext.w	a5,a5
ffffffe00020390c:	02079793          	slli	a5,a5,0x20
ffffffe000203910:	0207d793          	srli	a5,a5,0x20
ffffffe000203914:	00078613          	mv	a2,a5
ffffffe000203918:	038000ef          	jal	ffffffe000203950 <partition_init>
    for (int i = 0; i < 4; i++) {
ffffffe00020391c:	fec42783          	lw	a5,-20(s0)
ffffffe000203920:	0017879b          	addiw	a5,a5,1
ffffffe000203924:	fef42623          	sw	a5,-20(s0)
ffffffe000203928:	fec42783          	lw	a5,-20(s0)
ffffffe00020392c:	0007871b          	sext.w	a4,a5
ffffffe000203930:	00300793          	li	a5,3
ffffffe000203934:	f2e7d2e3          	bge	a5,a4,ffffffe000203858 <mbr_init+0x34>
        }
    }
}
ffffffe000203938:	00000013          	nop
ffffffe00020393c:	00000013          	nop
ffffffe000203940:	02813083          	ld	ra,40(sp)
ffffffe000203944:	02013403          	ld	s0,32(sp)
ffffffe000203948:	03010113          	addi	sp,sp,48
ffffffe00020394c:	00008067          	ret

ffffffe000203950 <partition_init>:

void partition_init(int partion_number, uint64_t start_lba, uint64_t sector_count) {
ffffffe000203950:	fd010113          	addi	sp,sp,-48
ffffffe000203954:	02113423          	sd	ra,40(sp)
ffffffe000203958:	02813023          	sd	s0,32(sp)
ffffffe00020395c:	03010413          	addi	s0,sp,48
ffffffe000203960:	00050793          	mv	a5,a0
ffffffe000203964:	feb43023          	sd	a1,-32(s0)
ffffffe000203968:	fcc43c23          	sd	a2,-40(s0)
ffffffe00020396c:	fef42623          	sw	a5,-20(s0)
    if (is_fat32(start_lba)) {
ffffffe000203970:	fe043503          	ld	a0,-32(s0)
ffffffe000203974:	8c1ff0ef          	jal	ffffffe000203234 <is_fat32>
ffffffe000203978:	00050793          	mv	a5,a0
ffffffe00020397c:	02078263          	beqz	a5,ffffffe0002039a0 <partition_init+0x50>
        fat32_init(start_lba, sector_count);
ffffffe000203980:	fd843583          	ld	a1,-40(s0)
ffffffe000203984:	fe043503          	ld	a0,-32(s0)
ffffffe000203988:	841ff0ef          	jal	ffffffe0002031c8 <fat32_init>
        printk("...fat32 partition #%d init done!\n", partion_number);
ffffffe00020398c:	fec42783          	lw	a5,-20(s0)
ffffffe000203990:	00078593          	mv	a1,a5
ffffffe000203994:	00002517          	auipc	a0,0x2
ffffffe000203998:	9cc50513          	addi	a0,a0,-1588 # ffffffe000205360 <lowerxdigits.0+0x70>
ffffffe00020399c:	dd0ff0ef          	jal	ffffffe000202f6c <printk>
    }
}
ffffffe0002039a0:	00000013          	nop
ffffffe0002039a4:	02813083          	ld	ra,40(sp)
ffffffe0002039a8:	02013403          	ld	s0,32(sp)
ffffffe0002039ac:	03010113          	addi	sp,sp,48
ffffffe0002039b0:	00008067          	ret

ffffffe0002039b4 <uart_getchar>:
#include "vfs.h"
#include "sbi.h"
#include "defs.h"
#include "printk.h"

char uart_getchar() {
ffffffe0002039b4:	fd010113          	addi	sp,sp,-48
ffffffe0002039b8:	02113423          	sd	ra,40(sp)
ffffffe0002039bc:	02813023          	sd	s0,32(sp)
ffffffe0002039c0:	03010413          	addi	s0,sp,48
    char ret;
    while (1) {
        struct sbiret sbi_result = sbi_debug_console_read(1, ((uint64_t)&ret - PA2VA_OFFSET), 0);
ffffffe0002039c4:	fef40713          	addi	a4,s0,-17
ffffffe0002039c8:	04100793          	li	a5,65
ffffffe0002039cc:	01f79793          	slli	a5,a5,0x1f
ffffffe0002039d0:	00f707b3          	add	a5,a4,a5
ffffffe0002039d4:	00000613          	li	a2,0
ffffffe0002039d8:	00078593          	mv	a1,a5
ffffffe0002039dc:	00100513          	li	a0,1
ffffffe0002039e0:	c81fd0ef          	jal	ffffffe000201660 <sbi_debug_console_read>
ffffffe0002039e4:	00050713          	mv	a4,a0
ffffffe0002039e8:	00058793          	mv	a5,a1
ffffffe0002039ec:	fce43c23          	sd	a4,-40(s0)
ffffffe0002039f0:	fef43023          	sd	a5,-32(s0)
        if (sbi_result.error == 0 && sbi_result.value == 1) {
ffffffe0002039f4:	fd843783          	ld	a5,-40(s0)
ffffffe0002039f8:	fc0796e3          	bnez	a5,ffffffe0002039c4 <uart_getchar+0x10>
ffffffe0002039fc:	fe043703          	ld	a4,-32(s0)
ffffffe000203a00:	00100793          	li	a5,1
ffffffe000203a04:	fcf710e3          	bne	a4,a5,ffffffe0002039c4 <uart_getchar+0x10>
            break;
        }
    }
    return ret;
ffffffe000203a08:	fef44783          	lbu	a5,-17(s0)
}
ffffffe000203a0c:	00078513          	mv	a0,a5
ffffffe000203a10:	02813083          	ld	ra,40(sp)
ffffffe000203a14:	02013403          	ld	s0,32(sp)
ffffffe000203a18:	03010113          	addi	sp,sp,48
ffffffe000203a1c:	00008067          	ret

ffffffe000203a20 <stdin_read>:

int64_t stdin_read(struct file *file, void *buf, uint64_t len) {
ffffffe000203a20:	fb010113          	addi	sp,sp,-80
ffffffe000203a24:	04113423          	sd	ra,72(sp)
ffffffe000203a28:	04813023          	sd	s0,64(sp)
ffffffe000203a2c:	05010413          	addi	s0,sp,80
ffffffe000203a30:	fca43423          	sd	a0,-56(s0)
ffffffe000203a34:	fcb43023          	sd	a1,-64(s0)
ffffffe000203a38:	fac43c23          	sd	a2,-72(s0)
    // todo: use uart_getchar() to get `len` chars
    char *buffer = (char *)buf;
ffffffe000203a3c:	fc043783          	ld	a5,-64(s0)
ffffffe000203a40:	fef43023          	sd	a5,-32(s0)
    int64_t i = 0;
ffffffe000203a44:	fe043423          	sd	zero,-24(s0)
    while (i < len) {
ffffffe000203a48:	0300006f          	j	ffffffe000203a78 <stdin_read+0x58>
        char c = uart_getchar();
ffffffe000203a4c:	f69ff0ef          	jal	ffffffe0002039b4 <uart_getchar>
ffffffe000203a50:	00050793          	mv	a5,a0
ffffffe000203a54:	fcf40fa3          	sb	a5,-33(s0)
        buffer[i] = c;
ffffffe000203a58:	fe843783          	ld	a5,-24(s0)
ffffffe000203a5c:	fe043703          	ld	a4,-32(s0)
ffffffe000203a60:	00f707b3          	add	a5,a4,a5
ffffffe000203a64:	fdf44703          	lbu	a4,-33(s0)
ffffffe000203a68:	00e78023          	sb	a4,0(a5)
        i++;
ffffffe000203a6c:	fe843783          	ld	a5,-24(s0)
ffffffe000203a70:	00178793          	addi	a5,a5,1
ffffffe000203a74:	fef43423          	sd	a5,-24(s0)
    while (i < len) {
ffffffe000203a78:	fe843783          	ld	a5,-24(s0)
ffffffe000203a7c:	fb843703          	ld	a4,-72(s0)
ffffffe000203a80:	fce7e6e3          	bltu	a5,a4,ffffffe000203a4c <stdin_read+0x2c>
    }
    return i;
ffffffe000203a84:	fe843783          	ld	a5,-24(s0)
}
ffffffe000203a88:	00078513          	mv	a0,a5
ffffffe000203a8c:	04813083          	ld	ra,72(sp)
ffffffe000203a90:	04013403          	ld	s0,64(sp)
ffffffe000203a94:	05010113          	addi	sp,sp,80
ffffffe000203a98:	00008067          	ret

ffffffe000203a9c <stdout_write>:

int64_t stdout_write(struct file *file, const void *buf, uint64_t len) {
ffffffe000203a9c:	fa010113          	addi	sp,sp,-96
ffffffe000203aa0:	04113c23          	sd	ra,88(sp)
ffffffe000203aa4:	04813823          	sd	s0,80(sp)
ffffffe000203aa8:	04913423          	sd	s1,72(sp)
ffffffe000203aac:	06010413          	addi	s0,sp,96
ffffffe000203ab0:	faa43c23          	sd	a0,-72(s0)
ffffffe000203ab4:	fab43823          	sd	a1,-80(s0)
ffffffe000203ab8:	fac43423          	sd	a2,-88(s0)
ffffffe000203abc:	00010693          	mv	a3,sp
ffffffe000203ac0:	00068493          	mv	s1,a3
    char to_print[len + 1];
ffffffe000203ac4:	fa843683          	ld	a3,-88(s0)
ffffffe000203ac8:	00168693          	addi	a3,a3,1
ffffffe000203acc:	00068613          	mv	a2,a3
ffffffe000203ad0:	fff60613          	addi	a2,a2,-1
ffffffe000203ad4:	fcc43823          	sd	a2,-48(s0)
ffffffe000203ad8:	00068e13          	mv	t3,a3
ffffffe000203adc:	00000e93          	li	t4,0
ffffffe000203ae0:	03de5613          	srli	a2,t3,0x3d
ffffffe000203ae4:	003e9893          	slli	a7,t4,0x3
ffffffe000203ae8:	011668b3          	or	a7,a2,a7
ffffffe000203aec:	003e1813          	slli	a6,t3,0x3
ffffffe000203af0:	00068313          	mv	t1,a3
ffffffe000203af4:	00000393          	li	t2,0
ffffffe000203af8:	03d35613          	srli	a2,t1,0x3d
ffffffe000203afc:	00339793          	slli	a5,t2,0x3
ffffffe000203b00:	00f667b3          	or	a5,a2,a5
ffffffe000203b04:	00331713          	slli	a4,t1,0x3
ffffffe000203b08:	00f68793          	addi	a5,a3,15
ffffffe000203b0c:	0047d793          	srli	a5,a5,0x4
ffffffe000203b10:	00479793          	slli	a5,a5,0x4
ffffffe000203b14:	40f10133          	sub	sp,sp,a5
ffffffe000203b18:	00010793          	mv	a5,sp
ffffffe000203b1c:	00078793          	mv	a5,a5
ffffffe000203b20:	fcf43423          	sd	a5,-56(s0)
    for (int i = 0; i < len; i++) {
ffffffe000203b24:	fc042e23          	sw	zero,-36(s0)
ffffffe000203b28:	0300006f          	j	ffffffe000203b58 <stdout_write+0xbc>
        to_print[i] = ((const char *)buf)[i];
ffffffe000203b2c:	fdc42783          	lw	a5,-36(s0)
ffffffe000203b30:	fb043703          	ld	a4,-80(s0)
ffffffe000203b34:	00f707b3          	add	a5,a4,a5
ffffffe000203b38:	0007c703          	lbu	a4,0(a5)
ffffffe000203b3c:	fc843683          	ld	a3,-56(s0)
ffffffe000203b40:	fdc42783          	lw	a5,-36(s0)
ffffffe000203b44:	00f687b3          	add	a5,a3,a5
ffffffe000203b48:	00e78023          	sb	a4,0(a5)
    for (int i = 0; i < len; i++) {
ffffffe000203b4c:	fdc42783          	lw	a5,-36(s0)
ffffffe000203b50:	0017879b          	addiw	a5,a5,1
ffffffe000203b54:	fcf42e23          	sw	a5,-36(s0)
ffffffe000203b58:	fdc42783          	lw	a5,-36(s0)
ffffffe000203b5c:	fa843703          	ld	a4,-88(s0)
ffffffe000203b60:	fce7e6e3          	bltu	a5,a4,ffffffe000203b2c <stdout_write+0x90>
    }
    to_print[len] = 0;
ffffffe000203b64:	fc843703          	ld	a4,-56(s0)
ffffffe000203b68:	fa843783          	ld	a5,-88(s0)
ffffffe000203b6c:	00f707b3          	add	a5,a4,a5
ffffffe000203b70:	00078023          	sb	zero,0(a5)
    return printk(to_print);
ffffffe000203b74:	fc843503          	ld	a0,-56(s0)
ffffffe000203b78:	bf4ff0ef          	jal	ffffffe000202f6c <printk>
ffffffe000203b7c:	00050793          	mv	a5,a0
ffffffe000203b80:	00048113          	mv	sp,s1
}
ffffffe000203b84:	00078513          	mv	a0,a5
ffffffe000203b88:	fa040113          	addi	sp,s0,-96
ffffffe000203b8c:	05813083          	ld	ra,88(sp)
ffffffe000203b90:	05013403          	ld	s0,80(sp)
ffffffe000203b94:	04813483          	ld	s1,72(sp)
ffffffe000203b98:	06010113          	addi	sp,sp,96
ffffffe000203b9c:	00008067          	ret

ffffffe000203ba0 <stderr_write>:

int64_t stderr_write(struct file *file, const void *buf, uint64_t len) {
ffffffe000203ba0:	fa010113          	addi	sp,sp,-96
ffffffe000203ba4:	04113c23          	sd	ra,88(sp)
ffffffe000203ba8:	04813823          	sd	s0,80(sp)
ffffffe000203bac:	04913423          	sd	s1,72(sp)
ffffffe000203bb0:	06010413          	addi	s0,sp,96
ffffffe000203bb4:	faa43c23          	sd	a0,-72(s0)
ffffffe000203bb8:	fab43823          	sd	a1,-80(s0)
ffffffe000203bbc:	fac43423          	sd	a2,-88(s0)
ffffffe000203bc0:	00010693          	mv	a3,sp
ffffffe000203bc4:	00068493          	mv	s1,a3
    char to_print[len + 1];
ffffffe000203bc8:	fa843683          	ld	a3,-88(s0)
ffffffe000203bcc:	00168693          	addi	a3,a3,1
ffffffe000203bd0:	00068613          	mv	a2,a3
ffffffe000203bd4:	fff60613          	addi	a2,a2,-1
ffffffe000203bd8:	fcc43823          	sd	a2,-48(s0)
ffffffe000203bdc:	00068e13          	mv	t3,a3
ffffffe000203be0:	00000e93          	li	t4,0
ffffffe000203be4:	03de5613          	srli	a2,t3,0x3d
ffffffe000203be8:	003e9893          	slli	a7,t4,0x3
ffffffe000203bec:	011668b3          	or	a7,a2,a7
ffffffe000203bf0:	003e1813          	slli	a6,t3,0x3
ffffffe000203bf4:	00068313          	mv	t1,a3
ffffffe000203bf8:	00000393          	li	t2,0
ffffffe000203bfc:	03d35613          	srli	a2,t1,0x3d
ffffffe000203c00:	00339793          	slli	a5,t2,0x3
ffffffe000203c04:	00f667b3          	or	a5,a2,a5
ffffffe000203c08:	00331713          	slli	a4,t1,0x3
ffffffe000203c0c:	00f68793          	addi	a5,a3,15
ffffffe000203c10:	0047d793          	srli	a5,a5,0x4
ffffffe000203c14:	00479793          	slli	a5,a5,0x4
ffffffe000203c18:	40f10133          	sub	sp,sp,a5
ffffffe000203c1c:	00010793          	mv	a5,sp
ffffffe000203c20:	00078793          	mv	a5,a5
ffffffe000203c24:	fcf43423          	sd	a5,-56(s0)
    for (int i = 0; i < len; i++) {
ffffffe000203c28:	fc042e23          	sw	zero,-36(s0)
ffffffe000203c2c:	0300006f          	j	ffffffe000203c5c <stderr_write+0xbc>
        to_print[i] = ((const char *)buf)[i];
ffffffe000203c30:	fdc42783          	lw	a5,-36(s0)
ffffffe000203c34:	fb043703          	ld	a4,-80(s0)
ffffffe000203c38:	00f707b3          	add	a5,a4,a5
ffffffe000203c3c:	0007c703          	lbu	a4,0(a5)
ffffffe000203c40:	fc843683          	ld	a3,-56(s0)
ffffffe000203c44:	fdc42783          	lw	a5,-36(s0)
ffffffe000203c48:	00f687b3          	add	a5,a3,a5
ffffffe000203c4c:	00e78023          	sb	a4,0(a5)
    for (int i = 0; i < len; i++) {
ffffffe000203c50:	fdc42783          	lw	a5,-36(s0)
ffffffe000203c54:	0017879b          	addiw	a5,a5,1
ffffffe000203c58:	fcf42e23          	sw	a5,-36(s0)
ffffffe000203c5c:	fdc42783          	lw	a5,-36(s0)
ffffffe000203c60:	fa843703          	ld	a4,-88(s0)
ffffffe000203c64:	fce7e6e3          	bltu	a5,a4,ffffffe000203c30 <stderr_write+0x90>
    }
    to_print[len] = 0;
ffffffe000203c68:	fc843703          	ld	a4,-56(s0)
ffffffe000203c6c:	fa843783          	ld	a5,-88(s0)
ffffffe000203c70:	00f707b3          	add	a5,a4,a5
ffffffe000203c74:	00078023          	sb	zero,0(a5)
    return printk("\033[31m%s\033[0m",to_print);
ffffffe000203c78:	fc843583          	ld	a1,-56(s0)
ffffffe000203c7c:	00001517          	auipc	a0,0x1
ffffffe000203c80:	70c50513          	addi	a0,a0,1804 # ffffffe000205388 <lowerxdigits.0+0x98>
ffffffe000203c84:	ae8ff0ef          	jal	ffffffe000202f6c <printk>
ffffffe000203c88:	00050793          	mv	a5,a0
ffffffe000203c8c:	00048113          	mv	sp,s1
}
ffffffe000203c90:	00078513          	mv	a0,a5
ffffffe000203c94:	fa040113          	addi	sp,s0,-96
ffffffe000203c98:	05813083          	ld	ra,88(sp)
ffffffe000203c9c:	05013403          	ld	s0,80(sp)
ffffffe000203ca0:	04813483          	ld	s1,72(sp)
ffffffe000203ca4:	06010113          	addi	sp,sp,96
ffffffe000203ca8:	00008067          	ret

ffffffe000203cac <in32>:

void virtio_dev_init() {
    for (int i = 0; i < VIRTIO_COUNT; i++) {
        uint64_t addr = VIRTIO_START + i * VIRTIO_SIZE;
        virtio_dev_test(io_to_virt(addr));
    }
ffffffe000203cac:	fd010113          	addi	sp,sp,-48
ffffffe000203cb0:	02813423          	sd	s0,40(sp)
ffffffe000203cb4:	03010413          	addi	s0,sp,48
ffffffe000203cb8:	fca43c23          	sd	a0,-40(s0)

    if (virtio_blk_regs) {
ffffffe000203cbc:	fd843783          	ld	a5,-40(s0)
ffffffe000203cc0:	0007a783          	lw	a5,0(a5)
ffffffe000203cc4:	fef42623          	sw	a5,-20(s0)
        virtio_blk_init();
    }
ffffffe000203cc8:	fec42783          	lw	a5,-20(s0)
ffffffe000203ccc:	00078513          	mv	a0,a5
ffffffe000203cd0:	02813403          	ld	s0,40(sp)
ffffffe000203cd4:	03010113          	addi	sp,sp,48
ffffffe000203cd8:	00008067          	ret

ffffffe000203cdc <memory_barrier>:
ffffffe000203cdc:	ff010113          	addi	sp,sp,-16
ffffffe000203ce0:	00813423          	sd	s0,8(sp)
ffffffe000203ce4:	01010413          	addi	s0,sp,16
ffffffe000203ce8:	0330000f          	fence	rw,rw
ffffffe000203cec:	00000013          	nop
ffffffe000203cf0:	00813403          	ld	s0,8(sp)
ffffffe000203cf4:	01010113          	addi	sp,sp,16
ffffffe000203cf8:	00008067          	ret

ffffffe000203cfc <io_to_virt>:
ffffffe000203cfc:	fe010113          	addi	sp,sp,-32
ffffffe000203d00:	00813c23          	sd	s0,24(sp)
ffffffe000203d04:	02010413          	addi	s0,sp,32
ffffffe000203d08:	fea43423          	sd	a0,-24(s0)
ffffffe000203d0c:	fe843703          	ld	a4,-24(s0)
ffffffe000203d10:	ff900793          	li	a5,-7
ffffffe000203d14:	02379793          	slli	a5,a5,0x23
ffffffe000203d18:	00f707b3          	add	a5,a4,a5
ffffffe000203d1c:	00078513          	mv	a0,a5
ffffffe000203d20:	01813403          	ld	s0,24(sp)
ffffffe000203d24:	02010113          	addi	sp,sp,32
ffffffe000203d28:	00008067          	ret

ffffffe000203d2c <virtio_blk_driver_init>:
void virtio_blk_driver_init() {
ffffffe000203d2c:	ff010113          	addi	sp,sp,-16
ffffffe000203d30:	00113423          	sd	ra,8(sp)
ffffffe000203d34:	00813023          	sd	s0,0(sp)
ffffffe000203d38:	01010413          	addi	s0,sp,16
    virtio_blk_regs->Status = 0;
ffffffe000203d3c:	00008797          	auipc	a5,0x8
ffffffe000203d40:	2e478793          	addi	a5,a5,740 # ffffffe00020c020 <virtio_blk_regs>
ffffffe000203d44:	0007b783          	ld	a5,0(a5)
ffffffe000203d48:	0607a823          	sw	zero,112(a5)
    virtio_blk_regs->Status |= DEVICE_ACKNOWLEDGE;
ffffffe000203d4c:	00008797          	auipc	a5,0x8
ffffffe000203d50:	2d478793          	addi	a5,a5,724 # ffffffe00020c020 <virtio_blk_regs>
ffffffe000203d54:	0007b783          	ld	a5,0(a5)
ffffffe000203d58:	0707a783          	lw	a5,112(a5)
ffffffe000203d5c:	0007871b          	sext.w	a4,a5
ffffffe000203d60:	00008797          	auipc	a5,0x8
ffffffe000203d64:	2c078793          	addi	a5,a5,704 # ffffffe00020c020 <virtio_blk_regs>
ffffffe000203d68:	0007b783          	ld	a5,0(a5)
ffffffe000203d6c:	00176713          	ori	a4,a4,1
ffffffe000203d70:	0007071b          	sext.w	a4,a4
ffffffe000203d74:	06e7a823          	sw	a4,112(a5)
    virtio_blk_regs->Status |= DEVICE_DRIVER;
ffffffe000203d78:	00008797          	auipc	a5,0x8
ffffffe000203d7c:	2a878793          	addi	a5,a5,680 # ffffffe00020c020 <virtio_blk_regs>
ffffffe000203d80:	0007b783          	ld	a5,0(a5)
ffffffe000203d84:	0707a783          	lw	a5,112(a5)
ffffffe000203d88:	0007871b          	sext.w	a4,a5
ffffffe000203d8c:	00008797          	auipc	a5,0x8
ffffffe000203d90:	29478793          	addi	a5,a5,660 # ffffffe00020c020 <virtio_blk_regs>
ffffffe000203d94:	0007b783          	ld	a5,0(a5)
ffffffe000203d98:	00276713          	ori	a4,a4,2
ffffffe000203d9c:	0007071b          	sext.w	a4,a4
ffffffe000203da0:	06e7a823          	sw	a4,112(a5)
    memory_barrier();
ffffffe000203da4:	f39ff0ef          	jal	ffffffe000203cdc <memory_barrier>
}
ffffffe000203da8:	00000013          	nop
ffffffe000203dac:	00813083          	ld	ra,8(sp)
ffffffe000203db0:	00013403          	ld	s0,0(sp)
ffffffe000203db4:	01010113          	addi	sp,sp,16
ffffffe000203db8:	00008067          	ret

ffffffe000203dbc <virtio_blk_feature_init>:
void virtio_blk_feature_init() {
ffffffe000203dbc:	ff010113          	addi	sp,sp,-16
ffffffe000203dc0:	00113423          	sd	ra,8(sp)
ffffffe000203dc4:	00813023          	sd	s0,0(sp)
ffffffe000203dc8:	01010413          	addi	s0,sp,16
    virtio_blk_regs->DeviceFeaturesSel = 0;
ffffffe000203dcc:	00008797          	auipc	a5,0x8
ffffffe000203dd0:	25478793          	addi	a5,a5,596 # ffffffe00020c020 <virtio_blk_regs>
ffffffe000203dd4:	0007b783          	ld	a5,0(a5)
ffffffe000203dd8:	0007aa23          	sw	zero,20(a5)
    virtio_blk_regs->DeviceFeaturesSel = 1;
ffffffe000203ddc:	00008797          	auipc	a5,0x8
ffffffe000203de0:	24478793          	addi	a5,a5,580 # ffffffe00020c020 <virtio_blk_regs>
ffffffe000203de4:	0007b783          	ld	a5,0(a5)
ffffffe000203de8:	00100713          	li	a4,1
ffffffe000203dec:	00e7aa23          	sw	a4,20(a5)
    virtio_blk_regs->DriverFeaturesSel = 0;
ffffffe000203df0:	00008797          	auipc	a5,0x8
ffffffe000203df4:	23078793          	addi	a5,a5,560 # ffffffe00020c020 <virtio_blk_regs>
ffffffe000203df8:	0007b783          	ld	a5,0(a5)
ffffffe000203dfc:	0207a223          	sw	zero,36(a5)
    virtio_blk_regs->DriverFeatures = 0x30000200;
ffffffe000203e00:	00008797          	auipc	a5,0x8
ffffffe000203e04:	22078793          	addi	a5,a5,544 # ffffffe00020c020 <virtio_blk_regs>
ffffffe000203e08:	0007b783          	ld	a5,0(a5)
ffffffe000203e0c:	30000737          	lui	a4,0x30000
ffffffe000203e10:	20070713          	addi	a4,a4,512 # 30000200 <PHY_SIZE+0x28000200>
ffffffe000203e14:	02e7a023          	sw	a4,32(a5)
    virtio_blk_regs->DriverFeaturesSel = 1;
ffffffe000203e18:	00008797          	auipc	a5,0x8
ffffffe000203e1c:	20878793          	addi	a5,a5,520 # ffffffe00020c020 <virtio_blk_regs>
ffffffe000203e20:	0007b783          	ld	a5,0(a5)
ffffffe000203e24:	00100713          	li	a4,1
ffffffe000203e28:	02e7a223          	sw	a4,36(a5)
    virtio_blk_regs->DriverFeatures = 0x0;
ffffffe000203e2c:	00008797          	auipc	a5,0x8
ffffffe000203e30:	1f478793          	addi	a5,a5,500 # ffffffe00020c020 <virtio_blk_regs>
ffffffe000203e34:	0007b783          	ld	a5,0(a5)
ffffffe000203e38:	0207a023          	sw	zero,32(a5)
    virtio_blk_regs->Status |= DEVICE_FEATURES_OK;
ffffffe000203e3c:	00008797          	auipc	a5,0x8
ffffffe000203e40:	1e478793          	addi	a5,a5,484 # ffffffe00020c020 <virtio_blk_regs>
ffffffe000203e44:	0007b783          	ld	a5,0(a5)
ffffffe000203e48:	0707a783          	lw	a5,112(a5)
ffffffe000203e4c:	0007871b          	sext.w	a4,a5
ffffffe000203e50:	00008797          	auipc	a5,0x8
ffffffe000203e54:	1d078793          	addi	a5,a5,464 # ffffffe00020c020 <virtio_blk_regs>
ffffffe000203e58:	0007b783          	ld	a5,0(a5)
ffffffe000203e5c:	00876713          	ori	a4,a4,8
ffffffe000203e60:	0007071b          	sext.w	a4,a4
ffffffe000203e64:	06e7a823          	sw	a4,112(a5)
    memory_barrier();
ffffffe000203e68:	e75ff0ef          	jal	ffffffe000203cdc <memory_barrier>
}
ffffffe000203e6c:	00000013          	nop
ffffffe000203e70:	00813083          	ld	ra,8(sp)
ffffffe000203e74:	00013403          	ld	s0,0(sp)
ffffffe000203e78:	01010113          	addi	sp,sp,16
ffffffe000203e7c:	00008067          	ret

ffffffe000203e80 <virtio_blk_queue_init>:
void virtio_blk_queue_init() {
ffffffe000203e80:	fc010113          	addi	sp,sp,-64
ffffffe000203e84:	02113c23          	sd	ra,56(sp)
ffffffe000203e88:	02813823          	sd	s0,48(sp)
ffffffe000203e8c:	04010413          	addi	s0,sp,64
    virtio_blk_ring.num = VIRTIO_QUEUE_SIZE;
ffffffe000203e90:	0000c797          	auipc	a5,0xc
ffffffe000203e94:	9c078793          	addi	a5,a5,-1600 # ffffffe00020f850 <virtio_blk_ring>
ffffffe000203e98:	01000713          	li	a4,16
ffffffe000203e9c:	00e79023          	sh	a4,0(a5)
    uint64_t size_of_descs = VIRTIO_QUEUE_SIZE * sizeof(struct virtio_desc);
ffffffe000203ea0:	10000793          	li	a5,256
ffffffe000203ea4:	fef43023          	sd	a5,-32(s0)
    uint64_t size_of_avail = sizeof(struct virtio_avail);
ffffffe000203ea8:	02600793          	li	a5,38
ffffffe000203eac:	fcf43c23          	sd	a5,-40(s0)
    uint64_t size_of_used = sizeof(struct virtio_used);
ffffffe000203eb0:	08800793          	li	a5,136
ffffffe000203eb4:	fcf43823          	sd	a5,-48(s0)
    uint64_t pages = alloc_pages(3);
ffffffe000203eb8:	00300513          	li	a0,3
ffffffe000203ebc:	a29fc0ef          	jal	ffffffe0002008e4 <alloc_pages>
ffffffe000203ec0:	00050793          	mv	a5,a0
ffffffe000203ec4:	fcf43423          	sd	a5,-56(s0)
    virtio_blk_ring.desc = (struct virtio_desc*)(pages);
ffffffe000203ec8:	fc843703          	ld	a4,-56(s0)
ffffffe000203ecc:	0000c797          	auipc	a5,0xc
ffffffe000203ed0:	98478793          	addi	a5,a5,-1660 # ffffffe00020f850 <virtio_blk_ring>
ffffffe000203ed4:	00e7b423          	sd	a4,8(a5)
    virtio_blk_ring.avail = (struct virtio_avail*)(pages + PGSIZE);
ffffffe000203ed8:	fc843703          	ld	a4,-56(s0)
ffffffe000203edc:	000017b7          	lui	a5,0x1
ffffffe000203ee0:	00f707b3          	add	a5,a4,a5
ffffffe000203ee4:	00078713          	mv	a4,a5
ffffffe000203ee8:	0000c797          	auipc	a5,0xc
ffffffe000203eec:	96878793          	addi	a5,a5,-1688 # ffffffe00020f850 <virtio_blk_ring>
ffffffe000203ef0:	00e7b823          	sd	a4,16(a5)
    virtio_blk_ring.used = (struct virtio_used*)(pages + 2*PGSIZE);
ffffffe000203ef4:	fc843703          	ld	a4,-56(s0)
ffffffe000203ef8:	000027b7          	lui	a5,0x2
ffffffe000203efc:	00f707b3          	add	a5,a4,a5
ffffffe000203f00:	00078713          	mv	a4,a5
ffffffe000203f04:	0000c797          	auipc	a5,0xc
ffffffe000203f08:	94c78793          	addi	a5,a5,-1716 # ffffffe00020f850 <virtio_blk_ring>
ffffffe000203f0c:	00e7bc23          	sd	a4,24(a5)
    virtio_blk_ring.avail->flags = VIRTQ_AVAIL_F_NO_INTERRUPT;
ffffffe000203f10:	0000c797          	auipc	a5,0xc
ffffffe000203f14:	94078793          	addi	a5,a5,-1728 # ffffffe00020f850 <virtio_blk_ring>
ffffffe000203f18:	0107b783          	ld	a5,16(a5)
ffffffe000203f1c:	00100713          	li	a4,1
ffffffe000203f20:	00e79023          	sh	a4,0(a5)
    for (int i = 1; i < VIRTIO_QUEUE_SIZE; i++) {
ffffffe000203f24:	00100793          	li	a5,1
ffffffe000203f28:	fef42623          	sw	a5,-20(s0)
ffffffe000203f2c:	03c0006f          	j	ffffffe000203f68 <virtio_blk_queue_init+0xe8>
        virtio_blk_ring.desc[i - 1].next = i;
ffffffe000203f30:	0000c797          	auipc	a5,0xc
ffffffe000203f34:	92078793          	addi	a5,a5,-1760 # ffffffe00020f850 <virtio_blk_ring>
ffffffe000203f38:	0087b703          	ld	a4,8(a5)
ffffffe000203f3c:	fec42783          	lw	a5,-20(s0)
ffffffe000203f40:	00479793          	slli	a5,a5,0x4
ffffffe000203f44:	ff078793          	addi	a5,a5,-16
ffffffe000203f48:	00f707b3          	add	a5,a4,a5
ffffffe000203f4c:	fec42703          	lw	a4,-20(s0)
ffffffe000203f50:	03071713          	slli	a4,a4,0x30
ffffffe000203f54:	03075713          	srli	a4,a4,0x30
ffffffe000203f58:	00e79723          	sh	a4,14(a5)
    for (int i = 1; i < VIRTIO_QUEUE_SIZE; i++) {
ffffffe000203f5c:	fec42783          	lw	a5,-20(s0)
ffffffe000203f60:	0017879b          	addiw	a5,a5,1
ffffffe000203f64:	fef42623          	sw	a5,-20(s0)
ffffffe000203f68:	fec42783          	lw	a5,-20(s0)
ffffffe000203f6c:	0007871b          	sext.w	a4,a5
ffffffe000203f70:	00f00793          	li	a5,15
ffffffe000203f74:	fae7dee3          	bge	a5,a4,ffffffe000203f30 <virtio_blk_queue_init+0xb0>
    virtio_blk_regs->QueueSel = 0;
ffffffe000203f78:	00008797          	auipc	a5,0x8
ffffffe000203f7c:	0a878793          	addi	a5,a5,168 # ffffffe00020c020 <virtio_blk_regs>
ffffffe000203f80:	0007b783          	ld	a5,0(a5)
ffffffe000203f84:	0207a823          	sw	zero,48(a5)
    virtio_blk_regs->QueueNum = VIRTIO_QUEUE_SIZE;
ffffffe000203f88:	00008797          	auipc	a5,0x8
ffffffe000203f8c:	09878793          	addi	a5,a5,152 # ffffffe00020c020 <virtio_blk_regs>
ffffffe000203f90:	0007b783          	ld	a5,0(a5)
ffffffe000203f94:	01000713          	li	a4,16
ffffffe000203f98:	02e7ac23          	sw	a4,56(a5)
    virtio_blk_regs->QueueAvailLow = 0xffffffff & virt_to_phys((uint64_t)virtio_blk_ring.avail);
ffffffe000203f9c:	0000c797          	auipc	a5,0xc
ffffffe000203fa0:	8b478793          	addi	a5,a5,-1868 # ffffffe00020f850 <virtio_blk_ring>
ffffffe000203fa4:	0107b783          	ld	a5,16(a5)
ffffffe000203fa8:	0007869b          	sext.w	a3,a5
ffffffe000203fac:	00008797          	auipc	a5,0x8
ffffffe000203fb0:	07478793          	addi	a5,a5,116 # ffffffe00020c020 <virtio_blk_regs>
ffffffe000203fb4:	0007b783          	ld	a5,0(a5)
ffffffe000203fb8:	80000737          	lui	a4,0x80000
ffffffe000203fbc:	00e6873b          	addw	a4,a3,a4
ffffffe000203fc0:	0007071b          	sext.w	a4,a4
ffffffe000203fc4:	08e7a823          	sw	a4,144(a5)
    virtio_blk_regs->QueueAvailHigh = virt_to_phys((uint64_t)virtio_blk_ring.avail) >> 32;
ffffffe000203fc8:	0000c797          	auipc	a5,0xc
ffffffe000203fcc:	88878793          	addi	a5,a5,-1912 # ffffffe00020f850 <virtio_blk_ring>
ffffffe000203fd0:	0107b783          	ld	a5,16(a5)
ffffffe000203fd4:	00078713          	mv	a4,a5
ffffffe000203fd8:	04100793          	li	a5,65
ffffffe000203fdc:	01f79793          	slli	a5,a5,0x1f
ffffffe000203fe0:	00f707b3          	add	a5,a4,a5
ffffffe000203fe4:	0207d713          	srli	a4,a5,0x20
ffffffe000203fe8:	00008797          	auipc	a5,0x8
ffffffe000203fec:	03878793          	addi	a5,a5,56 # ffffffe00020c020 <virtio_blk_regs>
ffffffe000203ff0:	0007b783          	ld	a5,0(a5)
ffffffe000203ff4:	0007071b          	sext.w	a4,a4
ffffffe000203ff8:	08e7aa23          	sw	a4,148(a5)
    virtio_blk_regs->QueueDescLow = 0xffffffff & virt_to_phys((uint64_t)virtio_blk_ring.desc);
ffffffe000203ffc:	0000c797          	auipc	a5,0xc
ffffffe000204000:	85478793          	addi	a5,a5,-1964 # ffffffe00020f850 <virtio_blk_ring>
ffffffe000204004:	0087b783          	ld	a5,8(a5)
ffffffe000204008:	0007869b          	sext.w	a3,a5
ffffffe00020400c:	00008797          	auipc	a5,0x8
ffffffe000204010:	01478793          	addi	a5,a5,20 # ffffffe00020c020 <virtio_blk_regs>
ffffffe000204014:	0007b783          	ld	a5,0(a5)
ffffffe000204018:	80000737          	lui	a4,0x80000
ffffffe00020401c:	00e6873b          	addw	a4,a3,a4
ffffffe000204020:	0007071b          	sext.w	a4,a4
ffffffe000204024:	08e7a023          	sw	a4,128(a5)
    virtio_blk_regs->QueueDescHigh = virt_to_phys((uint64_t)virtio_blk_ring.desc) >> 32;
ffffffe000204028:	0000c797          	auipc	a5,0xc
ffffffe00020402c:	82878793          	addi	a5,a5,-2008 # ffffffe00020f850 <virtio_blk_ring>
ffffffe000204030:	0087b783          	ld	a5,8(a5)
ffffffe000204034:	00078713          	mv	a4,a5
ffffffe000204038:	04100793          	li	a5,65
ffffffe00020403c:	01f79793          	slli	a5,a5,0x1f
ffffffe000204040:	00f707b3          	add	a5,a4,a5
ffffffe000204044:	0207d713          	srli	a4,a5,0x20
ffffffe000204048:	00008797          	auipc	a5,0x8
ffffffe00020404c:	fd878793          	addi	a5,a5,-40 # ffffffe00020c020 <virtio_blk_regs>
ffffffe000204050:	0007b783          	ld	a5,0(a5)
ffffffe000204054:	0007071b          	sext.w	a4,a4
ffffffe000204058:	08e7a223          	sw	a4,132(a5)
    virtio_blk_regs->QueueUsedLow = 0xffffffff & virt_to_phys((uint64_t)virtio_blk_ring.used);
ffffffe00020405c:	0000b797          	auipc	a5,0xb
ffffffe000204060:	7f478793          	addi	a5,a5,2036 # ffffffe00020f850 <virtio_blk_ring>
ffffffe000204064:	0187b783          	ld	a5,24(a5)
ffffffe000204068:	0007869b          	sext.w	a3,a5
ffffffe00020406c:	00008797          	auipc	a5,0x8
ffffffe000204070:	fb478793          	addi	a5,a5,-76 # ffffffe00020c020 <virtio_blk_regs>
ffffffe000204074:	0007b783          	ld	a5,0(a5)
ffffffe000204078:	80000737          	lui	a4,0x80000
ffffffe00020407c:	00e6873b          	addw	a4,a3,a4
ffffffe000204080:	0007071b          	sext.w	a4,a4
ffffffe000204084:	0ae7a023          	sw	a4,160(a5)
    virtio_blk_regs->QueueUsedHigh = virt_to_phys((uint64_t)virtio_blk_ring.used) >> 32;
ffffffe000204088:	0000b797          	auipc	a5,0xb
ffffffe00020408c:	7c878793          	addi	a5,a5,1992 # ffffffe00020f850 <virtio_blk_ring>
ffffffe000204090:	0187b783          	ld	a5,24(a5)
ffffffe000204094:	00078713          	mv	a4,a5
ffffffe000204098:	04100793          	li	a5,65
ffffffe00020409c:	01f79793          	slli	a5,a5,0x1f
ffffffe0002040a0:	00f707b3          	add	a5,a4,a5
ffffffe0002040a4:	0207d713          	srli	a4,a5,0x20
ffffffe0002040a8:	00008797          	auipc	a5,0x8
ffffffe0002040ac:	f7878793          	addi	a5,a5,-136 # ffffffe00020c020 <virtio_blk_regs>
ffffffe0002040b0:	0007b783          	ld	a5,0(a5)
ffffffe0002040b4:	0007071b          	sext.w	a4,a4
ffffffe0002040b8:	0ae7a223          	sw	a4,164(a5)
    memory_barrier();
ffffffe0002040bc:	c21ff0ef          	jal	ffffffe000203cdc <memory_barrier>
    virtio_blk_regs->QueueReady = 1;
ffffffe0002040c0:	00008797          	auipc	a5,0x8
ffffffe0002040c4:	f6078793          	addi	a5,a5,-160 # ffffffe00020c020 <virtio_blk_regs>
ffffffe0002040c8:	0007b783          	ld	a5,0(a5)
ffffffe0002040cc:	00100713          	li	a4,1
ffffffe0002040d0:	04e7a223          	sw	a4,68(a5)
    memory_barrier();
ffffffe0002040d4:	c09ff0ef          	jal	ffffffe000203cdc <memory_barrier>
}
ffffffe0002040d8:	00000013          	nop
ffffffe0002040dc:	03813083          	ld	ra,56(sp)
ffffffe0002040e0:	03013403          	ld	s0,48(sp)
ffffffe0002040e4:	04010113          	addi	sp,sp,64
ffffffe0002040e8:	00008067          	ret

ffffffe0002040ec <virtio_blk_config_init>:
void virtio_blk_config_init() {
ffffffe0002040ec:	fe010113          	addi	sp,sp,-32
ffffffe0002040f0:	00813c23          	sd	s0,24(sp)
ffffffe0002040f4:	02010413          	addi	s0,sp,32
    volatile struct virtio_blk_config *config = (struct virtio_blk_config*)(&virtio_blk_regs->Config);
ffffffe0002040f8:	00008797          	auipc	a5,0x8
ffffffe0002040fc:	f2878793          	addi	a5,a5,-216 # ffffffe00020c020 <virtio_blk_regs>
ffffffe000204100:	0007b783          	ld	a5,0(a5)
ffffffe000204104:	10078793          	addi	a5,a5,256
ffffffe000204108:	fef43423          	sd	a5,-24(s0)
    uint64_t capacity = ((uint64_t)config->capacity_hi << 32) | config->capacity_lo;
ffffffe00020410c:	fe843783          	ld	a5,-24(s0)
ffffffe000204110:	0047a783          	lw	a5,4(a5)
ffffffe000204114:	0007879b          	sext.w	a5,a5
ffffffe000204118:	02079793          	slli	a5,a5,0x20
ffffffe00020411c:	0207d793          	srli	a5,a5,0x20
ffffffe000204120:	02079713          	slli	a4,a5,0x20
ffffffe000204124:	fe843783          	ld	a5,-24(s0)
ffffffe000204128:	0007a783          	lw	a5,0(a5)
ffffffe00020412c:	0007879b          	sext.w	a5,a5
ffffffe000204130:	02079793          	slli	a5,a5,0x20
ffffffe000204134:	0207d793          	srli	a5,a5,0x20
ffffffe000204138:	00f767b3          	or	a5,a4,a5
ffffffe00020413c:	fef43023          	sd	a5,-32(s0)
}
ffffffe000204140:	00000013          	nop
ffffffe000204144:	01813403          	ld	s0,24(sp)
ffffffe000204148:	02010113          	addi	sp,sp,32
ffffffe00020414c:	00008067          	ret

ffffffe000204150 <virtio_blk_cmd>:
void virtio_blk_cmd(uint32_t type, uint32_t sector, void* buf) {
ffffffe000204150:	fe010113          	addi	sp,sp,-32
ffffffe000204154:	00113c23          	sd	ra,24(sp)
ffffffe000204158:	00813823          	sd	s0,16(sp)
ffffffe00020415c:	02010413          	addi	s0,sp,32
ffffffe000204160:	00050793          	mv	a5,a0
ffffffe000204164:	00058713          	mv	a4,a1
ffffffe000204168:	fec43023          	sd	a2,-32(s0)
ffffffe00020416c:	fef42623          	sw	a5,-20(s0)
ffffffe000204170:	00070793          	mv	a5,a4
ffffffe000204174:	fef42423          	sw	a5,-24(s0)
	virtio_blk_req.type = type;
ffffffe000204178:	0000b797          	auipc	a5,0xb
ffffffe00020417c:	6f878793          	addi	a5,a5,1784 # ffffffe00020f870 <virtio_blk_req>
ffffffe000204180:	fec42703          	lw	a4,-20(s0)
ffffffe000204184:	00e7a023          	sw	a4,0(a5)
    virtio_blk_req.sector = sector;
ffffffe000204188:	fe846703          	lwu	a4,-24(s0)
ffffffe00020418c:	0000b797          	auipc	a5,0xb
ffffffe000204190:	6e478793          	addi	a5,a5,1764 # ffffffe00020f870 <virtio_blk_req>
ffffffe000204194:	00e7b423          	sd	a4,8(a5)
    virtio_blk_ring.desc[0].addr = virt_to_phys((uint64_t)&virtio_blk_req);
ffffffe000204198:	0000b697          	auipc	a3,0xb
ffffffe00020419c:	6d868693          	addi	a3,a3,1752 # ffffffe00020f870 <virtio_blk_req>
ffffffe0002041a0:	0000b797          	auipc	a5,0xb
ffffffe0002041a4:	6b078793          	addi	a5,a5,1712 # ffffffe00020f850 <virtio_blk_ring>
ffffffe0002041a8:	0087b783          	ld	a5,8(a5)
ffffffe0002041ac:	04100713          	li	a4,65
ffffffe0002041b0:	01f71713          	slli	a4,a4,0x1f
ffffffe0002041b4:	00e68733          	add	a4,a3,a4
ffffffe0002041b8:	00e7b023          	sd	a4,0(a5)
    virtio_blk_ring.desc[0].len = sizeof(struct virtio_blk_req);
ffffffe0002041bc:	0000b797          	auipc	a5,0xb
ffffffe0002041c0:	69478793          	addi	a5,a5,1684 # ffffffe00020f850 <virtio_blk_ring>
ffffffe0002041c4:	0087b783          	ld	a5,8(a5)
ffffffe0002041c8:	01000713          	li	a4,16
ffffffe0002041cc:	00e7a423          	sw	a4,8(a5)
    virtio_blk_ring.desc[0].flags = VIRTQ_DESC_F_NEXT;
ffffffe0002041d0:	0000b797          	auipc	a5,0xb
ffffffe0002041d4:	68078793          	addi	a5,a5,1664 # ffffffe00020f850 <virtio_blk_ring>
ffffffe0002041d8:	0087b783          	ld	a5,8(a5)
ffffffe0002041dc:	00100713          	li	a4,1
ffffffe0002041e0:	00e79623          	sh	a4,12(a5)
    virtio_blk_ring.desc[0].next = 1;
ffffffe0002041e4:	0000b797          	auipc	a5,0xb
ffffffe0002041e8:	66c78793          	addi	a5,a5,1644 # ffffffe00020f850 <virtio_blk_ring>
ffffffe0002041ec:	0087b783          	ld	a5,8(a5)
ffffffe0002041f0:	00100713          	li	a4,1
ffffffe0002041f4:	00e79723          	sh	a4,14(a5)
    virtio_blk_ring.desc[1].addr = virt_to_phys((uint64_t)buf);
ffffffe0002041f8:	fe043683          	ld	a3,-32(s0)
ffffffe0002041fc:	0000b797          	auipc	a5,0xb
ffffffe000204200:	65478793          	addi	a5,a5,1620 # ffffffe00020f850 <virtio_blk_ring>
ffffffe000204204:	0087b783          	ld	a5,8(a5)
ffffffe000204208:	01078793          	addi	a5,a5,16
ffffffe00020420c:	04100713          	li	a4,65
ffffffe000204210:	01f71713          	slli	a4,a4,0x1f
ffffffe000204214:	00e68733          	add	a4,a3,a4
ffffffe000204218:	00e7b023          	sd	a4,0(a5)
    virtio_blk_ring.desc[1].len = VIRTIO_BLK_SECTOR_SIZE;
ffffffe00020421c:	0000b797          	auipc	a5,0xb
ffffffe000204220:	63478793          	addi	a5,a5,1588 # ffffffe00020f850 <virtio_blk_ring>
ffffffe000204224:	0087b783          	ld	a5,8(a5)
ffffffe000204228:	01078793          	addi	a5,a5,16
ffffffe00020422c:	20000713          	li	a4,512
ffffffe000204230:	00e7a423          	sw	a4,8(a5)
    if (type == VIRTIO_BLK_T_IN) {
ffffffe000204234:	fec42783          	lw	a5,-20(s0)
ffffffe000204238:	0007879b          	sext.w	a5,a5
ffffffe00020423c:	02079063          	bnez	a5,ffffffe00020425c <virtio_blk_cmd+0x10c>
        virtio_blk_ring.desc[1].flags = VIRTQ_DESC_F_WRITE | VIRTQ_DESC_F_NEXT; 
ffffffe000204240:	0000b797          	auipc	a5,0xb
ffffffe000204244:	61078793          	addi	a5,a5,1552 # ffffffe00020f850 <virtio_blk_ring>
ffffffe000204248:	0087b783          	ld	a5,8(a5)
ffffffe00020424c:	01078793          	addi	a5,a5,16
ffffffe000204250:	00300713          	li	a4,3
ffffffe000204254:	00e79623          	sh	a4,12(a5)
ffffffe000204258:	01c0006f          	j	ffffffe000204274 <virtio_blk_cmd+0x124>
        virtio_blk_ring.desc[1].flags = VIRTQ_DESC_F_NEXT;
ffffffe00020425c:	0000b797          	auipc	a5,0xb
ffffffe000204260:	5f478793          	addi	a5,a5,1524 # ffffffe00020f850 <virtio_blk_ring>
ffffffe000204264:	0087b783          	ld	a5,8(a5)
ffffffe000204268:	01078793          	addi	a5,a5,16
ffffffe00020426c:	00100713          	li	a4,1
ffffffe000204270:	00e79623          	sh	a4,12(a5)
    virtio_blk_ring.desc[1].next = 2;
ffffffe000204274:	0000b797          	auipc	a5,0xb
ffffffe000204278:	5dc78793          	addi	a5,a5,1500 # ffffffe00020f850 <virtio_blk_ring>
ffffffe00020427c:	0087b783          	ld	a5,8(a5)
ffffffe000204280:	01078793          	addi	a5,a5,16
ffffffe000204284:	00200713          	li	a4,2
ffffffe000204288:	00e79723          	sh	a4,14(a5)
    virtio_blk_ring.desc[2].addr = virt_to_phys((uint64_t)&virtio_blk_status);
ffffffe00020428c:	00008697          	auipc	a3,0x8
ffffffe000204290:	da468693          	addi	a3,a3,-604 # ffffffe00020c030 <virtio_blk_status>
ffffffe000204294:	0000b797          	auipc	a5,0xb
ffffffe000204298:	5bc78793          	addi	a5,a5,1468 # ffffffe00020f850 <virtio_blk_ring>
ffffffe00020429c:	0087b783          	ld	a5,8(a5)
ffffffe0002042a0:	02078793          	addi	a5,a5,32
ffffffe0002042a4:	04100713          	li	a4,65
ffffffe0002042a8:	01f71713          	slli	a4,a4,0x1f
ffffffe0002042ac:	00e68733          	add	a4,a3,a4
ffffffe0002042b0:	00e7b023          	sd	a4,0(a5)
    virtio_blk_ring.desc[2].len = sizeof(virtio_blk_status);
ffffffe0002042b4:	0000b797          	auipc	a5,0xb
ffffffe0002042b8:	59c78793          	addi	a5,a5,1436 # ffffffe00020f850 <virtio_blk_ring>
ffffffe0002042bc:	0087b783          	ld	a5,8(a5)
ffffffe0002042c0:	02078793          	addi	a5,a5,32
ffffffe0002042c4:	00100713          	li	a4,1
ffffffe0002042c8:	00e7a423          	sw	a4,8(a5)
    virtio_blk_ring.desc[2].flags = VIRTQ_DESC_F_WRITE;
ffffffe0002042cc:	0000b797          	auipc	a5,0xb
ffffffe0002042d0:	58478793          	addi	a5,a5,1412 # ffffffe00020f850 <virtio_blk_ring>
ffffffe0002042d4:	0087b783          	ld	a5,8(a5)
ffffffe0002042d8:	02078793          	addi	a5,a5,32
ffffffe0002042dc:	00200713          	li	a4,2
ffffffe0002042e0:	00e79623          	sh	a4,12(a5)
    virtio_blk_regs->Status |= DEVICE_DRIVER_OK;
ffffffe0002042e4:	00008797          	auipc	a5,0x8
ffffffe0002042e8:	d3c78793          	addi	a5,a5,-708 # ffffffe00020c020 <virtio_blk_regs>
ffffffe0002042ec:	0007b783          	ld	a5,0(a5)
ffffffe0002042f0:	0707a783          	lw	a5,112(a5)
ffffffe0002042f4:	0007871b          	sext.w	a4,a5
ffffffe0002042f8:	00008797          	auipc	a5,0x8
ffffffe0002042fc:	d2878793          	addi	a5,a5,-728 # ffffffe00020c020 <virtio_blk_regs>
ffffffe000204300:	0007b783          	ld	a5,0(a5)
ffffffe000204304:	00476713          	ori	a4,a4,4
ffffffe000204308:	0007071b          	sext.w	a4,a4
ffffffe00020430c:	06e7a823          	sw	a4,112(a5)
    virtio_blk_ring.avail->ring[(virtio_blk_ring.avail->idx + 1) % VIRTIO_QUEUE_SIZE] = 0;
ffffffe000204310:	0000b797          	auipc	a5,0xb
ffffffe000204314:	54078793          	addi	a5,a5,1344 # ffffffe00020f850 <virtio_blk_ring>
ffffffe000204318:	0107b683          	ld	a3,16(a5)
ffffffe00020431c:	0000b797          	auipc	a5,0xb
ffffffe000204320:	53478793          	addi	a5,a5,1332 # ffffffe00020f850 <virtio_blk_ring>
ffffffe000204324:	0107b783          	ld	a5,16(a5)
ffffffe000204328:	0027d783          	lhu	a5,2(a5)
ffffffe00020432c:	0007879b          	sext.w	a5,a5
ffffffe000204330:	0017879b          	addiw	a5,a5,1
ffffffe000204334:	0007879b          	sext.w	a5,a5
ffffffe000204338:	00078713          	mv	a4,a5
ffffffe00020433c:	41f7579b          	sraiw	a5,a4,0x1f
ffffffe000204340:	01c7d79b          	srliw	a5,a5,0x1c
ffffffe000204344:	00f7073b          	addw	a4,a4,a5
ffffffe000204348:	00f77713          	andi	a4,a4,15
ffffffe00020434c:	40f707bb          	subw	a5,a4,a5
ffffffe000204350:	0007879b          	sext.w	a5,a5
ffffffe000204354:	00179793          	slli	a5,a5,0x1
ffffffe000204358:	00f687b3          	add	a5,a3,a5
ffffffe00020435c:	00079223          	sh	zero,4(a5)
    virtio_blk_ring.avail->idx += 1;
ffffffe000204360:	0000b797          	auipc	a5,0xb
ffffffe000204364:	4f078793          	addi	a5,a5,1264 # ffffffe00020f850 <virtio_blk_ring>
ffffffe000204368:	0107b783          	ld	a5,16(a5)
ffffffe00020436c:	0027d703          	lhu	a4,2(a5)
ffffffe000204370:	0000b797          	auipc	a5,0xb
ffffffe000204374:	4e078793          	addi	a5,a5,1248 # ffffffe00020f850 <virtio_blk_ring>
ffffffe000204378:	0107b783          	ld	a5,16(a5)
ffffffe00020437c:	0017071b          	addiw	a4,a4,1 # ffffffff80000001 <VM_END+0x80000001>
ffffffe000204380:	03071713          	slli	a4,a4,0x30
ffffffe000204384:	03075713          	srli	a4,a4,0x30
ffffffe000204388:	00e79123          	sh	a4,2(a5)
    virtio_blk_regs->QueueNotify = 0;
ffffffe00020438c:	00008797          	auipc	a5,0x8
ffffffe000204390:	c9478793          	addi	a5,a5,-876 # ffffffe00020c020 <virtio_blk_regs>
ffffffe000204394:	0007b783          	ld	a5,0(a5)
ffffffe000204398:	0407a823          	sw	zero,80(a5)
    memory_barrier();
ffffffe00020439c:	941ff0ef          	jal	ffffffe000203cdc <memory_barrier>
}
ffffffe0002043a0:	00000013          	nop
ffffffe0002043a4:	01813083          	ld	ra,24(sp)
ffffffe0002043a8:	01013403          	ld	s0,16(sp)
ffffffe0002043ac:	02010113          	addi	sp,sp,32
ffffffe0002043b0:	00008067          	ret

ffffffe0002043b4 <virtio_blk_read_sector>:
void virtio_blk_read_sector(uint64_t sector, void *buf) {
ffffffe0002043b4:	fd010113          	addi	sp,sp,-48
ffffffe0002043b8:	02113423          	sd	ra,40(sp)
ffffffe0002043bc:	02813023          	sd	s0,32(sp)
ffffffe0002043c0:	03010413          	addi	s0,sp,48
ffffffe0002043c4:	fca43c23          	sd	a0,-40(s0)
ffffffe0002043c8:	fcb43823          	sd	a1,-48(s0)
    uint64_t original_idx = virtio_blk_ring.used->idx;
ffffffe0002043cc:	0000b797          	auipc	a5,0xb
ffffffe0002043d0:	48478793          	addi	a5,a5,1156 # ffffffe00020f850 <virtio_blk_ring>
ffffffe0002043d4:	0187b783          	ld	a5,24(a5)
ffffffe0002043d8:	0027d783          	lhu	a5,2(a5)
ffffffe0002043dc:	fef43423          	sd	a5,-24(s0)
    virtio_blk_cmd(VIRTIO_BLK_T_IN, sector, buf);
ffffffe0002043e0:	fd843783          	ld	a5,-40(s0)
ffffffe0002043e4:	0007879b          	sext.w	a5,a5
ffffffe0002043e8:	fd043603          	ld	a2,-48(s0)
ffffffe0002043ec:	00078593          	mv	a1,a5
ffffffe0002043f0:	00000513          	li	a0,0
ffffffe0002043f4:	d5dff0ef          	jal	ffffffe000204150 <virtio_blk_cmd>
        if (virtio_blk_ring.used->idx != original_idx) {
ffffffe0002043f8:	0000b797          	auipc	a5,0xb
ffffffe0002043fc:	45878793          	addi	a5,a5,1112 # ffffffe00020f850 <virtio_blk_ring>
ffffffe000204400:	0187b783          	ld	a5,24(a5)
ffffffe000204404:	0027d783          	lhu	a5,2(a5)
ffffffe000204408:	00078713          	mv	a4,a5
ffffffe00020440c:	fe843783          	ld	a5,-24(s0)
ffffffe000204410:	00e79463          	bne	a5,a4,ffffffe000204418 <virtio_blk_read_sector+0x64>
ffffffe000204414:	fe5ff06f          	j	ffffffe0002043f8 <virtio_blk_read_sector+0x44>
            break;
ffffffe000204418:	00000013          	nop
}
ffffffe00020441c:	00000013          	nop
ffffffe000204420:	02813083          	ld	ra,40(sp)
ffffffe000204424:	02013403          	ld	s0,32(sp)
ffffffe000204428:	03010113          	addi	sp,sp,48
ffffffe00020442c:	00008067          	ret

ffffffe000204430 <virtio_blk_write_sector>:
void virtio_blk_write_sector(uint64_t sector, const void *buf) {
ffffffe000204430:	fd010113          	addi	sp,sp,-48
ffffffe000204434:	02113423          	sd	ra,40(sp)
ffffffe000204438:	02813023          	sd	s0,32(sp)
ffffffe00020443c:	03010413          	addi	s0,sp,48
ffffffe000204440:	fca43c23          	sd	a0,-40(s0)
ffffffe000204444:	fcb43823          	sd	a1,-48(s0)
    uint64_t original_idx = virtio_blk_ring.used->idx;
ffffffe000204448:	0000b797          	auipc	a5,0xb
ffffffe00020444c:	40878793          	addi	a5,a5,1032 # ffffffe00020f850 <virtio_blk_ring>
ffffffe000204450:	0187b783          	ld	a5,24(a5)
ffffffe000204454:	0027d783          	lhu	a5,2(a5)
ffffffe000204458:	fef43423          	sd	a5,-24(s0)
    virtio_blk_cmd(VIRTIO_BLK_T_OUT, sector, (void*)buf);
ffffffe00020445c:	fd843783          	ld	a5,-40(s0)
ffffffe000204460:	0007879b          	sext.w	a5,a5
ffffffe000204464:	fd043603          	ld	a2,-48(s0)
ffffffe000204468:	00078593          	mv	a1,a5
ffffffe00020446c:	00100513          	li	a0,1
ffffffe000204470:	ce1ff0ef          	jal	ffffffe000204150 <virtio_blk_cmd>
        if (virtio_blk_ring.used->idx != original_idx) {
ffffffe000204474:	0000b797          	auipc	a5,0xb
ffffffe000204478:	3dc78793          	addi	a5,a5,988 # ffffffe00020f850 <virtio_blk_ring>
ffffffe00020447c:	0187b783          	ld	a5,24(a5)
ffffffe000204480:	0027d783          	lhu	a5,2(a5)
ffffffe000204484:	00078713          	mv	a4,a5
ffffffe000204488:	fe843783          	ld	a5,-24(s0)
ffffffe00020448c:	00e79463          	bne	a5,a4,ffffffe000204494 <virtio_blk_write_sector+0x64>
ffffffe000204490:	fe5ff06f          	j	ffffffe000204474 <virtio_blk_write_sector+0x44>
            break;
ffffffe000204494:	00000013          	nop
}
ffffffe000204498:	00000013          	nop
ffffffe00020449c:	02813083          	ld	ra,40(sp)
ffffffe0002044a0:	02013403          	ld	s0,32(sp)
ffffffe0002044a4:	03010113          	addi	sp,sp,48
ffffffe0002044a8:	00008067          	ret

ffffffe0002044ac <virtio_blk_init>:
void virtio_blk_init() {
ffffffe0002044ac:	de010113          	addi	sp,sp,-544
ffffffe0002044b0:	20113c23          	sd	ra,536(sp)
ffffffe0002044b4:	20813823          	sd	s0,528(sp)
ffffffe0002044b8:	22010413          	addi	s0,sp,544
    virtio_blk_driver_init();
ffffffe0002044bc:	871ff0ef          	jal	ffffffe000203d2c <virtio_blk_driver_init>
    virtio_blk_feature_init();
ffffffe0002044c0:	8fdff0ef          	jal	ffffffe000203dbc <virtio_blk_feature_init>
    virtio_blk_config_init();
ffffffe0002044c4:	c29ff0ef          	jal	ffffffe0002040ec <virtio_blk_config_init>
    virtio_blk_queue_init();
ffffffe0002044c8:	9b9ff0ef          	jal	ffffffe000203e80 <virtio_blk_queue_init>
    virtio_blk_read_sector(0, buf);
ffffffe0002044cc:	df040793          	addi	a5,s0,-528
ffffffe0002044d0:	00078593          	mv	a1,a5
ffffffe0002044d4:	00000513          	li	a0,0
ffffffe0002044d8:	eddff0ef          	jal	ffffffe0002043b4 <virtio_blk_read_sector>
    boot_signature[0] = buf[510];
ffffffe0002044dc:	fee44783          	lbu	a5,-18(s0)
ffffffe0002044e0:	def40423          	sb	a5,-536(s0)
    boot_signature[1] = buf[511];
ffffffe0002044e4:	fef44783          	lbu	a5,-17(s0)
ffffffe0002044e8:	def404a3          	sb	a5,-535(s0)
    printk("...virtio_blk_init done!\n");
ffffffe0002044ec:	00001517          	auipc	a0,0x1
ffffffe0002044f0:	eac50513          	addi	a0,a0,-340 # ffffffe000205398 <lowerxdigits.0+0xa8>
ffffffe0002044f4:	a79fe0ef          	jal	ffffffe000202f6c <printk>
}
ffffffe0002044f8:	00000013          	nop
ffffffe0002044fc:	21813083          	ld	ra,536(sp)
ffffffe000204500:	21013403          	ld	s0,528(sp)
ffffffe000204504:	22010113          	addi	sp,sp,544
ffffffe000204508:	00008067          	ret

ffffffe00020450c <virtio_dev_test>:
int virtio_dev_test(uint64_t virtio_addr) {
ffffffe00020450c:	fd010113          	addi	sp,sp,-48
ffffffe000204510:	02113423          	sd	ra,40(sp)
ffffffe000204514:	02813023          	sd	s0,32(sp)
ffffffe000204518:	03010413          	addi	s0,sp,48
ffffffe00020451c:	fca43c23          	sd	a0,-40(s0)
    void *virtio_space = (char*)(virtio_addr);
ffffffe000204520:	fd843783          	ld	a5,-40(s0)
ffffffe000204524:	fef43423          	sd	a5,-24(s0)
    struct virtio_regs *virtio_header = virtio_space;
ffffffe000204528:	fe843783          	ld	a5,-24(s0)
ffffffe00020452c:	fef43023          	sd	a5,-32(s0)
    if (in32(&virtio_header->DeviceID) == ID_VIRTIO_BLK) {
ffffffe000204530:	fe043783          	ld	a5,-32(s0)
ffffffe000204534:	00878793          	addi	a5,a5,8
ffffffe000204538:	00078513          	mv	a0,a5
ffffffe00020453c:	f70ff0ef          	jal	ffffffe000203cac <in32>
ffffffe000204540:	00050793          	mv	a5,a0
ffffffe000204544:	0007879b          	sext.w	a5,a5
ffffffe000204548:	00078713          	mv	a4,a5
ffffffe00020454c:	00200793          	li	a5,2
ffffffe000204550:	00f71a63          	bne	a4,a5,ffffffe000204564 <virtio_dev_test+0x58>
        virtio_blk_regs = virtio_space;
ffffffe000204554:	00008797          	auipc	a5,0x8
ffffffe000204558:	acc78793          	addi	a5,a5,-1332 # ffffffe00020c020 <virtio_blk_regs>
ffffffe00020455c:	fe843703          	ld	a4,-24(s0)
ffffffe000204560:	00e7b023          	sd	a4,0(a5)
    return 0;
ffffffe000204564:	00000793          	li	a5,0
}
ffffffe000204568:	00078513          	mv	a0,a5
ffffffe00020456c:	02813083          	ld	ra,40(sp)
ffffffe000204570:	02013403          	ld	s0,32(sp)
ffffffe000204574:	03010113          	addi	sp,sp,48
ffffffe000204578:	00008067          	ret

ffffffe00020457c <virtio_dev_init>:
void virtio_dev_init() {
ffffffe00020457c:	fe010113          	addi	sp,sp,-32
ffffffe000204580:	00113c23          	sd	ra,24(sp)
ffffffe000204584:	00813823          	sd	s0,16(sp)
ffffffe000204588:	02010413          	addi	s0,sp,32
    for (int i = 0; i < VIRTIO_COUNT; i++) {
ffffffe00020458c:	fe042623          	sw	zero,-20(s0)
ffffffe000204590:	0480006f          	j	ffffffe0002045d8 <virtio_dev_init+0x5c>
        uint64_t addr = VIRTIO_START + i * VIRTIO_SIZE;
ffffffe000204594:	fec42783          	lw	a5,-20(s0)
ffffffe000204598:	00078713          	mv	a4,a5
ffffffe00020459c:	000107b7          	lui	a5,0x10
ffffffe0002045a0:	0017879b          	addiw	a5,a5,1 # 10001 <PGSIZE+0xf001>
ffffffe0002045a4:	00f707bb          	addw	a5,a4,a5
ffffffe0002045a8:	0007879b          	sext.w	a5,a5
ffffffe0002045ac:	00c7979b          	slliw	a5,a5,0xc
ffffffe0002045b0:	0007879b          	sext.w	a5,a5
ffffffe0002045b4:	fef43023          	sd	a5,-32(s0)
        virtio_dev_test(io_to_virt(addr));
ffffffe0002045b8:	fe043503          	ld	a0,-32(s0)
ffffffe0002045bc:	f40ff0ef          	jal	ffffffe000203cfc <io_to_virt>
ffffffe0002045c0:	00050793          	mv	a5,a0
ffffffe0002045c4:	00078513          	mv	a0,a5
ffffffe0002045c8:	f45ff0ef          	jal	ffffffe00020450c <virtio_dev_test>
    for (int i = 0; i < VIRTIO_COUNT; i++) {
ffffffe0002045cc:	fec42783          	lw	a5,-20(s0)
ffffffe0002045d0:	0017879b          	addiw	a5,a5,1
ffffffe0002045d4:	fef42623          	sw	a5,-20(s0)
ffffffe0002045d8:	fec42783          	lw	a5,-20(s0)
ffffffe0002045dc:	0007871b          	sext.w	a4,a5
ffffffe0002045e0:	00700793          	li	a5,7
ffffffe0002045e4:	fae7d8e3          	bge	a5,a4,ffffffe000204594 <virtio_dev_init+0x18>
    if (virtio_blk_regs) {
ffffffe0002045e8:	00008797          	auipc	a5,0x8
ffffffe0002045ec:	a3878793          	addi	a5,a5,-1480 # ffffffe00020c020 <virtio_blk_regs>
ffffffe0002045f0:	0007b783          	ld	a5,0(a5)
ffffffe0002045f4:	00078463          	beqz	a5,ffffffe0002045fc <virtio_dev_init+0x80>
        virtio_blk_init();
ffffffe0002045f8:	eb5ff0ef          	jal	ffffffe0002044ac <virtio_blk_init>
ffffffe0002045fc:	00000013          	nop
ffffffe000204600:	01813083          	ld	ra,24(sp)
ffffffe000204604:	01013403          	ld	s0,16(sp)
ffffffe000204608:	02010113          	addi	sp,sp,32
ffffffe00020460c:	00008067          	ret
