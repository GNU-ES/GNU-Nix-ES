##

[chapter-3](https://nixos.org/nixos/nix-pills/enter-environment.html)


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


`# nix-env --install hello`


`# nix-env --list-generations`


`# nix-env --query`


`# nix-env --query --out-path`

Now that's interesting. When only nix-2.1.3 was installed, bin was a symlink to
 nix-2.1.3. Now that we've actually installed some things (man, hello), 
 it's a real directory, not a symlink.


`# ls -l ~/.nix-profile/`


`# which man`



`# nix-env --switch-generation`

```
9a649aaa5784:/code# nix-env --switch-generation 3
switching from generation 4 to 3
9a649aaa5784:/code# nix-env --switch-generation 4
switching from generation 3 to 4
9a649aaa5784:/code# 
```


`# nix-store --query --references $(which hello)`


`# nix-store --query --referrers $(which hello)`

`# cat ~/.nix-profile/manifest.nix`


`# nix-store --query --requisites $(which hello)`

Muito bom:
`# nix-store --query --tree $(which hello)`

`# nix-store --query --tree ~/.nix-profile`


There isn't anything like apt which solves a SAT problem in
 order to satisfy dependencies with lower and upper bounds 
 on versions. There's no need for this because all the 
 dependencies are static: if a derivation X depends on a
  derivation Y, then it always depends on it. A version of X
   which depended on Z would be a different derivation.
   
   
nix-env --uninstall '.*'
nix-env --uninstall '*'


Como fazer uma regex como:

find /nix/store/ '-nix-*'

Para achar: 

8928ygfyf9iassfrnj76v55s6zid58ja-nix-2.3.4

E ser melhor do que:

ls /nix/store/ | grep nix-

/nix/store/8928ygfyf9iassfrnj76v55s6zid58ja-nix-2.3.4/bin/nix-env --rollback
