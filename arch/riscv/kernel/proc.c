#include "mm.h"
#include "defs.h"
#include "proc.h"
#include "elf.h"
#include "stdlib.h"
#include "printk.h"
#include "fs.h"

extern void __dummy();
 
struct task_struct *idle;           // idle process
struct task_struct *current;        // 指向当前运行线程的 task_struct
struct task_struct *task[NR_TASKS]; // 线程数组，所有的线程都保存在此]
int first = 1;
extern char _sramdisk[];
extern char _eramdisk[];
extern uint64_t swapper_pg_dir[];
void print_int(){
  printk("int\n");
}

void load_program(struct task_struct *task) {
    Elf64_Ehdr *ehdr = (Elf64_Ehdr *)_sramdisk;
    Elf64_Phdr *phdrs = (Elf64_Phdr *)(_sramdisk + ehdr->e_phoff);
    for (int i = 0; i < ehdr->e_phnum; ++i) {
        Elf64_Phdr *phdr = phdrs + i;
        if (phdr->p_type == PT_LOAD) { 
            uint64_t va_start = phdr->p_vaddr; 
            uint64_t sz = phdr->p_memsz;
            uint64_t m = sz%PGSIZE==0?0:1;
            char* pa = (char*)((char*)ehdr+phdr->p_offset);
            char* mem = (char*)alloc_pages(sz/PGSIZE+m);
            for(int i=0;i<(sz/PGSIZE+m)*PGSIZE;i++){
              if(i<phdr->p_filesz){
                mem[i+phdr->p_offset] = pa[i];
              }else{
                mem[i+phdr->p_offset] = 0;
              }
            }
            create_mapping((uint64_t*)task->pgd, va_start, (uint64_t)mem - PA2VA_OFFSET, (sz/PGSIZE+m)*PGSIZE, 0x1f);
            int dummy = 0;
        }
        
    }
    task->thread.sepc = ehdr->e_entry;
}

void task_init() {
    srand(2024);
    // 1. 调用 kalloc() 为 idle 分配一个物理页
    // 2. 设置 state 为 TASK_RUNNING;
    // 3. 由于 idle 不参与调度，可以将其 counter / priority 设置为 0
    // 4. 设置 idle 的 pid 为 0
    // 5. 将 current 和 task[0] 指向 idle

    /* YOUR CODE HERE */
    idle = (struct task_struct *)kalloc();   
    idle->state = TASK_RUNNING;             
    idle->counter = 0;                     
    idle->priority = 0;         
    idle->pid = 0;         
    current = idle;        
    task[0] = idle;     

    // 1. 参考 idle 的设置，为 task[1] ~ task[NR_TASKS - 1] 进行初始化
    // 2. 其中每个线程的 state 为 TASK_RUNNING, 此外，counter 和 priority 进行如下赋值：
    //     - counter  = 0;
    //     - priority = rand() 产生的随机数（控制范围在 [PRIORITY_MIN, PRIORITY_MAX] 之间）
    // 3. 为 task[1] ~ task[NR_TASKS - 1] 设置 thread_struct 中的 ra 和 sp
    //     - ra 设置为 __dummy（见 4.2.2）的地址
    //     - sp 设置为该线程申请的物理页的高地址

    /* YOUR CODE HERE */
    for (int i = 1; i <= 1; i++) {
        
        task[i] = (struct task_struct *)kalloc();
        task[i]->state = TASK_RUNNING;
        task[i]->counter = 0;
        task[i]->pid = i;
        task[i]->priority = PRIORITY_MIN + (rand() % (PRIORITY_MAX - PRIORITY_MIN + 1));
        //printk("SET [PID = %d PRIORITY = %d COUNTER = %d]\n", task[i]->pid, task[i]->priority, task[i]->counter);
        
        task[i]->thread.ra = (uint64_t)__dummy;
        task[i]->thread.sp = (uint64_t)task[i] + PGSIZE;

        task[i]->thread.sepc = USER_START;
        task[i]->thread.sstatus |=  (1 << 5) | (1 << 18);
        task[i]->thread.sscratch = USER_END;
        
        uint64_t* pagetable = (uint64_t*)alloc_page();
        for(int i = 0; i < 512; i++){
         pagetable[i] = swapper_pg_dir[i]; 
        }
        task[i]->pgd = pagetable;
        task[i]->files = file_init();
        
        
        
        //uint64_t uapp_m = (_eramdisk-_sramdisk)%PGSIZE==0?0:1;
        //uint64_t uapp_size = (_eramdisk-_sramdisk)/PGSIZE+uapp_m;
        //char* uapp = (char*)alloc_pages(uapp_size);
        //for(int i=0;i<PGSIZE*uapp_size;i++){
        //  uapp[i] = _sramdisk[i];
        //}
        //create_mapping((uint64_t*)pagetable, USER_START, (uint64_t)uapp-PA2VA_OFFSET, (uint64_t)(_eramdisk-_sramdisk), 31);
        load_program(task[i]);
        
        uint64_t* u_mode_stack = (uint64_t*)alloc_page();
        create_mapping((uint64_t*)pagetable, (uint64_t)USER_END-PGSIZE, (uint64_t)u_mode_stack-PA2VA_OFFSET, PGSIZE, 23);

    }

    printk("...task_init done!\n");
}

