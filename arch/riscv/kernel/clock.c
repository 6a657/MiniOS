#include "stdint.h"
#include "sbi.h"
#include "defs.h"

// QEMU 中时钟的频率是 10MHz，也就是 1 秒钟相当于 10000000 个时钟周期
uint64_t TIMECLOCK = 10000000;

uint64_t get_cycles() {
     uint64_t cycles;
    __asm__ volatile (
        "rdtime %[cycles]"
        : [cycles] "=r" (cycles)  
        :  
        : "memory"  
    );
    return cycles;
}

void clock_set_next_event() {
    uint64_t next = get_cycles() + TIMECLOCK;
    sbi_set_timer(next);
}

