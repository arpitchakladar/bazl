cmake_minimum_required(VERSION 3.22)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR i686)

set(CMAKE_ASM_NASM_COMPILER nasm)
set(CMAKE_LINKER i686-elf-ld)

set(CMAKE_EXE_LINKER_FLAGS "-nostdlib -ffreestanding")
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

project(BazlBootLoader LANGUAGES ASM_NASM)

set(CMAKE_ASM_NASM_COMPILE_OBJECT "${CMAKE_ASM_NASM_COMPILE_OBJECT} -f bin")
set(CMAKE_ASM_NASM_LINK_EXECUTABLE "/bin/sh -ec \"cat <OBJECTS> > <TARGET>\"")
add_executable(boot-loader "${PROJECT_SOURCE_DIR}/src/boot-loader.asm")
target_compile_definitions(boot-loader PRIVATE KERNEL_SECTOR_COUNT=${KERNEL_SECTOR_COUNT} KERNEL_START=${KERNEL_START})
