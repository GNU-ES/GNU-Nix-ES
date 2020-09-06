##

[Using Nix as a build tool - Part 1](https://www.youtube.com/watch?v=ova4dZhzxAQ)

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

