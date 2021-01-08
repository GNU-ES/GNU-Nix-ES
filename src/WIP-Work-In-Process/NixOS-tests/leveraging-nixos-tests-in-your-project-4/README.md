


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


https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.454.1861&rep=rep1&type=pdf

TODO: write a test for this!
https://discourse.nixos.org/t/dockertools-buildimage-and-user-writable-tmp/5397/8


https://github.com/NixOS/nixpkgs/blob/f99b6369b1fe48759e7c40fdf18bc5281f2dd24a/nixos/tests/docker.nix
