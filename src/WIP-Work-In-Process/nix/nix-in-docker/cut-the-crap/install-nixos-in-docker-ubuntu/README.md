

##

[Intall NixOS on Ubuntu:20.04, Open source packaging cut-the-crap with nix](https://www.youtube.com/watch?v=fLQu8oF1rKA)

```
docker run \
 --interactive \
 --rm \
 --tty \
ubuntu:20.04 \
bash
```

`docker build --tag pedroregispoar/ubuntu20-04/nixos .`


Está quebrado!!

```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
pedroregispoar/ubuntu20-04/nixos
```
