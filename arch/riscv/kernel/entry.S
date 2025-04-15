    .extern trap_handler
    .extern dummy
    .section .text.entry
    .align 2
    .globl _traps

_traps:
    csrrw sp, sscratch, sp
    bne sp, x0, switch_to_kernel
    csrrw sp, sscratch, sp
switch_to_kernel:
    addi sp, sp, -264
    sd x1, 0(sp)
    sd x2, 8(sp)
    sd x3, 16(sp)
    sd x4, 24(sp)
    sd x5, 32(sp)
    sd x6, 40(sp)
    sd x7, 48(sp)
    sd x8, 56(sp)
    sd x9, 64(sp)
    sd x10, 72(sp)
    sd x11, 80(sp)
    sd x12, 88(sp)
    sd x13, 96(sp)
    sd x14, 104(sp)
    sd x15, 112(sp)
    sd x16, 120(sp)
    sd x17, 128(sp)
    sd x18, 136(sp)
    sd x19, 144(sp)
    sd x20, 152(sp)
    sd x21, 160(sp)
    sd x22, 168(sp)
    sd x23, 176(sp)
    sd x24, 184(sp)
    sd x25, 192(sp)
    sd x26, 200(sp)
    sd x27, 208(sp)
    sd x28, 216(sp)
    sd x29, 224(sp)
    sd x30, 232(sp)
    sd x31, 240(sp)
    csrr t0, sepc
    sd t0, 248(sp)

    mv a2, sp
    csrr a0, scause 
    csrr a1, sepc  
    call trap_handler

    ld t0, 248(sp)
    csrw sepc, t0
    ld x1, 0(sp)
    ld x2, 8(sp)
    ld x3, 16(sp)
    ld x4, 24(sp)
    ld x5, 32(sp)
    ld x6, 40(sp)
    ld x7, 48(sp)
    ld x8, 56(sp)
    ld x9, 64(sp)
    ld x10, 72(sp)
    ld x11, 80(sp)
    ld x12, 88(sp)
    ld x13, 96(sp)
    ld x14, 104(sp)
    ld x15, 112(sp)
    ld x16, 120(sp)
    ld x17, 128(sp)
    ld x18, 136(sp)
    ld x19, 144(sp)
    ld x20, 152(sp)
    ld x21, 160(sp)
    ld x22, 168(sp)
    ld x23, 176(sp)
    ld x24, 184(sp)
    ld x25, 192(sp)
    ld x26, 200(sp)
    ld x27, 208(sp)
    ld x28, 216(sp)
    ld x29, 224(sp)
    ld x30, 232(sp)
    ld x31, 240(sp)
    addi sp, sp, 264
    csrrw sp, sscratch, sp
    bne sp, x0, switch_to_user
    csrrw sp, sscratch, sp
switch_to_user:
    sret

   
    .globl __dummy
__dummy:
    csrr t0, sscratch
    csrw sscratch, sp
    addi sp, t0, 0
    #csrw sepc, x0
    #la t0,dummy
    #sd t0, 32(a1)
    #csrw sepc,t0
    sret



    .globl __switch_to
__switch_to:
    sd ra, 32(a0)
    sd sp, 40(a0)
    sd s0, 48(a0)
    sd s1, 56(a0) 
    sd s2, 64(a0) 
    sd s3, 72(a0)  
    sd s4, 80(a0)
    sd s5, 88(a0) 
    sd s6, 96(a0) 
    sd s7, 104(a0)  
    sd s8, 112(a0) 
    sd s9, 120(a0)  
    sd s10, 128(a0) 
    sd s11, 136(a0)
    csrr t1, sepc
    sd t1, 144(a0)
    csrr t1, sstatus
    sd t1, 152(a0)
    csrr t1, sscratch
    sd t1, 160(a0)


    ld ra, 32(a1)
    ld sp, 40(a1)
    ld s0, 48(a1)
    ld s1, 56(a1)  
    ld s2, 64(a1) 
    ld s3, 72(a1) 
    ld s4, 80(a1)  
    ld s5, 88(a1)  
    ld s6, 96(a1) 
    ld s7, 104(a1)  
    ld s8, 112(a1)   
    ld s9, 120(a1) 
    ld s10, 128(a1) 
    ld s11, 136(a1) 
    ld t1, 144(a1)
    csrw sepc, t1
    ld t1, 152(a1)
    csrw sstatus, t1
    ld t1, 160(a1)
    csrw sscratch, t1
    ld t1, 168(a1)
    li t0, 0xffffffdf80000000
    sub t1, t1, t0
    srli t1, t1, 12
    li t0, 0x8000000000000000
    or t1, t1, t0
    csrw satp, t1
    
    sfence.vma zero, zero

    ret

