#include "io/disk.h"
#include "utils/int.h"
#include "utils/ptr.h"
#include "utils/buf.h"
#include "mem/dyn.h"

const uint8_t BOOT_DRIVE_NUMBER;

void disk_read_buf(char *dst_buf, uint8_t sec, uintptr_t buf_len) {
	uint8_t sec_count = buf_len / SECTOR_SIZE;
	uint8_t rest_buf_len = buf_len % SECTOR_SIZE;
	if (rest_buf_len > 0) {
		char *temp_buf = dyn_alloc(SECTOR_SIZE);
		disk_read_sec(temp_buf, sec + sec_count, 1);
		buf_copy(dst_buf + (sec_count * SECTOR_SIZE), temp_buf, rest_buf_len);
		dyn_dealloc(temp_buf);
	}
	disk_read_sec(dst_buf, sec, sec_count);
}

void disk_write_buf(char *src_buf, uint8_t sec, uintptr_t buf_len) {
	uint8_t sec_count = buf_len / SECTOR_SIZE;
	uint8_t rest_buf_len = buf_len % SECTOR_SIZE;
	if (rest_buf_len > 0) {
		char *temp_buf = dyn_alloc(SECTOR_SIZE);
		buf_copy(temp_buf, src_buf + (sec_count * SECTOR_SIZE), rest_buf_len);
		buf_set(temp_buf + rest_buf_len, 0, SECTOR_SIZE - rest_buf_len);
		disk_write_sec(temp_buf, sec + sec_count, 1);
		dyn_dealloc(temp_buf);
	}
	disk_write_sec(src_buf, sec, sec_count);
}
