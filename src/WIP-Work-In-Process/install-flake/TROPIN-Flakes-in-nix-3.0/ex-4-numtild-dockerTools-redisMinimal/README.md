


docker run --interactive --net=host --tty --rm --workdir /code --volume "$(pwd)":/code ubuntu:20.04 bash

apt-get update

apt-get install -y redis-server

redis-server --version

ldd $(which redis-server)

TODO: combine ldd $(which id) with a `find` to do a the recursion part.
User this to build a image of the closure of the minimal iso with red nodes
of packages that still not pure. 

TODO: create a patch and version it, but apply it inside the repository 
created in this folder to show that it works.



# Links that may help


[danbst trying to fix siege](https://github.com/NixOS/nixpkgs/issues/15011#issuecomment-215151047)

```
{pkgs}:
let openssl_wr = pkgs.symlinkJoin "openssl-dev-out" (with pkgs; [ openssl.dev openssl.out ]);
in
{
  packageOverrides = pkgs_: with pkgs_; {
    siege_s = siege.overrideDerivation (super: rec {
      configureFlags = [ "--with-ssl=${openssl_wr}" ];
    });
  };
}
```


```
configureFlags = [
  "--with-ssl=${openssl.dev}"
  "--with-zlib=${zlib.dev}"
];
```
[NixOS/nixpkgs siege](https://github.com/NixOS/nixpkgs/blob/master/pkgs/tools/networking/siege/default.nix#L19-L22)


[redis NixOS/nixpkgs](https://github.com/NixOS/nixpkgs/blob/nixos-20.09/pkgs/servers/nosql/redis/default.nix#L38)

[How to link openssl statically](https://users.rust-lang.org/t/how-to-link-openssl-statically/14912)


[openssl_1_0_2](https://github.com/NixOS/nixpkgs/issues/76925#issuecomment-571451340)


[OPENSSL_INCLUDE_DIR = "${openssl.out.dev}/include";](https://github.com/nix-community/todomvc-nix/blob/1c8e52c4861a8fe1c550bbd0d012df1b9e5d553b/devshell.nix#L78)


Maybe usefull to troubleshoot:
patchelf --print-needed something
[Extra Dynamic Libraries](https://nixos.wiki/wiki/Packaging/Binaries)
