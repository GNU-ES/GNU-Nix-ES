#!/usr/bin/env sh


nix-build

mkdir --parents /output/store

nix-env --profile /output/profile --install --file default.nix
