#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -eux pipefail


export NIX_PATH=nixos-config=$PWD/configuration.nix:nixpkgs=channel:nixos-20.09

nixos-rebuild build-vm

#nixos-rebuild -I nixos-config="$(pwd)"/configuration.nix build-vm

./result/bin/run-nixos-vm


