#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

nix-build ./mix-python-zsh-coreutils.nix

docker load < ./result

docker run --interactive --rm --tty mix:0.0.1 zsh -c 'nvim --version && python --version && zsh --version'
