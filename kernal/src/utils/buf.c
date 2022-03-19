#include "utils/buf.h"

#include "utils/int.h"

void buf_copy(uint8_t *dst_buf, uint8_t *src_buf, uintptr_t len) {
	for (uintptr_t i = 0; i < len; i++)
		dst_buf[i] = src_buf[i];
}

void buf_set(uint8_t *buf, uint8_t value, uintptr_t len) {
	for (uintptr_t i = 0; i < len; i++)
		buf[i] = value;
}
