##


[libspatialindex](https://github.com/libspatialindex/libspatialindex/issues)


[libspatialindex](https://nixos.org/nixos/packages.html?channel=nixos-20.03&query=libspatialindex)



https://github.com/NixOS/nixpkgs/blob/741406a7282eb27f668d14012a94f94f464ceb7e/pkgs/development/libraries/libspatialindex/default.nix


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