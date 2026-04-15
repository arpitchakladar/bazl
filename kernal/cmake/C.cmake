set(CMAKE_C_FLAGS "-m16 -march=i386 -ffreestanding -g -nostdlib -nostartfiles -Wno-pointer-to-int-cast")

if ("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O0")
elseif ("${CMAKE_BUILD_TYPE}" STREQUAL "Release")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -O3")
endif()

# Use ld directly, but correctly — no -Wl, prefix needed
set(CMAKE_C_LINK_EXECUTABLE
    "${LINKER} -m elf_i386 --oformat binary -Ttext 0xb000 <OBJECTS> -o <TARGET>"
)

# Suppress CMake from adding dependency tracking to the linker
set(CMAKE_DEPFILE_FLAGS_C "")
set(CMAKE_C_LINKER_DEPFILE_FLAGS "")
