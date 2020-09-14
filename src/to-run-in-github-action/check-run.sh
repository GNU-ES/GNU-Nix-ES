#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail

cd to-be-moved

ls -ls

cd "$1"

ls -ls

./run.sh

cd ..
