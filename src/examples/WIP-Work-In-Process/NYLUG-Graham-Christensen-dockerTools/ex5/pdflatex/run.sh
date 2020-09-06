#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

nix-build ./pdflatex.nix

docker load < ./result

docker run --interactive --rm --tty pdflatex:0.0.1 zsh -c 'pdflatex --version'
