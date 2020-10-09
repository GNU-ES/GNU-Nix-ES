#!/bin/bash
declare -i FOOBAR=12;
echo $FOOBAR;

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
nix shell github:GNU-ES/hello -c hello