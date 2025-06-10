#include "utils/core.h"

void main() {
	for (uint8_t i = 0; i < 26; i++) {
		uint8_t j = i * 2;
		*(char*)(0xb8000 + j) = 'A' + (char) i;
		*(char*)(0xb8001 + j) = 0x0f;
	}
	return;
}
