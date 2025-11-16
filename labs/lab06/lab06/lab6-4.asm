%include 'in_out.asm'
SECTION .data
div: DB 'Результат', 0
rem: DB 'Остаток от деления', 0
SECTION .text
GLOBAL _start
_start:
mov eax,2
mov ebx,2
mul ebx
add eax,2
xor edx,edx
div ebx
add eax,1
mov edi,eax
mov eax,div
call sprint
mov eax,edi
call iprintLF
mov eax,rem
call sprint
mov eax,edx
call iprintLF
call quit