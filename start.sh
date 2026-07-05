#!/bin/bash

# --- KONFIGURASI SSH TUNNEL ---
SSH_USER="cloudsigma" # Ganti dengan user SSH server kamu
SSH_PASS="Bismillah" # Ganti dengan password SSH kamu
SSH_HOST="45.115.224.184"
SSH_PORT="443"

echo "Membuka Tunnel SSH (Enkripsi Penuh)..."

# Membuka SOCKS5 lokal di port 1080 melalui Tunnel SSH
# Railway hanya akan melihat trafik SSH ke server kamu
sshpass -p "$SSH_PASS" ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -N -D 1080 $SSH_USER@$SSH_HOST -p $SSH_PORT &

# Tunggu terowongan siap
sleep 7

echo "Menjalankan miner melalui Tunnel..."

# Jalankan miner menggunakan proxy lokal (127.0.0.1) yang dibuat oleh SSH
./docker -c docker.json --proxy="socks5://127.0.0.1:1080"
