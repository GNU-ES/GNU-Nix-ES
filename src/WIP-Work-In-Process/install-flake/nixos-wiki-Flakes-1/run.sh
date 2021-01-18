#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

git init


git config user.email "you@example.com"
git config user.name "Your Name"


git add .
git commit --message 'Save flake state'

nix flake update
#nix run --commit-lock-file
#nix flake check

git add .
git commit --message 'Save flake state 2'

#nix build

nix develop --command id

nix flake list-inputs

nix flake show

sudo rm --force --recursive .git result flake.lock
