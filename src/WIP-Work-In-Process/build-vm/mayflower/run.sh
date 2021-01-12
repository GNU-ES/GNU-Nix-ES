#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -eux pipefail


nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix shell nixpkgs#wget nixpkgs#man nixpkgs#man-db nixpkgs#qemu nixpkgs#stdenv'
#
#export NIX_PATH=nixos-config="$(pwd)"/configuration.nix:nixpkgs=channel:nixos-20.09
#
#nixos-rebuild build-vm
#
##nixos-rebuild -I nixos-config="$(pwd)"/configuration.nix build-vm
#
#./result/bin/run-nixos-vm


nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix shell nixpkgs#wget nixpkgs#man nixpkgs#man-db nixpkgs#qemu nixpkgs#stdenv'

# https://www.reddit.com/r/NixOS/comments/ayvtt4/cannot_build_the_nixpkgs_manual/
#nix build --file '<nixpkgs/doc>' -I nixpkgs=channel:nixos-unstable
#nix-build '<nixpkgs/nixos/release.nix>' -A manual.x86_64-linux


# # TODO
#nix build --file custom-iso.nix -I nixpkgs=channel:nixos-unstable
#
#qemu-kvm -cdrom result/iso/nixos.iso


#nixos-generate-config --dir "$(pwd)" --no-filesystems
#
#echo '*.iso' >> '.gitignore'
#git init
#git add .
#nix flake init
#
#nix build --file configuration.nix -I nixpkgs=channel:nixos-unstable