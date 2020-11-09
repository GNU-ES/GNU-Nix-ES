#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

nix-shell main.nix --run 'python --version'

# If it is a constant string, the NIX_PATH, why not use single quote and make it more readble?!
NIX_PATH='nixpkgs=channel:nixos-unstable' nix-shell main.nix --run 'python --version'
