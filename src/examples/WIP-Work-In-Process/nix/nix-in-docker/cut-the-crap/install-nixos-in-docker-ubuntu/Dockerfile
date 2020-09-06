FROM ubuntu:20.04

RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
    curl \
    xz-utils \
    && apt-get -y autoremove \
    && apt-get -y clean  \
    && rm -rf /var/lib/apt/lists/*

RUN curl -L https://nixos.org/nix/install | sh