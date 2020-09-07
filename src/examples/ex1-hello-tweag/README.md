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
git clone https://github.com/GNU-ES/GNU-Nix-ES.git \
&& cd GNU-Nix-ES \
&& git checkout 7e2be43e22149a2414d5f84212c0a28f6588f778 \
&& cd src/examples/ex1-hello-tweag \
&& ./run.sh \
&& ./end-mensage.sh
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

[Nix Flake MVP](https://gist.github.com/edolstra/40da6e3a4d4ee8fd019395365e0772e7#nixos-system-configuration) by gist Eelco Dolstra.

[Flake support #68897](https://github.com/NixOS/nixpkgs/pull/68897), the PR by Eelco Dolstra that created `flake`.

[Building nixos system with nix build and a channel specifier](https://discourse.nixos.org/t/building-nixos-system-with-nix-build-and-a-channel-specifier/4747/2)

[NixOS system configurations should be stored as flakes in (local) Git repositories](https://gist.github.com/edolstra/40da6e3a4d4ee8fd019395365e0772e7#nixos-system-configuration)

[Using experimental Nix features in Nixos, and when they will land in stable](https://discourse.nixos.org/t/using-experimental-nix-features-in-nixos-and-when-they-will-land-in-stable/7401)

Not sure if it is worth watch:
[NixOS Office Hours, 2020-02-21](https://youtu.be/FKpeI8U8-AE?t=155), Streamed live on Feb 21, 2020 about "Today, we are discussing some recent changes related to Flakes in Nix, Nixpkgs, and Hydra."

cd "$(basename "$_" .git)", [source](https://stackoverflow.com/a/59392290)

[Nix Flakes, Part 1: An introduction and tutorial](https://www.tweag.io/blog/2020-05-25-flakes/)


Has an example of "f90wrap" 
[A Tutorial Introduction to Nix](https://www.reddit.com/r/NixOS/comments/icyekr/a_tutorial_introduction_to_nix_rohit_goswami/g299qzk/)


[wiki.nikitavoloboev](https://wiki.nikitavoloboev.xyz/package-managers/nix)


[TROPIN youtube play list](https://www.youtube.com/watch?v=1ZV_47O9_Z8&list=PLZmotIJq3yOJab8-of7gMYrXkZyAjWPOw)



[Let’s nudge for goreleaser nix flakes support](https://discourse.nixos.org/t/lets-nudge-for-goreleaser-nix-flakes-support/8186/7)

[Issue: Understanding Flakes](https://github.com/nrdxp/nixflk/issues/19)

[Nix Flakes installer](https://github.com/numtide/nix-flakes-installer)


[nixos wiki](https://nixos.wiki/wiki/Flakes)


[How to use Nix Flakes system wide](https://gist.github.com/suhr/4bb1f8434d0622588b23f9fe13e79973)
   nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };


flake.nix

{
  outputs = { self, nixpkgs }: {
     # replace 'pedro' with your hostname here.
     nixosConfigurations.pedro = nixpkgs.lib.nixosSystem {
       system = "x86_64-linux";
       modules = [ ./configuration.nix ];
     }
  };
}