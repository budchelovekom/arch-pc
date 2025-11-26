%include 'in_out.asm'
SECTION .data
msg_func db "Функция: f(x)=4x-3",0
msg_result db "Результат: ",0
SECTION .text
global _start
_start:
pop ecx
pop edx
sub ecx,1
cmp ecx,0
jz _end
mov esi, 0
next:
pop eax
call atoi
mov ebx, eax
shl ebx, 2
sub ebx, 3
add esi,ebx
loop next
_end:
mov eax, msg_func
call sprintLF
mov eax, msg_result
call sprint
mov eax, esi
call iprintLF
call quit