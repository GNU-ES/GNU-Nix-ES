#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

nix-build ./bash-layered-with-user.nix

docker load < ./result


echo 'Testing if bash works:'
docker \
run \
--interactive \
--tty \
bash-layered-with-user \
bash -c 'ls -la'

echo 'Test if the user is the root one, passing explicitly with the flag --user'
docker \
run \
--interactive \
--tty \
--user=root \
bash-layered-with-user \
bash -c 'id'

echo 'Test if the user is the root one'
docker \
run \
--interactive \
--tty \
bash-layered-with-user \
bash -c 'id'

echo 'Test if the user is the somebody one'
docker \
run \
--interactive \
--tty \
--user=somebody \
bash-layered-with-user \
bash -c 'id'



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