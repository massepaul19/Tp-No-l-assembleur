;----------------------------------------------------------------
; MODULE MENU
;----------------------------------------------------------------

section .data
    menu_txt db "=====================================", 0x0A
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
    menu_len equ $ - menu_txt
    
    msg_invalide db "Choix invalide! Reessayez.", 0x0A
    msg_invalide_len equ $ - msg_invalide

    msg_bye db "Au revoir! Merci d'avoir utiliser  la calco de Paulo Masse.", 0x0A
    msg_bye_len equ $ - msg_bye




section .bss
    choix resb 2

section .text
    global afficher_menu
    global lire_choix
    global quitter_programme

afficher_menu:
    ; Afficher le menu
    mov eax, 4
    mov ebx, 1
    mov ecx, menu_txt
    mov edx, menu_len
    int 0x80
    ret

lire_choix:
    ; Lire le choix
    mov eax, 3
    mov ebx, 0
    mov ecx, choix
    mov edx, 2
    int 0x80
    
    ; Retourner le choix dans AL
    mov al, [choix]
    ret
    
;cette fonction me permet de quitter le programme

quitter_programme:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_bye
    mov edx, msg_bye_len
    int 0x80
    
    mov eax, 1
    xor ebx, ebx
    int 0x80
    
