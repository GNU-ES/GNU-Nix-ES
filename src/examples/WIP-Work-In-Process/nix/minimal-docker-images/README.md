##


`docker build --tag pedroregispoar/nixos/nix:2.3.4 .`

```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
pedroregispoar/nixos/nix:2.3.4 
```

https://nixos.wiki/wiki/Docker

Impressionante
http://lethalman.blogspot.com/2016/04/cheap-docker-images-with-nix_15.html