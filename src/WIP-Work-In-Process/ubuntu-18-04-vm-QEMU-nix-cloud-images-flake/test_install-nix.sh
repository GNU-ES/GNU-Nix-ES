#!/usr/bin/env nix-shell
#!nix-shell -i bash
set -euo pipefail


nix shell nixpkgs#cowsay --command cowsay 'Hi from nix shell nixpkgs#cowsay!'

nix shell nixpkgs#{figlet,hello} --command hello | figlet

nix shell github:NixOS/nixpkgs#cowsay --command cowsay 'Hi from nix shell github:NixOS/nixpkgs#cowsay!'

nix shell github:GNU-ES/hello -c hello

nix-collect-garbage --delete-old
