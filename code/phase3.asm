;----------------------------------------------------------------
; PHASE 3 : Addition simple (3 points)
;----------------------------------------------------------------
; Auteur: PAUL-BASTHYLLE MASSE MASSE
; Date: Décembre 2025
; Description: Lire deux chiffres et afficher leur somme
;----------------------------------------------------------------
section .data
    entrer1 db "Entrez le premier chiffre (0-9): "
    entrer1_len equ $ - entrer1
    
    entrer2 db "Entrez le deuxieme chiffre (0-9): "
    entrer2_len equ $ - entrer2
    
    msg_result db "Resultat: "
    msg_result_len equ $ - msg_result
    
section .bss
    num1 resb 2
    num2 resb 2
    result resb 3
    
section .text
    global _start
_start:
    ; Afficher prompt et lire premier chiffre
    mov eax, 4
    mov ebx, 1
    mov ecx, entrer1
    mov edx, entrer1_len
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 2
    int 0x80
    
    ; Afficher prompt et lire deuxième chiffre
    mov eax, 4
    mov ebx, 1
    mov ecx, entrer2
    mov edx, entrer2_len
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 2
    int 0x80
    
    ; Calculer la somme
    movzx eax, byte [num1]
    movzx ebx, byte [num2]
    sub eax, '0'
    sub ebx, '0'
    add eax, ebx
    
    ; Convertir en ASCII (dizaines et unités)
    xor edx, edx
    mov ecx, 10
    div ecx                      ; EAX=dizaines, EDX=unités
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
    
    ; Exit
    mov eax, 1
    xor ebx, ebx
    int 0x80