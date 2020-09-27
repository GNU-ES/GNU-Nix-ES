#!/bin/sh

if command -v apk &> /dev/null
then
    echo "Command apk could be found!"
    apk-install.sh "$@"
fi

if command -v apt &> /dev/null
then
    echo "Command apt could be found!"
    apt-install.sh "$@"
fi

if command -v apt-get &> /dev/null
then
    echo "Command apt-get could be found!"
    apt-get-install.sh "$@"
fi


if command -v yum &> /dev/null
then
    echo "Command yum could be found!"
    yum-install.sh "$@"
fi


if command -v pacman &> /dev/null
then
    echo "Command pacman could be found!"
    pacman-install.sh "$@"
fi