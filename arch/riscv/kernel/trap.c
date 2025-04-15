#include"stdint.h"
#include"sbi.h"
#include"defs.h"
#include"printk.h"
#include"proc.h"
void clock_set_next_event();
extern void syscall();

void trap_handler(uint64_t scause, uint64_t sepc, struct pt_regs *regs){
  if(scause & (1ul<<63)){
    if(scause & (5ul)){
     // printk("clock trap happen\n");  
      clock_set_next_event();
      do_timer();
    }
  }else if(scause == 8){
    syscall(regs);
  }
  else{
    printk("exception: %lld\n", scause);
  }
}

