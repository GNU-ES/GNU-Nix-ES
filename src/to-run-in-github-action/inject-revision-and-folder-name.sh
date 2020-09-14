#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail

REVISION=$(git rev-parse $(git rev-parse --short HEAD))

#https://stackoverflow.com/a/3601734
cd "$1"/${2:-''}
ls -la

find . -type f -name "README.md" -exec sed --in-place --regexp-extended "s/\b([a-f0-9]{40})\b/"$REVISION"/g" {} +

git status

#if [ ! -z $2 ]; then
#    echo 'up'
#else
#    echo 'down'
#fi


FOLDER_NAME="$1"
# echo "$FOLDER_NAME"

# https://stackoverflow.com/a/48546369
find . -type f -name "README.md" -exec sed --in-place --regexp-extended "s/&& cd src\/examples[^ ]*/\&\& cd src\/examples\/"$FOLDER_NAME"/g" {} +
