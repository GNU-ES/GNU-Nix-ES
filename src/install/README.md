
su "$INPUTED_USER_OR_DEFAULT" -c 'home/GNU-Nix-ES/.nix-profile/bin/nix-shell -I nixpkgs=channel:nixos-20.03 --packages nixFlakes'

## Docker

Just open an terminal, if you have git and Docker installed, and run:

```
git clone https://github.com/GNU-ES/GNU-Nix-ES.git \
&& cd GNU-Nix-ES \
&& git checkout c6d8df53ed09b762472f1b7789e599cac2ef8809 \
&& cd src/install \
&& ./run.sh
```

```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
ubuntu:20.04 \
bash -c './run.sh'
```

docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
ubuntu:20.04 \
bash -c "./utils/install-using-apt.sh --testing=yes"


su GNU-Nix-ES
sudo curl -L https://nixos.org/nix/install | sh

IMAGE="gnu-nix-es/$(git rev-parse --short HEAD)"
VERSION=0.0.1
IMAGE_VERSION="$IMAGE":"$VERSION"

docker build \
--label org.opencontainers.image.created=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
--label org.opencontainers.image.revision=$(git rev-parse $(git rev-parse --short HEAD)) \
--tag \
"$IMAGE_VERSION" . \
&& docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
ubuntu:20.04 \
bash -c "./utils/install-using-apt.sh --testing=yes"

# TODO

Reproduce:
https://askubuntu.com/a/476489


In ubuntu:18.04
root@75d133644b97:/code# su "$INPUTED_USER_OR_DEFAULT" -c 'echo $HOME $USER '
/home/GNU-Nix-ES GNU-Nix-ES
root@75d133644b97:/code# su -p "$INPUTED_USER_OR_DEFAULT" -c 'echo $HOME $USER '
/root


# Refs


