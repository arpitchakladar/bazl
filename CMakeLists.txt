cmake_minimum_required(VERSION 3.22)

if (NOT "${CMAKE_BUILD_TYPE}" STREQUAL "Release")
	set (CMAKE_BUILD_TYPE "Debug")
endif ()

set(KERNEL_SIZE_KB 20)
math(EXPR KERNEL_SECTOR_COUNT "${KERNEL_SIZE_KB} * 2")
set(KERNEL_START 0x1000)

add_subdirectory(kernel)
add_subdirectory(boot-loader)

project(Bazl)

set(bazl_TARGET_FILE "${CMAKE_CURRENT_BINARY_DIR}/bazl")

add_custom_target(
	bazl
		ALL
		DEPENDS kernel boot-loader
		COMMAND cat $<TARGET_FILE:boot-loader> $<TARGET_FILE:kernel> > ${bazl_TARGET_FILE}
			&& truncate -s ${KERNEL_SIZE_KB}k ${bazl_TARGET_FILE}
		VERBATIM
)

if ("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
	set(bazl_test_image_TARGET_FILE "${CMAKE_CURRENT_BINARY_DIR}/bazl-test.img")

	add_custom_target(
		bazl-test.img
			ALL
			DEPENDS bazl
			COMMAND cat ${bazl_TARGET_FILE} > ${bazl_test_image_TARGET_FILE}
				&& truncate -s 1m ${bazl_test_image_TARGET_FILE}
			VERBATIM
	)
endif ()
