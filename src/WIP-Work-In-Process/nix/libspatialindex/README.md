##


[libspatialindex](https://github.com/libspatialindex/libspatialindex/issues)


[libspatialindex](https://nixos.org/nixos/packages.html?channel=nixos-20.03&query=libspatialindex)



https://github.com/NixOS/nixpkgs/blob/84cf00f98031e93f389f1eb93c4a7374a33cc0a9/pkgs/development/libraries/libspatialindex/default.nix


`docker build --tag pedroregispoar/nixos/libspatialindex .`


```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
pedroregispoar/nixos/libspatialindex
```

```
9eb502216d3b:/code# nix-build libspatialindex.nix
...
9eb502216d3b:/code# ls
```