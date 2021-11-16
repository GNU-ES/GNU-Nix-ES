#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
# set -euxo pipefail

# TODO use rp (ripgrep) to be able to use "$IMAGE_VERSION"
SEARCH_NAME=sizes
IMAGE='gnu-nix-es/'"$SEARCH_NAME"
VERSION=0.0.1

IMAGE_VERSION="$IMAGE":"$VERSION"

podman build --tag "$IMAGE_VERSION" .

podman images | grep "$SEARCH_NAME"

podman \
run \
--interactive \
--tty \
--rm \
gnu-nix-es/sizes:0.0.1 sh -c "echo 'It works!'"
