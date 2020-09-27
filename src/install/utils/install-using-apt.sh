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


./utils/adduser-sudo.sh

#TOOO: do this in one update and install
if ! command -v sudo &> /dev/null
then
    echo 'The sudo was not detedcted!'
    echo 'Instaling it!'
    ./utils/apt-install.sh sudo curl
fi

#su GNU-Nix-ES -c 'ls -la'

curl --version
xz --version


echo "Trying sudo -u GNU-Nix-ES bash"
sudo -u GNU-Nix-ES bash -c '\
  echo "$ whoami" && whoami && echo "^^^^^^ GNU-Nix-ES expected"
  echo "123" | sudo -S curl -L https://nixos.org/nix/install | sh
  echo '. /home/GNU-Nix-ES/.nix-profile/etc/profile.d/nix.sh' >> ~/.bashrc
  nix --version
'