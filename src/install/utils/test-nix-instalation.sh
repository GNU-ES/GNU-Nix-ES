#!/usr/bin/env sh

## See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -ex pipefail

check_command_is_installed() {

    program_name="$1"
    return_code="$2"

    if command -v ${program_name} &> /dev/null
    then
        echo "Command ${program_name} found!"
    else
        echo "Command $program_name NOT found!"
        echo "The return code was: $return_code"
        return "$return_code"
    fi
}

check_command_is_installed $1 $2