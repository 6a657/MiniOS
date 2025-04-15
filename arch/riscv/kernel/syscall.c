#include "syscall.h"
#include "printk.h"
#include "proc.h"
extern struct task_struct* current;
void getpid(struct pt_regs* regs){
  regs->a0 = current->pid;
}
uint64_t write(uint64_t fd, const char* buf, uint64_t count){
  if(fd == 1){
    for(int i=0;i<count;i++){
      printk("%c",buf[i]);
    }
    return count;
  }else{
    return -1;
  }
}

int64_t sys_write(uint64_t fd, const char *buf, uint64_t len) {
    int64_t ret;
    struct file *file = &(current->files->fd_array[fd]);
    if (file->opened == 0) {
        printk("file not opened\n");
        return ERROR_FILE_NOT_OPEN;
    } else {
        // check perms and call write function of file
      if (!(file->perms & FILE_WRITABLE)) {
        printk("file not writable\n");
        return -1;
      }
      if (file->write != NULL) {
        ret = file->write(file, buf, len); 
      } else {
        printk("no write function implemented\n");
        return -1;
      }
    }
    return ret;
}

void syscall(struct pt_regs* regs) {
    if (regs->a7 == SYS_WRITE) {
      regs->a0 = sys_write(regs->a0, (const char *)regs->a1, regs->a2);
    } else if (regs->a7 == SYS_GETPID) {
      getpid(regs);
    } else if (regs->a7 == SYS_READ){
      regs->a0 = stdin_read(regs->a0, (const char *)regs->a1, regs->a2);
    } else{
      printk("syscall index = %lld\n", regs->a7);
    }
    regs->sepc += 4;
    return;
}
