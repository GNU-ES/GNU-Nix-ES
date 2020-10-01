
su "$INPUTED_USER_OR_DEFAULT" -c 'home/GNU-Nix-ES/.nix-profile/bin/nix-shell -I nixpkgs=channel:nixos-20.03 --packages nixFlakes'

## Docker

Just open an terminal, if you have git and Docker installed, and run:

```
apt-get update \
&& apt-get install -y git \
&& git clone https://github.com/GNU-ES/GNU-Nix-ES.git \
&& cd GNU-Nix-ES \
&& git checkout 32c705ab18a6b9cc2b0b585f4aeb3731200c273b \
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

```
docker run \
--interactive \
--rm \
--tty \
ubuntu:20.04 \
bash -c "apt-get update \
&& apt-get install -y git \
&& git clone https://github.com/GNU-ES/GNU-Nix-ES.git \
&& cd GNU-Nix-ES \
&& git checkout 7d544bc4c931f49ef0a2ae0e6aaeeb1532ee6e2d \
&& cd src/install \
&& ./run.sh"
```

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


