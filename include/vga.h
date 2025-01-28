#pragma once

#include "stdint.h"

#define vga_addr 0xB8000

#define width 80
#define height 25

#define VGA_BLACK 0x0
#define VGA_BLUE 0x1
#define VGA_GREEN 0x2
#define VGA_CYAN 0x3
#define VGA_RED 0x4
#define VGA_MAGENTA 0x5
#define VGA_BROWN 0x6
#define VGA_LIGHT_GREY 0x7
#define VGA_DARK_GREY 0x8
#define VGA_LIGHT_BLUE 0x9
#define VGA_LIGHT_GREEN 0xA
#define VGA_LIGHT_CYAN 0xB
#define VGA_LIGHT_RED 0xC
#define VGA_LIGHT_MAGENTA 0xD
#define VGA_LIGHT_BROWN 0xE
#define VGA_WHITE 0xF

void reset();
void newLine();
void scrollUp();
void print(const char *message, int error);
void screenColor(uint16_t color);
