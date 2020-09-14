#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail

REVISION=$(git rev-parse $(git rev-parse --short HEAD))

cd to-be-moved/"$1"

find . -type f -name "README.md" -exec sed --in-place --regexp-extended "s/\b([a-f0-9]{40})\b/"$REVISION"/g" {} +

# https://stackoverflow.com/a/10605775
FOLDER_NAME="$(find . -mindepth 1 -maxdepth 1 -type d | cut --delimiter='/' --field=2)"

# https://stackoverflow.com/a/48546369
find . -type f -name "README.md" -exec sed --in-place --regexp-extended "s/&& cd src\/examples[^ ]*/\&\& cd src\/examples\/"$FOLDER_NAME"/g" {} +
