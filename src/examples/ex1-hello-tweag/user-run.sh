#!/usr/bin/env bash
git clone https://github.com/GNU-ES/GNU-Nix-ES.git \
&& cd GNU-Nix-ES \
&& git checkout REVISION \
&& cd src/examples/ex1-hello-tweag \
&& ./run.sh



#sudo apt-get update -y \
#sudo apt-get install -y \
#curl \
#&& curl cfgcfg