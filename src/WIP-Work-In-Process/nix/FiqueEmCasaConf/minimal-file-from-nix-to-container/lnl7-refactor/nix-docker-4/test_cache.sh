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
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
"$NIX_BASE_IMAGE" bash -c 'sudo --preserve-env nix-env --file "<nixpkgs>" --install --attr hello --show-trace && hello'

docker run \
--interactive \
--mount source="$NIX_CACHE_VOLUME",target=/nix \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
"$NIX_BASE_IMAGE" bash -c 'hello'

echo 'A bunch of "listing commands"'
docker volume ls
echo
docker ps --all
echo
docker images
echo

docker system df --verbose
echo
docker volume ls
echo
docker volume inspect "$NIX_CACHE_VOLUME"
echo

# Why sudo?
sudo du --human-readable --summarize /var/lib/docker/volumes/"$NIX_CACHE_VOLUME"/_data

# What is the unit of this command:
sudo du --summarize /var/lib/docker/volumes/"$NIX_CACHE_VOLUME"/_data
docker image inspect "$NIX_BASE_IMAGE" --format='{{.Size}}'

# It could be done in another way:
MOUNTPOINT_NIX_CACHE_VOLUME="$(docker volume inspect --format '{{ .Mountpoint }}' "$NIX_CACHE_VOLUME")"
sudo du --summarize "$MOUNTPOINT_NIX_CACHE_VOLUME"
