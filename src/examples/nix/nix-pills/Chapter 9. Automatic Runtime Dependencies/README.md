##

[Add manylinux support](https://github.com/nix-community/poetry2nix/pull/18)

[Support manylinux wheels](https://github.com/nix-community/poetry2nix/issues/5)

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

nix-instantiate hello.nix


nix-store --query --references /nix/store/kcp96zwp3ygcb4h1115jb90x4cj93jzy-hello.drv



nix-store --realise /nix/store/kcp96zwp3ygcb4h1115jb90x4cj93jzy-hello.drv



nix-store --query --references /nix/store/kcp96zwp3ygcb4h1115jb90x4cj93jzy-hello.drv