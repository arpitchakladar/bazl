#include "core/types.h"

#pragma once

typedef struct {
	void *pointer;
	uint16_t length;
	bool occupied;
} allocation_t;

void *memory_allocate(uint16_t);
void memory_deallocate(void *);
