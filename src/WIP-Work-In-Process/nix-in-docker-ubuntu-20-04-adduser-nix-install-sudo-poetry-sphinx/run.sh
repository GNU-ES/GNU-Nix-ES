#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -eux pipefail


IMAGE_VERSION="gnu-nix-es/$(git rev-parse --short HEAD)":"0.0.1"

# Here is used a "trick" to inject informations, like the date and git revision, and
# the image name is changed, it is good for the next command, the `docker run` one.
docker build \
--label org.opencontainers.image.created=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
--label org.opencontainers.image.revision=$(git rev-parse $(git rev-parse --short HEAD)) \
--tag \
"$IMAGE_VERSION" .


docker run \
--interactive \
--rm \
--tty \
--user root \
--volume "$(pwd)":/code \
--workdir /code \
"gnu-nix-es/$(git rev-parse --short HEAD)":"0.0.1" \
bash -c "yes | sphinx-quickstart --author GNU-Nix-ES --language en --project GNU-Nix-ES --release 0.0.0 && make html"

sudo chown --recursive "$(id --user)":"$(id --group)" .

# TODO: add a clean
#sudo rm -r source build make.bat Makefile

# TODO:
# use sudo tee etc to save the output
#
# Ref to start use `yes`:
#https://askubuntu.com/a/805324