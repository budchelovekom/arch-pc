%include 'in_out.asm'
section .data
    msg1 db 'Введите B: ',0h
    msg2 db 'Наименьшее число: ',0h
    a dd 79
    c dd 41
section .bss
    min resb 10
    B resb 10
section .text
global _start
_start:
    mov eax, msg1
    call sprint
    

    mov ecx, B
    mov edx, 10
    call sread
    
    mov eax, B
    call atoi
    mov [B], eax
    
 
    mov eax, [a]
    mov [min], eax
    
    mov ebx, [B]
    cmp eax, ebx
    jl check_c     ;
    mov [min], ebx 
    
check_c:
    mov eax, [min]
    mov ecx, [c]
    cmp eax, ecx 
    mov [min], ecx  ;
    
    ; Вывод сообщения
    mov eax, msg2
    call sprint
   
    mov eax, [min]
    call iprintLF
    
    call quit