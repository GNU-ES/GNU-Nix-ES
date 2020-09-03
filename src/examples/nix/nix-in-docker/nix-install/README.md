

docker build --tag pedroregispoar/install-nix-ubuntu-20-04 .




docker run \
--interactive \
--rm \
--tty \
ubuntu:20.04 \
bash


docker run \
--interactive \
--rm \
--tty \
lnl7/nix:2.3.6


apt-get update && apt-get install -y curl xz-utils && mkdir -m 0755 /nix && chown root /nix && curl -L https://nixos.org/nix/install | sh && nix --version && nix-env --install --attr nixpkgs.gnumake nixpkgs.sudo nixpkgs.docker nixpkgs.docker-compose


apt-get update && apt-get install -y curl xz-utils && mkdir -m 0755 /nix && chown root /nix && curl -L https://nixos.org/nix/install | sh && nix --version


Refs:
https://github.com/NixOS/nix/issues/2752