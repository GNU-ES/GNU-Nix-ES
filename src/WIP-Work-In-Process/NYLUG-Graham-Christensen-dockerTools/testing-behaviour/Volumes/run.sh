#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


#TODO: inject $(git rev-parse --short HEAD) in the name

nix-build './Volumes.nix'

docker load < ./result


docker run \
--interactive \
--rm \
--tty \
--rm \
volumes-bash-interactive:0.0.1 -c 'ls -al /data'
