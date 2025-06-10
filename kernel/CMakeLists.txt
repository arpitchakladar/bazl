cmake_minimum_required(VERSION 3.22)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR i686)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

project(BazlKernal LANGUAGES ASM_NASM C)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH};${CMAKE_CURRENT_SOURCE_DIR}/cmake")

# Getting sources
file(GLOB_RECURSE ASM_NASM_SOURCES "${PROJECT_SOURCE_DIR}/src/*.asm")
file(GLOB_RECURSE C_SOURCES "${PROJECT_SOURCE_DIR}/src/*.c")

include(Link)
include(C)
include(Nasm)

add_executable(kernel ${ASM_NASM_SOURCES} ${C_SOURCES})
target_include_directories(kernel PRIVATE "${PROJECT_SOURCE_DIR}/src")
