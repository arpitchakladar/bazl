cmake_minimum_required(VERSION 3.22)

project(BazlBootLoader LANGUAGES ASM_NASM)

set(CMAKE_ASM_NASM_COMPILE_OBJECT "${CMAKE_ASM_NASM_COMPILE_OBJECT} -f bin")
set(CMAKE_ASM_NASM_LINK_EXECUTABLE "/bin/sh -ec \"cat <OBJECTS> > <TARGET>\"")

add_executable(boot_loader "${PROJECT_SOURCE_DIR}/src/boot_loader.asm")
target_compile_definitions(boot_loader PRIVATE KERNAL_SECTOR_COUNT=${KERNAL_SECTOR_COUNT})
