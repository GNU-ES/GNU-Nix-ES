##


[bcc](https://nixos.wiki/wiki/Cheatsheet#Reuse_a_package_as_a_build_environment)


https://github.com/iovisor/bcc/issues/2261

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


nix-shell '<nixpkgs>' --attr libspatialindex
