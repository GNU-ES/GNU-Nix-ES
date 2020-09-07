#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail

cd src/examples

find . -name 'user-run.sh' -exec sed --expression="s:REVISION:$(git rev-parse $(git rev-parse --short HEAD)):g" --in-place  {} +
find . -name 'README.md' -exec sed "s/user-run.sh/'$(cat {})'/"



#https://stackoverflow.com/a/15849152
#https://unix.stackexchange.com/a/12904
#https://www.everythingcli.org/find-exec-vs-find-xargs/
