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
A DQ 0xc9363a5be9cb5aaa,0x31201acbf3f0e1ac,0xfdf90a0d7a7cc7ce,0x73a84f9e8b8e5dc6,0x67cca311b00e2b04,0x9090d91b7096c87d,0x34c9006ae24d224e,0xed85d4c1f1f9b755
B DQ 0x7a1b1881358b5369, 0x66f7b2cbf0c57c03, 0x5cefe361c298c21a,0x8739aadb86c17863, 0x73885168590c979e,0x2d454bde85012415, 0x3227bb01df375499, 0xb1745ec6b8707900
C DQ 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
RD DQ 0x0
R DQ 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
