##

[chapter-2](https://nixos.org/nixos/nix-pills/install-on-your-running-system.html)


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


Yes, Nix also has a database. It's stored under /nix/var/nix/db. It is a sqlite database that keeps track of the dependencies between derivations.

The schema is very simple: there's a table of valid paths, mapping from an auto increment integer to a store path.

Then there's a dependency relation from path to paths upon which they depend.


Muito bonito:

`# cat ~/.nix-profile/etc/profile.d/nix.sh`

Pq dos erros?
`# ldd /nix/store/*bash*/bin/bash`
