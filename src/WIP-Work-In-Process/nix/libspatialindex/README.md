##


[libspatialindex](https://github.com/libspatialindex/libspatialindex/issues)


[libspatialindex](https://nixos.org/nixos/packages.html?channel=nixos-20.03&query=libspatialindex)



https://github.com/NixOS/nixpkgs/blob/b84a6f991d20e01c007beff7759bfcbd573071f8/pkgs/development/libraries/libspatialindex/default.nix


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