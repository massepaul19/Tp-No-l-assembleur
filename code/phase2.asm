;----------------------------------------------------------------
; PHASE 2 : Lecture clavier (3 points)
;----------------------------------------------------------------
; Auteur: PAUL-BASTHYLLE MASSE MASSE
; Date: Décembre 2025
; Description: Lire un caractère et l'afficher
;----------------------------------------------------------------

section .bss
    input_buf resb 128        ; Réserver 128 octets
    
section .text
    global _start

_start:
    ; Lire un caractère avec sys_read (syscall 3)
    mov eax, 3              ; sys_read
    mov ebx, 0              ; fd = 0 (stdin)
    mov ecx, input_buf      ; adresse du buffer
    mov edx, 128              ; lire au max 128 octets
    int 0x80                ; appel système
    
    mov esi, eax            ; sauvegarder le nombre d'octets lus
    
    ; Afficher le caractère lu avec sys_write (syscall 4)
    mov eax, 4              ; sys_write
    mov ebx, 1              ; fd = 1 (stdout)
    mov ecx, input_buf      ; adresse du buffer
    mov edx, esi            ; longueur = nombre d'octets lus
    int 0x80                ; appel système
    
    ; Terminer proprement avec sys_exit (syscall 1)
    mov eax, 1              ; sys_exit
    xor ebx, ebx            ; code retour = 0
    int 0x80                ; appel système
