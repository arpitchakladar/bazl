#include "utils/int.h"

#pragma once

extern const uint8_t BOOT_DRIVE_NUMBER;

// destination, sector count, cylinder number, sector number, head, drive
void disk_read_sectors(char *, uint8_t, uint8_t, uint8_t, uint8_t, uint8_t);

// source, sector count, cylinder number, sector number, head, drive
void disk_write_sectors(char *, uint8_t, uint8_t, uint8_t, uint8_t, uint8_t);
