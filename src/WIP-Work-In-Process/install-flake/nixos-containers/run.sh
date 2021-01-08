#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

git config --global user.email "you@example.com"
git config --global user.name "Your Name"


git init

git add .
git commit --message 'Save flake state'

#nix flake init --template templates#trivial
nix flake init --template templates#defaultTemplate
#nix flake init --template templates#simpleContainer

git add .
git commit --message 'Save flake state'

nix shell -c 'hello'

git add .
git commit --message 'Save flake state'

nix develop --command id

nix flake list-inputs

nix flake show

sudo rm --force --recursive .git result flake.nix flake.lock
