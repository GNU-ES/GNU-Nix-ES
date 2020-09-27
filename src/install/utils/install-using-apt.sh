#!/bin/bash

echo "Command $1 found! Using it to install Nix."

# TODO: check if it is bening running as root


#TOOO: check instalation, skip waht is already installed
./utils/apt-install.sh openssl wget xz-utils


