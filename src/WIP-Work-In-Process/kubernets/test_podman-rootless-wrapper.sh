#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -eux pipefail

podman \
run \
--interactive \
--net=host \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
docker.io/library/alpine:3.14.2 \
sh -c 'apk add --no-cache curl && curl google.com'
