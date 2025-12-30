;----------------------------------------------------------------
; PHASE 1 : Affichage d'un message (2 points)
;----------------------------------------------------------------
; Auteur: PAUL-BASTHYLLE MASSE MASSE
; Date: Décembre 2025
; Description: Afficher "Bonjour, monde!" et terminer proprement
;----------------------------------------------------------------

section .data
    ; Ici je dzfinis le message à Afficher
    msg db "Bonjour, monde!", 0X0A
    len equ $ - msg
    
section .text
global _start

_start:
    mov eax , 4
    mov ebx , 1
    mov ecx , msg
    mov edx , len
    int 0x80
    
    mov eax , 1 
    xor ebx , ebx
    int 0x80
    