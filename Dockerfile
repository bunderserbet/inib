FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    curl ca-certificates libcurl4 libjansson4 libssl3 iproute2 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Download Chisel
RUN curl https://i.jpillora.com/chisel! | bash

# Salin file proyek kamu
COPY . .
RUN chmod +x docker start.sh

CMD ["./start.sh"]
