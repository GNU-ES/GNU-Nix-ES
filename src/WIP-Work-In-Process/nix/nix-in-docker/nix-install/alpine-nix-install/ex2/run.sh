#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

IMAGE='gnu-nix-es/vai'
VERSION=0.0.1

IMAGE_VERSION="$IMAGE":"$VERSION"

docker build --tag "$IMAGE_VERSION" .

docker run \
--interactive \
--rm \
--tty \
--user pedro \
"$IMAGE_VERSION" \
bash -c "nix --version && nix-env --install --attr nixpkgs.python39 && python --version && python -c 'print(12345)'"

#/nix/store/5gpwq5cjnk09ymql4wgsy4w948q79bih-user-environment/bin/nix-env --install --attr nixpkgs.python39