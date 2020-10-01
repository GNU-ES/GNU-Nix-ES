#!/bin/bash

is_nix_installed () {
    if command -v nix &> /dev/null
    then
        echo "The nix is installed!"
        nix --version
        exit 0
    else
        echo 'no'
    fi
}


is_nix_installed