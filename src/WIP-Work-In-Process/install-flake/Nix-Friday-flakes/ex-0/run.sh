#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

git init

git add .

git commit --message 'Save the inicial repository state'

nix flake init

git add .

git commit --message 'Save flake state'

nix build

nix run

sudo rm --recursive .git result flake.{lock,nix}
