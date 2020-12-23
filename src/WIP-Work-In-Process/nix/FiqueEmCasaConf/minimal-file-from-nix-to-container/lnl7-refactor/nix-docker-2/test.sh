#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail


#stat --dereference $(readlink $(which sudo))

#chmod 4755 --recursive --verbose $(echo $(readlink $(which sudo)) | cut --delimiter='/' --fields=1-4)

chmod 4755 $(readlink $(which sudo))
