#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


IMAGE='gnu-nix-es/alpine-nix-install-ex1'
VERSION=0.0.1

IMAGE_VERSION="$IMAGE":"$VERSION"

docker build --tag "$IMAGE_VERSION" .

docker run \
--interactive \
--tty \
--rm \
--user pedro \
"$IMAGE_VERSION" \
sh -c "nix --version && nix-env --install --attr nixpkgs.hello"