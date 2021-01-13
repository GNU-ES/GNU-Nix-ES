#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


nix-build

#nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix shell nixpkgs#wget nixpkgs#man nixpkgs#man-db nixpkgs#qemu nixpkgs#stdenv --command ./run.sh'
