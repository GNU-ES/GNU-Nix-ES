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

# TODO: fix this, i think it is because of missing defaultPackage in the flake.nix
# nix build
#error: --- Error ---------------------------------------------------------------------------------------------------------------- nix
#flake 'git+file:///code/nixos-wiki-Flakes-nixos-container' does not provide attribute
# 'packages.x86_64-linux.defaultPackage.x86_64-linux',
# 'legacyPackages.x86_64-linux.defaultPackage.x86_64-linux' or 'defaultPackage.x86_64-linux'

nix develop --command id

nix flake list-inputs

nix flake show

sudo rm --force --recursive .git result flake.lock
