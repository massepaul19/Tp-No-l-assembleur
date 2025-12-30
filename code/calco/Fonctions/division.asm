;----------------------------------------------------------------
; MODULE DIVISION
;----------------------------------------------------------------

section .data
    msg_num1 db "Dividende (0-9): "
    msg_num1_len equ $ - msg_num1
    
    msg_num2 db "Diviseur (0-9): "
    msg_num2_len equ $ - msg_num2
    
    msg_quotient db "Quotient: "
    msg_quotient_len equ $ - msg_quotient
    
    msg_reste db "Reste: "
    msg_reste_len equ $ - msg_reste
    
    msg_div_zero db "Erreur: Division par zero!", 0x0A
    msg_div_zero_len equ $ - msg_div_zero

section .bss
    num1 resb 2
    num2 resb 2
    result resb 2

section .text
    global faire_division

faire_division:
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
    
    ; Vérifier division par zéro
    mov bl, [num2]
    sub bl, '0'
    cmp bl, 0
    je division_par_zero
    
    ; Diviser avec DIV
    mov al, [num1]
    sub al, '0'
    mov ah, 0                 ; Nettoyer AH !
    div bl                    ; AL = quotient, AH = reste
    
    ; Sauvegarder le reste
    mov dl, ah
    
    ; Afficher quotient
    add al, '0'
    mov [result], al
    mov byte [result+1], 0x0A
    
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_quotient
    push edx
    mov edx, msg_quotient_len
    int 0x80
    
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 2
    int 0x80
    
    ; Afficher reste
    pop edx
    add dl, '0'
    mov [result], dl
    mov byte [result+1], 0x0A
    
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_reste
    mov edx, msg_reste_len
    int 0x80
    
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 2
    int 0x80
    
    ret

division_par_zero:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_div_zero
    mov edx, msg_div_zero_len
    int 0x80
    ret
