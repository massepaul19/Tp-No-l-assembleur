;----------------------------------------------------------------
; MODULE SOUSTRACTION
;----------------------------------------------------------------

section .data
    msg_num1 db "Premier nombre (0-9): "
    msg_num1_len equ $ - msg_num1
    
    msg_num2 db "Deuxieme nombre (0-9): "
    msg_num2_len equ $ - msg_num2
    
    msg_result db "Resultat: "
    msg_result_len equ $ - msg_result
    
    msg_negatif db "Resultat negatif!", 0x0A
    msg_negatif_len equ $ - msg_negatif

section .bss
    num1 resb 2
    num2 resb 2
    result resb 3

section .text
    global faire_soustraction

faire_soustraction:
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
    
    ; Calculer différence
    movzx eax, byte [num1]
    movzx ebx, byte [num2]
    sub eax, '0'
    sub ebx, '0'
    
    ; Vérifier si négatif
    cmp eax, ebx
    jl resultat_negatif
    
    sub eax, ebx
    
    ; Convertir en ASCII
    add al, '0'
    mov [result], al
    mov byte [result+1], 0x0A
    
    ; Afficher résultat
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_result
    mov edx, msg_result_len
    int 0x80
    
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 2
    int 0x80
    
    ret

resultat_negatif:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_negatif
    mov edx, msg_negatif_len
    int 0x80
    ret
