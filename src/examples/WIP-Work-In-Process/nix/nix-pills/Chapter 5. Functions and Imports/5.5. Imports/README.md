##

[5.5. Imports](https://nixos.org/nixos/nix-pills/functions-and-imports.html#idm140737320508928)


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


nix repl


Nix is a domain-specific language for writing packages!

Nix has integer, floating point, string, path, boolean and null simple types. 
Then there are also lists, sets and functions. 
These types are enough to build an operating system.

Nix is strongly typed, but it's not statically typed. 
That is, you cannot mix strings and integers, you must first do the conversion.


file /nix/store/wwrhgby67wrs35v48kaj0aprm8imi587-hello-2.10/share/man/man1/hello.1.gz