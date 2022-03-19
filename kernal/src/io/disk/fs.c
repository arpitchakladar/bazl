#include "io/disk/fs.h"

#include "utils/int.h"
#include "utils/str.h"
#include "utils/ptr.h"
#include "io/disk.h"
#include "mem/dyn.h"

typedef struct {
	char name[FILE_NAME_MAX_LENGTH];
	uint8_t sec;
	uint8_t sec_count;
	bool occupied;
} file_t;

static uint8_t last_free_sec = FREE_SECTOR_START;

uint8_t get_sec_count(uint16_t len) {
	uint8_t sec_count = len / SECTOR_SIZE;
	if (sec_count * SECTOR_SIZE < len)
		sec_count++;
	return sec_count;
}

uint8_t find_file(char *name, file_t **dst_file) {
	file_t *file = dyn_alloc(sizeof(file_t));
	for (uint8_t sec = FREE_SECTOR_START; sec < last_free_sec; sec = file->sec + file->sec_count) {
		disk_read_buf((uint8_t *) file, sec, sizeof(file_t));
		if (file->occupied && str_equal(name, file->name)) {
			*dst_file = file;
			return sec;
		}
	}
	dyn_dealloc(file);
	*dst_file = null_ptr;
	return 0;
}

void file_create(char *name, uintptr_t len) {
	uint8_t req_sec_count = get_sec_count(len);
	file_t *file = dyn_alloc(sizeof(file_t));
	file_t *free_file = null_ptr;
	uint8_t free_file_desc_sec;
	bool name_unused = true;
	for (uint8_t sec = FREE_SECTOR_START; sec < last_free_sec; sec = file->sec + file->sec_count) {
		disk_read_buf((uint8_t *) file, sec, sizeof(file_t));
		if (!file->occupied) {
			if (str_equal(name, file->name)) {
				name_unused = false;
				break;
			} else if (file->sec_count >= req_sec_count && (free_file == null_ptr || free_file->sec_count > file->sec_count)) {
				free_file = file;
				free_file_desc_sec = sec;
			}
		}
	}

	if (name_unused) {
		if (free_file == null_ptr) {
			free_file_desc_sec = last_free_sec;
			free_file = dyn_alloc(sizeof(file_t));
			free_file->sec = ++last_free_sec;
			free_file->sec_count = req_sec_count;
			free_file->occupied = true;
			last_free_sec += req_sec_count;
			str_copy(free_file->name, name);
			disk_write_buf((uint8_t *) free_file, free_file_desc_sec, sizeof(file_t));
			dyn_dealloc(free_file);
		} else {
			str_copy(free_file->name, name);
			free_file->occupied = true;
			disk_write_buf((uint8_t *) free_file, free_file_desc_sec, sizeof(file_t));
		}
	}

	dyn_dealloc(file);
}

void file_delete(char *name) {
	file_t *file;
	uint8_t sec = find_file(name, &file);
	if (file != null_ptr) {
		file->occupied = false;
		disk_write_buf((uint8_t *) file, sec, sizeof(file_t));
		dyn_dealloc(file);
	}
}

void file_write(char *name, uint8_t *buf, uintptr_t buf_len) {
	file_t *file;
	uint8_t sec = find_file(name, &file);
	if (file != null_ptr) {
		if (file->sec_count * SECTOR_SIZE >= buf_len)
			disk_write_buf(buf, file->sec, buf_len);

		dyn_dealloc(file);
	}
}

uintptr_t file_read(char *name, uint8_t **dst_buf) {
	file_t *file;
	uint8_t sec = find_file(name, &file);
	uintptr_t len = 0;
	if (file == null_ptr)
		*dst_buf = null_ptr;
	else {
		len = file->sec_count * SECTOR_SIZE;
		*dst_buf = dyn_alloc(len);
		disk_read_sec(*dst_buf, file->sec, file->sec_count);
		dyn_dealloc(file);
	}
	return len;
}
