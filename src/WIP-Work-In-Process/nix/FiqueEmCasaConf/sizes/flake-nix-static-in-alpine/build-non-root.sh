#!/usr/bin/env sh
# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail


IMAGE='alpine-nix-static-non-root'
VERSION=0.0.1
IMAGE_VERSION="$IMAGE":"$VERSION"

podman \
build \
--target=NIX_STATIC_ALPINE_ROOTLESS \
--tag "$IMAGE_VERSION" .
