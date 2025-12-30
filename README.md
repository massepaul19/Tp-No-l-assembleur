# TP ASSEMBLEUR x86 - CALCULATRICE SIMPLE

**Auteur:** PAUL-BASTHYLLE MASSE MASSE  
**Version:** 2.0.0  
**Date:** Décembre 2025  
**Cours:** GSI 531 - Assembleur x86  
**GitHub:** [https://github.com/massepaul19/Tp-No-l-assembleur](https://github.com/massepaul19/Tp-No-l-assembleur)

---

## 📋 Description du projet

Ce projet implémente une **calculatrice simple en assembleur x86** (architecture 32 bits, format ELF) permettant d'effectuer les opérations suivantes :

- ✅ **Addition**
- ➖ **Soustraction**
- ✖️ **Multiplication**
- ➗ **Division**

Le programme affiche un menu interactif, lit deux chiffres (0-9) depuis l'entrée standard, effectue l'opération choisie et affiche le résultat.

### 🆕 Architecture modulaire professionnelle (Phase 6)

Ce projet adopte une **architecture modulaire** avec séparation des responsabilités :
- ✅ Chaque opération mathématique est dans son propre fichier
- ✅ Le menu est séparé dans un module dédié
- ✅ Un fichier `main.asm` orchestre l'ensemble
- ✅ Compilation multi-fichiers avec gestion des dépendances via Makefile

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
├── bin/                                   # 🎯 Exécutables générés
│   ├── calc                              # Calculatrice modulaire complète
│   ├── phase1                            # Exécutable phase 1
│   ├── phase2                            # Exécutable phase 2
│   ├── phase3                            # Exécutable phase 3
│   ├── phase4                            # Exécutable phase 4
│   └── phase5                            # Exécutable phase 5
├── code/                                  # 📂 Fichiers source assembleur
│   ├── calco/                            # 📦 Projet principal (architecture modulaire)
│   │   ├── Fonctions/                    # Module des opérations mathématiques
│   │   │   ├── addition.asm              # ➕ Fonction d'addition
│   │   │   ├── soustraction.asm          # ➖ Fonction de soustraction
│   │   │   ├── multiplication.asm        # ✖️ Fonction de multiplication
│   │   │   ├── division.asm              # ➗ Fonction de division
│   │   │   └── menu.asm                  # 📋 Fonction d'affichage du menu
│   │   └── main.asm                      # 🚀 Point d'entrée principal
│   ├── phase1.asm                        # Phase 1 : Affichage d'un message
│   ├── phase2.asm                        # Phase 2 : Lecture clavier
│   ├── phase3.asm                        # Phase 3 : Addition simple
│   ├── phase4.asm                        # Phase 4 : Menu et instructions CMP/JE
│   └── phase5.asm                        # Phase 5 : Multiplication et division
├── obj/                                   # 🔧 Fichiers objets (.o) générés
│   └── calco/                            # Objets du projet modulaire
│       ├── main.o
│       ├── menu.o
│       ├── addition.o
│       ├── soustraction.o
│       ├── multiplication.o
│       └── division.o
├── cours_assembleur_support_1.pdf        # 📖 Support de cours
├── GSI_531_TP1_Assembleur_2025_2026_2.pdf # 📄 Énoncé du TP
├── Reponses_questions.odt                # 📝 Réponses aux questions du TP
├── Makefile                              # ⚙️ Fichier d'automatisation
└── README.md                             # 📚 Ce fichier
```

---

## 🏗️ Architecture modulaire (Phase 6)

### Vue d'ensemble

Le projet principal (`calco/`) est organisé selon les principes de **programmation professionnelle** :

```
┌─────────────────────────────────────────────┐
│              main.asm                       │
│         (Point d'entrée)                    │
│  • Initialisation                           │
│  • Boucle principale                        │
│  • Coordination des modules                 │
└──────────────┬──────────────────────────────┘
               │
               ├──────► menu.asm (Affichage menu)
               │
               ├──────► addition.asm (Opération +)
               │
               ├──────► soustraction.asm (Opération -)
               │
               ├──────► multiplication.asm (Opération ×)
               │
               └──────► division.asm (Opération ÷)
```

### Description des modules

#### 📄 `main.asm` - Point d'entrée principal
```
Responsabilités :
  • Point d'entrée du programme (_start)
  • Gestion de la boucle principale
  • Lecture du choix utilisateur
  • Appel des modules appropriés
  • Gestion de la sortie du programme
  
Symboles exportés : _start
Symboles importés : afficher_menu, addition, soustraction, 
                    multiplication, division
```

#### 📋 `menu.asm` - Module d'affichage
```
Responsabilités :
  • Affichage du titre
  • Affichage des options du menu
  • Interface utilisateur claire
  
Fonction exportée : afficher_menu
```

#### ➕ `addition.asm` - Module addition
```
Responsabilités :
  • Lecture de deux chiffres
  • Addition des valeurs
  • Affichage du résultat
  
Fonction exportée : addition
Registres utilisés : AL (calcul), EAX, EBX, ECX, EDX (syscalls)
```

#### ➖ `soustraction.asm` - Module soustraction
```
Responsabilités :
  • Lecture de deux chiffres
  • Soustraction des valeurs
  • Gestion des résultats négatifs
  • Affichage du résultat
  
Fonction exportée : soustraction
Registres utilisés : AL (calcul), EAX, EBX, ECX, EDX (syscalls)
```

#### ✖️ `multiplication.asm` - Module multiplication
```
Responsabilités :
  • Lecture de deux chiffres
  • Multiplication (instruction MUL)
  • Gestion des résultats sur 16 bits (AX)
  • Affichage du résultat
  
Fonction exportée : multiplication
Registres utilisés : AL (opérande), AX (résultat), EAX, EBX, ECX, EDX
```

#### ➗ `division.asm` - Module division
```
Responsabilités :
  • Lecture de deux chiffres
  • Vérification du diviseur non nul
  • Division (instruction DIV)
  • Calcul du quotient (AL) et reste (AH)
  • Affichage du résultat et du reste
  
Fonction exportée : division
Registres utilisés : AL (quotient), AH (reste), AX, EAX, EBX, ECX, EDX
```

### Avantages de cette architecture

| Avantage | Description |
|----------|-------------|
| 🔧 **Modularité** | Chaque fonction est indépendante et réutilisable |
| 🛠️ **Maintenabilité** | Facile de modifier une opération sans toucher aux autres |
| 📖 **Lisibilité** | Code organisé et structuré, facile à comprendre |
| 📈 **Scalabilité** | Facile d'ajouter de nouvelles opérations (puissance, modulo, etc.) |
| 👔 **Professionnalisme** | Respect des bonnes pratiques de développement logiciel |
| 🐛 **Débogage** | Plus simple de localiser et corriger les bugs |
| 🔄 **Réutilisabilité** | Les modules peuvent être utilisés dans d'autres projets |

---

## 🚀 Démarrage rapide

### 1️⃣ Cloner le projet depuis GitHub

```bash
# Cloner le dépôt
git clone https://github.com/massepaul19/Tp-No-l-assembleur.git

# Se placer dans le répertoire du projet
cd Tp-No-l-assembleur

# Créer les dossiers nécessaires (si non présents)
mkdir -p obj/calco bin
```

### 2️⃣ Afficher l'aide du Makefile

```bash
# Voir toutes les commandes disponibles
make help
```

Vous verrez s'afficher :
```
╔════════════════════════════════════════════════════════════╗
║          TP ASSEMBLEUR x86 - CALCULATRICE SIMPLE           ║
╚════════════════════════════════════════════════════════════╝

  COMPILATION MODULAIRE :
  make all           - Compiler la calculatrice modulaire et toutes les phases 
  make calc          - Compiler la calculatrice modulaire
  ...
```

### 3️⃣ Compiler et exécuter la calculatrice modulaire

```bash
# Méthode 1 : Compilation puis exécution
make calc         # Compile tous les modules
make run          # Exécute la calculatrice

# Méthode 2 : Tout en une commande
make test_all     # Compile ET exécute directement

# Méthode 3 : Utiliser la cible par défaut
make all          # Compile tout (équivalent à make calc)
make run          # Exécute
```

### 4️⃣ Tester les phases individuelles

```bash
# Tester la phase 3 par exemple
make test_phase3  # Compile et exécute la phase 3

# Ou manuellement
make phase3       # Compile
make run_phase3   # Exécute
```

### 5️⃣ Nettoyage

```bash
# Nettoyer les fichiers compilés
make clean

# Nettoyer complètement (supprime obj/ et bin/)
make cleanall

# Effacer le terminal
make efface
```

---

## 📖 Commandes disponibles dans le Makefile

### 🏗️ Compilation modulaire

| Commande | Description | Sortie |
|----------|-------------|--------|
| `make all` | Compile la calculatrice modulaire complète | `bin/calc` |
| `make calc` | Compile la calculatrice modulaire | `bin/calc` |

Le processus de compilation :
```
1. main.asm        → obj/calco/main.o
2. menu.asm        → obj/calco/menu.o
3. addition.asm    → obj/calco/addition.o
4. soustraction.asm → obj/calco/soustraction.o
5. multiplication.asm → obj/calco/multiplication.o
6. division.asm    → obj/calco/division.o
7. Linkage de tous les .o → bin/calc
```

### 📚 Compilation des phases individuelles

| Commande | Description | Fichier source | Sortie |
|----------|-------------|----------------|--------|
| `make phase1` | Phase 1 : Affichage message | `code/phase1.asm` | `bin/phase1` |
| `make phase2` | Phase 2 : Lecture clavier | `code/phase2.asm` | `bin/phase2` |
| `make phase3` | Phase 3 : Addition simple | `code/phase3.asm` | `bin/phase3` |
| `make phase4` | Phase 4 : Menu + CMP/JE | `code/phase4.asm` | `bin/phase4` |
| `make phase5` | Phase 5 : MUL/DIV | `code/phase5.asm` | `bin/phase5` |

### ▶️ Exécution

| Commande | Description |
|----------|-------------|
| `make run` | Exécute la calculatrice modulaire (`bin/calc`) |
| `make run_phase1` | Exécute la phase 1 |
| `make run_phase2` | Exécute la phase 2 |
| `make run_phase3` | Exécute la phase 3 |
| `make run_phase4` | Exécute la phase 4 |
| `make run_phase5` | Exécute la phase 5 |

### 🧪 Tests rapides (Compile + Execute)

| Commande | Description |
|----------|-------------|
| `make test_all` | Compile et exécute la calculatrice complète |
| `make test_phase1` | Compile et exécute la phase 1 |
| `make test_phase2` | Compile et exécute la phase 2 |
| `make test_phase3` | Compile et exécute la phase 3 |
| `make test_phase4` | Compile et exécute la phase 4 |
| `make test_phase5` | Compile et exécute la phase 5 |

### 🗑️ Nettoyage

| Commande | Description |
|----------|-------------|
| `make clean` | Supprime tous les fichiers .o et exécutables |
| `make cleanall` | Supprime complètement les dossiers `obj/` et `bin/` |
| `make efface` | Efface le terminal (équivalent à `clear`) |

### ❓ Aide

| Commande | Description |
|----------|-------------|
| `make help` | Affiche l'aide complète avec toutes les commandes |

---

## 🔧 Compilation manuelle (sans Makefile)

Si vous souhaitez compiler manuellement pour comprendre le processus :

### Pour la calculatrice modulaire

```bash
# 1. Créer les dossiers nécessaires
mkdir -p obj/calco bin

# 2. Assembler chaque module individuellement
nasm -f elf32 code/calco/main.asm -o obj/calco/main.o
nasm -f elf32 code/calco/Fonctions/menu.asm -o obj/calco/menu.o
nasm -f elf32 code/calco/Fonctions/addition.asm -o obj/calco/addition.o
nasm -f elf32 code/calco/Fonctions/soustraction.asm -o obj/calco/soustraction.o
nasm -f elf32 code/calco/Fonctions/multiplication.asm -o obj/calco/multiplication.o
nasm -f elf32 code/calco/Fonctions/division.asm -o obj/calco/division.o

# 3. Lier tous les fichiers objets ensemble
ld -m elf_i386 obj/calco/main.o obj/calco/menu.o obj/calco/addition.o \
   obj/calco/soustraction.o obj/calco/multiplication.o obj/calco/division.o \
   -o bin/calc

# 4. Exécuter le programme
./bin/calc
```

### Pour une phase individuelle (exemple : phase 3)

```bash
# Créer les dossiers
mkdir -p obj bin

# Assembler
nasm -f elf32 code/phase3.asm -o obj/phase3.o

# Lier
ld -m elf_i386 obj/phase3.o -o bin/phase3

# Exécuter
./bin/phase3
```

---

## 📚 Phases du TP

### **Phase 1 : Affichage d'un message (2 points)** ✅
**Objectif :** Écrire un programme qui affiche "Bonjour, monde!" puis se termine proprement

**Concepts abordés :**
- Structure d'un programme assembleur (`section .data`, `.bss`, `.text`)
- Point d'entrée `_start`
- Appel système `sys_write` (EAX = 4)
- Appel système `sys_exit` (EAX = 1)
- Utilisation des registres EBX, ECX, EDX

**Commandes :**
```bash
make phase1       # Compiler
make run_phase1   # Exécuter
make test_phase1  # Compiler et exécuter
```

---

### **Phase 2 : Lecture clavier (3 points)** ✅
**Objectif :** Lire un caractère depuis stdin et l'afficher

**Concepts abordés :**
- Appel système `sys_read` (EAX = 3)
- Buffer de lecture en mémoire (section `.bss`)
- Registre ECX (adresse du buffer)
- Gestion des entrées utilisateur

**Commandes :**
```bash
make phase2       # Compiler
make run_phase2   # Exécuter
make test_phase2  # Compiler et exécuter
```

---

### **Phase 3 : Addition simple (3 points)** ✅
**Objectif :** Lire deux chiffres ASCII, les convertir en nombres et afficher leur somme

**Concepts abordés :**
- Conversion ASCII → numérique (`sub al, '0'`)
- Conversion numérique → ASCII (`add al, '0'`)
- Instruction `ADD`
- Manipulation des registres AL/AH/AX
- Gestion de la retenue

**Commandes :**
```bash
make phase3       # Compiler
make run_phase3   # Exécuter
make test_phase3  # Compiler et exécuter
```

**Exemple d'utilisation :**
```
Premier chiffre (0-9) : 5
Deuxième chiffre (0-9) : 3
Résultat : 8
```

---

### **Phase 4 : Menu et branchements (4 points)** ✅
**Objectif :** Afficher un menu et exécuter une action selon le choix utilisateur

**Concepts abordés :**
- Instruction `CMP` (compare)
- Sauts conditionnels : `JE` (jump if equal), `JNE` (jump if not equal)
- Labels et branchements
- Structure de contrôle (if/else en assembleur)
- Organisation du code avec des sections

**Commandes :**
```bash
make phase4       # Compiler
make run_phase4   # Exécuter
make test_phase4  # Compiler et exécuter
```

**Instructions de branchement :**
- `JE` / `JZ` : Saute si égal (zero flag)
- `JNE` / `JNZ` : Saute si différent
- `JG` / `JNLE` : Saute si plus grand (signed)
- `JL` / `JNGE` : Saute si plus petit (signed)
- `JMP` : Saut inconditionnel

---

### **Phase 5 : Multiplication et division (4 points)** ✅
**Objectif :** Utiliser les instructions `MUL` et `DIV`

**Concepts abordés :**
- Instruction `MUL` (multiplication non signée)
  - Opérande dans AL
  - Résultat dans AX (AL × opérande)
- Instruction `DIV` (division non signée)
  - Dividende dans AX
  - Quotient dans AL
  - Reste dans AH
- Nettoyage du registre AH avant division
- Gestion des débordements

**Commandes :**
```bash
make phase5       # Compiler
make run_phase5   # Exécuter
make test_phase5  # Compiler et exécuter
```

**Exemple MUL :**
```
6 × 7 = 42
AL = 6, opérande = 7
Après MUL : AX = 42
```

**Exemple DIV :**
```
17 ÷ 5 = 3 reste 2
AX = 17, opérande = 5
Après DIV : AL = 3 (quotient), AH = 2 (reste)
```

---

### **Phase 6 : Programme complet modulaire (4 points)** ✅ 🆕
**Objectif :** Assembler toutes les phases en une architecture professionnelle

**Concepts abordés :**
- **Architecture modulaire** : Séparation en plusieurs fichiers
- **Compilation multi-fichiers** : Assemblage et linkage séparés
- **Directives de liaison** :
  - `global` : Exporte un symbole (visible depuis d'autres fichiers)
  - `extern` : Importe un symbole (défini dans un autre fichier)
- **Convention d'appel** : Passage de paramètres, sauvegarde des registres
- **Gestion de la pile** : `push` / `pop` si nécessaire
- **Organisation professionnelle du code**

**Commandes :**
```bash
make calc         # Compiler (ou make all)
make run          # Exécuter
make test_all     # Compiler et exécuter
```

**Workflow de compilation :**
```
Phase 1 : Assemblage de chaque module (.asm → .o)
  ├─ main.asm → main.o
  ├─ menu.asm → menu.o
  ├─ addition.asm → addition.o
  ├─ soustraction.asm → soustraction.o
  ├─ multiplication.asm → multiplication.o
  └─ division.asm → division.o

Phase 2 : Linkage de tous les .o → exécutable
  └─ ld *.o → bin/calc
```

---

## 🔧 Exemple d'utilisation complète

### Workflow complet de développement

```bash
# 1. Nettoyer l'environnement
make cleanall

# 2. Compiler la calculatrice
make calc

# Sortie attendue :
# 🔨 Assemblage de main.asm...
# 🔨 Assemblage de menu.asm...
# 🔨 Assemblage de addition.asm...
# 🔨 Assemblage de soustraction.asm...
# 🔨 Assemblage de multiplication.asm...
# 🔨 Assemblage de division.asm...
# 🔗 Linkage de la calculatrice modulaire...
# ✅ Calculatrice modulaire compilée : bin/calc

# 3. Exécuter la calculatrice
make run
```

### Session d'utilisation interactive

```bash
$ make run
▶️  Lancement de la calculatrice modulaire...

╔═══════════════════════════════════════╗
║   CALCULATRICE SIMPLE - v2.0.0        ║
║   Architecture modulaire              ║
╚═══════════════════════════════════════╝

=== MENU PRINCIPAL ===
1. Addition (+)
2. Soustraction (-)
3. Multiplication (×)
4. Division (÷)
0. Quitter

Votre choix : 1

Premier chiffre (0-9) : 7
Deuxième chiffre (0-9) : 5

✅ Résultat : 12

Appuyez sur Entrée pour continuer...

=== MENU PRINCIPAL ===
1. Addition (+)
2. Soustraction (-)
3. Multiplication (×)
4. Division (÷)
0. Quitter

Votre choix : 4

Premier chiffre (0-9) : 9
Deuxième chiffre (0-9) : 4

✅ Quotient : 2
✅ Reste : 1

Appuyez sur Entrée pour continuer...

=== MENU PRINCIPAL ===
1. Addition (+)
2. Soustraction (-)
3. Multiplication (×)
4. Division (÷)
0. Quitter

Votre choix : 0

👋 Au revoir !
```

---

## 📝 Notes techniques importantes

### Architecture et format

| Caractéristique | Valeur |
|----------------|--------|
| **Architecture** | x86 32 bits (i386) |
| **Format de fichier** | ELF (Executable and Linkable Format) |
| **Assembleur** | NASM (Netwide Assembler) |
| **Linker** | ld (GNU linker) |
| **Système** | Linux |

### Registres utilisés

| Registre | Taille | Usage dans le projet |
|----------|--------|---------------------|
| **EAX** | 32 bits | Numéro d'appel système (syscall), résultats |
| **EBX** | 32 bits | 1er argument (file descriptor: 0=stdin, 1=stdout) |
| **ECX** | 32 bits | 2ème argument (adresse du buffer) |
| **EDX** | 32 bits | 3ème argument (longueur du buffer) |
| **AX** | 16 bits | Résultat de MUL, dividende de DIV |
| **AL** | 8 bits | Partie basse de AX, calculs arithmétiques |
| **AH** | 8 bits | Partie haute de AX, reste de DIV |

**Hiérarchie des registres :**
```
EAX (32 bits)
├─ AX (16 bits)
   ├─ AH (8 bits haut)
   └─ AL (8 bits bas)
```

### Appels système Linux (syscalls)

| Syscall | Numéro (EAX) | Arguments | Description |
|---------|--------------|-----------|-------------|
| **sys_exit** | 1 | EBX = code retour | Terminer le programme |
| **sys_read** | 3 | EBX = fd, ECX = buffer, EDX = taille | Lire depuis stdin/fichier |
| **sys_write** | 4 | EBX = fd, ECX = buffer, EDX = taille | Écrire vers stdout/fichier |

**File descriptors standards :**
- 0 = stdin (entrée standard)
- 1 = stdout (sortie standard)
- 2 = stderr (sortie d'erreur)

### Conversion ASCII

| Opération | Code assembleur | Explication |
|-----------|----------------|-------------|
| **ASCII → Nombre** | `sub al, '0'` ou `sub al, 48` | '5' (53) - '0' (48) = 5 |
| **Nombre → ASCII** | `add al, '0'` ou `add al, 48` | 5 + '0' (48) = '5' (53) |

**Table ASCII pour les chiffres :**
```
Caractère   Code ASCII (décimal)   Valeur numérique
'0'         48                     0
'1'         49                     1
'2'         50                     2
'3'         51                     3
'4'         52                     4
'5'         53                     5
'6'         54                     6
'7'         55                     7
'8'         56                     8
'9'         57                     9
```

### Instructions arithmétiques

| Instruction | Syntaxe | Description | Exemple |
|-------------|---------|-------------|---------|
| **ADD** | `add dest, src` | dest = dest + src | `add al, bl` |
| **SUB** | `sub dest, src` | dest = dest - src | `sub al, 3` |
| **MUL** | `mul src` | AX = AL × src (8 bits) | `mul bl` |
| **DIV** | `div src` | AL = AX ÷ src, AH = reste | `div bl` |

**Particularités MUL/DIV :**
- **MUL** : Résultat peut dépasser 8 bits, utilise AX (16 bits)
- **DIV** : Nécessite que AH soit nettoyé (mov ah, 0) avant division

### Directives de liaison (linking)

| Directive | Usage | Exemple |
|-----------|-------|---------|
| **global** | Rend un symbole visible depuis d'autres fichiers | `global _start` |
| **extern** | Déclare un symbole défini dans un autre fichier | `extern afficher_menu` |

**Exemple dans main.asm :**
```asm
global _start           ; Exporte le point d'entrée
extern afficher_menu    ; Importe depuis menu.asm
extern addition         ; Importe depuis addition.asm
```

**Exemple dans addition.asm :**
```asm
global addition         ; Exporte la fonction addition

addition:
    ; Code de la fonction
    ret
```

### Sections d'un programme

| Section | Description | Contenu |
|---------|-------------|---------|
| **.data** | Données initialisées | Messages, constantes |
| **.bss** | Données non initialisées | Buffers, variables |
| **.text** | Code exécutable | Instructions assembleur |

---

## 🐛 Débogage et résolution de problèmes

### Outils de débogage

#### 1. Vérifier l'assemblage

```bash
# Assembler avec affichage des erreurs
nasm -f elf32 code/calco/Fonctions/addition.asm -o obj/calco/addition.o

# Sortie si erreur :
# code/calco/Fonctions/addition.asm:15: error: symbol `addition` redefined
```

#### 2. Vérifier le linkage

```bash
# Lier avec affichage des erreurs
ld -m elf_i386 obj/calco/*.o -o bin/calc

# Sortie si erreur :
# ld: obj/calco/main.o: undefined reference to 'addition'
```

