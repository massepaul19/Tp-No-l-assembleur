;----------------------------------------------------------------
; PHASE 4 : Menu et CMP/JE (4 points)
;----------------------------------------------------------------
; Auteur: PAUL-BASTHYLLE MASSE MASSE
; Date: Décembre 2025
; Description: Afficher un menu et exécuter l'action choisie
;----------------------------------------------------------------

section .data
    menu db "=====================================", 0x0A
         db "=== MENU CALCULATRICE Paulo Masse ===", 0x0A
         db "=====================================", 0x0A
         db "   1. Addition", 0x0A
         db "   2. Soustraction", 0x0A
         db "   3. Multiplication", 0x0A
         db "   4. Division", 0x0A
         db "   5. Quitter", 0x0A
         db "=========== Paulo Masse ==============", 0x0A
         db "======================================", 0x0A
         db "Entrer votre choix: "
         

    menu_len equ $ - menu
    
    msg_addition db "Vous avez choisi: Addition", 0x0A
    msg_addition_len equ $ - msg_addition
    
    msg_soustraction db "Vous avez choisi: Soustraction", 0x0A
    msg_soustraction_len equ $ - msg_soustraction
    
    msg_multiplication db "Vous avez choisi: Multiplication", 0x0A
    msg_multiplication_len equ $ - msg_multiplication
    
    msg_division db "Vous avez choisi: Division", 0x0A
    msg_division_len equ $ - msg_division
    
    msg_quitter db "Au revoir!", 0x0A
    msg_quitter_len equ $ - msg_quitter
    
    msg_invalide db "Choix invalide!", 0x0A
    msg_invalide_len equ $ - msg_invalide
    
section .bss
    choix resb 2        ; Buffer pour le choix utilisateur
    
section .text
    global _start

_start:
    ; Afficher le menu
    mov eax, 4
    mov ebx, 1
    mov ecx, menu
    mov edx, menu_len
    int 0x80
    
    ; Lire le choix utilisateur
    mov eax, 3
    mov ebx, 0
    mov ecx, choix
    mov edx, 2
    int 0x80
    
    ; Charger le choix dans AL
    mov al, [choix]
    
    ; Comparer le choix avec CMP et sauter avec JE
    cmp al, '1'
    je action_addition
    
    cmp al, '2'
    je action_soustraction
    
    cmp al, '3'
    je action_multiplication
    
    cmp al, '4'
    je action_division
    
    cmp al, '5'
    je action_quitter
    
    ; Si aucune correspondance : choix invalide
    jmp choix_invalide

action_addition:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_addition
    mov edx, msg_addition_len
    int 0x80
    jmp fin

action_soustraction:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_soustraction
    mov edx, msg_soustraction_len
    int 0x80
    jmp fin

action_multiplication:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_multiplication
    mov edx, msg_multiplication_len
    int 0x80
    jmp fin

action_division:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_division
    mov edx, msg_division_len
    int 0x80
    jmp fin

action_quitter:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_quitter
    mov edx, msg_quitter_len
    int 0x80
    jmp fin

choix_invalide:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_invalide
    mov edx, msg_invalide_len
    int 0x80

fin:
    ; Terminer proprement
    mov eax, 1
    xor ebx, ebx
    int 0x80
