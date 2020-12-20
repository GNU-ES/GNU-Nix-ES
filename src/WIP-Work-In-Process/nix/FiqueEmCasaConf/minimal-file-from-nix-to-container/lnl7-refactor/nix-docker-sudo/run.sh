#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail


IMAGE="gnu-nix-es/$(git rev-parse --short HEAD)"
VERSION=0.0.1

TARGET_0='builder'
TARGET_1='prod'

IMAGE_VERSION_TARGET_0="$IMAGE""$TARGET_0":"$VERSION"
IMAGE_VERSION_TARGET_1="$IMAGE""$TARGET_1":"$VERSION"


nix-build --attr image

docker load < ./result


#chmod 4511 --verbose $(readlink $(which sudo))
#&& chown pedroregispoar:wheel --verbose $(readlink $(which sudo)) \
#&& stat --dereference $(readlink $(which sudo)) \
#&& su pedroregispoar -c 'sudo ls'

#chown pedroregispoar:wheel --verbose /run/current-system/sw/bin/sudo \
#&& chown pedroregispoar:wheel --verbose $(readlink /run/current-system/sw/bin/sudo) \
#&& chmod 0755 --verbose /run/current-system/sw/bin/sudo

#docker run \
#--interactive \
#--tty \
#--rm \
#--workdir /code \
#--volume "$(pwd)":/code \
#nix-base:0.0.1 bash -c 'chmod 4511 /run/current-system/sw/bin/su && chmod 4511 /run/current-system/sw/bin/sudo &&  su pedroregispoar -c 'sudo ls''


docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
nix-base:0.0.1 bash -c 'cat /etc/passwd && echo && cat /etc/group'


docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
nix-base:0.0.1 bash -c 'stat --format="%a" /bin/sudo && echo && stat --format="%a" /sbin/sudo'


docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
nix-base:0.0.1 bash -c "nix-env --file '<nixpkgs>' --install --attr hello"
#nix-base:0.0.1 bash -c "nix-env --file '<nixpkgs>' --install --attr hello && hello"


docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
nix-base:0.0.1 bash -c "cd / && nix-store --init && nix-store --load-db < .reginfo && id && nix-env --file '<nixpkgs>' --install --attr hello && hello"

docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
nix-base:0.0.1 bash -c "cd / && nix-store --init && nix-store --load-db < .reginfo && su pedroregispoar -c '&& id && nix-env --file '<nixpkgs>' --install --attr hello && hello'"


docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
nix-base:0.0.1 bash -c 'ls -al $(readlink /root/.nix-defexpr/nixos)'


docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
nix-base:0.0.1 bash -c 'ls -al $(readlink /root/.nix-defexpr/nixpkgs)'


docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
nix-base:0.0.1 bash -c 'ls -al $(readlink /nix/var/nix/gcroots/booted-system)'


docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
nix-base:0.0.1 bash -c 'ls -al $(echo $(echo $NIX_PATH) | cut --delimiter='=' --field=2)'

docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
nix-base:0.0.1 bash -c 'su pedroregispoar -c 'id''


docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--user=pedroregispoar \
--volume "$(pwd)":/code \
nix-base:0.0.1 bash -c 'id'

docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
nix-base:0.0.1 bash -c 'nix-env --install --attr nixpkgs.hello && hello'

#docker run \
#--interactive \
#--tty \
#--rm \
#--workdir /code \
#--volume "$(pwd)":/code \
#nix-base:0.0.1 bash -c 'nix-env --file '<nixpkgs>' --install --attr hello && hello'


#docker run \
#--interactive \
#--tty \
#--rm \
#--workdir /code \
#--volume "$(pwd)":/code \
#nix-base:0.0.1 bash -c 'nix-env --install --attr nixpkgs.git'


#--volume '/nix:/nix:ro' \
#--user 'pedroregispoar' \

#bash -c 'stat --format="%a" /sbin/sudo'
#--user=pedroregispoar \




#docker run \
#--interactive \
#--tty \
#--rm \
#--workdir /code \
#--user='root' \
#--volume "$(pwd)":/code \
#gnu-nix-es:0.0.1 bash -c 'stat --format="%a" /nix/store/.links'
#
#
#docker run \
#--interactive \
#--tty \
#--rm \
#--workdir /code \
#--user='pedroregispoar' \
#--volume "$(pwd)":/code \
#gnu-nix-es:0.0.1 bash -c ' /nix/store/jbryisjscy1mrkfnk8zqgcqynxbvrhci-nix-2.3.6/bin/nix-env --install --attr nixpkgs.git'


# TODO: investigate about the nix-store --gc
#RUN nix-env --file '<nixpkgs>' --install --attr \
#    curl \
#    findutils \
#    git \
#    glibc \
#    gnugrep \
#    gnused \
#    gnutar \
#    gzip \
#    jq \
#    procps \
#    vim \
#    which \
#    xz \
# && nix-store --gc

# nix-store --init && nix-store --load-db < .reginfo
# nix-env --install --attr nixpkgs.git
# nix-env --file '<nixpkgs>' --install --attr git

#ls -al /nix/var/nix/gcroots
#ls -al /nix/var/nix/profiles/per-user/root
#ls -al /root/.nix-defexpr
#ls -al /var/empty

#ln --symbolic ${path} $out/nix/var/nix/gcroots/booted-system
#ln --symbolic $out/nix/var/nix/profiles/per-user/root/profile $out/root/.nix-profile
#ln --symbolic ${unstable} $out/root/.nix-defexpr/nixos
#ln --symbolic ${unstable} $out/root/.nix-defexpr/nixpkgs


#ls -al /nix/var/nix/gcroots
#ls -al /nix/var/nix/profiles/per-user/root
#ls -al /root/.nix-defexpr
#ls -al /var/empty
#
#
#ls -al /nix/var/nix/gcroots
#ls -al /nix/var/nix/profiles/per-user/root
#ls -al /"$HOME"/.nix-defexpr
#ls -al /var/empty
#
#ln --symbolic ${path} $out/nix/var/nix/gcroots/booted-system
#ln --symbolic $out/nix/var/nix/profiles/per-user/root/profile $out/root/.nix-profile
#ln --symbolic ${unstable} $out/root/.nix-defexpr/nixos
#ln --symbolic ${unstable} $out/root/.nix-defexpr/nixpkgs
