#!/bin/bash

echo "Command $1 found! Using it to install Nix."

# TODO: check if it is bening running as root


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

INPUTED_USER_OR_DEFAULT=${1:-GNU-Nix-ES}
INPUTED_PASSWORD_OR_DEFAULT=${2:-'123'}

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
apt update

apt install -y --no-install-recommends ca-certificates lzma xz-utils wget sudo curl openssl
#DEBIAN_FRONTEND=noninteractive
#unset DEBIAN_FRONTEND

apt -y autoremove
apt -y clean
rm -rf /var/lib/apt/lists/*

mkdir -m 0755 /nix
chown "$INPUTED_USER_OR_DEFAULT" /nix

#
#echo "Trying sudo -u GNU-Nix-ES bash"
#sudo -u "$INPUTED_USER_OR_DEFAULT" bash -c "\
#  echo ""$ whoami" && whoami"
#  echo 'DEBUG: '"$INPUTED_PASSWORD_OR_DEFAULT"
##  ls -la
#  echo "123" | sudo -S curl -L https://nixos.org/nix/install | sh
##  ls -la /home/GNU-Nix-ES/.bashrc
##  echo '. /home/GNU-Nix-ES/.nix-profile/etc/profile.d/nix.sh' >> /home/GNU-Nix-ES/.bashrc
#"

# https://askubuntu.com/a/978467
sudo -u "$INPUTED_USER_OR_DEFAULT" bash <<EOF
  echo ""$ whoami" && whoami"
  echo 'DEBUG: '"$INPUTED_PASSWORD_OR_DEFAULT"
#  ls -la
  echo "$INPUTED_PASSWORD_OR_DEFAULT" | sudo -S curl -L https://nixos.org/nix/install | sh
  echo '. /home/'"$INPUTED_USER_OR_DEFAULT"'/.nix-profile/etc/profile.d/nix.sh' >> /home/"$INPUTED_USER_OR_DEFAULT"/.bashrc
#  ls -la /home/GNU-Nix-ES/.bashrc
#  echo '. /home/GNU-Nix-ES/.nix-profile/etc/profile.d/nix.sh' >> /home/GNU-Nix-ES/.bashrc
EOF


echo '. /home/'"$INPUTED_USER_OR_DEFAULT"'/.nix-profile/etc/profile.d/nix.sh' >> /home/"$INPUTED_USER_OR_DEFAULT"/.bashrc

#su "$INPUTED_USER_OR_DEFAULT" -c '. /home/"$USER"/.nix-profile/etc/profile.d/nix.sh && nix --version'


#"$INPUTED_PASSWORD_OR_DEFAULT"

#./utils/install-using-apt.sh \
#&& echo '. /home/GNU-Nix-ES/.nix-profile/etc/profile.d/nix.sh' >> /home/GNU-Nix-ES/.bashrc \
#&& su GNU-Nix-ES -c 'cat ~/.bashrc | grep nix' \
#&& su GNU-Nix-ES -c '. ~/.bashrc && nix --version'


sudo -u "$INPUTED_USER_OR_DEFAULT" bash -c '\
id \
&& . /home/"$USER"/.nix-profile/etc/profile.d/nix.sh \
&& nix --version
'

#shift
#shift
#su "$INPUTED_USER_OR_DEFAULT" "$@"
