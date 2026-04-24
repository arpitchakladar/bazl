#include "vga/vga.h"
#include "utils/int.h"

#define VGA_ADDRESS 0xB8000
#define VGA_WIDTH 80
#define VGA_HEIGHT 25

static uint16_t cursor_x = 0;
static uint16_t cursor_y = 0;

static uint16_t *vga_buffer = (uint16_t *)VGA_ADDRESS;

static void outb(uint16_t port, uint8_t value) {
	__asm__ volatile("outb %0, %1" : : "a"(value), "Nd"(port));
}

static void vga_update_cursor() {
	uint16_t pos = (cursor_y * VGA_WIDTH) + cursor_x;
	outb(0x3D4, 14);
	outb(0x3D5, (uint8_t)(pos >> 8));
	outb(0x3D4, 15);
	outb(0x3D5, (uint8_t)pos);
}

static void vga_new_line() {
	cursor_x = 0;
	cursor_y++;
	if (cursor_y >= VGA_HEIGHT) {
		vga_scroll_up();
		cursor_y = VGA_HEIGHT - 1;
	}
	vga_update_cursor();
}

void vga_write_char(char c, uint8_t color) {
	if (c == '\n') {
		vga_new_line();
		return;
	}
	if (c == '\r') {
		cursor_x = 0;
		return;
	}
	vga_buffer[(cursor_y * VGA_WIDTH) + cursor_x] = (color << 8) | c;
	cursor_x++;
	if (cursor_x >= VGA_WIDTH) {
		vga_new_line();
	}
	vga_update_cursor();
}

void vga_write_text(const char *text, uint8_t color) {
	while (*text) {
		vga_write_char(*text++, color);
	}
}

void vga_reset() {
	cursor_x = 0;
	cursor_y = 0;
	for (uint16_t i = 0; i < VGA_HEIGHT * VGA_WIDTH; i++) {
		vga_buffer[i] = (VGA_COLOR_BLACK << 8) | ' ';
	}
	vga_update_cursor();
}

void vga_scroll_up() {
	for (uint16_t y = 0; y < VGA_HEIGHT - 1; y++) {
		for (uint16_t x = 0; x < VGA_WIDTH; x++) {
			vga_buffer[(y * VGA_WIDTH) + x] = vga_buffer[((y + 1) * VGA_WIDTH) + x];
		}
	}

	for (uint16_t x = 0; x < VGA_WIDTH; x++) {
		vga_buffer[((VGA_HEIGHT - 1) * VGA_WIDTH) + x] =
				(VGA_COLOR_BLACK << 8) | ' ';
	}

	if (cursor_y > 0) {
		cursor_y -= 1;
	}

	vga_update_cursor();
}
