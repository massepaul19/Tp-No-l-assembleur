;----------------------------------------------------------------
; PHASE 5 : Multiplication et division (4 points)
;----------------------------------------------------------------
; Auteur: PAUL-BASTHYLLE MASSE MASSE
; Date: Décembre 2025
; Description: Utiliser MUL et DIV
;----------------------------------------------------------------

section .data
    msg_num1 db "Entrez le premier chiffre (0-9): "
    msg_num1_len equ $ - msg_num1
    
    msg_num2 db "Entrez le deuxieme chiffre (0-9): "
    msg_num2_len equ $ - msg_num2
    
    msg_mult db "Multiplication: "
    msg_mult_len equ $ - msg_mult
    
    msg_div db "Division (quotient): "
    msg_div_len equ $ - msg_div
    
    msg_reste db "Reste: "
    msg_reste_len equ $ - msg_reste
    
section .bss
    num1 resb 2
    num2 resb 2
    result resb 3
    
section .text
    global _start

_start:
    ; Lire le premier chiffre
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
    
    ; Lire le deuxième chiffre
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
    
    ; Convertir ASCII en nombres
    movzx eax, byte [num1]
    sub eax, '0'
    movzx ebx, byte [num2]
    sub ebx, '0'
    
    ; Sauvegarder les valeurs pour la division
    push eax
    push ebx
    
    ;=== MULTIPLICATION avec MUL ===
    ; AL contient le premier nombre
    ; MUL multiplie AL par l'opérande
    ; Résultat dans AX (AH:AL)
    mov al, [num1]
    sub al, '0'
    mov bl, [num2]
    sub bl, '0'
    mul bl                      ; AX = AL * BL
    
    ; Convertir le résultat en ASCII (2 chiffres)
    xor edx, edx
    mov ecx, 10
    div ecx                     ; AX / 10 → AL=dizaines, AH=unités
    ; Attention: après DIV, quotient dans AL, reste dans AH
    mov dl, ah                  ; Sauvegarder le reste (unités)
    add al, '0'
    add dl, '0'
    mov [result], al
    mov [result+1], dl
    mov byte [result+2], 0x0A
    
    ; Afficher "Multiplication: "
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_mult
    mov edx, msg_mult_len
    int 0x80
    
    ; Afficher le résultat
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 3
    int 0x80
    
    ;=== DIVISION avec DIV ===
    pop ebx                     ; Récupérer num2 (diviseur)
    pop eax                     ; Récupérer num1 (dividende)
    
    ; IMPORTANT: Nettoyer AH avant DIV
    ; DIV utilise AX (16 bits) comme dividende
    ; Si AH contient des données parasites, le résultat sera faux
    mov ah, 0                   ; Nettoyer AH !
    
    ; Diviser AL par BL
    div bl                      ; AL = quotient, AH = reste
    
    ; Sauvegarder le reste
    mov dl, ah
    
    ; Convertir quotient en ASCII
    add al, '0'
    mov [result], al
    mov byte [result+1], 0x0A
    
    ; Afficher "Division (quotient): "
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_div
    mov edx, msg_div_len
    int 0x80
    
    ; Afficher le quotient
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 2
    int 0x80
    
    ; Convertir reste en ASCII
    add dl, '0'
    mov [result], dl
    mov byte [result+1], 0x0A
    
    ; Afficher "Reste: "
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_reste
    mov edx, msg_reste_len
    int 0x80
    
    ; Afficher le reste
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 2
    int 0x80
    
    ; Terminer proprement
    mov eax, 1
    xor ebx, ebx
    int 0x80
