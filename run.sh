#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

#https://stackoverflow.com/a/2013573
SEARCH_PATH=${1:-'src/examples'}

# If you want debug:
# echo "$SEARCH_PATH"

cd "$SEARCH_PATH"

find . -name 'run.sh' -exec {ls} \;