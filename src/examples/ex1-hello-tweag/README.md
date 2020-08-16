#

If you want to run the `flake` hello world that [Eelco Dolstra](https://edolstra.github.io/) 
(the creator of NixOS [ ["technically"](https://www.youtube.com/embed/fsgYVi2PQr0?start=102&end=127&version=3) the 
creator was [Armijn Hemel](https://github.com/armijnhemel/) ]) have wrote 
[Nix Flakes, Part 1: An introduction and tutorial](https://www.tweag.io/blog/2020-05-25-flakes/) using:
- Docker
- ??


## Docker

Just open an terminal, if you have docker installed, run:

```
docker run \
--interactive \
--tty \
--rm \
lnl7/nix:2.3.6 bash \
-c 'nix-env --install --attr nixpkgs.commonsCompress nixpkgs.gnutar nixpkgs.lzma.bin nixpkgs.git \
 && git clone --depth=1 https://github.com/GNU-ES/hello.git \
 && cd "$(basename "$_" .git)" \
 && git checkout 26c2bdaddbd0fdfb5c6a36b0d76a09a8cff691a5 \
 && nix-shell -I nixpkgs=channel:nixos-20.03 --packages nixFlakes'
```

When it is finished run:

`nix --experimental-features 'nix-command flakes' shell github:GNU-ES/hello --command hello`

It should look like this output:
```
[nix-shell:/hello]# nix --experimental-features 'nix-command flakes' shell github:edolstra/hello --command hello
...
Hello World
```

And that is it, it should have worked!


### Install Docker

If you want to install [Docker](https://www.docker.com/) you can follow the official instructions to install [docker-ce](https://docs.docker.com/engine/install/).

And for completeness here is the docker version that was used:
```
docker --version
Docker version 19.03.12, build v19.03.12
```

## Links and sources


[Using experimental Nix features in Nixos, and when they will land in stable](https://discourse.nixos.org/t/using-experimental-nix-features-in-nixos-and-when-they-will-land-in-stable/7401)

cd "$(basename "$_" .git)", [source](https://stackoverflow.com/a/59392290)

[Nix Flakes, Part 1: An introduction and tutorial](https://www.tweag.io/blog/2020-05-25-flakes/)