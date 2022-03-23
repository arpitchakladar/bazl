cmake_minimum_required(VERSION 3.22)

project(BazlKernal LANGUAGES ASM_NASM C)

# Setting linkers and compilers

set(CMAKE_LINKER ${LINKER})
set(CMAKE_C_COMPILER ${C_COMPILER})

# Getting sources
file(GLOB_RECURSE ASM_NASM_SOURCES "${PROJECT_SOURCE_DIR}/src/*.asm")
file(GLOB_RECURSE C_SOURCES "${PROJECT_SOURCE_DIR}/src/*.c")

# Linking
set(CMAKE_EXE_LINKER_FLAGS "--oformat binary -m elf_i386 -Ttext ${KERNAL_START}")
set(CMAKE_LINK_EXECUTABLE "<CMAKE_LINKER> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")

# C
set(CMAKE_C_FLAGS "-m16 -ffreestanding -g -nostdlib -nostartfiles -Wno-pointer-to-int-cast")
if ("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O0")
elseif ("${CMAKE_BUILD_TYPE}" STREQUAL "Release")
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -O3")
endif ()

set(CMAKE_C_LINK_EXECUTABLE ${CMAKE_LINK_EXECUTABLE})

# ASM_NASM
set(CMAKE_ASM_NASM_COMPILE_OBJECT "<CMAKE_ASM_NASM_COMPILER> <DEFINES> -f elf -o <OBJECT> <SOURCE>")
set(CMAKE_ASM_NASM_LINK_EXECUTABLE ${CMAKE_LINK_EXECUTABLE})

add_executable(kernal "${PROJECT_SOURCE_DIR}/src/kernal_loader.asm" ${ASM_NASM_SOURCES} ${C_SOURCES})
target_include_directories(kernal PRIVATE "${PROJECT_SOURCE_DIR}/src")
math(EXPR FREE_SECTOR_START "${KERNAL_SECTOR_COUNT} + 1")
target_compile_definitions(kernal PRIVATE FREE_SECTOR_START=${FREE_SECTOR_START})
