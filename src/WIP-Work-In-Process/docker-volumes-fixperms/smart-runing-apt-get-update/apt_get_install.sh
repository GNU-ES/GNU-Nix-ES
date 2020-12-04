#!/bin/bash

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

    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends "$@"

    apt-get clean
    apt-get -y autoremove
    rm -rf /var/lib/apt/lists/*

    unset DEBIAN_FRONTEND

    exit 0
fi
