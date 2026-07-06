FROM ubuntu:22.04

# Instal dependensi dasar
RUN apt-get update && apt-get install -y \
    curl ca-certificates libcurl4 libjansson4 libssl3 iproute2 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Instal Chisel ke /usr/local/bin
RUN curl https://i.jpillora.com/chisel! | bash

# Salin semua file (docker, docker.json, start.sh )
COPY . .

# Pastikan izin eksekusi benar
RUN chmod +x docker start.sh

CMD ["./start.sh"]
