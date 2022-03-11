cmake_minimum_required(VERSION 3.22)

project(BazlKernal LANGUAGES ASM_NASM)

file(GLOB_RECURSE SOURCES "${PROJECT_SOURCE_DIR}/src/*.asm")

set(CMAKE_LINKER /bin/ld)
set(CMAKE_ASM_NASM_COMPILE_OBJECT "<CMAKE_ASM_NASM_COMPILER> -o <OBJECT> -f elf <SOURCE>")
set(CMAKE_ASM_NASM_LINK_EXECUTABLE "<CMAKE_LINKER> --oformat binary -m elf_i386 -Ttext 0x7e00 <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")

add_executable(kernal "${PROJECT_SOURCE_DIR}/src/kernal_loader.asm" ${SOURCES})
