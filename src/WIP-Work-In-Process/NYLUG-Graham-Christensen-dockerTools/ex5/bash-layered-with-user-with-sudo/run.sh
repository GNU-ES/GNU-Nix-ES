#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

nix-build ./bash-layered-with-user-with-sudo.nix

docker load < ./result

docker run --interactive --rm --tty bash-layered-with-user-with-sudo:0.0.1 bash -c 'ls -la'

docker run --interactive --rm --tty bash-layered-with-user-with-sudo:0.0.1 bash -c 'stat /sbin/su'

docker run --interactive --rm --tty bash-layered-with-user-with-sudo:0.0.1 bash -c 'su somebody'

# stat $(readlink $(which su))


#    adduser \
#    --disabled-password \
#    --force-badname \
#    --ingroup sudo \
#    --quiet \
#    --shell /bin/bash \
#    --home /home/"$INPUTED_USER_OR_DEFAULT" \
#    --gecos "User" "$INPUTED_USER_OR_DEFAULT"
#
#    useradd \
#    --badnames \
#    --gid sudo \
#    --home-dir /home/"$INPUTED_USER_OR_DEFAULT"
#    --shell /bin/bash \
#    --no-user-group