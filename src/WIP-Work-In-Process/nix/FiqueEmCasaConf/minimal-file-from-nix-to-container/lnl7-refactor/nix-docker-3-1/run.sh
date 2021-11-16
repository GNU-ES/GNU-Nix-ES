#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail


IMAGE="gnu-nix-es/$(git rev-parse --short HEAD)"
VERSION=0.0.1

IMAGE_VERSION="$IMAGE":"$VERSION"


nix-build --attr image

docker load < ./result

docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
nix-base:0.0.1 bash -c "sudo ls -al && id"


docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
nix-base:0.0.1 bash -c 'sudo su -c 'env''


docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
nix-base:0.0.1 bash -c 'sudo --preserve-env su -c 'env''


docker build --tag "$IMAGE_VERSION" .


docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
"$IMAGE_VERSION" bash -c 'sudo ls -al'



docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
"$IMAGE_VERSION" bash -c 'sudo --preserve-env nix-env --file "<nixpkgs>" --install --attr hello --show-trace && hello'


docker run \
--interactive \
--privileged \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
"$IMAGE_VERSION" bash -c 'sudo --preserve-env nix-build --attr image && stat result && sudo chown --recursive --verbose pedroregispoar:pedroregispoar result && stat result && cp --no-dereference --recursive --verbose $(nix-store --query --requisites result) result2'


docker load < ./result2

docker build --tag "$IMAGE_VERSION" .


docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
"$IMAGE_VERSION" bash -c 'sudo ls -al'



docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
"$IMAGE_VERSION" bash -c './test_nixos.iso_minimal.x86_64-linux.sh'


docker run \
--interactive \
--privileged \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
"$IMAGE_VERSION" bash -c './test_flake.sh'


#docker run \
#--interactive \
#--privileged \
#--tty \
#--rm \
#--workdir /code \
#--volume "$(pwd)":/code \
#"$IMAGE_VERSION" bash -c 'NIXOS_CONFIG="$(pwd)"/configuration.nix sudo --preserve-env nix-build "<nixpkgs/nixos>" --attr vm --verbose --show-trace'
##"$IMAGE_VERSION" bash -c 'sudo --preserve-env nix-build "<nixpkgs/nixos>" --attr vm --arg configuration ./configuration.nix --show-trace'


#docker run \
#--interactive \
#--privileged \
#--tty \
#--rm \
#--workdir /code \
#--volume "$(pwd)":/code \
#--volume '/nix/store':'/nix/store' \
#nix-base:0.0.1 bash


podman \
run \
--env=PATH=/root/.nix-profile/bin:/usr/bin:/bin \
--device=/dev/kvm \
--device=/dev/fuse \
--env="DISPLAY=${DISPLAY:-:0.0}" \
--interactive=true \
--log-level=error \
--network=host \
--privileged=true \
--tty=true \
--rm=true \
--userns=host \
--user=0 \
--volume=/sys/fs/cgroup:/sys/fs/cgroup:rw \
docker.nix-community.org/nixpkgs/nix-flakes


podman \
run \
--device=/dev/kvm \
--device=/dev/fuse \
--env="DISPLAY=${DISPLAY:-:0.0}" \
--interactive=true \
--log-level=error \
--network=host \
--mount=type=tmpfs,destination=/var/lib/containers \
--privileged=true \
--tty=true \
--rm=true \
--userns=host \
--user=0 \
--volume=/etc/localtime:/etc/localtime:ro \
--volume=/sys/fs/cgroup:/sys/fs/cgroup:rw \
--volume=/tmp/.X11-unix:/tmp/.X11-unix:ro \
localhost/nix-flake-nested-qemu-kvm-vm

podman \
run \
--device=/dev/kvm \
--device=/dev/fuse \
--env="DISPLAY=${DISPLAY:-:0.0}" \
--interactive=true \
--log-level=error \
--network=host \
--mount=type=tmpfs,destination=/var/lib/containers \
--privileged=true \
--tty=true \
--rm=true \
--userns=host \
--user=0 \
--volume=/sys/fs/cgroup:/sys/fs/cgroup:rw \
docker.nix-community.org/nixpkgs/nix-flakes


