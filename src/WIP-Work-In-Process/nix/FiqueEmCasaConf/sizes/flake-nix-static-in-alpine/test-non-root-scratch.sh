#!/usr/bin/env sh
# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail


IMAGE='alpine-nix-static-non-root-scratch'
VERSION=0.0.1
IMAGE_VERSION="$IMAGE":"$VERSION"


docker \
 run \
--interactive=true \
--tty=false \
--rm=true \
--user='ada_user' \
--workdir='/home/ada_user' \
--volume="$(pwd)":/code \
"$IMAGE_VERSION" \
shell \
nixpkgs#bashInteractive \
nixpkgs#coreutils \
--command \
bash \
<<COMMAND
/code/tests/test-fast.sh
#/code/tests/check.sh
#./code/tests/rootless.sh
COMMAND
