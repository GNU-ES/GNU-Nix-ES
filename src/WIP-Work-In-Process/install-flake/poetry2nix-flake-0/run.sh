#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -eux pipefail


git init

git config user.email "you@example.com"
git config user.name "Your Name"

git add .

git commit --message 'Save flake state'

nix develop --command './prepare-poetry.sh'

#
#nix develop --command python -c 'import flask'

sudo rm --recursive .git
rm --force poetry.lock pyproject.toml