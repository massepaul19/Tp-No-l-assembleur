;----------------------------------------------------------------
; CALCULATRICE COMPLÈTE - Main
;----------------------------------------------------------------
; Auteur: PAUL-BASTHYLLE MASSE MASSE
; Date: Décembre 2025
;----------------------------------------------------------------

section .data
    msg_bye db "Au revoir!", 0x0A
    msg_bye_len equ $ - msg_bye

section .text
    global _start
    extern afficher_menu
    extern lire_choix
    extern faire_addition
    extern faire_soustraction
    extern faire_multiplication
    extern faire_division
    extern quitter_programme

    


_start:
boucle_principale:
    ; Afficher le menu
    call afficher_menu
    
    ; Lire le choix utilisateur
    call lire_choix
    
    ; AL contient le choix
    cmp al, '1'
    je operation_addition
    
    cmp al, '2'
    je operation_soustraction
    
    cmp al, '3'
    je operation_multiplication
    
    cmp al, '4'
    je operation_division
    
    cmp al, '5'
    je operation_quitter
    
    ; Choix invalide, recommencer
    jmp boucle_principale

operation_addition:
    call faire_addition
    jmp boucle_principale

operation_soustraction:
    call faire_soustraction
    jmp boucle_principale

operation_multiplication:
    call faire_multiplication
    jmp boucle_principale

operation_division:
    call faire_division
    jmp boucle_principale

operation_quitter:
    call quitter_programme


