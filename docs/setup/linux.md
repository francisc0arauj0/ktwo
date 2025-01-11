# How to configure the ktwo kernel on Linux

### **Clone repository**

```bash
git clone https://github.com/francisc0arauj0/ktwo/
```

### **Install tools**

- nasm
- grub-mkrescue
- qemu

### **Setup Grub**

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