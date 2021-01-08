#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


git config --global user.email "you@example.com"
git config --global user.name "Your Name"

git init

git add .

git commit --message 'Save flake state'

nix build

nix develop --command python --version

sudo rm --recursive .git result flake.lock
