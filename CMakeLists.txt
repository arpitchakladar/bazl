cmake_minimum_required(VERSION 3.22)

project(Bazl LANGUAGES ASM_NASM)

set(SECTOR_COUNT 19) # For 10k, each sector = 512 bytes and the first sector is the boot loader

add_subdirectory(kernal)
add_subdirectory(boot_loader)

add_custom_target(bazl
	ALL
	DEPENDS kernal boot_loader
	COMMAND cat $<TARGET_FILE:boot_loader> $<TARGET_FILE:kernal> > bazl && truncate -s 10k bazl
	VERBATIM)
