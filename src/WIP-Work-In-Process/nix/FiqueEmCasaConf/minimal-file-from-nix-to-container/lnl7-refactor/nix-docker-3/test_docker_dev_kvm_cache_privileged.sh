#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail


IMAGE="gnu-nix-es/$(git rev-parse --short HEAD)"
VERSION=0.0.1

NIX_BASE_IMAGE='nix-base:0.0.1'

NIX_CACHE_VOLUME='nix-cache-volume'

# Burn cache, as it may make you waste a lot of time!
docker ps --all --quiet | xargs --no-run-if-empty docker stop --time=0 \
&& docker ps --all --quiet | xargs --no-run-if-empty docker rm --force \
&& docker volume rm --force "$NIX_CACHE_VOLUME"

nix-build --attr image

docker load < ./result

docker \
run \
--cap-add SYS_ADMIN \
--device=/dev/kvm \
--interactive \
--mount source="$NIX_CACHE_VOLUME",target=/nix \
--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.cache/ \
--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.config/nix/ \
--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.nix-defexpr/ \
--privileged=true \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
--volume /sys/fs/cgroup/:/sys/fs/cgroup:ro \
"$NIX_BASE_IMAGE" bash -c "./flake_requirements.sh && sudo --preserve-env nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix flake show github:GNU-ES/hello'"

docker \
run \
--cap-add SYS_ADMIN \
--device=/dev/kvm \
--interactive \
--mount source="$NIX_CACHE_VOLUME",target=/nix \
--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.cache/ \
--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.config/nix/ \
--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.nix-defexpr/ \
--privileged=true \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
--volume /sys/fs/cgroup/:/sys/fs/cgroup:ro \
"$NIX_BASE_IMAGE" bash -c "sudo --preserve-env nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix flake show github:GNU-ES/hello'"


#SHA_SYSTEMD_CONTAINER="$(docker run \
#--cap-add SYS_ADMIN \
#--detach=true \
#--device=/dev/kvm \
#--interactive \
#--mount source="$NIX_CACHE_VOLUME",target=/nix \
#--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.cache/ \
#--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.config/nix/ \
#--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.nix-defexpr/ \
#--privileged=true \
#--tty \
#--workdir /code \
#--volume "$(pwd)":/code \
#--volume /sys/fs/cgroup/:/sys/fs/cgroup:ro \
#"$NIX_BASE_IMAGE" bash -c 'sudo --preserve-env /nix/var/nix/profiles/default/bin/init')"


#docker run \
#--interactive \
#--tty \
#--detach=true \
#--privileged=true \
#--name systemd_websrv
#centos:latest /usr/sbin/init
#
#docker exec \
#--interactive \
#--tty \
#systemd_websrv \
#bash -c 'systemctl status'

#docker exec \
#--interactive \
#--tty \
#"$SHA_SYSTEMD_CONTAINER" \
#bash -c 'systemctl status'

#nix-base:0.0.1 bash -c 'nix-env --install --attr nixpkgs.systemd && systemctl --version'

docker \
run \
--cap-add SYS_ADMIN \
--device=/dev/kvm \
--interactive \
--mount source="$NIX_CACHE_VOLUME",target=/nix \
--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.cache/ \
--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.config/nix/ \
--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.nix-defexpr/ \
--privileged=true \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
--volume /sys/fs/cgroup/:/sys/fs/cgroup:ro \
"$NIX_BASE_IMAGE" bash -c "sudo --preserve-env nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix flake show github:GNU-ES/hello'"


#docker \
# run \
#--cap-add SYS_ADMIN \
#--device=/dev/kvm \
#--interactive \
#--mount source="$NIX_CACHE_VOLUME",target=/nix \
#--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.cache/ \
#--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.config/nix/ \
#--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.nix-defexpr/ \
#--privileged=true \
#--tty \
#--rm \
#--workdir /code \
#--volume "$(pwd)":/code \
#--volume /sys/fs/cgroup/:/sys/fs/cgroup:ro \
#"$NIX_BASE_IMAGE" bash -c "sudo --preserve-env nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix shell nixpkgs#nixos-shell nixpkgs#git nixpkgs#man nixpkgs#man-db'"


#docker \
# run \
#--cap-add SYS_ADMIN \
#--device=/dev/kvm \
#--interactive \
#--mount source="$NIX_CACHE_VOLUME",target=/nix \
#--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.cache/ \
#--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.config/nix/ \
#--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.nix-defexpr/ \
#--privileged=true \
#--tty \
#--rm \
#--workdir /code \
#--volume "$(pwd)":/code \
#--volume /sys/fs/cgroup/:/sys/fs/cgroup:ro \
#"$NIX_BASE_IMAGE" bash -c "sudo --preserve-env nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes"
#
#nix shell nixpkgs#rustc \
#nixpkgs#python39 \
#nixpkgs#julia \
#nixpkgs#nodejs \
#nixpkgs#nixos-shell \
#nixpkgs#git \
#nixpkgs#man \
#nixpkgs#man-db \
#nixpkgs#poetry \
#nixpkgs#lorri \
#nixpkgs#direnv \
#


#nixpkgs#poetry2nix \
#nixpkgs#npm2nix \


#git clone https://github.com/Mic92/nixos-shell.git \
#&& cd nixos-shell/examples \
#&& nixos-shell
