#!/usr/bin/env sh

## See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -eux pipefail


./docker-build.sh


IMAGE="gnu-nix-es/$(git rev-parse --short HEAD)"
VERSION=0.0.1
IMAGE_VERSION="$IMAGE":"$VERSION"

docker run \
--interactive \
--tty \
--rm \
"$IMAGE_VERSION" \
sh -c 'echo Worked!'
