##


[Basic C Application with Nix/Nixpkgs](https://www.youtube.com/watch?v=LiEqN8r-BRw)



`docker build --tag pedroregispoar/nixos/hande-made-hello .`

```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
pedroregispoar/nixos/hande-made-hello
```


`nix-shell --packages gcc`


Porque entra no shell?
Porque seu eu sair do shell o gcc não é mais acessivél?


echo $NIX_PATH


`nix-shell --packages gcc`

`nix-build default.nix`


`realpath result`


`[nix-shell:/code]# ./result/bin/hello`


