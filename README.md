# Sharpening
Sharpening an mage using a high level language with x86 assembly


To compile: nasm -f elf name.asm-o name.o
            gcc -m32 main.c name.o sharpen.o -o open  WARNING:  Requires both edge and sharpen
            ./open choice[1 or 2] imageName.format
