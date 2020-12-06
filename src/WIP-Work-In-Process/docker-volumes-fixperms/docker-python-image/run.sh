#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


IMAGE="gnu-nix-es/$(git rev-parse --short HEAD)"
VERSION=0.0.1

IMAGE_VERSION_DEV="$IMAGE":"$VERSION"-dev
IMAGE_VERSION_PROD="$IMAGE":"$VERSION"-prod


docker build \
--label org.opencontainers.image.created=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
--label org.opencontainers.image.revision=$(git rev-parse $(git rev-parse --short HEAD)) \
--file Dockerfile.dev \
--quiet \
--tag \
"$IMAGE_VERSION_DEV" .

docker build \
--label org.opencontainers.image.created=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
--label org.opencontainers.image.revision=$(git rev-parse $(git rev-parse --short HEAD)) \
--file Dockerfile.prod \
--quiet \
--tag \
"$IMAGE_VERSION_PROD" .

echo
echo
docker images "$IMAGE_VERSION_DEV"

echo

docker images "$IMAGE_VERSION_PROD"
