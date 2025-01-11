#include "io.h"

void outPortB(uint16_t port, uint8_t value) {
	//
	__asm__ volatile("outb %1, %0" : : "dN"(port), "a"(value));
}
