#!/bin/bash

# Script Name: calc_build.sh
# Purpose: Automate the compilation of Flex/Bison calculator program
# Compatibility: Ubuntu/Linux-based systems
# Usage: ./calc_build.sh (ensure execute permission with chmod +x calc_build.sh)

# Set script execution rules:
# -e: Exit immediately if any command fails
# -u: Treat unset variables as an error and exit
# -o pipefail: Make pipeline return the exit status of the last failed command
set -euo pipefail

# Define color codes for better output readability
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color (reset to default)

# -------------------------- Step 1: Check required files -------------------------
echo -e "${YELLOW}=== Checking required source files ===${NC}"
if [ ! -f "calc.y" ]; then
    echo -e "${RED}Error: calc.y file not found in current directory!${NC}"
    exit 1
fi

if [ ! -f "calc.l" ]; then
    echo -e "${RED}Error: calc.l file not found in current directory!${NC}"
    exit 1
fi
echo -e "${GREEN}✓ All required source files exist${NC}"

# -------------------------- Step 2: Generate parser code with Bison ---------------
echo -e "\n${YELLOW}=== Generating parser code (bison) ===${NC}"
if command -v bison &> /dev/null; then
    bison -d calc.y
    echo -e "${GREEN}✓ Bison completed: calc.tab.c and calc.tab.h generated${NC}"
else
    echo -e "${RED}Error: Bison is not installed!${NC}"
    echo -e "${YELLOW}Install it first with: sudo apt install -y bison${NC}"
    exit 1
fi

# -------------------------- Step 3: Generate lexer code with Flex -----------------
echo -e "\n${YELLOW}=== Generating lexer code (flex) ===${NC}"
if command -v flex &> /dev/null; then
    flex calc.l
    echo -e "${GREEN}✓ Flex completed: lex.yy.c generated${NC}"
else
    echo -e "${RED}Error: Flex is not installed!${NC}"
    echo -e "${YELLOW}Install it first with: sudo apt install -y flex${NC}"
    exit 1
fi

# -------------------------- Step 4: Compile executable with GCC -------------------
echo -e "\n${YELLOW}=== Compiling executable binary ===${NC}"
if command -v gcc &> /dev/null; then
    gcc -o calc calc.tab.c lex.yy.c -lfl
    echo -e "${GREEN}✓ Compilation completed: 'calc' executable generated${NC}"
else
    echo -e "${RED}Error: GCC compiler is not installed!${NC}"
    echo -e "${YELLOW}Install it first with: sudo apt install -y build-essential${NC}"
    exit 1
fi

# -------------------------- Final Success Message ---------------------------------
echo -e "\n${GREEN}=== Build succeeded! ===${NC}"
echo -e "To run the calculator program: ${YELLOW}./calc${NC}"
echo -e "Example input: 123+456 (press Enter) to see the result"