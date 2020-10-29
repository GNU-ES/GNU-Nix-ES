#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


#TODO: inject $(git rev-parse --short HEAD) in the name

nix-build './docker-tools-example-1.nix'

docker load < ./result

WORKDIR_1=$(docker run \
--rm \
--workdir /code1 \
docker-tools-example-1:0.0.1 \
bash -c 'pwd')

WORKDIR_2=$(docker run \
--rm \
--workdir /code2 \
docker-tools-example-1:0.0.1 \
bash -c 'pwd')



WORKDIR_RESULT=$(docker run \
--rm \
docker-tools-example-1:0.0.1 \
bash -c 'pwd')

echo $WORKDIR_RESULT

if [[ "$WORKDIR_1" != "$WORKDIR_RESULT" ]]; then
    echo .
else
    exit 42
fi

if [[ "$WORKDIR_2" == "$WORKDIR_RESULT" ]]; then
    echo .
else
    exit 42
fi
