%include 'in_out.asm'

SECTION .data
    msg: DB 'Введите x: ',0
    result: DB 'f(g(x)) = 2(3x-1)+7 = ',0
SECTION .bss
    x: RESB 80
    res: RESB 80
SECTION .text
GLOBAL _start

_start:
    ;------------------------------------------
    ; Основная программа
    ;------------------------------------------
    mov eax, msg
    call sprint        ; Вывод "Введите x: "
    
    mov ecx, x
    mov edx, 80
    call sread         ; Ввод значения x
    
    mov eax, x
    call atoi          ; Преобразование строки в число (результат в eax)
    
    call _calcul       ; Вызов подпрограммы _calcul для вычисления f(g(x))
    
    mov eax, result
    call sprint        ; Вывод "f(g(x)) = 2(3x-1)+7 = "
    
    mov eax, [res]
    call iprintLF      ; Вывод результата с переводом строки
    
    call quit          ; Завершение программы

;------------------------------------------
; Подпрограмма вычисления f(g(x))
; Вход: eax = x
; Выход: [res] = f(g(x)) = 2*(3*x - 1) + 7
;------------------------------------------
_calcul:
    push ebx           ; Сохраняем ebx в стеке
    
    call _subcalcul    ; Вычисляем g(x) = 3*x - 1 (результат в eax)
    
    ; Теперь вычисляем f(g(x)) = 2*g(x) + 7
    mov ebx, 2
    mul ebx            ; eax = g(x) * 2
    add eax, 7         ; eax = 2*g(x) + 7
    
    mov [res], eax     ; Сохраняем результат
    
    pop ebx            ; Восстанавливаем ebx из стека
    ret                ; Выход из подпрограммы

;------------------------------------------
; Подпрограмма вычисления g(x) = 3*x - 1
; Вход: eax = x
; Выход: eax = g(x) = 3*x - 1
;------------------------------------------
_subcalcul:
    push ebx           ; Сохраняем ebx в стеке
    
    mov ebx, 3
    mul ebx            ; eax = x * 3
    sub eax, 1         ; eax = 3*x - 1
    
    pop ebx            ; Восстанавливаем ebx из стека
    ret                ; Выход из подпрограммы