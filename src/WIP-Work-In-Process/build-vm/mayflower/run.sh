#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -eux pipefail


nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix shell nixpkgs#wget nixpkgs#man nixpkgs#man-db nixpkgs#qemu nixpkgs#stdenv'
#
#export NIX_PATH=nixos-config="$(pwd)"/configuration.nix:nixpkgs=channel:nixos-20.09
#
#nixos-rebuild build-vm
#
##nixos-rebuild -I nixos-config="$(pwd)"/configuration.nix build-vm
#
#./result/bin/run-nixos-vm


# This works in NixOS
# Ubuntu too
nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix shell nixpkgs#wget nixpkgs#man nixpkgs#man-db nixpkgs#qemu nixpkgs#stdenv --command nix build --file custom-iso.nix -I nixpkgs=channel:nixos-unstable'



nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix shell nixpkgs#wget nixpkgs#man nixpkgs#man-db nixpkgs#qemu nixpkgs#stdenv --command sudo qemu-kvm --version'

nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix shell nixpkgs#wget nixpkgs#man nixpkgs#man-db nixpkgs#qemu nixpkgs#stdenv --command qemu-kvm'


nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix shell nixpkgs#xorg.xclock --command xclock'

sudo chown --recursive pedroregispoar:pedroregispoargroup /tmp/.X11-unix

#nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix shell nixpkgs#wget nixpkgs#man nixpkgs#man-db nixpkgs#qemu nixpkgs#stdenv'

#nix-build custom-iso.nix

# https://www.reddit.com/r/NixOS/comments/ayvtt4/cannot_build_the_nixpkgs_manual/
#nix build --file '<nixpkgs/doc>' -I nixpkgs=channel:nixos-unstable
#nix-build '<nixpkgs/nixos/release.nix>' -A manual.x86_64-linux


podman \
run \
--interactive \
--net=host \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
ubuntu:20.04 \
bash -c 'apt-get update && apt-get install -y hello && hello'



sudo apt-get update \
&& apt-get install -y apt-transport-https \
&& curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - \
&& echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" >> /etc/apt/sources.list.d/kubernetes.list \
&& apt-get update \
&& apt-get install -y kubelet kubeadm kubectl





. /etc/os-release \
&& echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list \
&& curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key | sudo apt-key add - \
&& sudo apt-get update \
&& sudo apt-get -y upgrade \
&& sudo apt-get -y install podman

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb

sudo dpkg -i minikube_latest_amd64.deb

minikube start --driver=podman --container-runtime=cri-o --alsologtostderr -v=7

minikube kubectl -- get pods -A



# # TODO
#nix build --file custom-iso.nix -I nixpkgs=channel:nixos-unstable
#
#qemu-kvm -cdrom result/iso/nixos.iso


#nixos-generate-config --dir "$(pwd)" --no-filesystems
#
#echo '*.iso' >> '.gitignore'
#git init
#git add .
#nix flake init
#
#nix build --file configuration.nix -I nixpkgs=channel:nixos-unstable