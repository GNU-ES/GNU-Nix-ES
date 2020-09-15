# First

```
#!/usr/bin/env bash
git clone https://github.com/GNU-ES/GNU-Nix-ES.git \
&& cd GNU-Nix-ES \
&& git checkout 7984718b50a0572a0e42013cf44f1be561c3f1f0 \
&& cd src/broken/to-test-ci \
&& cd ex3-part-3-tweag \
&& ./run.sh
```

If you already have cloned, run the script:
`./run.sh`


## Play around

If it works play in the interactive mode


[Nix Flakes, Part 3: Managing NixOS systems](https://www.tweag.io/blog/2020-07-31-nixos-flakes/)


TODO: We must pin the nixpkgs version using flakes!
https://stackoverflow.com/questions/50242387/how-to-record-a-reproducible-profile-in-nix-especially-from-nix-env


## Docker

Just open an terminal, if you have docker installed, and run:

```
docker run \
--interactive \
--tty \
--rm \
lnl7/nix:2.3.6 bash \
-c 'nix-env --install --attr nixpkgs.commonsCompress nixpkgs.gnutar nixpkgs.lzma.bin nixpkgs.git \
 && nix-shell -I nixpkgs=channel:nixos-20.03 --packages nixFlakes'
```


```
git init my-flake \
&& cd $_ \
&& nix --experimental-features 'nix-command flakes' flake init -t templates#simpleContainer \
&& git config --global user.email "you@example.com" \
&& git config --global user.name "Your Name" \
&& git commit -a -m 'Initial version' \
&& nix build --experimental-features 'nix-command flakes' /my-flake#nixosConfigurations.container.config.system.build.toplevel \
&& ls result/
```

I don't know how to use `nixos-container` using Docker and only `Nix`. I really think that is is possible because of this
[Dejà vu: Updating NixOS local VMs ](http://blog.patapon.info/nixos-local-vm/), use `Ctrl + c` and search for this text 
`Building without nixos-rebuild`, and this 
[Eelco Dolstra (the creator of flake) comment](https://github.com/NixOS/nixpkgs/pull/68897#discussion_r377142616). 
Maybe use an Docker conteiner with `NixOS` would be usefull, for example, 
[https://hub.docker.com/r/nixos/nix/](https://hub.docker.com/r/nixos/nix/).


### Runing in NixOS


`nix-shell -I nixpkgs=channel:nixos-20.03 --packages nixFlakes`

```
git init my-flake \
&& cd $_ \
&& nix flake init -t templates#simpleContainer \
&& git commit -a -m 'Initial version' \
&& sudo nixos-container create flake-test --flake "$(pwd)" \
&& sudo nixos-container start flake-test \
&& curl http://flake-test/
```

And that is it, it should have worked!

Cleanig:
```
sudo nixos-container destroy flake-test \
&& cd .. \
&& sudo rm -rf my-flake .git
```


### Install Docker

If you want to install [Docker](https://www.docker.com/) you can follow the official instructions to install [docker-ce](https://docs.docker.com/engine/install/).

And for completeness here is the docker version that was used:
```
docker --version
Docker version 19.03.12, build v19.03.12
```

## Links and sources

[Nix Flake MVP by Eelco Dolstra](https://gist.github.com/edolstra/40da6e3a4d4ee8fd019395365e0772e7)


cd "$(basename "$_" .git)", [source](https://stackoverflow.com/a/59392290)

[Nix Flakes, Part 1: An introduction and tutorial](https://www.tweag.io/blog/2020-05-25-flakes/)