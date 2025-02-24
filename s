#!/usr/bin/env bash

# Colors
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
RED='\033[1;31m'
NC='\033[0m'  # No Color

# Enable TAB autocompletion on first press
bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'

# Function to display menu
display_menu() {
    echo -e "${CYAN}Welcome to Shell Automation Tool (SAT)${NC}"
    echo "Choose an option:"
    echo "1. Create File"
    echo "2. Git Workflow"
    echo "3. Compile & Run C File"
    echo "4. Learning Mode"
    echo "q. Quit"
    echo ""
}

# Function to create a file
create_file() {
    while true; do
        read -e -p "Enter file name (or type 'q' to return to menu): " filename
        [[ "$filename" == "q" ]] && return
        if [[ -z "$filename" ]]; then
            echo -e "${RED}Error: File name cannot be empty.${NC}"
            continue
        fi
        read -p "Confirm file name '$filename'? (y/n): " confirm
        [[ "$confirm" == "n" ]] && continue
        [[ "$confirm" == "q" ]] && return
        if [[ -e "$filename" ]]; then
            echo -e "${RED}Error: File '$filename' already exists. Choose another name.${NC}"
        else
            touch "$filename"
            echo -e "${GREEN}File '$filename' created.${NC}"
            session_log+="touch $filename\n"
            return
        fi
    done
}

# Function to run Git Workflow
git_workflow() {
    echo -e "${YELLOW}🚀 Git Workflow:${NC}"
    
    # Verificar el estado del repo antes de continuar
    git status
    
    # Solicitar mensaje de commit
    read -p "Commit message: " commit_msg
    
    # Agregar archivos al commit
    git add .
    
    # Realizar el commit
    git commit -m "$commit_msg"
    
    # Empujar los cambios a GitHub
    git push
    
    echo -e "${GREEN}✅ Git push completed.${NC}"
    
    # Esperar una tecla para regresar al menú
    read -n 1 -p "Press any key to return to the menu..."
    clear
}


# Function to compile and run a C file
compile_and_run_c_file() {
    read -e -p "Enter the name of the C file (without extension): " cfile
    if [[ -z "$cfile" ]]; then
        echo -e "${RED}Error: No file name provided.${NC}"
        return
    fi
    if [[ ! -f "$cfile.c" ]]; then
        echo -e "${RED}Error: File '$cfile.c' not found.${NC}"
        return
    fi
    gcc -Wall -Werror -Wextra -pedantic -std=gnu89 "$cfile.c" -o "$cfile.out"
    if [[ $? -eq 0 ]]; then
        echo -e "${GREEN}Compilation successful. Running program...${NC}"
        ./$cfile.out
        echo -e "\n${YELLOW}Press any key to continue...${NC}"
        read -n 1  # Esto pausa hasta que presiones una tecla
        clear  # Limpia la pantalla después de que el usuario vio el resultado
    else
        echo -e "${RED}Compilation failed. Check the errors above.${NC}"
    fi
}

# Learning Mode Function
learning_mode() {
    clear
    echo "LEARNING MODE - Explanation"
    echo "--------------------------------"
    echo "This mode tracks your current session activities."
    echo -e "${YELLOW}$session_log${NC}"
    echo "--------------------------------"
    echo "Press 'm' to go back to the menu, or 'q' to quit."
    while true; do
        read -n 1 choice
        echo ""
        case "$choice" in
            m) return;;
            q) exit 0;;
        esac
    done
}

# Main Execution Loop
session_log=""
if [[ $# -eq 0 ]]; then
    while true; do
        display_menu
        read -r option  # 🔥 Captura la opción correctamente
        case "$option" in
            1) create_file ;;
            2) git_workflow ;;  # 🔥 Ahora ejecutará Git Workflow correctamente
            3) compile_and_run_c_file ;;
            4) learning_mode ;;
            q) exit 0 ;;
            *) echo -e "${RED}Invalid option, try again.${NC}" ;;
        esac
    done
else
    echo "Invalid usage. Run 's' without arguments to open the menu."
fi

