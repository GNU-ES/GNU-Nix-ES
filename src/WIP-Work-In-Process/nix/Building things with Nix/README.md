##

[Building things with Nix](https://qfpl.io/posts/nix/building-things-with-nix/)

`docker build --tag pedroregispoar/nixos/W .`

```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
pedroregispoar/nixos/W
```

    