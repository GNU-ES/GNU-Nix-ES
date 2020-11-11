##


[libspatialindex](https://github.com/libspatialindex/libspatialindex/issues)


[libspatialindex](https://nixos.org/nixos/packages.html?channel=nixos-20.03&query=libspatialindex)



https://github.com/NixOS/nixpkgs/blob/a674302cf85f80ff9b7368c25ccd8f61d8205cca/pkgs/development/libraries/libspatialindex/default.nix


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


app = pkgs.poetry2nix.mkPoetryApplication {
  projectDir = ./.;
  propagatedBuildInputs = externalDeps;
};
https://github.com/abcdw/tgytdl/blob/0f88206389a2d6392e728ed59e55bbded532ec21/flake.nix#L13