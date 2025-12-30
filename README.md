# TP ASSEMBLEUR x86 - CALCULATRICE SIMPLE

**Auteur:** PAUL-BASTHYLLE MASSE MASSE  
**Version:** 1.0.0  
**Date:** Décembre 2025  
**Cours:** GSI 531 - Assembleur x86  
**GitHub:** [https://github.com/massepaul19/Tp-No-l-assembleur](https://github.com/massepaul19/Tp-No-l-assembleur)

---

## 📋 Description du projet

Ce projet implémente une **calculatrice simple en assembleur x86** (architecture 32 bits, format ELF) permettant d'effectuer les opérations suivantes :

###Pour contrainte de temps j'ai utilisé l'ia afin d'accomplir rapidement 

- ✅ **Addition**
- ➖ **Soustraction**
- ✖️ **Multiplication**
- ➗ **Division**

Le programme affiche un menu interactif, lit deux chiffres (0-9) depuis l'entrée standard, effectue l'opération choisie et affiche le résultat.

---

## 🛠️ Prérequis

Avant de commencer, assurez-vous d'avoir installé les outils suivants sur votre système Linux :
```bash
# Vérifier si NASM est installé
nasm -v

# Vérifier si ld (linker) est installé
ld -v

# Si non installés, installer avec :
sudo apt-get update
sudo apt-get install nasm binutils build-essential
```

---

## 📁 Structure du projet
```
TP Assembleur/
├── code/                           # Dossier contenant les fichiers source
│   ├── phase1.asm                  # Phase 1 : Affichage d'un message
│   ├── phase2.asm                  # Phase 2 : Lecture clavier
│   ├── phase3.asm                  # Phase 3 : Addition simple
│   ├── phase4.asm                  # Phase 4 : Menu et instructions CMP/JE
│   ├── phase5.asm                  # Phase 5 : Multiplication et division
│   └── calc.asm                    # Phase 6 : Programme complet
├── obj/                            # Fichiers objets (.o) générés
├── bin/                            # Exécutables générés
├── GSI_531_TP1_Assembleur_2025_2026_2.pdf  # Énoncé du TP
├── Makefile                        # Fichier d'automatisation
└── README.md                       # Ce fichier
```

---

## 🚀 Démarrage rapide

### 1️⃣ Cloner le projet depuis GitHub
```bash
# Cloner le dépôt
git clone https://github.com/massepaul19/Tp-No-l-assembleur.git

# Se placer dans le répertoire du projet
cd Tp-No-l-assembleur

# Exécuter le script de setup
chmod +x setup.sh
./setup.sh
```

### 2️⃣ Compiler et exécuter avec le Makefile
```bash
# Voir toutes les commandes disponibles
make help

# Compiler une phase spécifique (exemple : phase 1)
make phase1

# Exécuter la phase compilée
make run_phase1

# Compiler et exécuter directement
make test_phase1

# Compiler le programme complet
make all

# Exécuter le programme complet
make run
```

### 3️⃣ Compilation manuelle (sans Makefile)
```bash
# Créer les dossiers nécessaires
mkdir -p obj bin

# Assembler le fichier source
nasm -f elf32 code/calc.asm -o obj/calc.o

# Lier le fichier objet pour créer l'exécutable
ld -m elf_i386 obj/calc.o -o bin/calc

# Exécuter le programme
./bin/calc
```

---

## 📖 Commandes disponibles dans le Makefile

### Compilation

| Commande | Description |
|----------|-------------|
| `make all` | Compile le programme complet (phase 6) |
| `make phase1` | Compile la phase 1 (affichage message) |
| `make phase2` | Compile la phase 2 (lecture clavier) |
| `make phase3` | Compile la phase 3 (addition simple) |
| `make phase4` | Compile la phase 4 (menu + CMP/JE) |
| `make phase5` | Compile la phase 5 (multiplication/division) |

### Exécution

| Commande | Description |
|----------|-------------|
| `make run` | Exécute le programme complet |
| `make run_phase1` | Exécute la phase 1 |
| `make run_phase2` | Exécute la phase 2 |
| `make run_phase3` | Exécute la phase 3 |
| `make run_phase4` | Exécute la phase 4 |
| `make run_phase5` | Exécute la phase 5 |

### Tests rapides

| Commande | Description |
|----------|-------------|
| `make test_phase1` | Compile et exécute la phase 1 |
| `make test_phase2` | Compile et exécute la phase 2 |
| `make test_phase3` | Compile et exécute la phase 3 |
| `make test_phase4` | Compile et exécute la phase 4 |
| `make test_phase5` | Compile et exécute la phase 5 |
| `make test_all` | Compile et exécute le programme complet |

### Nettoyage

| Commande | Description |
|----------|-------------|
| `make clean` | Supprime tous les fichiers .o et exécutables |
| `make cleanall` | Supprime complètement les dossiers obj/ et bin/ |

### Aide

| Commande | Description |
|----------|-------------|
| `make help` | Affiche l'aide avec toutes les commandes disponibles |

---

## 📚 Phases du TP

### **Phase 1 : Affichage d'un message (2 points)**
- ✅ Écrire un programme qui affiche "Bonjour, monde!" puis se termine proprement
- **Concepts :** `section .text`, `_start`, `sys_write`, `sys_exit`
- **QCM :** 
  - Quelle section contient les instructions ? **Réponse : .text**
  - Quel registre contient le numéro de l'appel système ? **Réponse : EAX**

### **Phase 2 : Lecture clavier (3 points)**
- ✅ Lire un caractère depuis stdin et l'afficher
- **Concepts :** `sys_read`, registre `ECX`, buffer de lecture
- **QCM :** 
  - Quel est le numéro de sys_read ? **Réponse : 3**
  - À quoi sert ECX lors de la lecture ? **Réponse : Adresse du buffer**

### **Phase 3 : Addition simple (3 points)**
- ✅ Lire deux chiffres ASCII, les convertir en nombres et afficher leur somme
- **Concepts :** Conversion ASCII → numérique, soustraction de '0'
- **QCM :** 
  - Pourquoi soustrait-on '0' ? **Réponse : Pour convertir ASCII en nombre**
  - Quel registre contient le résultat ? **Réponse : AL ou AX**

### **Phase 4 : Menu et branchements (4 points)**
- ✅ Afficher un menu et exécuter une action selon le choix utilisateur
- **Concepts :** `CMP`, `JE` (jump if equal), `JNE`, branchements conditionnels
- **QCM :** 
  - Que fait CMP ? **Réponse : Compare deux valeurs**
  - Quand est-ce que le "JE" saute-t-il ? **Réponse : Quand les valeurs sont égales**

### **Phase 5 : Multiplication et division (4 points)**
- ✅ Utiliser les instructions `MUL` et `DIV`
- **Concepts :** Rôle de `AL`, `AH`, `AX`, gestion du reste
- **QCM :** 
  - Où se trouve le reste après DIV ? **Réponse : Dans AH**
  - Pourquoi faut-il nettoyer AH ? **Réponse : Pour éviter des erreurs de calcul**

### **Phase 6 : Programme complet (4 points)**
- ✅ Assembler toutes les phases précédentes
- Calculatrice fonctionnelle avec menu interactif
- **QCM :** Quelle instruction permet de comparer deux valeurs ?
  - a) MOV
  - b) **CMP** ✅
  - c) JE
  - d) ADD

