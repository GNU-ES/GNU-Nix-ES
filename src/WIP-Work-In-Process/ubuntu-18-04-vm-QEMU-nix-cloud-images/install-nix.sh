#!/usr/bin/env nix-shell
#!nix-shell -i bash
set -euo pipefail


test -d /nix || sudo mkdir --mode=0755 /nix \
&& sudo chown "$USER": /nix \
&& command -v nix >/dev/null 2>&1 || curl -L https://nixos.org/nix/install | sh \
&& test -d ~/.config/nix || mkdir --parent --mode=755 ~/.config/nix && touch ~/.config/nix/nix.conf \
&& cat ~/.config/nix/nix.conf | grep 'kvm' >/dev/null && /bin/true || echo 'system-features = kvm' >> ~/.config/nix/nix.conf \
&& cat ~/.config/nix/nix.conf | grep 'flakes' >/dev/null && /bin/true || echo 'experimental-features = nix-command flakes ca-references' >> ~/.config/nix/nix.conf \
&& test -d ~/.config/nixpkgs || mkdir --parent --mode=755 ~/.config/nixpkgs && touch ~/.config/nixpkgs/config.nix \
&& cat ~/.config/nixpkgs/config.nix | grep 'allowUnfree' >/dev/null && /bin/true || echo '{ allowUnfree = true; }' >> ~/.config/nixpkgs/config.nix \
&& . "$HOME"/.nix-profile/etc/profile.d/nix.sh \
&& nix --version


# NOTE: the order here is important!!
#cat ~/.bashrc | grep 'nix-shell' >/dev/null && /bin/true || echo '. "$HOME"/.nix-profile/etc/profile.d/nix.sh' >> ~/.bashrc
#cat ~/.bashrc | grep 'nix-shell' >/dev/null && /bin/true || echo "nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'bash'" >> ~/.bashrc

#nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'bash'
#sudo --preserve-env su -c "chsh --shell $(nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'echo $SHELL')"
#export SHELL=$(nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'echo $SHELL'):$SHELL
#echo $(nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'echo $SHELL') >> /etc/shells

echo "alias nsf='nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes'" >> ~/.bashrc
echo "alias f='nsf'" >> ~/.bashrc
. ~/.bashrc

#nix flake --help
