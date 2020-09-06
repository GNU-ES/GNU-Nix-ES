##

[Chapter 7. Working Derivation](https://nixos.org/nixos/nix-pills/working-derivation.html)


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


```
nix-repl> :l <nixpkgs>
Added 11835 variables.
nix-repl> "${bash}"
"/nix/store/kgp3vq8l9yb8mzghbw83kyr3f26yqvsz-bash-4.4-p23"
```

Como usar uma versão especifica do bash? 


d = derivation { name = "foo"; builder = "${bash}/bin/bash"; args = [ ./builder.sh ]; system = builtins.currentSystem; }



/nix/store/wdmfnwalv4cl89mamklzssys810ysycn-simple/simple




nix-build simple.nix