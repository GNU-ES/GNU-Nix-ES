


From https://nixos.mayflower.consulting/blog/2019/07/11/leveraging-nixos-tests-in-your-project/
and from https://github.com/mayflower/goldenbook


```
docker run \
--interactive \
--privileged \
--tty \
--rm \
nixos/nix:latest nix-env --install --attr nixpkgs.git \
&& git clone https://github.com/GNU-ES/GNU-Nix-ES.git \
&& cd GNU-Nix-ES \
&& git checkout fdf3266e3aedebded87ff6c44ca245026bca558c \
&& cd src/WIP-Work-In-Process/NixOS-tests/leveraging-nixos-tests-in-your-project-3 \
&& ./run.sh
```
