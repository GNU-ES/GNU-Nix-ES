#!/usr/bin/env sh

set -ex

apt update
DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends "$@"
apt clean
rm -rf /var/lib/apt/lists/*
exit 0
