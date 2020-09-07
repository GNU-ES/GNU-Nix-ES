#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail


REVISION=$(git rev-parse $(git rev-parse --short HEAD))


#find . -name 'README.md' -exec cat {} +

sed --in-place README.md --expression="s:REVISION:$REVISION:g"
