#!/usr/bin/env sh

IMAGE='pedroregispoar/nixorg'

docker build --tag "$IMAGE" .

docker images | grep "$IMAGE"

docker run \
--interactive \
--rm \
--tty \
"$IMAGE" \
sh -c "nix --version && nix-env --install --attr nixpkgs.hello"

It is broken!!