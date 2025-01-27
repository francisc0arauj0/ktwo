# Bootloader

If you want to use another bootloader it will be at your own risk.

## Grub

### **Install tools**

Windows
- grub-mkrescue
- grub-pc-bin

Linux 
- grub-pc-bin
- xorriso
- mtools

### **Create folders**

```
ktwo/ (root folder)
├── ktwo/
│    └── boot/
│          └── grub/
│                └── grub.cfg
```


### **Create file**
Grub.cfg

```
set timeout=5
set default=0

menuentry "name" {
  multiboot /boot/kernel
  boot
}
```