all:
	mkdir build
	gcc -m32 -fno-stack-protector -fno-builtin -c kernel/main.c -o build/kernel.o
	nasm -f elf32 boot/boot.asm -o build/boot.o
	ld -m elf_i386 -T linker.ld -o ktwokernel build/boot.o build/kernel.o -z noexecstack
	mv ktwokernel ktwo/boot/kernel
	grub-mkrescue -o ktwo.iso ktwo/
	rm -r build
	qemu-system-i386 ktwo.iso


# file ktwo.ios
# xorriso -indev ktwo.iso -find
# sudo apt install grub-pc-bin