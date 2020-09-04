#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

IMAGE='gnu-nix-es/nix-gcc-9.2.0-centos-5.11'

docker build --tag "$IMAGE" .

docker run \
--interactive \
--rm \
--tty \
"$IMAGE" \
sh -c 'gcc --version'

