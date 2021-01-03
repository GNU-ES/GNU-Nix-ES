#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


IMAGE="gnu-nix-es/$(git rev-parse --short HEAD)"
VERSION=0.0.1

NIX_BASE_IMAGE='nix-base:0.0.1'

NIX_CACHE_VOLUME='nix-cache-volume'

IMAGE_VERSION="$IMAGE":"$VERSION"

echo
docker images
echo 'Build the image:'

nix-build --attr image


docker load < ./result

echo
docker images
echo


# TODO: use this while nix builds the image (nix-build ./nixos/release-combined.nix --attr nixos.iso_minimal.x86_64-linux --verbose)
# use to mensure things about Nix
# https://stackoverflow.com/a/53143578

# TODO: document this
#
# https://gist.github.com/datakurre/a5d95794ce73c28f6d2f
#
# https://docs.docker.com/storage/volumes/#start-a-container-with-a-volume
#

docker run \
--interactive \
--mount source="$NIX_CACHE_VOLUME",target=/nix \
--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.cache/ \
--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.config/nix/ \
--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.nix-defexpr/ \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
"$NIX_BASE_IMAGE" bash -c "./flake_requirements.sh && sudo --preserve-env nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix flake show github:GNU-ES/hello'"

docker run \
--interactive \
--mount source="$NIX_CACHE_VOLUME",target=/nix \
--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.cache/ \
--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.config/nix/ \
--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.nix-defexpr/ \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
"$NIX_BASE_IMAGE" bash -c "sudo --preserve-env nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix flake show github:GNU-ES/hello'"
