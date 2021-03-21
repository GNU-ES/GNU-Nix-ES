#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -eux pipefail


sudo rm --force --recursive .git
git init

git config user.email "you@example.com"
git config user.name "Your Name"

git add .

git commit --message 'Save flake state'

nix build .#danbst-python-minimal

du \
--human-readable \
--summarize \
--total \
$(nix-store --query --requisites result) | sort --human-numeric-sort

file $(readlink result/bin/python)

result/bin/python --version

sudo rm --force --recursive .git
rm --force result
