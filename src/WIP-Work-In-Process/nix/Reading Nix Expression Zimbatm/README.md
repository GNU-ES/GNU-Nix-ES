##

[Managing build environments](https://nixos.org/nix/manual/#idm140737322627280)


[Reading Nix Expression Zimbatm](https://www.youtube.com/watch?v=61MuMY9XFNo)

`docker build --tag pedroregispoar/nixos/pan .`

```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
pedroregispoar/nixos/pan
```
