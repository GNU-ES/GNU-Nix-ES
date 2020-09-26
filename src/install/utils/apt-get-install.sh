#!/usr/bin/env sh

set -ex

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends "$@"
apt-get clean
rm -rf /var/lib/apt/lists/*
exit 0
