#!/bin/bash
# ==============================================
# CTF-Forge: Automated Recon & Enumeration Tool
# Author: Jihad Tichti
# ==============================================

# -------------------------------
# Colors for output
# -------------------------------
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
NC="\033[0m" # No Color

# -------------------------------
# Banner
# -------------------------------
banner() {
  RED="\033[0;31m"
  NC="\033[0m"  # No Color

  echo -e "${RED}"
  cat << "EOF"
  ____ _____ _____     _____                    
 / ___|_   _|  ___|   |  ___|__  _ __ __ _  ___ 
| |     | | | |_ _____| |_ / _ \| '__/ _` |/ _ \
| |___  | | |  _|_____|  _| (_) | | | (_| |  __/
 \____| |_| |_|       |_|  \___/|_|  \__, |\___|
                                     |___/      
EOF
  echo -e "${NC}"  # Reset color after banner
}



# -------------------------------
# Check for required tools
# -------------------------------
check_deps() {
    dependencies=("nmap" "gobuster" "dirsearch" "enum4linux")
    for tool in "${dependencies[@]}"; do
        if ! command -v $tool &> /dev/null; then
            echo -e "${RED}[-] $tool is not installed. Please install it first.${NC}"
        fi
    done
}

# -------------------------------
# Create output folder
# -------------------------------
create_output() {
    TARGET_IP=$1
    OUTDIR="output/$TARGET_IP"
    mkdir -p "$OUTDIR/nmap"
    mkdir -p "$OUTDIR/web"
    mkdir -p "$OUTDIR/smb"
    mkdir -p "$OUTDIR/privesc"
    mkdir -p "$OUTDIR/flags"
}

# -------------------------------
# Main Menu
# -------------------------------
main_menu() {
    echo -e "${GREEN}Select an option:${NC}"
    echo "1) Full Recon"
    echo "2) Web Enumeration"
    echo "3) SMB Enumeration"
    echo "4) Privilege Escalation Check"
    echo "5) Flag Finder"
    echo "6) Exit"
    echo -n "Choice: "
    read choice
    case $choice in
        1) full_recon ;;
        2) web_enum ;;
        3) smb_enum ;;
        4) privesc ;;
        5) flag_finder ;;
        6) exit 0 ;;
        *) echo -e "${RED}Invalid choice!${NC}"; main_menu ;;
    esac
}

# -------------------------------
# Module Functions (placeholders)
# -------------------------------
full_recon() {
    echo -e "${YELLOW}[+] Running full recon...${NC}"
    ./modules/recon.sh $TARGET_IP
    ./modules/web_enum.sh $TARGET_IP
    ./modules/smb_enum.sh $TARGET_IP
    main_menu
}

web_enum() {
    echo -e "${YELLOW}[+] Running web enumeration...${NC}"
    ./modules/web_enum.sh $TARGET_IP
    main_menu
}

smb_enum() {
    echo -e "${YELLOW}[+] Running SMB enumeration...${NC}"
    ./modules/smb_enum.sh $TARGET_IP
    main_menu
}

privesc() {
    echo -e "${YELLOW}[+] Running privilege escalation check...${NC}"
    ./modules/privesc.sh $TARGET_IP
    main_menu
}

flag_finder() {
    echo -e "${YELLOW}[+] Searching for flags...${NC}"
    ./modules/flag_finder.sh $TARGET_IP
    main_menu
}

# -------------------------------
# Script Start
# -------------------------------
banner
check_deps

# Ask for target IP
echo -n "Enter target IP: "
read TARGET_IP
create_output $TARGET_IP

# Show menu
main_menu
