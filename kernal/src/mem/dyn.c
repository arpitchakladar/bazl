#include "utils/int.h"
#include "utils/bool.h"
#include "utils/ptr.h"
#include "mem/dyn.h"

typedef struct {
	void *ptr;
	uintptr_t len;
	bool occupied;
} alloc_t;

#define MAX_ALLOCATIONS 64
#define alloc_entries ((alloc_t *) 0xa400)
static void *last_alloc_ptr = alloc_entries + (sizeof(alloc_t) * MAX_ALLOCATIONS);

void *dyn_alloc(uintptr_t len) {
	alloc_t *free_entry = null_ptr;
	bool no_freed = true;
	for (int i = 0; i < MAX_ALLOCATIONS; i++) {
		alloc_t *entry = alloc_entries + i;
		if(!entry->occupied) {
			if (entry->len >= len) {
				if (no_freed || free_entry->len > entry->len)
					free_entry = entry;
				no_freed = false;
			} else if (no_freed && (free_entry == null_ptr || free_entry->len > entry->len))
				free_entry = entry;
		}
	}

	if (no_freed) {
		void *next_last_alloc_ptr = last_alloc_ptr + len;

		if (((uintptr_t) next_last_alloc_ptr) < 0xffff) {
			free_entry->ptr = last_alloc_ptr;
			free_entry->len = len;
			free_entry->occupied = true;
			last_alloc_ptr = next_last_alloc_ptr;
		} else
			free_entry->ptr = null_ptr;
	}

	return free_entry->ptr;
}

void dyn_dealloc(void *ptr) {
	if (ptr != null_ptr) {
		for (int i = 0; i < MAX_ALLOCATIONS; i++) {
			alloc_t *entry = alloc_entries + i;
			uintptr_t offset = ptr - entry->ptr;
			if (offset == 0) {
				entry->occupied = false;
				break;
			} else if (offset > 0 && offset < entry->len) {
				alloc_t *new_entry = null_ptr;
				uintptr_t new_entry_len = entry->len - offset;
				for (int j = 0; j < MAX_ALLOCATIONS; j++) {
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
