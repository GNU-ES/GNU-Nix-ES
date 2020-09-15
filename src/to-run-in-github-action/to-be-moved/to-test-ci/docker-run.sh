#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -eux pipefail


./docker-build.sh

exit_code=$?
echo 'The exit_code:'$exit_code

if [ $exit_code -eq 0 ] ; then
  echo 'The ./docker-build.sh seens to have worked correcly.'
else
  echo 'The ./docker-build.sh may have failed.'
  exit 99
fi

IMAGE="gnu-nix-es/$(git rev-parse --short HEAD)"
VERSION=0.0.1
IMAGE_VERSION="$IMAGE":"$VERSION"

docker run \
--interactive \
--tty \
--rm \
"$IMAGE_VERSION" \
sh -c 'echo Worked!'
