# Bazl
A simple CLI OS for intel 386 architecture. Runs in 16-bit real mode, and is written in NASM assembly and C.

## Table Of Contents
- [Requirements](#requirements)
- [Getting Started](#getting-started)
- [ToDo List](#todo-list)

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
2. Run a build script. (For the first time "i386-elf-gcc" and "i386-elf-ld" must be in your PATH)
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
- Create a file system.
- Add processes and executables.
- Add a user/permission system.
- Add and manage processes or external programs.
- Add system calls.
- Use memory segmentation, to increase usable memory to 1mb.
- Switch to 32-bit protected mode.
