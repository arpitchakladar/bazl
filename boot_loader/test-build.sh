rm -rf build
mkdir build
i686-elf-gcc -ffreestanding -m32 -g -c "src/test.c" -o "build/test.o"
nasm src/kernal_entry.asm -f elf -o build/kernal_entry.o
i686-elf-ld -o build/kernal.bin -Ttext 0x1000 build/kernal_entry.o build/test.o --oformat binary
nasm src/boot_loader.asm -f bin -o build/boot_loader.bin
cat build/boot_loader.bin build/kernal.bin > build/final.bin
truncate -s 10240 build/final.bin
