#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail

REVISION=$(git rev-parse $(git rev-parse --short HEAD))

find . -type f -name "README.md" -exec sed --in-place --regexp-extended "s/\b([a-f0-9]{40})\b/"$REVISION"/g" {} +


#find . -name 'README.md' -exec {} \;

##echo "$(pwd)"
##ls -la
#for folder in src/examples/*
#do
#	cd "$folder"
#  ./run.sh
#  cd -
#
##  ls -la
##  echo "$folder"
#
#done
#
#
#./src/utils/end-mensage.sh
