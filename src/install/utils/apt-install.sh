#!/usr/bin/env sh

set -ex

apt update

DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends "$@"

apt -y autoremove
apt -y clean
rm -rf /var/lib/apt/lists/*

exit 0
