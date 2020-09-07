##

[Managing build environments](https://nixos.org/nix/manual/#idm140737322627280)


`docker build --tag pedroregispoar/nixos/hello .`

```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
pedroregispoar/nixos/hello
```


`nix-shell '<nixpkgs>' --attr hello`

```
[nix-shell]$ tar xf $src
[nix-shell]$ cd hello
[nix-shell]$ ./configure
[nix-shell]$ make
[nix-shell]$ ./hello
```



[](https://stackoverflow.com/questions/48470942/how-to-build-nix-hello-world)

[](https://github.com/NixOS/nix/issues/2259)
