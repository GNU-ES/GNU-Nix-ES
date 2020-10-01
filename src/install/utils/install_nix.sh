#!/bin/bash


INPUTED_USER_OR_DEFAULT=${1:-GNU-Nix-ES}
INPUTED_PASSWORD_OR_DEFAULT=${2:-'123'}

if [ ! -d '/nix' ]; then
    echo 'Creating /nix'
    mkdir -m 0755 /nix
    chown "$INPUTED_USER_OR_DEFAULT" /nix
fi

## https://askubuntu.com/a/978467
#sudo -u "$INPUTED_USER_OR_DEFAULT" bash <<EOF
#    echo "$INPUTED_PASSWORD_OR_DEFAULT" | sudo -S curl -L https://nixos.org/nix/install | sh
#    echo '. /home/'"$INPUTED_USER_OR_DEFAULT"'/.nix-profile/etc/profile.d/nix.sh' >> /home/"$INPUTED_USER_OR_DEFAULT"/.bashrc
##    bash -c '. ./home/$INPUTED_USER_OR_DEFAULT/.bashrc && nix --version'
##    ls -al
##    id
#
#    exit 0
##    # Tests:
##    echo ""$ whoami" && whoami"
##    cat ~/.bashrc | grep nix
##    ls -la
##    ls -la /home/"$INPUTED_USER_OR_DEFAULT"/.bashrc
##    echo 'DEBUG: '"$INPUTED_PASSWORD_OR_DEFAULT"
#EOF

# ./utils/run_nix_install.sh

#sudo -u "$INPUTED_USER_OR_DEFAULT" bash -c './utils/run_nix_install.sh'

#sudo -u "$INPUTED_USER_OR_DEFAULT" bash <<EOF
#    ./utils/run_nix_install.sh
#    exit 0
#EOF

#sudo_curl_nixos_install


sudo -u "$INPUTED_USER_OR_DEFAULT" bash <<EOF
    INPUTED_USER_OR_DEFAULT=${1:-GNU-Nix-ES}
    INPUTED_PASSWORD_OR_DEFAULT=${2:-'123'}

    if [ ! -f 'utils/nix_oficial_installer.sh' ]; then
        echo 'sfgsr'
        curl -L https://nixos.org/nix/install -o nix_oficial_installer.sh
    fi
#    echo "$INPUTED_PASSWORD_OR_DEFAULT" | sudo -S curl -L https://nixos.org/nix/install | sh
    echo "$INPUTED_PASSWORD_OR_DEFAULT" | sudo -S cat nix_oficial_installer.sh | sh

#    echo "$INPUTED_PASSWORD_OR_DEFAULT" | sudo -S
#    echo ". /home/$INPUTED_USER_OR_DEFAULT/.nix-profile/etc/profile.d/nix.sh" >> /home/"$INPUTED_USER_OR_DEFAULT"/.bashrc

#    . ./home/"$INPUTED_USER_OR_DEFAULT"/.bashrc
    . /home/"$INPUTED_USER_OR_DEFAULT"/.nix-profile/etc/profile.d/nix.sh
    nix --version

#    echo "$INPUTED_PASSWORD_OR_DEFAULT" | sudo -S /nix/var/nix/profiles/per-user/"$INPUTED_USER_OR_DEFAULT"/profile/bin/nix-env --install --attr nixpkgs.commonsCompress nixpkgs.gnutar nixpkgs.lzma.bin nixpkgs.git
#    echo "$INPUTED_PASSWORD_OR_DEFAULT" | sudo -S mkdir -p "$INPUTED_USER_OR_DEFAULT"/.config/nix
#    echo 'experimental-features = nix-command flakes ca-references' >> "$INPUTED_USER_OR_DEFAULT"/.config/nix/nix.conf
#    nix-shell -I nixpkgs=channel:nixos-20.03 --packages nixFlakes --run 'nix flake --version'
#    nix-shell -I nixpkgs=channel:nixos-20.03 --packages nixFlakes
#    ls -al
#    id

#     #Tests:
#    echo ""$ whoami" && whoami"
#    cat ~/.bashrc | grep nix
#    ls -la
#    ls -la /home/"$INPUTED_USER_OR_DEFAULT"/.bashrc
#    echo 'DEBUG: '"$INPUTED_PASSWORD_OR_DEFAULT"
EOF

if [ ! -d "/home/$INPUTED_USER_OR_DEFAULT/.config/nix/" ]; then
    echo 'Creating '"/home/$INPUTED_USER_OR_DEFAULT/.config/nix/"
    mkdir -p "/home/$INPUTED_USER_OR_DEFAULT/.config/nix/"

    echo 'experimental-features = nix-command flakes ca-references' >> /home/"$INPUTED_USER_OR_DEFAULT"/.config/nix/nix.conf
    echo ". /home/$INPUTED_USER_OR_DEFAULT/.nix-profile/etc/profile.d/nix.sh" >> /home/"$INPUTED_USER_OR_DEFAULT"/.bashrc
fi


su -P "$INPUTED_USER_OR_DEFAULT" -c "bash -c $'. /home/GNU-Nix-ES/.nix-profile/etc/profile.d/nix.sh \
&& ./utils/requirements-flake.sh \
&& nix-shell -I nixpkgs=channel:nixos-20.03 --packages nixFlakes'"

#su "$INPUTED_USER_OR_DEFAULT" -c 'nix-shell -I nixpkgs=channel:nixos-20.03 --packages nixFlakes'
#su "$INPUTED_USER_OR_DEFAULT" -c 'bash -c 'nix-shell'


#if [ -n "$testing" ]; then
#    sudo -u "$INPUTED_USER_OR_DEFAULT" bash -c '\
#    id \
#    && . /home/"$USER"/.nix-profile/etc/profile.d/nix.sh \
#    && nix --version \
#    && /nix/var/nix/profiles/per-user/"$USER"/profile/bin/nix-env --install --attr nixpkgs.commonsCompress nixpkgs.gnutar nixpkgs.lzma.bin nixpkgs.git \
#    && mkdir -p $USER/.config/nix \
#    && echo 'experimental-features = nix-command flakes ca-references' >> "$USER"/.config/nix/nix.conf \
#    && nix-shell -I nixpkgs=channel:nixos-20.03 --packages nixFlakes --run 'nix flake --version'
#    '
#else
#    su "$INPUTED_USER_OR_DEFAULT"
#fi

