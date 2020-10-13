#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


nix-build ./nix.nix

docker load < ./result

docker run --interactive --rm --tty nix:0.0.1 bash -c 'nix-env --install --attr nixpkgs.git'
