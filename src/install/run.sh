#!/bin/bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail

##https://stackoverflow.com/a/2013573
##https://stackoverflow.com/a/2013589
#SEARCH_PATH=${1:-'examples'}
#
## If you want debug:
## echo "$SEARCH_PATH"

## TODO: better documantation os what it does, where it is documented officially
#DIR="${BASH_SOURCE%/*}"
#
#
## TODO: Advantages and Limitations
## echo "$(pwd)"
## vs
## echo "$PWD"
#if [ ! -d "$DIR" ]; then
#    DIR="$PWD"
#    echo 'DEBUG: ''$DIR='"$DIR"
#fi
#
##. "$DIR/incl.sh"
##. "$DIR/main.sh"
#
#"$DIR/"install.sh

./install.sh

## For debug:
##echo "$(pwd)"
##ls -la
#cd ..
#./utils/end-mensage.sh