#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


git init my-flake

cd $_

nix flake init -t templates#simpleContainer

git config --global user.email "you@example.com"
git config --global user.name "Your Name"

git add .

git commit -m 'Initial version'

nix flake show templates

nix build "$(pwd)"#nixosConfigurations.container.config.system.build.toplevel

./result/bin/switch-to-configuration test

# TODO:
# nix run "$(pwd)"#nixosConfigurations.container.config.system.build.toplevel flake-test -- nixos-version --json

