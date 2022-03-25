cmake_minimum_required(VERSION 3.22)

if (NOT "${CMAKE_BUILD_TYPE}" STREQUAL "Release")
	set (CMAKE_BUILD_TYPE "Debug")
endif ()

project(Bazl LANGUAGES ASM_NASM C)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH};${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(Hex)
include(Kernal)

add_subdirectory(kernal)
add_subdirectory(boot_loader)

include(Bazl)

if ("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
	include(BazlTestImage)
endif ()
