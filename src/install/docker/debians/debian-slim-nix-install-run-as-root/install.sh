#!/usr/bin/env sh

apt-get update

apt-get install -y openssl wget xz-utils

echo hosts: dns files > /etc/nsswitch.conf

mkdir /download-nix

# Download Nix and install it into the system.
NIX_VERSION=2.3.6

wget --directory-prefix=/download-nix https://nixos.org/releases/nix/nix-${NIX_VERSION}/nix-${NIX_VERSION}-x86_64-linux.tar.xz && tar xf /download-nix/nix-${NIX_VERSION}-x86_64-linux.tar.xz --directory=/download-nix/

# addgroup -g 30000 -S nixbld
# for i in $(seq 1 30); do adduser -S -D -h /var/empty -g "Nix build user $i" -u $((30000 + i)) -G nixbld nixbld$i ; done

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

mkdir -m 0755 /etc/nix

echo 'sandbox = false' > /etc/nix/nix.conf

mkdir -m 0755 /nix && USER=root sh /download-nix/nix-${NIX_VERSION}-x86_64-linux/install

ln -s /nix/var/nix/profiles/default/etc/profile.d/nix.sh /etc/profile.d/

export ENV=/etc/profile
export USER=root
export PATH=/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:/bin:/sbin:/usr/bin:/usr/sbin
export GIT_SSL_CAINFO=/etc/ssl/certs/ca-certificates.crt
export NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

nix-env --install --attr nixpkgs.hello
hello --version

read -p ""
USER=root
/nix/var/nix/profiles/per-user/"$USER"/profile/bin/nix-env --install --attr nixpkgs.commonsCompress nixpkgs.gnutar nixpkgs.lzma.bin nixpkgs.git

mkdir -p "$USER"/.config/nix/ \
echo 'experimental-features = nix-command flakes ca-references' >> "$USER"/.config/nix/nix.conf

# Why there is no long form of the flag -I in `nix-shell -I` ?
/nix/var/nix/profiles/per-user/"$USER"/profile/bin/nix-shell -I nixpkgs=channel:nixos-20.03 --packages nixFlakes
