#!/bin/sh

is_nix_installed () {
    if command -v nix &> /dev/null
    then
        echo "The nix is installed!"
        nix --version
        exit 0
    fi
}
