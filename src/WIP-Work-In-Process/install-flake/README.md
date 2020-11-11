

Ideia: use `ONBUILD RUN` for entrypoint.

[Nix Installation Guide](https://nixos.wiki/wiki/Nix_Installation_Guide)

[Install Nix in multi-user mode on non-NixOS](https://nixos.wiki/wiki/Install_Nix_in_multi-user_mode_on_non-NixOS)


[This is how I currently got Nix installed on OSX:](https://github.com/NixOS/nix/issues/697)



[Docker image nixos/nix](https://hub.docker.com/r/nixos/nix/dockerfile)

the workaround I have seen is to (simplified):

    create a temporary user with sudo access
    install nix under that user
    delete the user
    configure the root account with the nix profile
[source](https://www.gitmemory.com/issue/NixOS/nix/1559/531690854)



[Think of the ONBUILD command as an instruction the parent Dockerfile gives to the child Dockerfile.](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#onbuild)

## On Alpine


# On NixOS


nix --version

sudo nix-channel --list

sudo nixos-rebuild switch --show-trace

sudo nixos-rebuild switch --no-write-lock-file

nixos-rebuild --flake .#mymachine switch


sudo nix-channel --list
sudo nix-channel --add https://nixos.org/channels/nixos-20.09
sudo nix-channel --list

sudo nix-channel --add https://nixos.org/channels/nixos-20.03

nix-instantiate --eval --expr '(import <nixpkgs> {}).lib.version'

sudo nix-channel --remove nixos-20.09

NIX_PATH=nixos-config=/etc/nixos/configuration.nix:nixpkgs=channel:nixos-20.03 sudo nixos-rebuild switch



Works:

nix --version
nix (Nix) 2.3.6

sudo nix-channel --list
nixos https://nixos.org/channels/nixos-20.03
nixos-20.03 https://nixos.org/channels/nixos-20.03
nixpkgs https://nixos.org/channels/nixpkgs-unstable

nix-instantiate --eval --expr '(import <nixpkgs> {}).lib.version'
"20.03.3236.2257e6cf4d7"


## Trying to make flake work 

git log --pretty=oneline

sudo git checkout f0a3924b1d88ea569555944ba2df22afe575c9f7

cd /etc/nixos
nix flake update

git switch -

sudo git checkout d0c6577d81dd976b28b3b117ffe60eb32e8f0c47

nix flake update

sudo nix-channel --list
sudo nix-channel --add https://nixos.org/channels/nixos-20.09
sudo nix-channel --list

----

sudo nix-channel --list
nixos https://nixos.org/channels/nixos-unstable
nixos-20.03 https://nixos.org/channels/nixos-20.03
nixos-20.09 https://nixos.org/channels/nixos-20.09
nixpkgs https://nixos.org/channels/nixpkgs-unstable


After first step commit:
`sudo nixos-rebuild switch`

sudo mv _flake.nix flake.nix
sudo git add .
sudo git commit -m 'Add flake.nix'

nix --version

nix flake update


nix flake info nixpkgs

sudo nixos-rebuild switch --flake '.#' --no-write-lock-file


