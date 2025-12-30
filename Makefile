#----------------------------------------------------------------
# MAKEFILE - TP ASSEMBLEUR x86 - CALCULATRICE SIMPLE
#----------------------------------------------------------------
# Auteur: PAUL-BASTHYLLE MASSE MASSE
# Date: Décembre 2025
# Cours: GSI 531
#----------------------------------------------------------------

# Variables
ASM = nasm
LD = ld
ASMFLAGS = -f elf32
LDFLAGS = -m elf_i386

SRC_DIR = code
OBJ_DIR = obj
BIN_DIR = bin

#----------------------------------------------------------------
# RÈGLES PRINCIPALES
#----------------------------------------------------------------

.PHONY: all clean cleanall help phase1 phase2 phase3 phase4 phase5

# Compiler le programme complet (phase 6)
all:
	@mkdir -p $(OBJ_DIR) $(BIN_DIR)
	@echo "🔨 Assemblage de calc.asm..."
	$(ASM) $(ASMFLAGS) $(SRC_DIR)/calc.asm -o $(OBJ_DIR)/calc.o
	@echo "🔗 Linkage de calc..."
	$(LD) $(LDFLAGS) $(OBJ_DIR)/calc.o -o $(BIN_DIR)/calc
	@echo "✅ Programme complet compilé : $(BIN_DIR)/calc"

# Phase 1 : Affichage d'un message
phase1:
	@mkdir -p $(OBJ_DIR) $(BIN_DIR)
	$(ASM) $(ASMFLAGS) $(SRC_DIR)/phase1.asm -o $(OBJ_DIR)/phase1.o
	$(LD) $(LDFLAGS) $(OBJ_DIR)/phase1.o -o $(BIN_DIR)/phase1
	@echo "✅ Phase 1 compilée"

# Phase 2 : Lecture clavier
phase2:
	@mkdir -p $(OBJ_DIR) $(BIN_DIR)
	$(ASM) $(ASMFLAGS) $(SRC_DIR)/phase2.asm -o $(OBJ_DIR)/phase2.o
	$(LD) $(LDFLAGS) $(OBJ_DIR)/phase2.o -o $(BIN_DIR)/phase2
	@echo "✅ Phase 2 compilée"

# Phase 3 : Addition simple
phase3:
	@mkdir -p $(OBJ_DIR) $(BIN_DIR)
	$(ASM) $(ASMFLAGS) $(SRC_DIR)/phase3.asm -o $(OBJ_DIR)/phase3.o
	$(LD) $(LDFLAGS) $(OBJ_DIR)/phase3.o -o $(BIN_DIR)/phase3
	@echo "✅ Phase 3 compilée"

# Phase 4 : Menu et CMP/JE
phase4:
	@mkdir -p $(OBJ_DIR) $(BIN_DIR)
	$(ASM) $(ASMFLAGS) $(SRC_DIR)/phase4.asm -o $(OBJ_DIR)/phase4.o
	$(LD) $(LDFLAGS) $(OBJ_DIR)/phase4.o -o $(BIN_DIR)/phase4
	@echo "✅ Phase 4 compilée"

# Phase 5 : Multiplication et division
phase5:
	@mkdir -p $(OBJ_DIR) $(BIN_DIR)
	$(ASM) $(ASMFLAGS) $(SRC_DIR)/phase5.asm -o $(OBJ_DIR)/phase5.o
	$(LD) $(LDFLAGS) $(OBJ_DIR)/phase5.o -o $(BIN_DIR)/phase5
	@echo "✅ Phase 5 compilée"

#----------------------------------------------------------------
# RÈGLES D'EXÉCUTION
#----------------------------------------------------------------

# Exécuter le programme complet
run:
	@echo "▶️  Exécution de la calculatrice..."
	@$(BIN_DIR)/calc

# Exécuter les phases individuellement
run_phase1:
	@echo "▶️  Exécution Phase 1..."
	@$(BIN_DIR)/phase1

run_phase2:
	@echo "▶️  Exécution Phase 2..."
	@$(BIN_DIR)/phase2

run_phase3:
	@echo "▶️  Exécution Phase 3..."
	@$(BIN_DIR)/phase3

run_phase4:
	@echo "▶️  Exécution Phase 4..."
	@$(BIN_DIR)/phase4

run_phase5:
	@echo "▶️  Exécution Phase 5..."
	@$(BIN_DIR)/phase5

# Compiler et exécuter directement
test_phase1: phase1 run_phase1
test_phase2: phase2 run_phase2
test_phase3: phase3 run_phase3
test_phase4: phase4 run_phase4
test_phase5: phase5 run_phase5
test_all: all run

#----------------------------------------------------------------
# NETTOYAGE
#----------------------------------------------------------------

clean:
	@echo "🗑️  Nettoyage des fichiers compilés..."
	@rm -f $(OBJ_DIR)/*.o $(BIN_DIR)/*
	@echo "✅ Nettoyage terminé"

cleanall: clean
	@rm -rf $(OBJ_DIR) $(BIN_DIR)
	@echo "✅ Nettoyage complet terminé"

#----------------------------------------------------------------
# AIDE
#----------------------------------------------------------------

help:
	@echo "╔════════════════════════════════════════════════════════════╗"
	@echo "║          TP ASSEMBLEUR x86 - CALCULATRICE SIMPLE          ║"
	@echo "╚════════════════════════════════════════════════════════════╝"
	@echo ""
	@echo "COMPILATION :"
	@echo "  make all           - Compiler le programme complet (phase 6)"
	@echo "  make phase1        - Compiler la phase 1 (affichage message)"
	@echo "  make phase2        - Compiler la phase 2 (lecture clavier)"
	@echo "  make phase3        - Compiler la phase 3 (addition simple)"
	@echo "  make phase4        - Compiler la phase 4 (menu + CMP/JE)"
	@echo "  make phase5        - Compiler la phase 5 (MUL/DIV)"
	@echo ""
	@echo "EXÉCUTION :"
	@echo "  make run           - Exécuter le programme complet"
	@echo "  make run_phase1    - Exécuter la phase 1"
	@echo "  make run_phase2    - Exécuter la phase 2"
	@echo "  make run_phase3    - Exécuter la phase 3"
	@echo "  make run_phase4    - Exécuter la phase 4"
	@echo "  make run_phase5    - Exécuter la phase 5"
	@echo ""
	@echo "TESTS RAPIDES :"
	@echo "  make test_phase1   - Compiler + exécuter phase 1"
	@echo "  make test_phase2   - Compiler + exécuter phase 2"
	@echo "  make test_phase3   - Compiler + exécuter phase 3"
	@echo "  make test_phase4   - Compiler + exécuter phase 4"
	@echo "  make test_phase5   - Compiler + exécuter phase 5"
	@echo "  make test_all      - Compiler + exécuter programme complet"
	@echo ""
	@echo "NETTOYAGE :"
	@echo "  make clean         - Supprimer fichiers .o et exécutables"
	@echo "  make cleanall      - Supprimer obj/ et bin/ complètement"
	@echo ""
	@echo "╚════════════════════════════════════════════════════════════╝"
	@echo "Auteur: PAUL-BASTHYLLE MASSE MASSE | GSI 531 | Décembre 2025"

.PHONY: all clean cleanall help phase1 phase2 phase3 phase4 phase5 \
        run run_phase1 run_phase2 run_phase3 run_phase4 run_phase5 \
        test_phase1 test_phase2 test_phase3 test_phase4 test_phase5 test_all