---

## 🔧 Exemple d'utilisation
```bash
$ make all
🔨 Assemblage de calc.asm...
🔗 Linkage de calc...
✅ Programme complet compilé : bin/calc

$ make run
▶️  Exécution de la calculatrice...

=== CALCULATRICE SIMPLE ===
1. Addition
2. Soustraction
3. Multiplication
4. Division
Choix : 1

Premier chiffre (0-9) : 5
Deuxième chiffre (0-9) : 3

Résultat : 8
```

---

## 📝 Notes importantes

### Architecture
- Ce projet est conçu pour **Linux 32 bits** (`-f elf32`)
- Format de fichier : **ELF** (Executable and Linkable Format)

### Registres utilisés
- **EAX** : Numéro d'appel système (syscall)
- **EBX** : 1er argument (file descriptor)
- **ECX** : 2ème argument (adresse du buffer)
- **EDX** : 3ème argument (longueur)
- **AL** : Partie basse de AX (8 bits)
- **AH** : Partie haute de AX (8 bits)
- **AX** : 16 bits (AL + AH)

### Appels système Linux
- **sys_read** = 3 (lecture depuis stdin)
- **sys_write** = 4 (écriture vers stdout)
- **sys_exit** = 1 (terminer le programme)

### Conversion ASCII
- Pour convertir un chiffre ASCII en nombre : `sub al, '0'` ou `sub al, 48`
- Pour convertir un nombre en chiffre ASCII : `add al, '0'` ou `add al, 48`
- Exemple : '5' (ASCII 53) - '0' (ASCII 48) = 5 (nombre)

### Instructions arithmétiques
- **ADD** : Addition
- **SUB** : Soustraction
- **MUL** : Multiplication (résultat dans AX)
- **DIV** : Division (quotient dans AL, reste dans AH)

---

## 🐛 Débogage

Si vous rencontrez des erreurs :
```bash
# Vérifier les erreurs d'assemblage
nasm -f elf32 code/calc.asm -o obj/calc.o

# Vérifier les erreurs de linkage
ld -m elf_i386 obj/calc.o -o bin/calc

# Exécuter avec strace pour voir les appels système
strace ./bin/calc

# Vérifier le code de retour
echo $?
```

---

## 📧 Contact

Pour toute question sur le TP :
- **Auteur :** PAUL-BASTHYLLE MASSE MASSE
- **GitHub :** [massepaul19](https://github.com/massepaul19)

---

## 📜 Licence

Ce projet est réalisé dans le cadre du cours **GSI 531 - Assembleur x86**.

---

**Bon courage ! 🚀**

*Dernière mise à jour : Décembre 2025*
