#include "utils/int.h"

#pragma once

#define SECTOR_SIZE 512

extern const uint8_t BOOT_DRIVE_NUMBER;

// destination, sector number, sector count
void disk_read_sec(char *, uint8_t, uint8_t);

// source, sector number, sector count
void disk_write_sec(char *, uint8_t, uint8_t);

// destination, sector number, buffer size
void disk_read_buf(char *, uint8_t, uintptr_t);

// source, sector number, buffer size
void disk_write_buf(char *, uint8_t, uintptr_t);
