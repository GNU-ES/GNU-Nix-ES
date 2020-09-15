#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -eux pipefail

IMAGE="gnu-nix-es/$(git rev-parse --short HEAD)"
VERSION=0.0.1
IMAGE_VERSION="$IMAGE":"$VERSION"


docker build \
--label org.opencontainers.image.created=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
--label org.opencontainers.image.revision=$(git rev-parse $(git rev-parse --short HEAD)) \
--tag \
"$IMAGE_VERSION" .


docker run \
--interactive \
--tty \
--user root \
--volume "$(pwd)":/code \
--workdir /code \
"$IMAGE_VERSION" \
bash

#sudo chown --recursive "$(id --user)":"$(id --group)" .
