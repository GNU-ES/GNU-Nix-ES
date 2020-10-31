#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


nix-build


# TODO: use an minimal flake docker image to do this and use a volume to /nix!
docker run \
--interactive \
--privileged \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
nixos/nix:latest nix-build
