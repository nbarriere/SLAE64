; Filename:      egghunter-msg-stack.nasm
; Author:        Nicolas Barrière
; Student ID:    SLAE - 1398
; Created Date:  31.01.2019
; Note:          x64
; Assembler:     nasm -f elf64 egghunter-msg-stack.nasm -o egghunter-msg-stack.o
; Linker:        ld -m elf_x86_64 egghunter-msg-stack.o -o egghunter-msg-stack
; Assembly dump: objdump -d ./egghunter-msg-stack|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-7 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'

global _start

section .text

_start:

;ssize_t write(int fd, const void *buf, size_t count);
	xor rax, rax                 ; Clear rax register
	inc rax                      ; sys_write
	xor rdi, rdi                 ; Clear rdi register
	inc rdi                      ; 1 = stdout

	xor rsi, rsi                 ; Clear rsi register
	push rsi                     ; Push null byte in stack
	mov r9,  0x202020200a21646e  ;"    \n!dn"
	push r9                      ; Push string to stack
	mov r9,  0x756f662073676745  ;"uof sggE"
	push r9                      ; Push string to stack

	mov rsi, rsp                 ; Copy pointer to string
	xor rdx, rdx                 ; Clear rdx register
	mov dl, 0x10                 ; count (string char)
	syscall

	;Exit the progam
	xor rax, rax                 ; Clear rax register
	mov al, 0x3c                 ; sys_exit
	xor rdi, rdi                 ; Clear rdi register
	syscall
