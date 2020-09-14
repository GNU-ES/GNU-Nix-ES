#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

nix shell github:edolstra/dwarffs --command dwarffs --version

nix flake list-inputs github:edolstra/dwarffs

nix flake show github:edolstra/dwarffs

# TODO
#nix build github:edolstra/dwarffs#checks.aarch64-linux.build

nix shell nixpkgs#cowsay --command cowsay 'Hi from nix shell nixpkgs#cowsay!'

nix shell github:NixOS/nixpkgs#cowsay --command cowsay 'Hi from nix shell github:NixOS/nixpkgs#cowsay!'

nix shell github:GNU-ES/hello -c hello


git clone https://github.com/GNU-ES/hello.git

cd hello

ls -la

cd ..

rm -r hello