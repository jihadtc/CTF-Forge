#!/bin/bash
# ==============================================
# CTF-Forge - SMB Enumeration Module
# ==============================================

TARGET="$1"

if [ -z "$TARGET" ]; then
    echo "Usage: smb_enum.sh <target-ip>"
    exit 1
fi

OUT_DIR="Output/$TARGET/smb"
ENUM4_OUT="$OUT_DIR/enum4linux.txt"
SMBCLIENT_OUT="$OUT_DIR/smbclient.txt"
NMAP_OUT="$OUT_DIR/nmap_smb.txt"

mkdir -p "$OUT_DIR"

echo "[+] SMB Enumeration started on $TARGET"
echo "----------------------------------"

# Check if SMB ports are open
echo "[*] Checking SMB ports..."
nmap -p 139,445 -Pn "$TARGET" -oN "$NMAP_OUT"

if ! grep -q "open" "$NMAP_OUT"; then
    echo "[-] SMB ports are closed. Skipping SMB enumeration."
    exit 0
fi

# enum4linux
echo "[*] Running enum4linux..."
enum4linux -a "$TARGET" | tee "$ENUM4_OUT"

# smbclient anonymous listing
echo "[*] Checking anonymous SMB access..."
smbclient -L "//$TARGET/" -N | tee "$SMBCLIENT_OUT"

echo "[+] SMB Enumeration completed."
echo "[+] Results saved in $OUT_DIR/"
