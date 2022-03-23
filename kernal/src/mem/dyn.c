#include "mem/dyn.h"

#include "utils/int.h"
#include "utils/bool.h"
#include "utils/ptr.h"

typedef struct {
	void *ptr;
	uintptr_t len;
	bool occupied;
} alloc_t;

#define ALLOCATION_COUNT 64
#define alloc_entries ((alloc_t *) 0x500)
static void *last_alloc_ptr = alloc_entries + (sizeof(alloc_t) * ALLOCATION_COUNT);

void *dyn_alloc(uintptr_t len) {
	alloc_t free_entry = {
		.ptr = null_ptr,
		.len = 0,
		.occupied = false
	};
	bool occupied_available = false;
	for (int i = 0; i < ALLOCATION_COUNT; i++) {
		alloc_t *entry = alloc_entries + i;
		if(!entry->occupied) {
			if (entry->len >= len) {
				if (!occupied_available || free_entry.len > entry->len)
					free_entry = *entry;
				occupied_available = true;
			} else if (!occupied_available && (free_entry.ptr == null_ptr || free_entry.len > entry->len))
				free_entry = *entry;
		}
	}

	if (!occupied_available) {
		void *next_last_alloc_ptr = last_alloc_ptr + len;

		free_entry.ptr = last_alloc_ptr;
		free_entry.len = len;
		free_entry.occupied = true;
		last_alloc_ptr = next_last_alloc_ptr;
	}

	return free_entry.ptr;
}

void dyn_dealloc(void *ptr) {
	if (ptr != null_ptr) {
		for (int i = 0; i < ALLOCATION_COUNT; i++) {
			alloc_t *entry = alloc_entries + i;
			uintptr_t offset = ptr - entry->ptr;
			if (offset == 0) {
				entry->occupied = false;
				break;
			} else if (offset > 0 && offset < entry->len) {
				alloc_t *new_entry = null_ptr;
				uintptr_t new_entry_len = entry->len - offset;
				for (int j = 0; j < ALLOCATION_COUNT; j++) {
					alloc_t *current_entry = alloc_entries + j;
					if (!current_entry->occupied && new_entry_len > current_entry->len && (new_entry == null_ptr || new_entry->len > current_entry->len))
						new_entry = current_entry;
				}
				if (new_entry != null_ptr) {
					new_entry->len = new_entry_len;
					new_entry->ptr = ptr;
					entry->len = offset;
				}
				break;
			}
		}
	}
}
