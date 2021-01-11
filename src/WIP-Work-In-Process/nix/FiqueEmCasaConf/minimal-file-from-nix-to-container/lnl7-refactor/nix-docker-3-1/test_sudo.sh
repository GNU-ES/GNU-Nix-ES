#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail


#stat --dereference $(readlink $(which sudo))


stat /nix/var/nix/profiles/per-user
echo
sudo chown --recursive pedroregispoar:wheel /nix/var/nix/
echo
stat /nix/var/nix/profiles/per-user

#stat /nix/var/nix/profiles/per-user
#echo
#sudo chmod 755 /nix/var/nix/profiles/per-user
#echo
#stat /nix/var/nix/profiles/per-user


sudo chown --recursive pedroregispoar:wheel /tmp /nix/var/nix/ /home/pedroregispoar/.cache/var /home/pedroregispoar/.cache/nix/

sudo chmod 755 /nix/var/nix/temproots/
#stat /nix/var/nix/
#sudo chown --recursive pedroregispoar:wheel /tmp /nix/var/nix/ /home/pedroregispoar/.cache/var /home/pedroregispoar/.cache/nix/
#

nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes

#sudo find . ! -path '*sudo*' -exec chown --recursive pedroregispoar:wheel {} --verbose \;