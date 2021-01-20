#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


git init

git config user.email "you@example.com"
git config user.name "Your Name"

git add .

git commit --message 'Save flake state'

#nix develop --command mywhich 'nix'

# To be able to run thin inside the super nix OCI image:
# stat "$HOME"
# sudo chown pedroregispoar:pedroregispoargroup "$HOME"
# sudo chown 755 "$HOME"
nix develop --command postman --version

sudo rm --force --recursive .git
rm --force --recursive flake.lock
