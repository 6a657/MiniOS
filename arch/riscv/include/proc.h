#ifndef __PROC_H__
#define __PROC_H__

#include "stdint.h"
#include "fs.h"

#if TEST_SCHED
#define NR_TASKS (1 + 1)    // 测试时线程数量
#else
#define NR_TASKS (1 + 1)   // 用于控制最大线程数量（idle 线程 + 31 内核线程）
#endif

#define TASK_RUNNING 0      // 为了简化实验，所有的线程都只有一种状态

#define PRIORITY_MIN 1
#define PRIORITY_MAX 10

struct thread_struct {
    uint64_t ra;
    uint64_t sp;
    uint64_t s[12];
    uint64_t sepc, sstatus, sscratch;
};

struct task_struct {
    uint64_t state;     
    uint64_t counter;   
    uint64_t priority;  
    uint64_t pid;      
    struct thread_struct thread;
    uint64_t *pgd;
    struct files_struct *files;
};

struct pt_regs{
    uint64_t ra, sp, gp, tp;
    uint64_t t0, t1, t2;
    uint64_t s0, s1;
    uint64_t a0, a1, a2, a3, a4, a5, a6, a7;
    uint64_t s2, s3, s4, s5, s6, s7, s8, s9, s10, s11;
    uint64_t t3, t4, t5, t6;
    uint64_t sepc, sstatus;
};

/* 线程初始化，创建 NR_TASKS 个线程 */
void task_init();

/* 在时钟中断处理中被调用，用于判断是否需要进行调度 */
void do_timer();

/* 调度程序，选择出下一个运行的线程 */
void schedule();

/* 线程切换入口函数 */
void switch_to(struct task_struct *next);

/* dummy funciton: 一个循环程序，循环输出自己的 pid 以及一个自增的局部变量 */
void dummy();

#endif
