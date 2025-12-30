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
CALCO_DIR = $(SRC_DIR)/calco
FUNC_DIR = $(CALCO_DIR)/Fonctions
OBJ_DIR = obj
CALCO_OBJ_DIR = $(OBJ_DIR)/calco
BIN_DIR = bin

# Fichiers objets pour la calculatrice modulaire
CALCO_OBJECTS = $(CALCO_OBJ_DIR)/main.o \
                $(CALCO_OBJ_DIR)/menu.o \
                $(CALCO_OBJ_DIR)/addition.o \
                $(CALCO_OBJ_DIR)/soustraction.o \
                $(CALCO_OBJ_DIR)/multiplication.o \
                $(CALCO_OBJ_DIR)/division.o

#----------------------------------------------------------------
# RÈGLES PRINCIPALES
#----------------------------------------------------------------

.PHONY: all clean cleanall help phase1 phase2 phase3 phase4 phase5 calc

# Compiler la calculatrice modulaire complète et toutes les phases
all: calc phase1 phase2 phase3 phase4 phase5


calc: $(CALCO_OBJECTS)
	@mkdir -p $(BIN_DIR)
	@echo "🔗 Linkage de la calculatrice modulaire..."
	$(LD) $(LDFLAGS) $(CALCO_OBJECTS) -o $(BIN_DIR)/calc
	@echo "✅ Calculatrice modulaire compilée : $(BIN_DIR)/calc"

# Compilation des modules individuels
$(CALCO_OBJ_DIR)/main.o: $(CALCO_DIR)/main.asm
	@mkdir -p $(CALCO_OBJ_DIR)
	@echo "🔨 Assemblage de main.asm..."
	$(ASM) $(ASMFLAGS) $< -o $@

$(CALCO_OBJ_DIR)/menu.o: $(FUNC_DIR)/menu.asm
	@mkdir -p $(CALCO_OBJ_DIR)
	@echo "🔨 Assemblage de menu.asm..."
	$(ASM) $(ASMFLAGS) $< -o $@

$(CALCO_OBJ_DIR)/addition.o: $(FUNC_DIR)/addition.asm
	@mkdir -p $(CALCO_OBJ_DIR)
	@echo "🔨 Assemblage de addition.asm..."
	$(ASM) $(ASMFLAGS) $< -o $@

$(CALCO_OBJ_DIR)/soustraction.o: $(FUNC_DIR)/soustraction.asm
	@mkdir -p $(CALCO_OBJ_DIR)
	@echo "🔨 Assemblage de soustraction.asm..."
	$(ASM) $(ASMFLAGS) $< -o $@

$(CALCO_OBJ_DIR)/multiplication.o: $(FUNC_DIR)/multiplication.asm
	@mkdir -p $(CALCO_OBJ_DIR)
	@echo "🔨 Assemblage de multiplication.asm..."
	$(ASM) $(ASMFLAGS) $< -o $@

$(CALCO_OBJ_DIR)/division.o: $(FUNC_DIR)/division.asm
	@mkdir -p $(CALCO_OBJ_DIR)
	@echo "🔨 Assemblage de division.asm..."
	$(ASM) $(ASMFLAGS) $< -o $@

#----------------------------------------------------------------
# PHASES INDIVIDUELLES (Tests progressifs)
#----------------------------------------------------------------

# Phase 1 : Affichage d'un message
phase1:
	@mkdir -p $(OBJ_DIR) $(BIN_DIR)
	@echo "🔨 Assemblage de phase1.asm..."
	$(ASM) $(ASMFLAGS) $(SRC_DIR)/phase1.asm -o $(OBJ_DIR)/phase1.o
	$(LD) $(LDFLAGS) $(OBJ_DIR)/phase1.o -o $(BIN_DIR)/phase1
	@echo "✅ Phase 1 compilée"

# Phase 2 : Lecture clavier
phase2:
	@mkdir -p $(OBJ_DIR) $(BIN_DIR)
	@echo "🔨 Assemblage de phase2.asm..."
	$(ASM) $(ASMFLAGS) $(SRC_DIR)/phase2.asm -o $(OBJ_DIR)/phase2.o
	$(LD) $(LDFLAGS) $(OBJ_DIR)/phase2.o -o $(BIN_DIR)/phase2
	@echo "✅ Phase 2 compilée"

# Phase 3 : Addition simple
phase3:
	@mkdir -p $(OBJ_DIR) $(BIN_DIR)
	@echo "🔨 Assemblage de phase3.asm..."
	$(ASM) $(ASMFLAGS) $(SRC_DIR)/phase3.asm -o $(OBJ_DIR)/phase3.o
	$(LD) $(LDFLAGS) $(OBJ_DIR)/phase3.o -o $(BIN_DIR)/phase3
	@echo "✅ Phase 3 compilée"

