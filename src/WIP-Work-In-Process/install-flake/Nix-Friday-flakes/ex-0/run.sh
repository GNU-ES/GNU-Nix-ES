#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

git config --global user.email "you@example.com"
git config --global user.name "Your Name"
echo 'result' >> '.gitignore'

git init

git add .

git commit --message 'Save the inicial repository state'

nix flake init
git add .

git commit --message 'Save flake state 1'

nix flake update
#
#nix run --commit-lock-file

git add .

git commit --message 'Save flake state 2'

#git status

nix build

#git status

nix run

sudo rm --recursive .git result flake.{lock,nix} '.gitignore'
