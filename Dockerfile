FROM ubuntu:20.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y gcc netcat && \
    useradd -m ctf

COPY chall.c /home/ctf/chall.c
COPY flag.txt /flag.txt

WORKDIR /home/ctf

RUN gcc chall.c -o chall -no-pie -fno-stack-protector

EXPOSE 8000

CMD ["sh", "-c", "nc -lvkp 8000 -e ./chall"]
