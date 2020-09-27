#!/usr/bin/env sh


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -eux pipefail

#echo "$1"
#echo "$2"

INPUTED_USER_OR_DEFAULT=${1:-GNU-Nix-ES}
INPUTED_PASSWORD_OR_DEFAULT=${2:-'123'}

if [ -z ${1+x} ]; then
    if [ "$INPUTED_USER_OR_DEFAULT" != "GNU-Nix-ES" ]; then
        echo "Some bizar thing happened!"
        echo "No INPUTED_USER_OR_DEFAULT was given using \$1,"
        echo "the default user is: "$INPUTED_USER_OR_DEFAULT""
    else
        echo "."
    fi
else
    if [ "$INPUTED_USER_OR_DEFAULT" != "$1" ]; then
        echo "Some bizar thing happened!"
    else
        echo "."
    fi
fi

if [ -z ${2+x} ]; then
    if [ "$INPUTED_PASSWORD_OR_DEFAULT" != "123" ]; then
        echo "Some bizar thing happened!"
        echo "No INPUTED_PASSWORD_OR_DEFAULT was given using \$2,"
        echo "the default user is: "$INPUTED_PASSWORD_OR_DEFAULT""
    else
        echo "."
    fi
else
    if [ "$INPUTED_PASSWORD_OR_DEFAULT" != "$2" ]; then
        echo "Some bizar thing happened!"
        echo "The given password using \$2 is $INPUTED_PASSWORD_OR_DEFAULT"
    else
        echo "."
    fi
fi


adduser \
--disabled-password \
--force-badname \
--ingroup sudo \
--quiet \
--shell /bin/bash \
--home /home/"$INPUTED_USER_OR_DEFAULT" \
--gecos "User" "$INPUTED_USER_OR_DEFAULT"

## Tests:
cat /etc/passwd | grep "$INPUTED_USER_OR_DEFAULT"
#id --version
id "$INPUTED_USER_OR_DEFAULT"
#id "$INPUTED_USER_OR_DEFAULT" --groups
##id "$INPUTED_USER_OR_DEFAULT" --name

echo "$INPUTED_USER_OR_DEFAULT":"$INPUTED_PASSWORD_OR_DEFAULT" | chpasswd

# Tests:
#id "$INPUTED_USER_OR_DEFAULT"
#su "$INPUTED_USER_OR_DEFAULT" -c "echo "$INPUTED_PASSWORD_OR_DEFAULT" | sudo --stdin ls -la"
#su "$INPUTED_USER_OR_DEFAULT" -c "echo "$INPUTED_PASSWORD_OR_DEFAULT" | sudo --stdin id"
#echo "$INPUTED_PASSWORD_OR_DEFAULT" | sudo --stdin id
#su "$INPUTED_USER_OR_DEFAULT" -c 'id'


#adduser \
#--append \
#--disabled-password \
#--force-badname \
#--gecos "User" "$INPUTED_USER_OR_DEFAULT" \
#--groups sudo "$INPUTED_USER_OR_DEFAULT" \
#--shell /bin/bash \
#--home /home/"$INPUTED_USER_OR_DEFAULT" \
# && ls -la
#
#
#echo "$INPUTED_USER_OR_DEFAULT":"$INPUTED_PASSWORD_OR_DEFAULT" | chpasswd

# adduser --append --groups sudo "$INPUTED_USER_OR_DEFAULT"


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