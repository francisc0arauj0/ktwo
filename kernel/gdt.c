#include "gdt.h"
#include "memory.h"

extern void gdt_flush(uint32_t);
extern void tss_flush();

struct gdt_entry_struct gdt_entries[6];
struct gdt_ptr_struct gdt_ptr;
struct tss_entry_struct tss_entry;

void initGDT() {
	gdt_ptr.limit = (sizeof(struct gdt_entry_struct) * 6) - 1;
	gdt_ptr.base = (uint32_t)&gdt_entries;

	setGdtGates(0, 0, 0, 0, 0);								 // Null segment
	setGdtGates(1, 0, 0xFFFFFFFF, 0x9A, 0xCF); // Kernel code segment (r0)
	setGdtGates(2, 0, 0xFFFFFFFF, 0x92, 0xCF); // Kernel data segment (r0)
	setGdtGates(3, 0, 0xFFFFFFFF, 0xFA, 0xCF); // User code segment   (r3)
	setGdtGates(4, 0, 0xFFFFFFFF, 0xF2, 0xCF); // User data segment   (r3)

	writeTSS(5, 0x10, 0x0);

	gdt_flush((uint32_t)&gdt_ptr);
	tss_flush();
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

void writeTSS(uint32_t number, uint16_t ss0, uint32_t esp0) {
	uint32_t base = (uint32_t)&tss_entry;
	uint32_t limit = base + sizeof(tss_entry);

	setGdtGates(number, base, limit, 0x89, 0x00);
	memset(&tss_entry, 0, sizeof(tss_entry));

	tss_entry.ss0 = ss0;
	tss_entry.esp0 = esp0;

	tss_entry.cs = 0x08 | 0x3;

	tss_entry.ss = 0x10 | 0x3;
	tss_entry.ds = 0x10 | 0x3;
	tss_entry.es = 0x10 | 0x3;
	tss_entry.fs = 0x10 | 0x3;
	tss_entry.gs = 0x10 | 0x3;
}
