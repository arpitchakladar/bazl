cmake_minimum_required(VERSION 3.22)

project(BazlKernal LANGUAGES ASM_NASM C)

# Setting linkers and compilers

set(CMAKE_LINKER ${LINKER})
set(CMAKE_C_COMPILER ${C_COMPILER})

# Getting sources
file(GLOB_RECURSE ASM_NASM_SOURCES "${PROJECT_SOURCE_DIR}/src/*.asm")
file(GLOB_RECURSE C_SOURCES "${PROJECT_SOURCE_DIR}/src/*.c")

# Linking command
set(CMAKE_LINK_EXECUTABLE "<CMAKE_LINKER> --oformat binary -m elf_i386 -Ttext 0x7e00 <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")

# C
## Compile to GAS assembly and then compile the GAS file with ".code16" directive
set(CMAKE_C_COMPILE_OBJECT "<CMAKE_C_COMPILER> -m16 -ffreestanding -S -g -nostdlib -nostartfiles  -I ${PROJECT_SOURCE_DIR}/src -o <OBJECT>.s <SOURCE> && <CMAKE_C_COMPILER> -I ${PROJECT_SOURCE_DIR}/src -m16 -ffreestanding -c -g -nostdlib -nostartfiles -o <OBJECT> <OBJECT>.s")
set(CMAKE_C_LINK_EXECUTABLE ${CMAKE_LINK_EXECUTABLE})

# ASM_NASM
set(CMAKE_ASM_NASM_COMPILE_OBJECT "<CMAKE_ASM_NASM_COMPILER> -o <OBJECT> -f elf <SOURCE>")
set(CMAKE_ASM_NASM_LINK_EXECUTABLE ${CMAKE_LINK_EXECUTABLE})

add_executable(kernal "${PROJECT_SOURCE_DIR}/src/kernal_loader.asm" ${ASM_NASM_SOURCES} ${C_SOURCES})
target_include_directories(kernal PRIVATE "${PROJECT_SOURCE_DIR}/src")
