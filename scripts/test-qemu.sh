#!/bin/sh
qemu-system-x86_64 -drive format=raw,file="build/bazl",index=0,if=floppy,  -m 128M
