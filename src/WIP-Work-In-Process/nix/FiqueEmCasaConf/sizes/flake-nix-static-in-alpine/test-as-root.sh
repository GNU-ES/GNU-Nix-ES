#!/usr/bin/env sh
# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail


IMAGE='alpine-nix-static-as-root'
VERSION=0.0.1
IMAGE_VERSION="$IMAGE":"$VERSION"


podman \
 run \
--interactive=true \
--tty=false \
--rm=true \
--volume="$(pwd)":/code \
"$IMAGE_VERSION" \
sh <<COMMAND
./code/tests/test-fast.sh
#./code/tests/tests.sh
COMMAND
