#!/usr/bin/env sh


#sudo --preserve-env nix-env --file "<nixpkgs>" --install --attr \
#commonsCompress \
#gnutar \
#lzma.bin \
#git

sudo --preserve-env mkdir --parent ~/.config/nix/nix \
&& sudo --preserve-env touch /home/pedroregispoar/.config/nix/nix.conf \
&& sudo --preserve-env chown pedroregispoar:wheel /home/pedroregispoar/.config/nix/nix.conf \
&& echo 'experimental-features = nix-command flakes ca-references' >> ~/.config/nix/nix.conf


sudo mkdir --mode=755 --parent /nix/var/nix/profiles


#stat --format "uid=%u uname=%U gid=%g gname=%G %a %A" /tmp \
#&& stat --format "uid=%u uname=%U gid=%g gname=%G %a %A" /nix/var/nix \
#&& stat --format "uid=%u uname=%U gid=%g gname=%G %a %A" /nix/var/nix/profiles \
#&& stat --format "uid=%u uname=%U gid=%g gname=%G %a %A" /nix/var/nix/temproots \
#&& stat --format "uid=%u uname=%U gid=%g gname=%G %a %A" /home/pedroregispoar/.cache/var \
#&& stat --format "uid=%u uname=%U gid=%g gname=%G %a %A" /home/pedroregispoar/.cache/nix/


sudo chown --recursive pedroregispoar:pedroregispoargroup \
  /tmp \
  /nix/var/nix \
  /nix/var/nix/profiles \
  /nix/var/nix/temproots \
  /home/pedroregispoar/.cache/var \
  /home/pedroregispoar/.cache/nix/

sudo chmod 755 /nix/store
sudo chmod 755 /nix/var/nix
sudo chmod 755 /nix/var
sudo chmod 755 /nix/var/nix/temproots
sudo chmod 755 /tmp

sudo mkdir --mode=755 /home/pedroregispoar/.local

cd /home/pedroregispoar/ \
&& sudo find . ! -path '*sudo*' -exec chown pedroregispoar:pedroregispoargroup {} --verbose \; \
&& cd -

cd "$HOME" \
&& sudo find "$HOME" ! -path '*sudo*' -exec chown pedroregispoar:pedroregispoargroup {} --verbose \; \
&& cd -




#nix-store --init && nix-store --load-db < /.reginfo

nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix flake show github:GNU-ES/hello'
