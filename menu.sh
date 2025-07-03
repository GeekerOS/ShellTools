#!/bin/bash

# Copyright 2025 ShellTools  authors.

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# Define color variables for better readability
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Display menu function
show_menu() {
    echo -e "${BLUE}=============================================${NC}"
    echo -e "${GREEN}            System Information Menu           ${NC}"
    echo -e "${BLUE}=============================================${NC}"
    echo -e "${YELLOW}1)${NC} View System Information"
    echo -e "${YELLOW}2)${NC} Check Disk Space"
    echo -e "${YELLOW}3)${NC} View Memory Usage"
    echo -e "${YELLOW}4)${NC} Exit Program"
    echo -e "${BLUE}---------------------------------------------${NC}"
}

# Get user input and execute corresponding action
get_user_choice() {
    read -p "Enter your choice [1-4]: " choice
    case $choice in
        1)
            echo -e "${GREEN}Retrieving system information...${NC}"
            echo
            uname -a
            echo
            lsb_release -a 2>/dev/null || echo "Unable to retrieve distribution information"
            ;;
        2)
            echo -e "${GREEN}Checking disk space...${NC}"
            echo
            df -h
            ;;
        3)
            echo -e "${GREEN}Checking memory usage...${NC}"
            echo
            free -h
            echo
            echo -e "${YELLOW}Memory usage trend (last 5 samples):${NC}"
            for ((i=5; i>0; i--)); do
                free -m | awk 'NR==2{printf "Memory used: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
                sleep 1
            done
            ;;
        4)
            echo -e "${RED}Exiting program...${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Error: Invalid choice. Please enter a number between 1 and 4${NC}"
            ;;
    esac
}

# Main program loop
while true; do
    show_menu
    get_user_choice
    echo
    read -p "Press Enter to return to menu..."
    clear
done 
