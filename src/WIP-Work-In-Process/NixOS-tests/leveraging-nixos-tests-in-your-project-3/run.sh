#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


docker run \
--interactive \
--privileged \
--tty \
--rm \
nixos/nix:latest
"nix-env --install --attr nixpkgs.git \
&& git clone https://github.com/GNU-ES/GNU-Nix-ES.git \
&& cd GNU-Nix-ES \
&& git checkout d3a8d430e6c4de04e94398c2b795af0eab715e47 \
&& cd src/WIP-Work-In-Process/NixOS-tests/leveraging-nixos-tests-in-your-project-3 \
&& nix-build"
```
