#include "stdint.h"
#include "sbi.h"
#include "printk.h"

struct sbiret sbi_ecall(uint64_t eid, uint64_t fid,
                        uint64_t arg0, uint64_t arg1, uint64_t arg2,
                        uint64_t arg3, uint64_t arg4, uint64_t arg5) {
    uint64_t error,value;
    struct sbiret ret;

    __asm__ volatile (   
        "mv a7, %[eid]\n" 
        "mv a6, %[fid]\n"
        "mv a0, %[arg0]\n"       
        "mv a1, %[arg1]\n"      
        "mv a2, %[arg2]\n"    
        "mv a3, %[arg3]\n"   
        "mv a4, %[arg4]\n"      
        "mv a5, %[arg5]\n"  
        "ecall\n"   
        "mv %[error], a0\n"   
        "mv %[value], a1\n"  
        : [error] "=r" (error), [value] "=r" (value)  
        : [eid] "r" (eid), [fid] "r" (fid), [arg0] "r" (arg0), [arg1] "r" (arg1),
          [arg2] "r" (arg2), [arg3] "r" (arg3), [arg4] "r" (arg4), [arg5] "r" (arg5)
        : "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7", "memory" 
    );
    ret.error = error;
    ret.value = value;
    return ret;
}

struct sbiret sbi_debug_console_write_byte(uint8_t byte) {
    const uint64_t EID = 0x4442434e;
    const uint64_t FID = 2;
    return sbi_ecall(EID, FID, byte, 0, 0, 0, 0, 0);
}

struct sbiret sbi_system_reset(uint32_t reset_type, uint32_t reset_reason) {
    const uint64_t EID = 0x53525354;
    const uint64_t FID = 0;
    return sbi_ecall(EID, FID, (uint64_t)reset_type, (uint64_t)reset_reason, 0, 0, 0, 0);
}

struct sbiret sbi_debug_console_read(uint64_t num_bytes, uint64_t base_addr_lo, uint64_t base_addr_hi){
    const uint64_t EID = 0x4442434e;
    const uint64_t FID = 1;
    return sbi_ecall(EID, FID, (uint64_t)num_bytes, (uint64_t)base_addr_lo, (uint64_t)base_addr_hi, 0, 0, 0);
}

struct sbiret sbi_debug_console_write(unsigned long num,unsigned long lo, unsigned long hi) {
    const uint64_t EID = 0x4442434e;
    const uint64_t FID = 0;
    return sbi_ecall(EID, FID, (uint64_t)num, (uint64_t)lo, (uint64_t)hi, 0, 0, 0);
}

struct sbiret sbi_set_timer(uint64_t stime_value) {
    const uint64_t EID = 0x54494d45;
    const uint64_t FID = 0;
    return sbi_ecall(EID, FID, stime_value, 0, 0, 0, 0, 0);
}
