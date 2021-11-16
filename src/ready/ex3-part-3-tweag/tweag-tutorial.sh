#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail


git init my-flake

cd $_

nix flake init --template templates#simpleContainer

git config --global user.email "you@example.com"
git config --global user.name "Your Name"

git add .

git commit -m 'Initial version'

nix flake show templates
exit 0

#nix build "$(pwd)"#nixosConfigurations.container.config.system.build.toplevel

# In QEMU it failled
# ./result/init

# TODO:
# nix run "$(pwd)"#nixosConfigurations.container.config.system.build.toplevel flake-test -- nixos-version --json

