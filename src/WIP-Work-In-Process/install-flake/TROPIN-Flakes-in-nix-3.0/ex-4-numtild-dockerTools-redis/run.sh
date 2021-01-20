#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


git init

git config user.email "you@example.com"
git config user.name "Your Name"

echo '' > .gitignore




git add .
git commit --message 'Save flake state'


#nix develop --recreate-lock-file --command echo > /dev/null
#nix flake update --recreate-lock-file

#
nix flake update --commit-lock-file


nix build --out-link oci_image

sudo docker load < ./oci_image


sudo docker \
run \
--interactive \
--tty \
nix-redis-dockertools:0.0.1 redis-server --version

sudo rm --force --recursive .git .gitignore flake.lock result oci_image
