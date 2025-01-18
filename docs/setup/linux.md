# How to configure the ktwo kernel on Linux

### **Clone repository**

```bash
git clone https://github.com/francisc0arauj0/ktwo/
```

### **Install tools**

- nasm
- grub-pc-bin
- xorriso
- qemu-system-i386
- clang-format

### **Setup Grub** 
If you want to use another bootloader it will be at your own risk.

Create folders

```
ktwo/ (root folder)
├── ktwo/
│    └── boot/
│          └── grub/
│                └── grub.cfg
```

Grub.cfg

```
set timeout=5
set default=0

menuentry "name" {
  multiboot /boot/kernel
  boot
}
```

### **Build**

```bash
make
```
