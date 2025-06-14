# Bazl
A simple CLI OS for x86 architecture. Runs in 32-bit protected mode, and is written in NASM assembly and C.

## Table Of Contents
- [Requirements](#requirements)
- [Getting Started](#getting-started)
- [ToDo List](#todo-list)

### Requirements
- cmake (>= 3.22)
- nasm (>= 2.15.05)
- i686-elf-gcc (>= 13.2.0)
- i686-elf-ld (>= 2.41)

### Getting Started
1. Clone the repository.
```sh
git clone https://github.com/arpitchakladar/bazl
cd bazl
```
2. Run a build script. (For the first time "i686-elf-gcc" and "i686-elf-ld" must be in your PATH)
```sh
scripts/build-make.sh
```
or for another generator.
```sh
scripts/build.sh -G <generator>
```
3. Run with an emulator (preferably QEMU)
```sh
scripts/test-qemu.sh
```

### ToDo List
- Add more system calls.
- Add processes and executables.
- Add a user/permission system.
- Use memory segmentation.
