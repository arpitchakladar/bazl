cmake_minimum_required(VERSION 3.22)
cmake_policy(SET CMP0116 OLD)  # disables depfile generation entirely

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR i686)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

project(BazlKernal LANGUAGES ASM_NASM C)

# Getting sources
file(
	GLOB_RECURSE ASM_NASM_SOURCES
		"${PROJECT_SOURCE_DIR}/src/*.asm"
)
file(
	GLOB_RECURSE C_SOURCES
		"${PROJECT_SOURCE_DIR}/src/*.c"
)

# Linker
set(CMAKE_LINKER i686-elf-ld)
set(
	CMAKE_EXE_LINKER_FLAGS
		"--oformat binary -nostdlib -Ttext ${KERNEL_START}"
)
set(
	CMAKE_LINK_EXECUTABLE
		"<CMAKE_LINKER> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>"
)
set(CMAKE_C_LINK_EXECUTABLE ${CMAKE_LINK_EXECUTABLE})
set(CMAKE_ASM_NASM_LINK_EXECUTABLE ${CMAKE_LINK_EXECUTABLE})

# C
set(CMAKE_C_COMPILER i686-elf-gcc)
set(CMAKE_C_FLAGS "-ffreestanding -m32 -g")
if ("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O0")
elseif ("${CMAKE_BUILD_TYPE}" STREQUAL "Release")
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -O3")
endif ()

# NASM
set(CMAKE_ASM_NASM_COMPILER nasm)
set(
	CMAKE_ASM_NASM_COMPILE_OBJECT
		"<CMAKE_ASM_NASM_COMPILER> <DEFINES> -f elf -o <OBJECT> <SOURCE>"
)

add_executable(kernel ${ASM_NASM_SOURCES} ${C_SOURCES})
target_include_directories(kernel PRIVATE "${PROJECT_SOURCE_DIR}/src")

set(KERNEL_SECTOR_COUNT_TXT "${CMAKE_BINARY_DIR}/kernel_sector_count.txt")
