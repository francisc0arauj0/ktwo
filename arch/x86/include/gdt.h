#pragma once

#include "stdint.h"

struct gdt_entry_struct {
	uint16_t limit;
	uint16_t base_lower;
	uint8_t base_middle;
	uint8_t access;
	uint8_t flags;
	uint8_t base_height;
} __attribute__((packed));

struct gdt_ptr_struct {
	uint16_t limit;
	unsigned int base;
} __attribute__((packed));

struct tss_entry_struct {
	uint32_t esp0; // r0
	uint32_t ss0;	 // r0
	uint32_t cs;	 // Code Segment (r3)
	uint32_t ss;	 // Stack Segment (r3)
	uint32_t ds;	 // Data Segment (r3)
	uint32_t es;	 // Extra Segment
	uint32_t fs;	 // FS Segment
	uint32_t gs;	 // GS Segment
} __attribute__((packed));

void initGDT();
void setGdtGate(uint32_t number, uint32_t base, uint32_t limit, uint8_t access, uint8_t gran);
void writeTSS(uint32_t number, uint16_t ss0, uint32_t esp0);
