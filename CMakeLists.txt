cmake_minimum_required(VERSION 3.22)

project(Bazl LANGUAGES ASM_NASM C)

if (NOT "${CMAKE_BUILD_TYPE}" STREQUAL "Release")
	set (CMAKE_BUILD_TYPE "Debug")
endif ()

set(KERNAL_SIZE_KB 20)
math(EXPR KERNAL_SECTOR_COUNT "${KERNAL_SIZE_KB} * 2")
math(EXPR _KERNAL_START "65535 - (${KERNAL_SECTOR_COUNT} * 512) + 1")

function(to_hex DEC HEX)
    while(DEC GREATER 0)
        math(EXPR _val "${DEC} % 16")
        math(EXPR DEC "${DEC} / 16")
        if(_val EQUAL 10)
            set(_val "A")
        elseif(_val EQUAL 11)
            set(_val "B")
        elseif(_val EQUAL 12)
            set(_val "C")
        elseif(_val EQUAL 13)
            set(_val "D")
        elseif(_val EQUAL 14)
            set(_val "E")
        elseif(_val EQUAL 15)
            set(_val "F")
        endif()
        set(_res "${_val}${_res}")
    endwhile()
    set(${HEX} "0x${_res}" PARENT_SCOPE)
endfunction()

to_hex(${_KERNAL_START} KERNAL_START)

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
