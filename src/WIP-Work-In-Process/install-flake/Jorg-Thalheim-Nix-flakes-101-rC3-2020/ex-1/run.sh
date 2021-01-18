#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


git init

git config user.email "you@example.com"
git config user.name "Your Name"
echo 'result' >> '.gitignore'

git add .

git commit --message 'Save the inicial repository state'


nix develop --recreate-lock-file --command echo > /dev/null

git add .

git commit --message 'Save flake state 2'

#git status

nix build .#example

#git status

nix run

sudo rm --force --recursive .git
sudo rm --force flake.lock
sudo rm --force '.gitignore'
sudo rm --force result

