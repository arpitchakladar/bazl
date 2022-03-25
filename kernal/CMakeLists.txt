cmake_minimum_required(VERSION 3.22)

project(BazlKernal LANGUAGES ASM_NASM C)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH};${CMAKE_CURRENT_SOURCE_DIR}/cmake")

# Setting linkers and compilers

set(CMAKE_LINKER ${LINKER})
set(CMAKE_C_COMPILER ${C_COMPILER})

# Getting sources
file(GLOB_RECURSE ASM_NASM_SOURCES "${PROJECT_SOURCE_DIR}/src/*.asm")
file(GLOB_RECURSE C_SOURCES "${PROJECT_SOURCE_DIR}/src/*.c")

include(Link)
include(C)
include(Nasm)

add_executable(kernal "${PROJECT_SOURCE_DIR}/src/kernal_loader.asm" ${ASM_NASM_SOURCES} ${C_SOURCES})
target_include_directories(kernal PRIVATE "${PROJECT_SOURCE_DIR}/src")
math(EXPR FREE_SECTOR_START "${KERNAL_SECTOR_COUNT} + 1")
target_compile_definitions(kernal PRIVATE FREE_SECTOR_START=${FREE_SECTOR_START})
