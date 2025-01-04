#include "gdt.h"
#include "vga.h"

void kmain(void);

void kmain(void) {
	print("ktwo kernel\n");
	print("\n[VGA] Finished");
	initGDT();
	print("\n[GDT] Finished");
}
