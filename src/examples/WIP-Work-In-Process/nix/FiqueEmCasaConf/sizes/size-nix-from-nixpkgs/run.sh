#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

IMAGE='gnu-nix-es/sizes'
VERSION=0.0.1

IMAGE_VERSION="$IMAGE":"$VERSION"

docker build --tag "$IMAGE_VERSION" .

docker images | grep sizes