#include "gdt.h"

extern void gdt_flush(uint32_t);

struct gdt_entry_struct gdt_entries[5];
struct gdt_ptr_struct gdt_ptr;

void initGDT() {
	gdt_ptr.limit = (sizeof(gdt_entries) * 5) - 1;
	gdt_ptr.base = (uint32_t)&gdt_entries;

	setGdtGates(0, 0, 0, 0, 0);								 // Null segment
	setGdtGates(1, 0, 0xFFFFFFFF, 0x9A, 0xCF); // Kernel code segment (r0)
	setGdtGates(2, 0, 0xFFFFFFFF, 0x92, 0xCF); // Kernel data segment (r0)
	setGdtGates(3, 0, 0xFFFFFFFF, 0xFA, 0xCF); // User code segment   (r3)
	setGdtGates(4, 0, 0xFFFFFFFF, 0xF2, 0xCF); // User data segment   (r3)

	gdt_flush((uint32_t)&gdt_ptr);
}

void setGdtGates(uint32_t number, uint32_t base, uint32_t limit, uint8_t access, uint8_t gran) {
	gdt_entries[number].base_lower = (base & 0xFFFF);
	gdt_entries[number].base_middle = (base >> 16) & 0xFF;
	gdt_entries[number].base_height = (base >> 24) & 0xFF;

	gdt_entries[number].limit = (limit & 0xFFFF);

	gdt_entries[number].flags = (limit >> 16) & 0x0F;
	gdt_entries[number].flags |= (gran & 0xF0);

	gdt_entries[number].access = access;
}
