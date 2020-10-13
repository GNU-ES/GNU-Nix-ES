#!/bin/bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -eux pipefail

#echo "$1"
#echo "$2"

echo 'Script name='$0
echo 'The number of arguments $#='$#
echo 'All arguments passed "$@"='"$@"


INPUTED_USER_OR_DEFAULT=${1:-GNU-Nix-ES}
INPUTED_PASSWORD_OR_DEFAULT=${2:-'123'}


if ! command -v sudo &> /dev/null
then
    ./apt_get_install.sh 'sudo'
fi

if command -v sudo &> /dev/null
then
    echo 'Printing the sudo version'
    sudo --version | head -n1

    adduser \
    --disabled-password \
    --force-badname \
    --ingroup sudo \
    --quiet \
    --shell /bin/bash \
    --home /home/"$INPUTED_USER_OR_DEFAULT" \
    --gecos "User" "$INPUTED_USER_OR_DEFAULT"

    # Here the password is changed:
    echo "$INPUTED_USER_OR_DEFAULT":"$INPUTED_PASSWORD_OR_DEFAULT" | chpasswd
else
    echo 'The sudo is not installed!'
    exit 1
fi


## Tests:
test_added_user (){
    # test_1
    # Given:
    #   - an ubuntu:20.04 docker image
    # When:
    #   - adduser ...
    # Then:
    #   - it must be possible log as the created user (su "$INPUTED_USER_OR_DEFAULT")
    #   - the user must apear in /etc/passwd, so cat /etc/passwd | grep "$INPUTED_USER_OR_DEFAULT"
    #   - TODO

    # Here is the tric, if we only
    # su "$INPUTED_USER_OR_DEFAULT"
    # we get stuck as the new shell user (try it to see)
    # but we can pass bash and a command and it works!
    su "$INPUTED_USER_OR_DEFAULT" bash -c 'echo Loged as: $USER && ls -al'

    id

    echo 'The "$USER"='"$USER"

    id "$USER" --groups

    su "$INPUTED_USER_OR_DEFAULT" bash -c 'id'
    su "$INPUTED_USER_OR_DEFAULT" -c 'id'

    #id --version | head -n 1
    id "$INPUTED_USER_OR_DEFAULT"
    id "$INPUTED_USER_OR_DEFAULT" --groups
    ## Why this not work?
    #id "$INPUTED_USER_OR_DEFAULT" --name

    cat /etc/passwd | grep "$INPUTED_USER_OR_DEFAULT" || echo 'Error, this test failed!'
}

## Tests:
test_password (){
    su "$INPUTED_USER_OR_DEFAULT" -c "echo "$INPUTED_PASSWORD_OR_DEFAULT" | sudo -S ls -la"

    su "$INPUTED_USER_OR_DEFAULT" -c "echo "$INPUTED_PASSWORD_OR_DEFAULT" | sudo -S id"

    echo "$INPUTED_PASSWORD_OR_DEFAULT" | sudo -S id
}


test_run_all_tests () {
    test_added_user
    test_password
}

#test_run_all_tests


# TODOS

# TESTS!! Please, we need sanity checks!!

# http://manpages.ubuntu.com/manpages/xenial/pt/man8/adduser.8.html
# /etc/adduser.conf

#INPUTED_USER={"$1":-'GNU-Nix-ES'}
#adduser: Please enter a username matching the regular expression configured
#via the NAME_REGEX configuration variable.  Use the `--force-badname'
#option to relax this check or reconfigure NAME_REGEX.

# TODO
# Study the implementation of adduser
# https://askubuntu.com/a/726067
#
# Really bad, sorry.
# http://manpages.ubuntu.com/manpages/xenial/pt/man8/adduser.8.html

# Refs
#https://stackoverflow.com/a/2013589
