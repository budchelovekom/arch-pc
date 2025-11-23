%include 'in_out.asm'

section .data
    msg_x db 'Введите x: ', 0h
    msg_a db 'Введите a: ', 0h
    msg_result db 'f(x) = ', 0h
    newline db 0Ah, 0h
    
section .bss
    x resb 10
    a resb 10
    result resb 10

section .text
global _start

_start:
    ; Ввод значения x
    mov eax, msg_x
    call sprint
    mov ecx, x
    mov edx, 10
    call sread
    
    ; Ввод значения a
    mov eax, msg_a
    call sprint
    mov ecx, a
    mov edx, 10
    call sread
    
    ; Преобразование x и a из строк в числа
    mov eax, x
    call atoi
    mov [x], eax    ; сохраняем числовое значение x
    
    mov eax, a
    call atoi
    mov [a], eax    ; сохраняем числовое значение a
    
    ; Вычисление функции f(x) для варианта 6:
    ; f(x) = { x + a, если x = a
    ;        { 5x,    если x ≠ a
    
    mov ebx, [x]    ; ebx = x
    mov ecx, [a]    ; ecx = a
    
    ; Сравниваем x и a
    cmp ebx, ecx
    je case_equal   ; если x = a, переходим к case_equal
    
    ; Случай x ≠ a: f(x) = 5x
    mov eax, ebx    ; eax = x
    mov edx, 5      ; множитель 5
    imul eax, edx   ; eax = 5 * x
    jmp store_result
    
case_equal:
    ; Случай x = a: f(x) = x + a
    mov eax, ebx    ; eax = x
    add eax, ecx    ; eax = x + a
    
store_result:
    mov [result], eax ; сохраняем результат
    
    ; Вывод результата
    mov eax, msg_result
    call sprint
    
    mov eax, [result]
    call iprintLF   ; выводим число с переводом строки
    
    ; Завершение программы
    call quit