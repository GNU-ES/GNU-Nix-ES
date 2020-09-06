##

[Creating the simplest Nix package humanly possible](https://www.youtube.com/watch?v=HklCUm0-ktE)

`docker build --tag pedroregispoar/nixos/image-package .`

```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
pedroregispoar/nixos/image-package
```



nix-prefetch-url --type sha256 https://raw.githubusercontent.com/PedroRegisPOAR/Teste-06-07-2016/mast
er/readme-images/github-octocat.png


nix-build



nix-env -iA nixpkgs.pkgs.python35

attr vem de attribute
nix-env --attr --install nixpkgs.pkgs.python38


Flags:
https://github.com/networkelements/NixOS/blob/master/man%20nix-env


nix-env -qaP python3

nix-env -aqP python3

nix-env --available --query --attr-path python3

nix-env --available --attr-path --query python3

nix-env --available --attr-path --query python3-3.9.0a4


nix-env --install python3-3.9.0a4


nix-env --available --query 'python3.*' | wc
