#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail

cd 'to-be-moved'

# https://stackoverflow.com/a/10605775
FOLDER_NAME="$(find . -mindepth 1 -maxdepth 1 -type d | cut --delimiter='/' --field=2)"

mv --recursive "$FOLDER_NAME" ../examples/
