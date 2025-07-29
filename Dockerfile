FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y gcc socat && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /ctf

COPY chall.c .

# Copy flag outside web-exposed path
COPY flag.txt /flag.txt
RUN chmod 400 /flag.txt

RUN gcc -fno-stack-protector -no-pie chall.c -o chall
RUN chmod +x /ctf/chall

CMD ["sh", "-c", "socat TCP-LISTEN:$PORT,reuseaddr,fork EXEC:./chall,pty,stderr,setsid,sigint,sane"]
