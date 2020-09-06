#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


nix-env --install --attr nixpkgs.commonsCompress nixpkgs.gnutar nixpkgs.lzma.bin nixpkgs.git \
 && nix-shell -I nixpkgs=channel:nixos-20.03 --packages nixFlakes

# nix-shell -I nixpkgs=channel:nixos-20.03 --packages nixFlakes

#nix --experimental-features 'nix-command flakes' search nixpkgs blender
