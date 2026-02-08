#!/bin/bash
# ==============================================
# CTF-Forge - Dependency & Wordlist Checks
# ==============================================

check_deps() {
    dependencies=("nmap" "gobuster" "enum4linux")

    for tool in "${dependencies[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            echo -e "${RED}[-] $tool is not installed!${NC}"
            echo "Install it and try again."
            exit 1
        fi
    done

    # dirsearch special case
    if ! command -v dirsearch &> /dev/null && ! command -v dirsearch.py &> /dev/null; then
        echo -e "${RED}[-] dirsearch is not installed!${NC}"
        exit 1
    fi
}

check_wordlist() {
    if [[ ! -f "$1" ]]; then
        echo -e "${RED}[!] Missing wordlist: $1${NC}"
        echo "Verify your Kali wordlists."
        exit 1
    fi
}

# ---- Run Checks ----
check_deps
check_wordlist "$WORDLIST_COMMON"
check_wordlist "$WORDLIST_DIRBUSTER"
check_wordlist "$WORDLIST_ROCKYOU"
