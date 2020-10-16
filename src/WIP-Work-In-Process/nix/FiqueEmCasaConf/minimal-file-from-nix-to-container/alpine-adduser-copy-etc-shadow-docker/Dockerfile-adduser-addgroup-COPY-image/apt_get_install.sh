#!/bin/sh

## See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -eux pipefail

# https://stackoverflow.com/a/56569081
# DEBIAN_FRONTEND=noninteractive apt-get -yq install
# What about -q?


echo 'Script name='$0
echo 'The number of arguments $#='$#
echo 'All arguments passed "$@"='"$@"


if [ $# -lt 1 ]; then
    echo "You are calling $0 with no parameters, it does not make sense!"
else
    ./run_apt-get_update.sh

    # https://github.com/sudo-bmitch/docker-base/blob/2bc11becb270195e6ab7f91f999c14f09456c1a7/bin.alpine/apk-install
    apk add --no-cache --clean-protected "$@"

    exit 0
fi
