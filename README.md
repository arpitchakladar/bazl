# Bazl
A simple CLI OS for intel 386 architecture. Operates in 16-bit real mode, and is written in NASM assembly and C.

## Table Of Contents
- [Requirements](#requirements)
- [Getting Started](#getting-started)

### Requirements
- cmake (>= 3.22)
- nasm (>= 2.15.05)
- i386-elf-gcc (>= 11.2.0)
- i386-elf-binutils (>= 2.38.0)

### Getting Started
1. Clone the repository.
```sh
git clone https://github.com/arpitchakladar/bazl
cd bazl
```
2. Use cmake with flags -DLINKER and -DC_COMPILER, to use i386 cross compiler and linker.
```sh
cmake -B build -DLINKER=$(where i386-elf-ld) -DC_COMPILER=$(where i386-elf-gcc)
```
3. Build using the build system
```sh
make -C build
```
4. Run with an emulator (preferably QEMU)
```sh
qemu-system-i386 build/bazl
```
