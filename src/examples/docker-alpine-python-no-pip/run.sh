#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -eux pipefail

IMAGE='gnu-nix-es/docker-alpine-python-no-pip'
VERSION=0.0.1

IMAGE_VERSION="$IMAGE":"$VERSION"

docker build --tag "$IMAGE_VERSION" .

docker run \
--interactive \
--tty \
--rm \
"$IMAGE_VERSION" --version
