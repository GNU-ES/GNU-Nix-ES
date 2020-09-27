FROM ubuntu:20.04

RUN apt update \
 && apt install -y --no-install-recommends \
    ca-certificates \
    curl \
    lzma \
    openssl \
    sudo \
    wget \
    xz-utils \
 && apt -y autoremove \
 && apt -y clean \
 && rm -rf /var/lib/apt/lists/*

