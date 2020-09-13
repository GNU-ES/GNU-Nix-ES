#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail

REVISION=$(git rev-parse $(git rev-parse --short HEAD))

cd 'to-be-moved'

find . -type f -name "README.md" -exec sed --in-place --regexp-extended "s/\b([a-f0-9]{40})\b/"$REVISION"/g" {} +

FOLDER_NAME="$(basename "$(pwd)")"
#PIECE=${FOLDER_NAME}' \\'
#find . -type f -name "README.md" -exec sed --in-place --regexp-extended "s/&& cd src\/examples[^ ]*/\&\& cd src\/examples\/"$PIECE"/g" {} +

find . -type f -name "README.md" -exec sed --in-place --regexp-extended "s/&& cd src\/examples[^ ]*/\&\& cd src\/examples\/"$FOLDER_NAME"/g" {} +
