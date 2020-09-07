#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail

cd src/examples

find . -name 'README.md' -exec sed --expression="s:REVISION:$(git rev-parse $(git rev-parse --short HEAD)):g" --in-place  {} +


#https://stackoverflow.com/a/15849152
#https://www.everythingcli.org/find-exec-vs-find-xargs/
