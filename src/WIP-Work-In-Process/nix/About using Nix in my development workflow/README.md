##

[About using Nix in my development workflow](https://medium.com/@ejpcmac/about-using-nix-in-my-development-workflow-12422a1f2f4c)

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

    