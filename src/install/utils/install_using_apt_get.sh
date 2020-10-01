#!/bin/bash

echo "Command $1 found! Using it to install Nix."

INPUTED_USER_OR_DEFAULT=${1:-GNU-Nix-ES}
INPUTED_PASSWORD_OR_DEFAULT=${2:-'123'}

#docker run \
#--interactive \
#--rm \
#--tty \
#--volume "$(pwd)":/code \
#--workdir /code \
#ubuntu:20.04 \
#bash -c "./apt-get-install.sh 'sudo' && ./adduser-with-sudo-privileges.sh && ./install-using-apt.sh && echo 0"


# TODO: check if it is bening running as root


./utils/is_nix_installed.sh


. ./utils/args-wrapper/args-wrapper.sh

./utils/install_requirements.sh

# Remove this sorce of noise!
#sudo --version

./utils/adduser_with_sudo_privileges.sh

./utils/install_nix.sh


#if [ -n "$password" ]; then
#    echo "You supplied the 'password' parameter!"
#    INPUTED_PASSWORD_OR_DEFAULT="$password"
#else
#    INPUTED_PASSWORD_OR_DEFAULT='123'
#    echo "Using default password='$INPUTED_PASSWORD_OR_DEFAULT'!"
#fi
#
#if [ -n "$testing" ]; then
#    echo "You supplied the 'testing' parameter!"
##    INPUTED_PASSWORD_OR_DEFAULT="$testing"
##else
##    echo "Using default testing!"
##    INPUTED_PASSWORD_OR_DEFAULT='123'
#fi
#
#if [ -n "$user" ]; then
#    echo "You supplied the 'user' parameter!"
#    INPUTED_USER_OR_DEFAULT="$user"
#else
#    INPUTED_USER_OR_DEFAULT='GNU-Nix-ES'
#    echo "Using default 'user'=$INPUTED_USER_OR_DEFAULT!"
#fi

#INPUTED_USER_OR_DEFAULT=${2:-GNU-Nix-ES}
#INPUTED_PASSWORD_OR_DEFAULT=${3:-'123'}
#
#mkdir -m 0755 /nix
#chown "$INPUTED_USER_OR_DEFAULT" /nix
#
## https://askubuntu.com/a/978467
#sudo -u "$INPUTED_USER_OR_DEFAULT" bash <<EOF
#    echo "$INPUTED_PASSWORD_OR_DEFAULT" | sudo -S curl -L https://nixos.org/nix/install | sh
#    echo '. /home/'"$INPUTED_USER_OR_DEFAULT"'/.nix-profile/etc/profile.d/nix.sh' >> /home/"$INPUTED_USER_OR_DEFAULT"/.bashrc
#
##    # Tests:
##    echo ""$ whoami" && whoami"
##    cat ~/.bashrc | grep nix
##    ls -la
##    ls -la /home/"$INPUTED_USER_OR_DEFAULT"/.bashrc
##    echo 'DEBUG: '"$INPUTED_PASSWORD_OR_DEFAULT"
#EOF

## Remove the added programs, try keep the system as clear as possible.
#for missing_requirement in "${missing_requirements[@]}"
#do
#    if [ ${missing_requirement} != 'sudo' ]; then
#        apt remove -y $missing_requirement
#    fi
#done


