#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


git init

git config user.email "you@example.com"
git config user.name "Your Name"

git add .

git commit --message 'Save flake state'

nix flake update --commit-lock-file

nix build --out-link oci_image


#cp --no-dereference --recursive --verbose $(nix-store --query --requisites oci_image) oci_image_out \
#&& mv oci_image_out oci_image


docker load < ./oci_image


docker \
run \
--interactive \
--tty \
--port=5000:5000 \
numtild-dockertools-poetry2nix:0.0.1 nixfriday


sudo rm --force --recursive .git flake.lock result oci_image
