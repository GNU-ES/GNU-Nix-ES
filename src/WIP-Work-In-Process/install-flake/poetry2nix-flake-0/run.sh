#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -eux pipefail

IMAGE="gnu-nix-es/$(git rev-parse --short HEAD)"
VERSION=0.0.1
IMAGE_VERSION="$IMAGE":"$VERSION"


nix develop --command './test_.nix'

nix develop --command python -c 'import rtree'

sudo chown pedroregispoar:pedroregispoargroup --recursive /nix

sudo --preserve-env --user=pedroregispoar --group=pedroregispoargroup ls
