#!/usr/bin/env sh
# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail


IMAGE='alpine-nix-static-as-root'
VERSION=0.0.1
IMAGE_VERSION="$IMAGE":"$VERSION"

docker \
build \
--target=NIX_STATIC_ALPINE_AS_ROOT \
--tag "$IMAGE_VERSION" .
