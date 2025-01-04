global gdt_flush

gdt_flush:
  mov eax, [esp+4]  ; Gdt ptr addr
  lgdt [eax]        ; Set gdt table

  mov eax, 0x10
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  mov ss, ax
  jmp 0x08:.flush

.flush:
  ret 