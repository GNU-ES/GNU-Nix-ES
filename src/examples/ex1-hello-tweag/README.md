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
 && git clone https://github.com/GNU-ES/hello.git \
 && cd "$(basename "$_" .git)" \
 && git checkout d1bdee43831d01108f9f580f32a0d6a4f3c0f01e \
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


[Eelco Dolstra: "The idea is that your NixOS system is itself a flake, so its flake.lock pins the exact version of Nixpkgs."](https://github.com/nixos/rfcs/pull/49#issuecomment-511756456)

[Nix Flake MVP](https://gist.github.com/edolstra/40da6e3a4d4ee8fd019395365e0772e7#nixos-system-configuration) by Eelco Dolstra.

[Flake support #68897](https://github.com/NixOS/nixpkgs/pull/68897), the PR by Eelco Dolstra that created `flake`.

[Building nixos system with nix build and a channel specifier](https://discourse.nixos.org/t/building-nixos-system-with-nix-build-and-a-channel-specifier/4747/2)

[NixOS system configurations should be stored as flakes in (local) Git repositories](https://gist.github.com/edolstra/40da6e3a4d4ee8fd019395365e0772e7#nixos-system-configuration)

[Using experimental Nix features in Nixos, and when they will land in stable](https://discourse.nixos.org/t/using-experimental-nix-features-in-nixos-and-when-they-will-land-in-stable/7401)

Not sure if it is worth watch:
[NixOS Office Hours, 2020-02-21](https://youtu.be/FKpeI8U8-AE?t=155), Streamed live on Feb 21, 2020 about "Today, we are discussing some recent changes related to Flakes in Nix, Nixpkgs, and Hydra."

cd "$(basename "$_" .git)", [source](https://stackoverflow.com/a/59392290)

[Nix Flakes, Part 1: An introduction and tutorial](https://www.tweag.io/blog/2020-05-25-flakes/)