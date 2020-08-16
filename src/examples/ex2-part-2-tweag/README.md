#


[Nix Flakes, Part 2: Evaluation caching](https://www.tweag.io/blog/2020-06-25-eval-cache/) using:


## Docker

Just open an terminal, if you have docker installed, run:

```
docker run \
--interactive \
--tty \
--rm \
lnl7/nix:2.3.6 bash \
-c 'nix-env --install --attr nixpkgs.commonsCompress nixpkgs.gnutar nixpkgs.lzma.bin nixpkgs.git \
 && nix-shell -I nixpkgs=channel:nixos-20.03 --packages nixFlakes'
```

### Install Docker

If you want to install [Docker](https://www.docker.com/) you can follow the official instructions to install [docker-ce](https://docs.docker.com/engine/install/).

And for completeness here is the docker version that was used:
```
docker --version
Docker version 19.03.12, build v19.03.12
```

## Links and sources


cd "$(basename "$_" .git)", [source](https://stackoverflow.com/a/59392290)

[Nix Flakes, Part 1: An introduction and tutorial](https://www.tweag.io/blog/2020-05-25-flakes/)