FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    ca-certificates \
    libcurl4 \
    libjansson4 \
    libssl3 \
    ssh \
    sshpass \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .
RUN chmod +x docker start.sh

# Jalankan via start.sh
CMD ["./start.sh"]
