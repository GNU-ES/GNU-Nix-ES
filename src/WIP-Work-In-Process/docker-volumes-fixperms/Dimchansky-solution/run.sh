#!/usr/bin/env bash
# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


rmdir artifacts
mkdir artifacts

podman \
run \
--interactive=true \
--tty=false \
--rm=true \
--workdir=/artifacts \
--volume="$(pwd)"/artifacts:/artifacts \
docker.io/library/alpine:3.14.2 \
sh \
<< COMMANDS
echo Changing owner from \$(id -u):\$(id -g) to $(id -u):$(id -g)
chown -R $(id -u):$(id -g) /artifacts
COMMANDS


stat artifacts

rmdir artifacts
