cmake_minimum_required(VERSION 3.22)

project(BazlBootLoader LANGUAGES ASM_NASM)

set(CMAKE_ASM_NASM_COMPILE_OBJECT "<CMAKE_ASM_NASM_COMPILER> -dSECTOR_COUNT=${SECTOR_COUNT} -o <OBJECT> -f bin <SOURCE>")
set(CMAKE_ASM_NASM_LINK_EXECUTABLE "/bin/sh -ec \"cat <OBJECTS> > <TARGET>\"")

add_executable(boot_loader "${PROJECT_SOURCE_DIR}/src/boot_loader.asm")
