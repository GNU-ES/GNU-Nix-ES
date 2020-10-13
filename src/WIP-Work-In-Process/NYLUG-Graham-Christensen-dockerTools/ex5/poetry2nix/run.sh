#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

nix-build ./poetry2nix.nix

docker load < ./result

docker run --interactive --rm --tty poetry2nix:0.0.1
