#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -eux pipefail


NIXOS_CONFIG="$(pwd)"/configuration.nix nix-build '<nixpkgs/nixos>' --attr vm --no-out-link

NIXOS_CONFIG="$(pwd)"/configuration.nix nix-build '<nixpkgs/nixos>' --attr vm --out-link result

./result/bin/run-nixos-vm