#if TEST_SCHED
#define MAX_OUTPUT ((NR_TASKS - 1) * 10)
char tasks_output[MAX_OUTPUT];
int tasks_output_index = 0;
char expected_output[] = "2222222222111111133334222222222211111113";
#include "sbi.h"
#endif

void dummy() {
    uint64_t MOD = 1000000007;
    uint64_t auto_inc_local_var = 0;
    int last_counter = -1;
    while (1) {
        
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
           // if (current->counter == 1) {
           //     --(current->counter);   // forced the counter to be zero if this thread is going to be scheduled
           // }                           // in case that the new counter is also 1, leading the information not printed.
            last_counter = current->counter;
            auto_inc_local_var = (auto_inc_local_var + 1) % MOD;
            printk("[PID = %d] is running. auto_inc_local_var = %d, counter = %d\n", current->pid, auto_inc_local_var, current->counter);
            printk("[PID = %d] Thread space begin at %lx\n",current->pid, current);
            
            #if TEST_SCHED
            tasks_output[tasks_output_index++] = current->pid + '0';
            if (tasks_output_index == MAX_OUTPUT) {
                for (int i = 0; i < MAX_OUTPUT; ++i) {
                    if (tasks_output[i] != expected_output[i]) {
                        printk("\033[31mTest failed!\033[0m\n");
                        printk("\033[31m    Expected: %s\033[0m\n", expected_output);
                        printk("\033[31m    Got:      %s\033[0m\n", tasks_output);
                        sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
                    }
                }
                printk("\033[32mTest passed!\033[0m\n");
                printk("\033[32m    Output: %s\033[0m\n", expected_output);
                sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
            }
            #endif
        }
    }
}

extern void __switch_to(struct task_struct *prev, struct task_struct *next);

void switch_to(struct task_struct *next) {
    // YOUR CODE HERE
   
    if(current == next){
    
    }else{
        printk("switch to [PID = %d COUNTER = %d]!!!\n",next->pid,next->counter);
        struct task_struct *temp = current;
        current = next;
        __switch_to(temp,next);
    }
}

void schedule() {
    //printk("schedule\n");
    struct task_struct *next = idle;
    uint64_t max_counter = 0;       
    int all_zero = 1;       
    for (int i = 0; i < NR_TASKS; i++) {
        if (task[i]->state != TASK_RUNNING) {
            continue; 
        }

        if (task[i]->counter > 0 && all_zero) {
            all_zero = 0; 
        }

        if (task[i]->counter > max_counter) {
            max_counter = task[i]->counter;
            next = task[i];
        }
    }
    if (all_zero==1) {
        for (int i = 1; i < NR_TASKS; i++) {
            if (task[i]->state == TASK_RUNNING) {
                //printk("SET [PID = %d PRIORITY = %d COUNTER = %d]\n", task[i]->pid, task[i]->priority, task[i]->counter);
                task[i]->counter = task[i]->priority;
            }
        }
        schedule();
    }else{
        switch_to(next);
    }
}


void do_timer() {
    //printk("do_timer!!!\n");
    if (current == idle || current->counter == 0) {
        schedule();
    } else {
        current->counter -= 1;
        if(current->counter==0){
          schedule();
        }
    }
}

