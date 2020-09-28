#!/bin/bash

echo "Command $1 found! Using it to install Nix."

# TODO: check if it is bening running as root

. ./utils/args-wrapper/args-wrapper.sh

##TOOO: refactor this?
#if ! command -v openssl &> /dev/null
#then
#    echo 'The openssl was not detedcted!'
#    echo 'Instaling it!'
#    ./utils/apt-install.sh openssl
#fi
#
#if ! command -v wget &> /dev/null
#then
#    echo 'The wget was not detedcted!'
#    echo 'Instaling it!'
#    ./utils/apt-install.sh wget
#fi
#
#if ! command -v xz &> /dev/null
#then
#    echo 'The xz was not detedcted!'
#    echo 'Instaling it!'
#    ./utils/apt-install.sh xz-utils
#fi

#./utils/apt-install.sh openssl wget xz-utils

#apt update
#
#apt install -y --no-install-recommends ca-certificates lzma xz-utils wget sudo curl openssl
##DEBIAN_FRONTEND=noninteractive
##unset DEBIAN_FRONTEND
#
#apt -y autoremove
#apt -y clean
#rm -rf /var/lib/apt/lists/*


if [ -n "$password" ]; then
    echo "You supplied the 'password' parameter!"
    INPUTED_PASSWORD_OR_DEFAULT="$password"
else
    echo "Using default 'password'!"
    INPUTED_PASSWORD_OR_DEFAULT='123'
fi

if [ -n "$testing" ]; then
    echo "You supplied the testing parameter!"
#    INPUTED_PASSWORD_OR_DEFAULT="$testing"
#else
#    echo "Using default testing!"
#    INPUTED_PASSWORD_OR_DEFAULT='123'
fi

if [ -n "$user" ]; then
    echo "You supplied the 'user' parameter!"
    INPUTED_USER_OR_DEFAULT="$user"
else
    echo "Using default 'user'!"
    INPUTED_USER_OR_DEFAULT='GNU-Nix-ES'
fi

#INPUTED_USER_OR_DEFAULT=${2:-GNU-Nix-ES}
#INPUTED_PASSWORD_OR_DEFAULT=${3:-'123'}


if [ -n "$testing" ]; then
    ## Tests:
    cat /etc/passwd | grep "$INPUTED_USER_OR_DEFAULT"
    #id --version
    id "$INPUTED_USER_OR_DEFAULT"
    id "$INPUTED_USER_OR_DEFAULT" --groups
    id "$INPUTED_USER_OR_DEFAULT" --name
    id --groups
    id --name
fi


TESTING=${1:-0}
INPUTED_USER_OR_DEFAULT=${2:-GNU-Nix-ES}
INPUTED_PASSWORD_OR_DEFAULT=${3:-'123'}

if [ -z ${2+x} ]; then
    if [ "$INPUTED_USER_OR_DEFAULT" != "GNU-Nix-ES" ]; then
        echo "Some bizar thing happened!"
        echo "No INPUTED_USER_OR_DEFAULT was given using \$2,"
        echo "the default user is: "$INPUTED_USER_OR_DEFAULT""
    else
        echo "."
    fi
else
    if [ "$INPUTED_USER_OR_DEFAULT" != "$2" ]; then
        echo "Some bizar thing happened!"
    else
        echo "."
    fi
fi

if [ -z ${3+x} ]; then
    if [ "$INPUTED_PASSWORD_OR_DEFAULT" != "123" ]; then
        echo "Some bizar thing happened!"
        echo "No INPUTED_PASSWORD_OR_DEFAULT was given using \$3,"
        echo "the default user is: "$INPUTED_PASSWORD_OR_DEFAULT""
    else
        echo "."
    fi
else
    if [ "$INPUTED_PASSWORD_OR_DEFAULT" != "$3" ]; then
        echo "Some bizar thing happened!"
        echo "The given password using \$3 is $INPUTED_PASSWORD_OR_DEFAULT"
    else
        echo "."
    fi
fi

INPUTED_USER_OR_DEFAULT=${2:-GNU-Nix-ES}
INPUTED_PASSWORD_OR_DEFAULT=${3:-'123'}

adduser \
--disabled-password \
--force-badname \
--ingroup sudo \
--quiet \
--shell /bin/bash \
--home /home/"$INPUTED_USER_OR_DEFAULT" \
--gecos "User" "$INPUTED_USER_OR_DEFAULT"

if [ ! -z ${1+x} ]; then
    ## Tests:
    cat /etc/passwd | grep "$INPUTED_USER_OR_DEFAULT"
    #id --version
    id "$INPUTED_USER_OR_DEFAULT"
    id "$INPUTED_USER_OR_DEFAULT" --groups
    id "$INPUTED_USER_OR_DEFAULT" --name
fi

echo "$INPUTED_USER_OR_DEFAULT":"$INPUTED_PASSWORD_OR_DEFAULT" | chpasswd

mkdir -m 0755 /nix
chown "$INPUTED_USER_OR_DEFAULT" /nix

# https://askubuntu.com/a/978467
sudo -u "$INPUTED_USER_OR_DEFAULT" bash <<EOF
    echo "$INPUTED_PASSWORD_OR_DEFAULT" | sudo -S curl -L https://nixos.org/nix/install | sh
    echo '. /home/'"$INPUTED_USER_OR_DEFAULT"'/.nix-profile/etc/profile.d/nix.sh' >> /home/"$INPUTED_USER_OR_DEFAULT"/.bashrc

#    # Tests:
#    echo ""$ whoami" && whoami"
#    cat ~/.bashrc | grep nix
#    ls -la
#    ls -la /home/"$INPUTED_USER_OR_DEFAULT"/.bashrc
#    echo 'DEBUG: '"$INPUTED_PASSWORD_OR_DEFAULT"
EOF


if [ -n "$testing" ]; then
    sudo -u "$INPUTED_USER_OR_DEFAULT" bash -c '\
    id \
    && . /home/"$USER"/.nix-profile/etc/profile.d/nix.sh \
    && nix --version
    '
else
    su "$INPUTED_USER_OR_DEFAULT" 
fi
