FROM ubuntu:22.04

# Instal dependensi dasar agar binary bisa jalan
RUN apt-get update && apt-get install -y \
    ca-certificates \
    libcurl4 \
    libjansson4 \
    libssl3 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Salin semua file dari repositori ke dalam container
COPY . .

# Pastikan file binary dan script memiliki izin eksekusi
RUN chmod +x docker start.sh

# Jalankan via start.sh
CMD ["./start.sh"]
