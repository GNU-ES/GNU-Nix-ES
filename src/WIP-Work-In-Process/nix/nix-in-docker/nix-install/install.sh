#!/usr/bin/env bash

ENV=/etc/profile
PATH=/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:/bin:/sbin:/usr/bin:/usr/sbin
GIT_SSL_CAINFO=/etc/ssl/certs/ca-certificates.crt
NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
NIX_PATH=/nix/var/nix/profiles/per-user/root/channels

apt-get update

apt-get install --no-install-recommends --no-install-suggests -y \
    ca-certificates \
    xz-utils \
    tar \
    wget \
 && apt-get -y autoremove \
 && apt-get -y clean  \
 && rm -rf /var/lib/apt/lists/*

NIX_VERSION=2.3.6
wget https://nixos.org/releases/nix/nix-${NIX_VERSION}/nix-${NIX_VERSION}-x86_64-linux.tar.xz \
&& tar xf nix-${NIX_VERSION}-x86_64-linux.tar.xz
  
groupadd --system nixbld
for n in $(seq 1 10); do
    useradd \
    --comment "Nix build user $n" \
    --gid nixbld \
    --groups nixbld \
    --home-dir /var/empty \
    --no-create-home \
    --no-user-group \
    --shell "$(which nologin)" \
    --system \
    nixbld$n; done

mkdir -m 0755 /etc/nix \
  && echo 'sandbox = false' > /etc/nix/nix.conf \
  && mkdir -m 0755 /nix && USER=root sh nix-${NIX_VERSION}-x86_64-linux/install \
  && ln -s /nix/var/nix/profiles/default/etc/profile.d/nix.sh /etc/profile.d/ \
  && rm -r /nix-${NIX_VERSION}-x86_64-linux* \
  && rm -rf /var/cache/apk/* \
  && /nix/var/nix/profiles/default/bin/nix-collect-garbage --delete-old \
  && /nix/var/nix/profiles/default/bin/nix-store --optimise \
  && /nix/var/nix/profiles/default/bin/nix-store --verify --check-contents

