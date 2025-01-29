#include "gdt.h"
#include "idt.h"
#include "stdio.h"
#include "vga.h"

void kmain(void);

void kmain(void) {
	puts("Welcome to KTWO (x86, 32 bits)");
	puts("Copyright (C) Francisco Araujo, GPL-3.0\n");
	puts("[VGA] Finished");
	initGDT();
	puts("[GDT] Finished");
	initIDT();
	puts("[IDT] Finished");
}