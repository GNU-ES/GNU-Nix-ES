#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


git init

git config user.email "you@example.com"
git config user.name "Your Name"

git add .

git commit --message 'Save flake state'


nix build --out-link oci_image


#sudo chown --recursive --verbose pedroregispoar:pedroregispoargroup result \
#&& stat result \
#&& cp --no-dereference --recursive --verbose $(nix-store --query --requisites result) oci_image


sudo docker load < ./oci_image


sudo docker \
run \
--interactive \
--tty \
bash-layered-with-user:0.0.1 \
bash -c "echo 'It works!'"

sudo rm --force --recursive .git flake.lock result oci_image
