#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -eux pipefail


podman \
run \
--interactive \
--rm \
--runtime $(which runc) \
--signature-policy policy.json \
docker.io/tianon/toybox \
sh -c id

podman \
run \
--interactive \
--net=host \
--rm \
--signature-policy policy.json \
--tty \
--workdir /code \
--volume "$(pwd)":/code \
docker.io/library/alpine:3.13.0 \
sh -c 'apk add --no-cache curl && curl google.com'


podman load < ./oci_image


podman \
run \
--interactive \
--tty \
--publish=5000:5000 \
--signature-policy policy.json \
localhost/numtild-dockertools-poetry2nix:0.0.1 nixfriday
