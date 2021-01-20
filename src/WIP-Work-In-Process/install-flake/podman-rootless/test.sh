#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


# TODO: Why not only
# sudo echo pedroregispoar:10000:65536 >> /etc/sub?id
#
sudo su -c 'echo pedroregispoar:100000:65536 >> /etc/subuid'
sudo su -c 'sudo echo pedroregispoar:100000:65536 >> /etc/subgid'

podman \
run \
--interactive \
--net=host \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
docker.io/library/alpine:3.13.0 \
sh -c 'apk add --no-cache git && git init'
