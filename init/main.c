#include "printk.h"

extern void test();
extern void schedule();

int start_kernel() {
    printk("2024");
    printk(" ZJU Operating System\n");
    schedule();
    test();
    return 0;
}
