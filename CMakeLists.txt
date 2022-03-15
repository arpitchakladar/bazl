cmake_minimum_required(VERSION 3.22)

project(Bazl LANGUAGES ASM_NASM C)

if (NOT "${CMAKE_BUILD_TYPE}" STREQUAL "Release")
	set (CMAKE_BUILD_TYPE "Debug")
endif ()

set(KERNAL_SIZE_KB 10)
math(EXPR KERNAL_SECTOR_COUNT "(${KERNAL_SIZE_KB} * 2) - 1")

add_subdirectory(kernal)
add_subdirectory(boot_loader)

set(bazl_TARGET_FILE "${CMAKE_CURRENT_BINARY_DIR}/bazl")

add_custom_target(bazl
	ALL
	DEPENDS kernal boot_loader
	COMMAND cat $<TARGET_FILE:boot_loader> $<TARGET_FILE:kernal> > ${bazl_TARGET_FILE} && truncate -s ${KERNAL_SIZE_KB}k ${bazl_TARGET_FILE}
	VERBATIM)

set(bazl_test_image_TARGET_FILE "${CMAKE_CURRENT_BINARY_DIR}/bazl-test.img")

# Create a 1 megabyte image for testing
if ("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
	add_custom_target(bazl_test_image
		ALL
		DEPENDS bazl
		COMMAND cat ${bazl_TARGET_FILE} > ${bazl_test_image_TARGET_FILE} && truncate -s 1m ${bazl_test_image_TARGET_FILE}
		VERBATIM)
endif ()
