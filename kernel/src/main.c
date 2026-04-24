#include "utils/int.h"

void kmain(void) {
	volatile uint16_t* video = (uint16_t*)0xB8000;

	for (uint8_t i = 0; i < 26; i++) {
		video[i] = 0x0F41 + i;
	}
}
