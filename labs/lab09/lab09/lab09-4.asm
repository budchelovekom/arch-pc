%include 'in_out.asm'

SECTION .data
    msg_func db "Функция: f(x)=4x-3",0
    msg_result db "Результат: ",0
    
SECTION .bss
    result resd 1  ; переменная для хранения результата
    
SECTION .text
global _start

_start:
    ; Получаем количество аргументов командной строки
    pop ecx        ; ECX = argc (количество аргументов)
    pop edx        ; EDX = argv[0] (имя программы)
    sub ecx, 1     ; Уменьшаем счетчик на 1 (не считаем имя программы)
    
    cmp ecx, 0     ; Проверяем, есть ли аргументы
    jz _end        ; Если нет аргументов, переходим к концу
    
    mov esi, 0     ; ESI будет хранить сумму результатов
    
_next:
    pop eax        ; Берем следующий аргумент командной строки
    call atoi      ; Преобразуем строку в число (результат в EAX)
    
    ; Вызываем подпрограмму для вычисления f(x) = 4x - 3
    call _calculate_function
    
    ; Добавляем результат к общей сумме
    add esi, eax
    
    loop _next     ; Повторяем для всех аргументов

_end:
    ; Выводим информацию о функции
    mov eax, msg_func
    call sprintLF
    
    ; Выводим результат
    mov eax, msg_result
    call sprint
    
    mov eax, esi
    call iprintLF
    
    call quit      ; Завершаем программу

;-----------------------------------------------------
; Подпрограмма вычисления функции f(x) = 4x - 3
; Вход:  EAX = x (аргумент функции)
; Выход: EAX = f(x) = 4*x - 3
; Сохраняемые регистры: сохраняются все, кроме EAX
;-----------------------------------------------------
_calculate_function:
    push ebx       ; Сохраняем EBX в стеке
    
    mov ebx, eax   ; Копируем x в EBX
    shl ebx, 2     ; EBX = x * 4 (быстрее, чем mul)
    sub ebx, 3     ; EBX = 4x - 3
    
    mov eax, ebx   ; Возвращаем результат в EAX
    
    pop ebx        ; Восстанавливаем EBX из стека
    ret            ; Возврат из подпрограммы