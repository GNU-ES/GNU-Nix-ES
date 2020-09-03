##

[Chapter 8. Generic Builders](https://nixos.org/nixos/nix-pills/generic-builders.html)


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

1) 

```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
pedroregispoar/nixos/nix-pills
```


`# nix-build hello1.nix` 

To run what was built: `result/bin/hello`

```
43f98a96060a:/code# result/bin/hello
Hello, world!
``` 







[Pill 8 baseInputs vs buildInputs?](https://github.com/NixOS/nix-pills/issues/137)

[Chapter 8. Generic Builders. Builder script can't unpack tarball](https://github.com/NixOS/nix-pills/issues/87)


