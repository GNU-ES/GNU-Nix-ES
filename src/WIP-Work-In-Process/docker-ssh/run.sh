#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -eux pipefail


USER_TO_LOGIN='root'
CONTAINER_NAME='test_sshd'

IMAGE="gnu-nix-es/$(git rev-parse --short HEAD)"
VERSION=0.0.1
IMAGE_VERSION="$IMAGE":"$VERSION"

docker build \
--label org.opencontainers.image.created=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
--label org.opencontainers.image.revision=$(git rev-parse $(git rev-parse --short HEAD)) \
--tag \
"$IMAGE_VERSION" .


OLD_ID="$(docker ps --all | grep "$CONTAINER_NAME" | cut --delimiter=' ' --field=1)"
echo "$OLD_ID"

if [ -z ${OLD_ID+x} ]; then
    echo '---------------------------'
    docker stop "$OLD_ID"
fi

docker rm --force "$CONTAINER_NAME"

SHA_ID=$(docker run --detach --publish-all --name "$CONTAINER_NAME" "$IMAGE_VERSION")
echo "$SHA_ID"

# https://stackoverflow.com/a/20686101
IP="$(docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$SHA_ID")"
echo "$IP"

SSH_PORT=$(docker port "$CONTAINER_NAME" 22 | cut --delimiter=':' --field=2)
echo "$SSH_PORT"

ssh "$USER_TO_LOGIN"@"$IP" -p "$SSH_PORT"


docker container stop "$CONTAINER_NAME"
docker rm "$CONTAINER_NAME"
#docker image rm "$IMAGE_VERSION"