# Phase 4 : Menu et CMP/JE
phase4:
	@mkdir -p $(OBJ_DIR) $(BIN_DIR)
	@echo "🔨 Assemblage de phase4.asm..."
	$(ASM) $(ASMFLAGS) $(SRC_DIR)/phase4.asm -o $(OBJ_DIR)/phase4.o
	$(LD) $(LDFLAGS) $(OBJ_DIR)/phase4.o -o $(BIN_DIR)/phase4
	@echo "✅ Phase 4 compilée"

# Phase 5 : Multiplication et division
phase5:
	@mkdir -p $(OBJ_DIR) $(BIN_DIR)
	@echo "🔨 Assemblage de phase5.asm..."
	$(ASM) $(ASMFLAGS) $(SRC_DIR)/phase5.asm -o $(OBJ_DIR)/phase5.o
	$(LD) $(LDFLAGS) $(OBJ_DIR)/phase5.o -o $(BIN_DIR)/phase5
	@echo "✅ Phase 5 compilée"

#----------------------------------------------------------------
# RÈGLES D'EXÉCUTION
#----------------------------------------------------------------

# Exécuter la calculatrice complète
run:
	@echo "▶️  Lancement de la calculatrice modulaire..."
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

#----------------------------------------------------------------
# TESTS RAPIDES (Compilation + Exécution)
#----------------------------------------------------------------

test_phase1: phase1 run_phase1
test_phase2: phase2 run_phase2
test_phase3: phase3 run_phase3
test_phase4: phase4 run_phase4
test_phase5: phase5 run_phase5
test_all: calc run

#----------------------------------------------------------------
# NETTOYAGE
#----------------------------------------------------------------

clean:
	@echo "🗑️  Nettoyage des fichiers compilés..."
	@rm -f $(OBJ_DIR)/*.o
	@rm -f $(CALCO_OBJ_DIR)/*.o
	@rm -f $(BIN_DIR)/phase* $(BIN_DIR)/calc
	@echo "✅ Nettoyage terminé"

cleanall: clean
	@echo "🗑️  Nettoyage complet..."
	@rm -rf $(OBJ_DIR) $(BIN_DIR)
	@echo "✅ Nettoyage complet terminé"

#----------------------------------------------------------------
# AIDE
#----------------------------------------------------------------

help:
	@echo "╔════════════════════════════════════════════════════════════╗"
	@echo "║          TP ASSEMBLEUR x86 - CALCULATRICE SIMPLE           ║"
	@echo "╚════════════════════════════════════════════════════════════╝"
	@echo ""
	@echo "  COMPILATION MODULAIRE :"
	@echo "  make all           - Compiler la calculatrice modulaire et toutes les phases "
	@echo "  make calc          - Compiler la calculatrice modulaire"
	@echo ""
	@echo "  PHASES INDIVIDUELLES :"
	@echo "  make phase1        - Compiler la phase 1 (affichage message)"
	@echo "  make phase2        - Compiler la phase 2 (lecture clavier)"
	@echo "  make phase3        - Compiler la phase 3 (addition simple)"
	@echo "  make phase4        - Compiler la phase 4 (menu + CMP/JE)"
	@echo "  make phase5        - Compiler la phase 5 (MUL/DIV)"
	@echo ""
	@echo "  EXÉCUTION :"
	@echo "  make run           - Exécuter la calculatrice modulaire"
	@echo "  make run_phase1    - Exécuter la phase 1"
	@echo "  make run_phase2    - Exécuter la phase 2"
	@echo "  make run_phase3    - Exécuter la phase 3"
	@echo "  make run_phase4    - Exécuter la phase 4"
	@echo "  make run_phase5    - Exécuter la phase 5"
	@echo ""
	@echo "  TESTS RAPIDES (Compile + Execute) :"
	@echo "  make test_phase1   - Compiler + exécuter phase 1"
	@echo "  make test_phase2   - Compiler + exécuter phase 2"
	@echo "  make test_phase3   - Compiler + exécuter phase 3"
	@echo "  make test_phase4   - Compiler + exécuter phase 4"
	@echo "  make test_phase5   - Compiler + exécuter phase 5"
	@echo "  make test_all      - Compiler + exécuter calculatrice complète"
	@echo ""
	@echo "  NETTOYAGE :"
	@echo "  make clean         - Supprimer fichiers .o et exécutables"
	@echo "  make cleanall      - Supprimer obj/ et bin/ complètement"
	@echo "  make efface	     - Effacer le terminal"
	@echo ""
	@echo "╔════════════════════════════════════════════════════════════╗"
	@echo "║Auteur: PAUL-BASTHYLLE MASSE MASSE | GSI 531 | Décembre 2025║"
	@echo "╚════════════════════════════════════════════════════════════╝"
	

.PHONY: all clean cleanall help phase1 phase2 phase3 phase4 phase5 calc \
        run run_phase1 run_phase2 run_phase3 run_phase4 run_phase5 \
        test_phase1 test_phase2 test_phase3 test_phase4 test_phase5 test_all
        
efface:
	clear
