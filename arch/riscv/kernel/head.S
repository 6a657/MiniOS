    .extern start_kernel
    .extern task_init
    .extern mm_init
    .extern _traps
    .extern print_int

    .section .text.init
    .globl _start
_start:
    la sp, boot_stack_top
    call setup_vm
    call relocate
    call print_int
    call mm_init
    call setup_vm_final
    
    la t0, _traps
    csrw stvec, t0
    li t1, 1<<5
    csrs sie, t1
    rdtime a0
    li a1,10000000
    add a0,a0,a1
    add a1,x0,x0
    call sbi_set_timer
    #call schedule
    
    #li t2, 1<<1
    # csrs sstatus, t2
    li a0,2024

    call task_init
    j start_kernel

relocate:
    # set ra = ra + PA2VA_OFFSET
    # set sp = sp + PA2VA_OFFSET (If you have set the sp before)
    li t0, 0xffffffdf80000000
    add ra, ra, t0
    add sp, sp, t0
    
    la t1, if
    add t1,t1,t0
    csrw stvec, t1
    sfence.vma zero, zero
    # set satp with early_pgtbl
    li t0, 0x8000000000000000
    la t1, early_pgtbl
    srli t1, t1, 12
    or t1, t1, t0
    csrw satp, t1
    if:
    ret

    .section .bss.stack
    .globl boot_stack
boot_stack:
    .space 4096

    .globl boot_stack_top
boot_stack_top:
