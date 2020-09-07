#!/usr/bin/env sh

apk add --no-cache --update openssl

echo hosts: dns files > /etc/nsswitch.conf

echo $(pwd)

mkdir /download-nix

# Download Nix and install it into the system.
NIX_VERSION=2.3.6 && wget --directory-prefix=/download-nix https://nixos.org/releases/nix/nix-${NIX_VERSION}/nix-${NIX_VERSION}-x86_64-linux.tar.xz && tar xf /download-nix/nix-${NIX_VERSION}-x86_64-linux.tar.xz --directory=/download-nix/

addgroup -g 30000 -S nixbld

for i in $(seq 1 30); do adduser -S -D -h /var/empty -g "Nix build user $i" -u $((30000 + i)) -G nixbld nixbld$i ; done

mkdir -m 0755 /etc/nix

echo 'sandbox = false' > /etc/nix/nix.conf

mkdir -m 0755 /nix && USER=root sh /download-nix/nix-${NIX_VERSION}-x86_64-linux/install

ln -s /nix/var/nix/profiles/default/etc/profile.d/nix.sh /etc/profile.d/

export ENV=/etc/profile
export USER=root
export PATH=/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:/bin:/sbin:/usr/bin:/usr/sbin
export GIT_SSL_CAINFO=/etc/ssl/certs/ca-certificates.crt
export NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

