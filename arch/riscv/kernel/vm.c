/* early_pgtbl: 用于 setup_vm 进行 1GiB 的映射 */
#include"defs.h"
#include "printk.h"
#include "printk.h"
#include "stdlib.h"
const uint64_t _PA2VA_OFFSET = (VM_START - PHY_START);
uint64_t early_pgtbl[512] __attribute__((__aligned__(0x1000)));

void setup_vm() {
    printk("setup_vm begin!!!\n");

    uint64_t pa = PHY_START;
    uint64_t va1 = PHY_START;       
    uint64_t va2 = VM_START; 
    uint64_t pte_flags = 0xF; 
    
    //early_pgtbl[(va1 >> 30LL) & 0x1FF] = ((pa >> 30LL) << 28LL) | pte_flags;
    early_pgtbl[(va2 >> 30LL) & 0x1FF] = ((pa >> 30LL) << 28LL) | pte_flags;
    
    printk("setup_vm done!!!\n");
}

uint64_t  swapper_pg_dir[512] __attribute__((__aligned__(0x1000)));
extern char _stext[];
extern char _srodata[];
extern char _sdata[];
void setup_vm_final(void) {  
    printk("setup_vm_final begin!!!\n");  
    uint64_t kernel_va = VM_START + OPENSBI_SIZE;  
    uint64_t kernel_pa = PHY_START + OPENSBI_SIZE;  
    uint64_t kernel_len = (uint64_t)_srodata - (uint64_t)_stext;  

    uint64_t rodata_va = kernel_va + kernel_len;  
    uint64_t rodata_pa = kernel_pa + kernel_len;  
    uint64_t rodata_len = (uint64_t)_sdata - (uint64_t)_srodata;  

    uint64_t mem_va = (uint64_t)_sdata;  
    uint64_t mem_pa = (uint64_t)_sdata - PA2VA_OFFSET;  
    uint64_t mem_len = PHY_SIZE - kernel_len - rodata_len - OPENSBI_SIZE;  

    printk("text: %lx--%lx X|-|R|V\n", kernel_va, kernel_va+ kernel_len);  
    create_mapping(swapper_pg_dir, kernel_va, kernel_pa, kernel_len, 0xB);  
    printk("rodata: %lx--%lx -|-|R|V\n", rodata_va, rodata_va+rodata_len);  
    create_mapping(swapper_pg_dir, rodata_va, rodata_pa, rodata_len, 0x3);  
    printk("mem: %lx--%lx -|W|R|V\n", mem_va, mem_va+mem_len);  
    create_mapping(swapper_pg_dir, mem_va, mem_pa, mem_len, 0x7);  
 
    uint64_t pg_dir_pa = (uint64_t)swapper_pg_dir - PA2VA_OFFSET;  
    uint64_t satp_val = ((pg_dir_pa >> 12) & 0xfffffffffff) | 0x8000000000000000;  
    asm volatile("csrw satp, %0"::"r"(satp_val));  
    asm volatile("sfence.vma zero, zero");  

    printk("setup_vm_final done!!!\n");  
    return;  
}  

void create_mapping(uint64_t *pgtbl, uint64_t va, uint64_t pa, uint64_t sz, uint64_t perm) {
    printk("create_mapping begin!!!\n");
    uint64_t _va = va;
    uint64_t _pa = pa;
    const uint64_t offset = 0xffffffdf80000000;
    while (_va < va+sz) {
        uint64_t vpn[3];
        vpn[2] = (_va >> 30) & 0x1FF;
        vpn[1] = (_va >> 21) & 0x1FF;
        vpn[0] = (_va >> 12) & 0x1FF;
        uint64_t* _pgtbl = pgtbl+offset;
        if ((pgtbl[vpn[2]] & 1) == 0) {
            uint64_t* new_page = (uint64_t*)kalloc();
            uint64_t entry_value = (((uint64_t)new_page - PA2VA_OFFSET) >> 12) << 10;
            pgtbl[vpn[2]] = entry_value | 1;
        }
        uint64_t* pgtbl1 = ((pgtbl[vpn[2]] >> 10) << 12)+offset;
        if ((pgtbl1[vpn[1]] & 1) == 0) {
            uint64_t* new_page = (uint64_t*)kalloc();
            uint64_t entry_value = (((uint64_t)new_page - PA2VA_OFFSET) >> 12) << 10;
            pgtbl1[vpn[1]] = entry_value | 1;
        }
        uint64_t* pgtbl2 = ((pgtbl1[vpn[1]] >> 10) << 12)+offset;
        pgtbl2[vpn[0]] = ((_pa >> 12) << 10) | perm;
        if (_va-va <= 20*PGSIZE) {
            printk("Mapping: VA %lx -> PTE %lx\n", _va, pgtbl2[vpn[0]]);
        }
        _va += PGSIZE;
        _pa += PGSIZE;
    }
    printk("create_mapping done!!!\n");
    return;
}
