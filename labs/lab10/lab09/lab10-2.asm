%include 'in_out.asm'

SECTION .data
    filename db 'name.txt', 0      ; Имя создаваемого файла
    prompt db 'Как Вас зовут? ', 0 ; Приглашение для ввода
    intro db 'Меня зовут ', 0      ; Строка для записи в файл
    
SECTION .bss
    name resb 255                  ; Буфер для ввода имени
    
SECTION .text
    global _start
    
_start:
    ; 1. Вывод приглашения
    mov eax, prompt
    call sprint
    
    ; 2. Ввод фамилии и имени с клавиатуры
    mov ecx, name
    mov edx, 255
    call sread
    
    ; 3. Создание файла с именем name.txt
    mov eax, 8               ; sys_creat
    mov ebx, filename        ; имя файла
    mov ecx, 0644o           ; права доступа rw-r--r-- (в восьмеричном)
    int 80h
    
    ; Сохраняем дескриптор файла в esi
    mov esi, eax
    
    ; 4. Запись в файл сообщения "Меня зовут "
    mov eax, intro
    call slen                ; получаем длину строки intro
    mov edx, eax             ; длина строки для записи
    mov ecx, intro           ; строка для записи
    mov ebx, esi             ; дескриптор файла
    mov eax, 4               ; sys_write
    int 80h
    
    ; 5. Дописать в файл строку, введенную с клавиатуры
    mov eax, name
    call slen                ; получаем длину введенного имени
    mov edx, eax             ; длина строки для записи
    mov ecx, name            ; строка с именем
    mov ebx, esi             ; дескриптор файла
    mov eax, 4               ; sys_write
    int 80h
    
    ; 6. Закрыть файл
    mov ebx, esi             ; дескриптор файла
    mov eax, 6               ; sys_close
    int 80h
    
    ; Завершение программы
    call quit