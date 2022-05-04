%include "syscall.mac"
%macro print 2
mov rsi, %1
mov rcx, %2
call printhex
%endmacro
%macro stepone 2
mov rax, [A+8*%1]
mul rbx
add [R+8*%2], rax
adc rdx, 0
mov [R+8*%1], rdx
%endmacro
%macro starttwo 1
mov rbx, [B+8*%1]
mov rax, [A+8*0]
mul rbx
add [R+8*0], rax
adc rdx, 0
mov rcx, rdx
mov r9, [R+8*0]
mov [C+8*%1], r9
%endmacro
%macro rero 2
mov r9, [R+8*%1]
mov [R+8*%2], r9
%endmacro
%macro two_1 1
mov rax, [A+8*%1]
mul rbx
mov [R+8*0], rdx
add [R+8*%1], rax
mov r9, 0
adc [R+8*0], r9
add [R+8*%1], rcx
adc [R+8*0], r9
%endmacro
%macro two_2 1
mov rax, [A+8*%1]
mul rbx
mov rcx, rdx
add [R+8*%1], rax
adc rcx, 0
mov r9, [R+8*0]
add [R+8*%1], r9
adc rcx, 0
%endmacro
SECTION .text
global _start
EXTERN printhex
_start:
mov rbx, [B+8*0]
mov rax, [A+8*0]
mul rbx
mov [C+8*0], rax
mov [R+8*0], rdx
stepone 1, 0
stepone 2, 1
stepone 3, 2
stepone 4, 3
stepone 5, 4
stepone 6, 5
stepone 7, 6
%assign i 1
%rep 7
starttwo i
two_1 1
two_2 2
two_1 3
two_2 4
two_1 5
two_2 6
two_1 7
mov r9, [R+8*0]
mov [RD], r9
rero 1, 0
rero 2, 1
rero 3, 2
rero 4, 3
rero 5, 4
rero 6, 5
rero 7, 6
mov r9, [RD]
mov [R+8*7], r9
%assign i i+1
%endrep
%assign i 0
%rep 8
mov r9, [R+i*8]
mov [(C+64)+i*8], r9
%assign i i+1
%endrep
print A, 64
print B, 64
print C, 128
EXIT
SECTION .data
A DQ 0x487610c816f7e4a8,0xd8d4d00152b432f4,0x04b93fbf6abb8c90,0xb62cf6085d5d1b66,0xa3d6be921e0b70e2,0x39658ba003e9ef01,0x23ae151d238bcbed,0x3ddf156de99ae2c6
B DQ 0x292c750319a5db9a,0x2980bb2055e53193,0x3874539ad509954a,0xd3d742a533fd3f52,0xcda6f8c10874a10b,0xa6185295c9f7d4c0,0x76900d93551a0fc2,0x1d64dcfce6d71588
C DQ 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
RD DQ 0x0
R DQ 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
