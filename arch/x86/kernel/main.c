#include "gdt.h"
#include "idt.h"
#include "stdio.h"
#include "vga.h"

void kmain(void);

void kmain(void) {
	puts("Welcome to ktwo kernel");
	puts("[VGA] Finished");
	initGDT();
	puts("[GDT] Finished");
	initIDT();
	puts("[IDT] Finished");
}
