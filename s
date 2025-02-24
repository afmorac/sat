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
        if [[ -e "$filename" ]]; then
            echo -e "${RED}Error: File '$filename' already exists. Choose another name.${NC}"
        else
            touch "$filename"
            echo -e "${GREEN}File '$filename' created.${NC}"
            return
        fi
    done
}

# Function to handle Git Workflow
git_workflow() {
    if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        echo -e "${RED}Error: You are not in a Git repository.${NC}"
        echo -e "${YELLOW}Tip: Use 'git init' to create a new repository here.${NC}"
        echo -e "${CYAN}Or navigate to an existing Git repository and try again.${NC}"
        read -p "Press any key to return to the menu..."
        return
    fi

    while true; do
        echo -e "${YELLOW}Git Workflow Steps:${NC}"
        echo "1. git add"
        echo "2. git commit"
        echo "3. git push"
        echo "q. Quit"
        read -p "Choose step: " git_step

        case $git_step in
            1)
                while true; do
                    echo -e "${YELLOW}git add:${NC}"
                    echo "  m - Add all files"
                    echo "  d - Add specific directory"
                    echo "  f - Add specific file"
                    echo "  c - Custom add command"
                    echo "  q - Quit"
                    read -p "Choose option: " add_option

                    case $add_option in
                        m) git add . ; break ;;
                        d) read -p "Enter directory name: " dir; git add "$dir" ; break ;;
                        f) read -p "Enter file name: " file; git add "$file" ; break ;;
                        c) read -p "Enter custom add command: " custom_add; eval "$custom_add" ; break ;;
                        q) break ;;
                        *) echo -e "${RED}Invalid option. Try again.${NC}" ;;
                    esac
                done
                ;;
            2)
                read -p "Enter commit message: " commit_msg
                git commit -m "$commit_msg"
                ;;
            3)
                git push
                ;;
            q) return ;;
            *) echo -e "${RED}Invalid option. Try again.${NC}" ;;
        esac
    done
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
        read -n 1 -p "Press any key to continue..."
        clear
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

# Main Execution
if [[ $# -eq 0 ]]; then
    while true; do
        display_menu
        read -r -p "Select an option: " option
        case "$option" in
            1) create_file ;;
            2) git_workflow ;;
            3) compile_and_run_c_file ;;
            4) learning_mode ;;
            q) exit 0 ;;
            *) echo -e "${RED}Invalid option, try again.${NC}" ;;
        esac
    done
else
    echo "Invalid usage. Run 's' without arguments to open the menu."
fi

