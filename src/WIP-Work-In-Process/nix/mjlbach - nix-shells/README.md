##

[]()


`docker build --tag  .`

```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
nixos/nix:2.3.4
```

e6105e8552eb:/code/gibson_v2# mkdir --parents ~/.config/nixpkgs/
e6105e8552eb:/code/gibson_v2# echo '{ allowUnfree = true; }' >> ~/.config/nixpkgs/config.nix
e6105e8552eb:/code/gibson_v2# nix-shell
