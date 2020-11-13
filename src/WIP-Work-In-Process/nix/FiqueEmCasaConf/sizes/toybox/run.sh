#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

# TODO: use rp (ripgrep)?
# TODO: capture the spaces with a regex 'toybox        0.8.4'
# tianon/toybox        0.8.4               fa9d11b03c7f        2 weeks ago         723kB

docker pull tianon/toybox:0.8.4
docker pull alpine:3.12.0

docker images | grep --fixed-strings 'alpine'
docker images | grep --fixed-strings 'tianon/toybox'
