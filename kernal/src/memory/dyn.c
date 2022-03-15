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
	alloc_t *smallest_free_entry = null_ptr;
	bool no_free_dealloc_memory = true;
	for (int i = 0; i < MAX_ALLOCATIONS; i++) {
		alloc_t *entry = alloc_entries + i;
		if(!entry->occupied) {
			if (entry->length >= length) {
				if (no_free_dealloc_memory || smallest_free_entry->length > entry->length)
					smallest_free_entry = entry;
				no_free_dealloc_memory = false;
			} else if (no_free_dealloc_memory)
				if (smallest_free_entry == null_ptr)
					smallest_free_entry = entry;
				else if (smallest_free_entry->length > entry->length)
					smallest_free_entry = entry;
		}
	}

	if (no_free_dealloc_memory) {
		void *next_last_alloc_ptr = last_alloc_ptr + length;

		if (((uintptr_t) next_last_alloc_ptr) < 0xffff) {
			smallest_free_entry->ptr = last_alloc_ptr;
			smallest_free_entry->length = length;
			smallest_free_entry->occupied = true;
			last_alloc_ptr = next_last_alloc_ptr;
		} else
			smallest_free_entry->ptr = null_ptr;
	}

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
