#!/bin/bash
# ==============================================
# CTF-Forge - Reconnaissance Module
# ==============================================

TARGET="$1"

# Check target
if [ -z "$TARGET" ]; then
    echo "Usage: recon.sh <target-ip>"
    exit 1
fi

OUT_DIR="Output/$TARGET"
FAST_SCAN="$OUT_DIR/nmap_fast.txt"
FULL_SCAN="$OUT_DIR/nmap_full.txt"

mkdir -p "$OUT_DIR"

echo "[+] Reconnaissance started on $TARGET"
echo "----------------------------------"

# Fast port scan
echo "[*] Running fast port scan..."
nmap -p- --min-rate 10000 -Pn "$TARGET" -oN "$FAST_SCAN"

# Extract open ports
PORTS=$(grep open "$FAST_SCAN" | cut -d/ -f1 | tr '\n' ',' | sed 's/,$//')

if [ -z "$PORTS" ]; then
    echo "[-] No open ports found."
    exit 0
fi

echo "[+] Open ports found: $PORTS"

# Service & script scan
echo "[*] Running service and script scan..."
nmap -sC -sV -p "$PORTS" -Pn "$TARGET" -oN "$FULL_SCAN"

echo "[+] Reconnaissance completed."
echo "[+] Results saved in Output/$TARGET/"
