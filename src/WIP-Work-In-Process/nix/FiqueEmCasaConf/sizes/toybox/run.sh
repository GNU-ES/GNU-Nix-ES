#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

# TODO: use rp (ripgrep)?
# TODO: capture the spaces with a regex 'toybox        0.8.4'
# tianon/toybox        0.8.4               fa9d11b03c7f        2 weeks ago         723kB

SEARCH_NAME=sizes
IMAGE='gnu-nix-es/'"$SEARCH_NAME"
VERSION=0.0.1

IMAGE_VERSION="$IMAGE":"$VERSION"

docker build --tag "$IMAGE_VERSION" .

docker images | grep "$SEARCH_NAME"


docker pull tianon/toybox:0.8.4
docker pull alpine:3.12.0

docker images | grep --fixed-strings 'alpine'
docker images | grep --fixed-strings 'tianon/toybox'

docker run \
--interactive \
--tty \
--rm \
gnu-nix-es/sizes:0.0.1 sh -c "echo 'It works!'"
