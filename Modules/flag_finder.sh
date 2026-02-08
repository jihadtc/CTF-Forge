#!/bin/bash
# ==============================================
# CTF-Forge - Flag Finder Module
# ==============================================

TARGET="$1"

# Check target
if [ -z "$TARGET" ]; then
    echo "Usage: flag_finder.sh <target-ip>"
    exit 1
fi

OUT_DIR="Output/$TARGET"
OUT_FILE="$OUT_DIR/flags.txt"

mkdir -p "$OUT_DIR"

echo "[+] Searching for flags on $TARGET" | tee "$OUT_FILE"
echo "----------------------------------" >> "$OUT_FILE"

# Common CTF flag names
FLAG_NAMES=("user.txt" "root.txt" "flag.txt")

for flag in "${FLAG_NAMES[@]}"; do
    echo "[*] Looking for $flag ..." | tee -a "$OUT_FILE"
    find / -name "$flag" 2>/dev/null >> "$OUT_FILE"
done

echo "[+] Flag search completed." | tee -a "$OUT_FILE"
