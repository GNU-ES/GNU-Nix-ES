##

[Managing build environments](https://nixos.org/nix/manual/#idm140737322627280)


`docker build --tag pedroregispoar/nixos/pan .`

```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
pedroregispoar/nixos/pan
```


Por alguma razão o exemplo apresentado em [Managing build environments](https://nixos.org/nix/manual/#idm140737322627280) 
não funciona 

`nix-shell '<nixpkgs>' -A pan`

```
[nix-shell]$ tar xf $src
[nix-shell]$ cd pan-*
[nix-shell]$ ./configure
[nix-shell]$ make
[nix-shell]$ ./pan/gui/pan
```



Mas ao se usar nix-shell --help é possivel achar o mesmo exemplo, com comandos "parecidos":

EXAMPLES
       To build the dependencies of the package Pan, and start an interactive shell in which to build it:

           $ nix-shell '<nixpkgs>' -A pan
           [nix-shell]$ unpackPhase
           [nix-shell]$ cd pan-*
           [nix-shell]$ configurePhase
           [nix-shell]$ buildPhase
           [nix-shell]$ ./pan/gui/pan

