cmake_minimum_required(VERSION 3.22)

if (NOT "${CMAKE_BUILD_TYPE}" STREQUAL "Release")
	set (CMAKE_BUILD_TYPE "Debug")
endif ()

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH};${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(Hex)
include(Kernel)

add_subdirectory(kernel)
add_subdirectory(boot-loader)

project(Bazl)

include(Bazl)

if ("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
	include(BazlTestImage)
endif ()
