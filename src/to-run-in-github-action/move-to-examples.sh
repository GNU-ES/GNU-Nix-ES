#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail

cd to-be-moved
echo "Moving "$1" to ${2:-'examples'}."
mv "$1" ../../${2:-'examples'}/
