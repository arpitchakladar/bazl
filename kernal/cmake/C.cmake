set(CMAKE_C_FLAGS "-m16 -ffreestanding -g -nostdlib -nostartfiles -Wno-pointer-to-int-cast")
if ("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O0")
elseif ("${CMAKE_BUILD_TYPE}" STREQUAL "Release")
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -O3")
endif ()

set(CMAKE_C_LINK_EXECUTABLE ${CMAKE_LINK_EXECUTABLE})
