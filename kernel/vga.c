#include "vga.h"

uint16_t column = 0;
uint16_t row = 0;

uint16_t *const vga = (uint16_t *const)vga_addr;
const uint16_t default_color = (VGA_LIGHT_GREY << 8) | (VGA_BLACK << 12);

void reset() {
	column = 0;
	row = 0;

	for (uint16_t y = 0; y < height; y++) {
		for (uint16_t x = 0; x < width; x++) {
			vga[y * width + x] = ' ' | default_color;
		}
	}
}

void newLine() {
	if (row < height - 1) {
		row++;
		column = 0;
	} else {
		scrollUp();
		column = 0;
	}
};

void scrollUp() {
	for (uint16_t y = 0; y < height; y++) {
		for (uint16_t x = 0; x < width; x++) {
			vga[(height - 1) * width + x] = ' ' | default_color;
		}
		for (uint16_t x = 0; x < width; x++) {
			vga[(height - 1) * width + x] = ' ' | default_color;
		}
	}
}

void handleTab() {
	if (column == width) {
		newLine();
	}

	uint16_t tab = 2 - (column % 2);

	while (tab--) {
		vga[row * width + (column++)] = ' ' | default_color;
	}
}

void screenColor(uint16_t color) {
	for (uint16_t y = 0; y < height; y++) {
		for (uint16_t x = 0; x < width; x++) {
			vga[y * width + x] = (vga[y * width + x] & 0x00FF) | (color << 12);
		}
	}
}

void print(const char *message) {
	while (*message) {
		if (*message == '\n') {
			newLine();
		} else if (*message == '\r') {
			column = 0;
		} else if (*message == '\t') {
			handleTab();
		} else {
			if (column == width) {
				newLine();
			}
			vga[row * width + (column++)] = *message | default_color;
		}
		message++;
	}
}

void error(const char *error) {
	while (*error) {
		if (*error == '\n') {
			newLine();
		} else if (*error == '\r') {
			column = 0;
		} else if (*error == '\t') {
			handleTab();
		} else {
			if (column == width) {
				newLine();
			}
			vga[row * width + (column++)] = *error | (VGA_WHITE << 8) | (VGA_RED << 12);
		}
		error++;
	}
}