#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -eux pipefail

#echo "$(pwd)"
#ls -la
#cd to-be-moved/"$1"
#echo "$(pwd)"
#ls -la
#
#./run.sh


ls -la
echo '###############################'
cd /to-be-moved/
echo "$1"
cd "$1"
ls -la
./run.sh

