# First

```
#!/usr/bin/env bash
git clone https://github.com/GNU-ES/GNU-Nix-ES.git \
&& cd GNU-Nix-ES \
&& git checkout 71fa5cce30f540890fb267cd0a2b61952d3af17a \
&& cd src/broken/to-test-ci \
&& cd ex4-flake-python \
&& ./run.sh
```

If you already have cloned, run the script:
`./run.sh`


## Play around

If it works play in the interactive mode


## Docker

Just open an terminal, if you have docker installed, run:

```
docker build --tag pedroregispoar/flake . \
&& docker run \
--interactive \
--tty \
--rm \
pedroregispoar/flake
```

`nix profile install nixpkgs#python3 && python --version`

It should look like this output:
```
[nix-shell:/]# nix profile install nixpkgs#python3 && python --version
Python 3.8.5

[nix-shell:/]# 
```


Note: to not have to use `--experimental-features 'nix-command flakes ca-references'` 
the creation of `~/.config/nix/nix.conf` in the `Dockerfile`.

WIP:
`nix profile install github:NixOS/nixpkgs/master#python3`

`nix profile install .`

`nix develop`


### Install Docker

If you want to install [Docker](https://www.docker.com/) you can follow the official instructions to install [docker-ce](https://docs.docker.com/engine/install/).

And for completeness here is the docker version that was used:
```
docker --version
Docker version 19.03.12, build v19.03.12
```
