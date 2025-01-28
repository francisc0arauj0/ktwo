#include "stdio.h"
#include "vga.h"

void putc(char c) {
	//
	print(&c, 0);
}

void puts(const char *s) {
	while (*s) {
		putc(*s);
		s++;
	}
	putc('\n');
}