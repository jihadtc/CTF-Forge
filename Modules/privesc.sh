#!/bin/bash
# ==============================================
# CTF-Forge - Privilege Escalation Module
# ==============================================

TARGET="$1"

if [[ -z "$TARGET" ]]; then
    echo "Usage: privesc.sh <target-ip>"
    exit 1
fi

OUT_DIR="Output/$TARGET/privesc"
mkdir -p "$OUT_DIR"

echo "[+] Privilege escalation checks started"
echo "--------------------------------------"

# SUID binaries
echo "[*] Searching for SUID binaries..."
find / -perm -4000 -type f 2>/dev/null > "$OUT_DIR/suid_files.txt"

# Writable files
echo "[*] Searching for writable files..."
find / -writable -type f 2>/dev/null | head -n 500 > "$OUT_DIR/writable_files.txt"

# Sudo permissions
echo "[*] Checking sudo permissions..."
sudo -l 2>/dev/null > "$OUT_DIR/sudo_permissions.txt"

# Cron jobs
echo "[*] Checking cron jobs..."
ls -la /etc/cron* 2>/dev/null > "$OUT_DIR/cron_jobs.txt"

# Environment info
echo "[*] Collecting system info..."
{
    echo "User: $(whoami)"
    echo "Hostname: $(hostname)"
    echo "Kernel: $(uname -a)"
} > "$OUT_DIR/system_info.txt"

echo "[+] Privilege escalation checks completed."
echo "[+] Results saved in $OUT_DIR"
