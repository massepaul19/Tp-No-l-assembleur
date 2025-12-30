;----------------------------------------------------------------
; MODULE MULTIPLICATION
;----------------------------------------------------------------

section .data
    msg_num1 db "Premier nombre (0-9): "
    msg_num1_len equ $ - msg_num1
    
    msg_num2 db "Deuxieme nombre (0-9): "
    msg_num2_len equ $ - msg_num2
    
    msg_result db "Resultat: "
    msg_result_len equ $ - msg_result

section .bss
    num1 resb 2
    num2 resb 2
    result resb 3

section .text
    global faire_multiplication

faire_multiplication:
    ; Lire num1
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_num1
    mov edx, msg_num1_len
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 2
    int 0x80
    
    ; Lire num2
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_num2
    mov edx, msg_num2_len
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 2
    int 0x80
    
    ; Multiplier avec MUL
    mov al, [num1]
    sub al, '0'
    mov bl, [num2]
    sub bl, '0'
    mul bl                    ; AX = AL * BL
    
    ; Convertir en ASCII (2 chiffres)
    xor edx, edx
    mov ecx, 10
    div ecx
    mov dl, ah
    add al, '0'
    add dl, '0'
    mov [result], al
    mov [result+1], dl
    mov byte [result+2], 0x0A
    
    ; Afficher résultat
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_result
    mov edx, msg_result_len
    int 0x80
    
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 3
    int 0x80
    
    ret
