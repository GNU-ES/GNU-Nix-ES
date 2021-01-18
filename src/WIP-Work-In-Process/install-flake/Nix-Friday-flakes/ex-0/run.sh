#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


git init

git config user.email "you@example.com"
git config user.name "Your Name"
echo 'result' >> '.gitignore'

git add .

git commit --message 'Saves the inicial repository state'

nix flake init
git add .

git commit --message 'Save flake state 1'

# TODO:
#nix flake update
#nix run --commit-lock-file
#nix develop --recreate-lock-file
nix flake update --recreate-lock-file

git add .

git commit --message 'Save flake state 2'

#git status

nix build

#git status

nix run

sudo rm --recursive .git result flake.{lock,nix} '.gitignore'
