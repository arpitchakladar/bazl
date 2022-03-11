# Bazl
A simple os for intel 386 architecture.

## Table Of Contents
- [Requirements](#requirements)
- [Getting Started](#getting-started)

### Requirements
- cmake (>= 3.22)
- nasm (>= 2.15.05)

### Getting Started
1. Clone the repository.
```sh
git clone https://github.com/arpitchakladar/bazl
cd bazl
```
2. Use cmake to generate a build system (preferably Make or Ninja).
```sh
cmake -B build
```
3. Build using the build system
```sh
make -C build
```
4. Run with an emulator (preferably QEMU)
```sh
qemu-system-i386 build/bazl
```
