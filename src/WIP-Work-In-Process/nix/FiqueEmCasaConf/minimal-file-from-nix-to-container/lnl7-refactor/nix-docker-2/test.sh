#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail

mkdir --parent /nix/var/nix/gcroots
mkdir --parent /var/empty

mkdir --parent /nix/var/nix/profiles/per-user/root
#mkdir --parent /root/.nix-defexpr

mkdir --parent /nix/var/nix/profiles/per-user/pedroregispoar
mkdir --parent /pedroregispoar/.nix-defexpr


mkdir --parent /home/pedroregispoar/.local/share/nix

touch /home/pedroregispoar/.nix-profile.lock
sudo chmod 0775 /home/pedroregispoar/.nix-profile.lock
chown pedroregispoar:wheel /home/pedroregispoar/.nix-profile.lock
stat /home/pedroregispoar/.nix-profile.lock



cd / \
&& sudo nix-store --init \
&& sudo nix-store --load-db < /.reginfo \
&& sudo touch /nix/var/nix/gc.lock \
&& sudo chown pedroregispoar /nix/var/nix/gc.lock \
&& sudo chown pedroregispoar /nix/var/nix/temproots \
&& sudo chmod 0775 /nix/var/nix/temproots \
&& stat --dereference $(readlink $(which sudo)) \
&& sudo chown --recursive --verbose pedroregispoar /nix/store/ /nix/var/ /tmp/ \
&& stat --dereference $(readlink $(which sudo)) \
&& chown --recursive root:root --verbose $(echo $(readlink $(which sudo)) | cut --delimiter='/' --fields=1-4) /tmp/ \
&& chmod 4755 --recursive --verbose $(echo $(readlink $(which sudo)) | cut --delimiter='/' --fields=1-4) /tmp/ \
&& stat --dereference $(readlink $(which sudo)) \
&& su pedroregispoar -c 'sudo ls -al' \
&& sudo ls -al \
&& chmod 0777 --recursive --verbose /tmp/ \
&& mkdir --mode=0777 /nix/var/log
