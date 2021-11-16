#!/usr/bin/env sh
# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
# set -euxo pipefail

#./build-as-root.sh
#./test-as-root.sh

./build-non-root.sh
./build-non-root-scratch.sh

#./test-non-root.sh
#./test-non-root-scratch.sh
