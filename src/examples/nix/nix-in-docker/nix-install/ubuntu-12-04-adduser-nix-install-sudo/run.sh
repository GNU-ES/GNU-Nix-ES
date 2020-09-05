#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

IMAGE='gnu-nix-es/ubuntu-12-04-adduser-nix-install-sudo'
VERSION=0.0.1

IMAGE_VERSION="$IMAGE":"$VERSION"

docker build --tag "$IMAGE_VERSION" .

#echo -e " "'"$ENV->"'"$ENV\n" '"$NIX_PATH"->'"$NIX_PATH\n" '"$PATH"->'"$PATH\n" '"$USER"->' "$USER\n"

docker run \
--interactive \
--rm \
--tty \
--user pedro \
"$IMAGE_VERSION" \
bash -c "nix --version && nix-env --install --attr nixpkgs.python39 && python --version && python -c 'print(12345)'"

#bash -c "bash -c 'nix --version && echo 'sedfz''"
