

https://github.com/NixOS/nixpkgs/blob/2d50c7c08e4833f49eb5e2e9c783e631bb7eaccf/pkgs/build-support/docker/default.nix#L50-L51

[Run command as root in nix?](https://github.com/NixOS/nix/issues/1436)


[Can't execute setuid binaries in Nix 1.11.10+](https://github.com/NixOS/nix/issues/1429)
nix-build -E 'with import <nixpkgs> {}; runCommand "test" {} "/run/wrappers/bin/sudo echo hello"'
