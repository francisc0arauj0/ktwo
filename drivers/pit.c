#include "pit.h"
#include "idt.h"
#include "stdint.h"
#include "vga.h"

uint64_t ticks;
const uint32_t frequency = 100;

/**
 * void onIrq0(struct InterruptRegisters *regs) {
 *  ticks += 1;
 *	print("Timer Ticked!");
 * }
 */

void initTimer() {
	ticks = 0;

	// 1.1931816666 Mhz
	uint32_t divisor = 1193180 / frequency;

	// 0x43 - Mode/Command register
	outPortB(0x43, 0x36);
	// 0x40 - Channel 0
	outPortB(0x40, (uint8_t)(divisor & 0xFF));
	outPortB(0x40, (uint8_t)((divisor >> 8) & 0xFF));
}
