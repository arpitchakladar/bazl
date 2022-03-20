#include "io/disk.h"
#include "utils/int.h"
#include "utils/bool.h"

#pragma once

#define FILE_NAME_MAX_LENGTH 128

void file_create(char *, uintptr_t);
void file_rename(char *, char *);
void file_delete(char *);
void file_write(char *, uint8_t *, uintptr_t);
uintptr_t file_read(char *, uint8_t **);
