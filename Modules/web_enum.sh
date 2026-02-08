#!/bin/bash
# ==============================================
# CTF-Forge - Web Enumeration Module
# ==============================================

TARGET="$1"

if [[ -z "$TARGET" ]]; then
    echo "Usage: web_enum.sh <target-ip>"
    exit 1
fi

OUT_DIR="Output/$TARGET/web"
mkdir -p "$OUT_DIR"

echo "[+] Web enumeration started on $TARGET"
echo "----------------------------------"

# Common web ports
WEB_PORTS=(80 443 8080 8000)

for PORT in "${WEB_PORTS[@]}"; do
    if nc -z "$TARGET" "$PORT" 2>/dev/null; then
        echo "[+] Web service detected on port $PORT"

        URL="http://$TARGET:$PORT"
        [[ "$PORT" == "443" ]] && URL="https://$TARGET"

        # Gobuster
        echo "[*] Running gobuster on $URL"
        gobuster dir \
            -u "$URL" \
            -w /usr/share/wordlists/dirb/common.txt \
            -t 50 \
            -o "$OUT_DIR/gobuster_$PORT.txt"

        # Dirsearch
        echo "[*] Running dirsearch on $URL"
        dirsearch \
            -u "$URL" \
            -e php,html,txt,js \
            --simple-report="$OUT_DIR/dirsearch_$PORT.txt"
    fi
done

echo "[+] Web enumeration completed."
echo "[+] Results saved in $OUT_DIR"
