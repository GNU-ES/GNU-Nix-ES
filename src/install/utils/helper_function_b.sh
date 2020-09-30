#!/bin/bash

#
# https://stackoverflow.com/a/56569081
# DEBIAN_FRONTEND=noninteractive apt-get -yq install
# What about -q?

echo '"$@"='"$@"


apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends "$@"


apt-get clean
apt-get -y autoremove
rm -rf /var/lib/apt/lists/*

unset DEBIAN_FRONTEND

exit 0
