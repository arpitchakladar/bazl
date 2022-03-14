#include "utils/int.h"
#include "utils/bool.h"
#include "utils/ptr.h"
#include "memory/dyn.h"

typedef struct {
	void *ptr;
	uint16_t length;
	bool occupied;
} alloc_t;

#define MAX_ALLOCATIONS 64
#define alloc_entries ((alloc_t *) 0xa400)
static void *last_alloc_ptr = alloc_entries + (sizeof(alloc_t) * MAX_ALLOCATIONS);

void *memory_alloc(uint16_t length) {
	alloc_t *smallest_free_entry = nullptr;
	for (int i = 0; i < MAX_ALLOCATIONS; i++) {
		alloc_t *entry = alloc_entries + i;
		if(!entry->occupied) {
			if (entry->length >= length) {
				smallest_free_entry->occupied = true;
				return entry->ptr;
			} else if (smallest_free_entry == nullptr)
				smallest_free_entry = entry;
			else if (smallest_free_entry->length > entry->length)
				smallest_free_entry = entry;
		}
	}

	void *next_last_alloc_ptr = last_alloc_ptr + length;

	if (((uintptr_t) next_last_alloc_ptr) < 0xffff) {
		smallest_free_entry->ptr = last_alloc_ptr;
		smallest_free_entry->length = length;
		smallest_free_entry->occupied = true;
		last_alloc_ptr = next_last_alloc_ptr;
	} else
		smallest_free_entry->ptr = nullptr;

	return smallest_free_entry->ptr;
}

void memory_dealloc(void *ptr) {
	for (int i = 0; i < MAX_ALLOCATIONS; i++) {
		alloc_t *entry = alloc_entries + i;
		if (entry->ptr == ptr) {
			entry->occupied = false;
			return;
		}
	}
}
