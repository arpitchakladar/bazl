#include "vga/vga.h"

void kmain(void) {
	vga_write_text("Hello, World!\n",
								 vga_color(VGA_COLOR_WHITE, VGA_COLOR_BLACK));
	vga_write_text("This is in the next line.",
								 vga_color(VGA_COLOR_WHITE, VGA_COLOR_BLACK));
}
