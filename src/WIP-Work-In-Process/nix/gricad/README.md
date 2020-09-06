##


`docker build --tag pedroregispoar/nixos/chapter-1 .`

```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--volume "$(pwd)":/nix \
--workdir /code \
pedroregispoar/nixos/chapter-1
```

