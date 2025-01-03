#pragma once

#define vga_addr 0xB8000

#define width 80
#define height 25

#define VGA_BLACK 0
#define VGA_BLUE 1
#define VGA_GREEN 2
#define VGA_CYAN 3
#define VGA_RED 4
#define VGA_LIGHT_GREY 7

void reset();
void newLine();
void scrollUp();
void print(const char *message);
