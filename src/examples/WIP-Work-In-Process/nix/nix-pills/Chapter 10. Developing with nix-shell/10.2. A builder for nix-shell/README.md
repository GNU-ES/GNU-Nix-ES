##

[Chapter 10. Developing with nix-shell](https://nixos.org/nixos/nix-pills/developing-with-nix-shell.html)


`docker build --tag pedroregispoar/nixos/nix-pills .`

```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
pedroregispoar/nixos/nix-pills
```

