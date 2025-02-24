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
    echo -e "${YELLOW}🚀 Git Workflow:${NC}"
    if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        echo -e "${RED}Error: Not inside a Git repository.${NC}"
        return
    fi
    
    while true; do
        echo "Choose an action:"
        echo "  1. Add files"
        echo "  2. Commit changes"
        echo "  3. Push to remote"
        echo "  q. Quit Git Workflow"
        read -p "Select an option: " git_option

        case "$git_option" in
            1)
                git add .
                echo -e "${GREEN}Files added.${NC}"
                ;;
            2)
                read -p "Enter commit message: " commit_msg
                git commit -m "$commit_msg"
                echo -e "${GREEN}Commit created.${NC}"
                ;;
            3)
                current_branch=$(git branch --show-current)
                git push origin "$current_branch"
                echo -e "${GREEN}Changes pushed to '$current_branch' branch.${NC}"
                ;;
            q)
                return;;
            *)
                echo -e "${RED}Invalid option. Try again.${NC}";;
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

