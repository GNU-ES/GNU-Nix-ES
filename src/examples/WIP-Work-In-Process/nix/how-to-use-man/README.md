##


My first difficult in use Nix was that I was not able to use `man` or some other kind of way to get full
flags of a command or the `--help` for some command.

### Prof 

```
docker run \
--interactive \
--rm \
--tty \
nixos/nix:2.3.4
```


The `nix --help` worked, but `nix-env --help` did not:

```
4ea240d69620:/# nix-env --help
error: command 'man nix-env' failed: No such file or directory
```


### Solution?

After a long search (when you are not used to search about some thing it is hard) I found the followng link:


[Nix-env not linking man pages into environment?](https://discourse.nixos.org/t/nix-env-not-linking-man-pages-into-environment/1468)


In this question I found this answer from the user `ivanbrennan`:

[https://discourse.nixos.org/t/nix-env-not-linking-man-pages-into-environment/1468/3](https://discourse.nixos.org/t/nix-env-not-linking-man-pages-into-environment/1468/3)

He says "It isn’t pretty, but this actually works.", well I am beginner in Nix, so I am not sure if it is good or bad.  
```buildoutcfg
FROM lnl7/nix:latest

RUN nix-env --file '<nixpkgs>' --install --attr man \
 && nix-env --install \
    $(nix-instantiate --no-gc-warning --expr ' \
        with import <nixpkgs> {};              \
        buildEnv {                             \
          name = "manpages-hack";              \
          paths = [                            \
            bashInteractive.man                \
            curl.man                           \
            jq.man                             \
          ];                                   \
          extraOutputsToInstall = [ "man" ];   \
        }'                                     \
    )
```

Looking carefully to the above snippet (the clearly came from a `Dockerfile` (TODO link)), I managed to get 
the `man` command and full flags.  

`docker build --tag pedroregispoar/nixos/nix:2.3.4 .`

```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
pedroregispoar/nixos/nix:2.3.4 
```


Running `# man nix-env` worked!







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
