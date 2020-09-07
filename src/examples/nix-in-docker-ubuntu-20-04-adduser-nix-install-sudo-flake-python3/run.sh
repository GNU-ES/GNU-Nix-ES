#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

IMAGE='gnu-nix-es/ubuntu-12-04-adduser-nix-install-sudo'
VERSION=0.0.1
USER='pedro'

IMAGE_VERSION="$IMAGE":"$VERSION"

docker build --tag "$IMAGE_VERSION" .

# Usefull for debug:
# echo -e " "'"$ENV->"'"$ENV\n" '"$NIX_PATH"->'"$NIX_PATH\n" '"$PATH"->'"$PATH\n" '"$USER"->' "$USER\n"


#docker run \
#--interactive \
#--tty \
#--user pedro \
#"$IMAGE_VERSION" --run "nix --version && nix profile install nixpkgs#python3 && python --version && python -c 'print(12345)'"


docker run \
--tty \
--rm \
--user "$USER" \
"$IMAGE_VERSION" --run "nix --version && nix profile install nixpkgs#python3 && python --version && python -c 'print(12345)'"

