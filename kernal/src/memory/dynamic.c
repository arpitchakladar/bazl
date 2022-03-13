#include "core/types.h"
#include "memory/dynamic.h"

#define DYNAMIC_ALLOCATION_ENTRY_LENGTH 64
#define allocation_entries ((allocation_t *) 0x5d00)
static void *last_allocation_pointer = 0;

void *memory_allocate(uint16_t length) {
	allocation_t *smallest_free_entry = nullptr;
	for (int i = 0; i < DYNAMIC_ALLOCATION_ENTRY_LENGTH; i++) {
		allocation_t *entry = allocation_entries + i;
		if(!entry->occupied) {
			if (entry->length >= length) {
				smallest_free_entry->occupied = true;
				return entry->pointer;
			} else if (smallest_free_entry == nullptr)
				smallest_free_entry = entry;
			else if (smallest_free_entry->length > entry->length)
				smallest_free_entry = entry;
		}
	}

	void *next_last_allocation_pointer = last_allocation_pointer + length;

	if (((uintptr_t) next_last_allocation_pointer) < 0x5d00) {
		smallest_free_entry->pointer = last_allocation_pointer;
		smallest_free_entry->length = length;
		smallest_free_entry->occupied = true;
		last_allocation_pointer = next_last_allocation_pointer;
	} else
		smallest_free_entry->pointer = nullptr;

	return smallest_free_entry->pointer;
}

void memory_deallocate(void *pointer) {
	for (int i = 0; i < DYNAMIC_ALLOCATION_ENTRY_LENGTH; i++) {
		allocation_t *entry = allocation_entries + i;
		if (entry->pointer == pointer) {
			entry->occupied = false;
			return;
		}
	}
}