podman \
run \
--env=PATH=/root/.nix-profile/bin:/usr/bin:/bin \
--events-backend=file \
--device=/dev/kvm \
--device=/dev/fuse \
--env="DISPLAY=${DISPLAY:-:0.0}" \
--interactive=true \
--log-level=error \
--network=host \
--mount=type=tmpfs,destination=/var/lib/containers \
--privileged=true \
--tty=false \
--rm=true \
--user=0 \
--volume=/etc/localtime:/etc/localtime:ro \
--volume=/sys/fs/cgroup:/sys/fs/cgroup:ro \
--volume=/tmp/.X11-unix:/tmp/.X11-unix:ro \
docker.nix-community.org/nixpkgs/nix-flakes \
<<COMMANDS
mkdir --parent --mode=755 ~/.config/nix
echo 'experimental-features = nix-command flakes ca-references ca-derivations' >> ~/.config/nix/nix.conf
nix \
profile \
install \
github:ES-Nix/podman-rootless/from-nixpkgs \
&& mkdir -p -m 0755 /var/tmp \
&& podman \
run \
--cgroups=disabled \
--env=PATH=/root/.nix-profile/bin:/usr/bin:/bin \
--events-backend=file \
--env="DISPLAY=${DISPLAY:-:0.0}" \
--interactive=true \
--log-level=error \
--network=host \
--privileged=true \
--tty=false \
--rm=true \
--user=0 \
--volume=/sys/fs/cgroup:/sys/fs/cgroup:rw \
docker.nix-community.org/nixpkgs/nix-flakes \
<<COMMANDSNESTED
mkdir --parent --mode=0755 ~/.config/nix
echo 'experimental-features = nix-command flakes ca-references ca-derivations' >> ~/.config/nix/nix.conf
nix \
profile \
install \
github:ES-Nix/podman-rootless/from-nixpkgs \
&& mkdir --parent --mode=0755 /var/tmp \
&& podman \
run \
--events-backend=file \
--storage-driver="vfs" \
--cgroups=disabled \
--log-level=error \
--interactive=true \
--network=host \
--tty=true \
docker.io/library/alpine:3.14.0 \
sh \
-c 'apk add --no-cache curl && echo PinPinP'
COMMANDSNESTED
COMMANDS

podman \
run \
--device=/dev/kvm \
--device=/dev/fuse \
--env="DISPLAY=${DISPLAY:-:0.0}" \
--env="PATH=/root/.nix-profile/bin:/usr/bin:/bin" \
--events-backend="file" \
--interactive=true \
--log-level=error \
--network=host \
--mount=type=tmpfs,destination=/var/lib/containers \
--privileged=true \
--tty=true \
--rm=true \
--user=0 \
--volume=/etc/localtime:/etc/localtime:ro \
--volume=/sys/fs/cgroup:/sys/fs/cgroup:ro \
--volume=/tmp/.X11-unix:/tmp/.X11-unix:ro \
docker.nix-community.org/nixpkgs/nix-flakes


mkdir --parent --mode=0755 ~/.config/nix
echo 'experimental-features = nix-command flakes ca-references ca-derivations' >> ~/.config/nix/nix.conf
nix \
profile \
install \
github:ES-Nix/podman-rootless/from-nixpkgs \
&& mkdir --parent --mode=0755 /var/tmp

podman \
run \
--cgroups=disabled \
--device=/dev/kvm \
--device=/dev/fuse \
--env=PATH=/root/.nix-profile/bin:/usr/bin:/bin \
--env="DISPLAY=${DISPLAY:-:0.0}" \
--events-backend=file \
--interactive=true \
--log-level=error \
--network=host \
--privileged=true \
--rm=true \
--storage-driver="vfs" \
--tty=true \
--user=0 \
--volume=/sys/fs/cgroup:/sys/fs/cgroup:rw \
docker.nix-community.org/nixpkgs/nix-flakes


mkdir --parent --mode=0755 ~/.config/containers

echo '[storage]' >> ~/.config/containers/storage.conf
echo 'driver = "overlay"' >> ~/.config/containers/storage.conf

echo '[storage.options]' >> ~/.config/containers/storage.conf
echo 'mount_program = '"$(nix eval --raw nixpkgs#fuse-overlayfs)"'/bin/fuse-overlayfs' >> ~/.config/containers/storage.conf


nix profile install nixpkgs#fuse-overlayfs

podman \
run \
--device=/dev/fuse \
--log-level=error \
--interactive=true \
--storage-driver=overlay \
--storage-opt="overlay.mount_program=$(nix eval --raw nixpkgs#fuse-overlayfs)'/bin/fuse-overlayfs'" \
--tty=true \
docker.io/library/alpine:3.14.0 \
sh

