%include 'in_out.asm'
SECTION .data
msg: DB 'Результат: ',0   ; Изменил имя с div на msg (div - зарезервированное слово)
SECTION .text
GLOBAL _start
_start:
; ---- Вычисление выражения (3+2)*4+5
mov ebx,3
mov eax,2
add ebx,eax    ; ebx = 3 + 2 = 5
mov eax,ebx    ; Переносим результат в eax для умножения
mov ecx,4
mul ecx        ; eax = 5 * 4 = 20
add eax,5      ; eax = 20 + 5 = 25
mov edi,eax    ; Сохраняем результат

; ---- Вывод результата на экран
mov eax,msg
call sprint
mov eax,edi
call iprintLF
call quit