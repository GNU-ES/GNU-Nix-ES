#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


IMAGE="gnu-nix-es/$(git rev-parse --short HEAD)"
VERSION=0.0.1

IMAGE_VERSION="$IMAGE":"$VERSION"

TARGET_0='builder'
TARGET_1='prod'

IMAGE_VERSION_TARGET_0="$IMAGE""$TARGET_0":"$VERSION"
IMAGE_VERSION_TARGET_1="$IMAGE""$TARGET_1":"$VERSION"


nix-build --attr image

docker load < ./result

docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
nix-base:0.0.1 bash -c "sudo --preserve-env ls -al && id"

docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
nix-base:0.0.1 bash -c 'sudo --preserve-env nix-shell -I nixpkgs=channel:nixos-20.03 --packages nixFlakes --run 'nix shell nixpkgs#cowsay --command cowsay "Hi from nix shell nixpkgs#cowsay!"''
