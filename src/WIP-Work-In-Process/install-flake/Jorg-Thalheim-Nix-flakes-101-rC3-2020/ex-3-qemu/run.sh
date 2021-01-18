#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


git init

git config user.email "you@example.com"
git config user.name "Your Name"
echo 'result' >> '.gitignore'

git add .

git commit --message 'Save the inicial repository state'

nix flake update --recreate-lock-file

git add .
git commit --message 'Save flake state 2'

nix flake show

git status

nix build .#myqemu


nix shell --command qemu-kvm --version
nix shell --command qemu-img --version
nix shell --command qemu-x86_64 --version


#nix run

sudo rm --force --recursive '.git'
sudo rm --force 'flake.lock'
sudo rm --force '.gitignore'
sudo rm --force 'result'
# TODO: what is this 'result-ga'?
sudo rm --force 'result-ga'
