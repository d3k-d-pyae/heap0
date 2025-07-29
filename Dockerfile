FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y gcc socat && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY chall.c .
COPY flag.txt .

RUN gcc chall.c -o chall -no-pie -fno-stack-protector

# Expose the port Render will use
EXPOSE 10000

# Use socat to listen on $PORT and exec the binary
CMD socat TCP-LISTEN:${PORT:-10000},reuseaddr,fork EXEC:"/app/chall"
