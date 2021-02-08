


[Nix: How and Why it Works](https://www.youtube.com/watch?v=lxtHH838yko)

[github nix-how-and-why](https://github.com/grahamc/talks/tree/a83a3ece6f3a88b01b612dfec145576745923550/talks-nixcon-2019/nix-how-and-why)

[Docker Tip #66: Fixing Error Response from Daemon: Invalid Mode](https://nickjanetakis.com/blog/docker-tip-66-fixing-error-response-from-daemon-invalid-mode)

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


e423deb6bfc3:/code# cat trivial.nix 


[Is $out a file or a folder?](https://www.youtube.com/embed/lxtHH838yko?start=231&end=240&version=3)


e423deb6bfc3:/code# cat hello.nix 
let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "hello" { buildInputs = [ ]; }
  ''
    hello > $out
  ''

buildInputs não são necessários inicialmente.


[Why no ; in the end?](https://www.youtube.com/embed/lxtHH838yko?start=461&end=480&version=3)



e423deb6bfc3:/code# nix-build example.nix 
...
e423deb6bfc3:/code# cat result


Para um curso, revisar o que é um link simbólico.

```
e423deb6bfc3:/code# nix-build example.nix 
these derivations will be built:
  /nix/store/09igh8mwk25z9hlp19y086aw8zgjv1d8-hello.drv
building '/nix/store/09igh8mwk25z9hlp19y086aw8zgjv1d8-hello.drv'...
/nix/store/8gnccbbc5gjjacc13m7rwwfq86k4lkwk-hello
e423deb6bfc3:/code# ls -l result 
lrwxrwxrwx    1 root     root            49 Jun 16 11:23 result -> /nix/store/8gnccbbc5gjjacc13m7rwwfq86k4lkwk-hello
e423deb6bfc3:/code# cat result 
Hello World
e423deb6bfc3:/code# readlink result 
/nix/store/8gnccbbc5gjjacc13m7rwwfq86k4lkwk-hello
```

```
e423deb6bfc3:/code# cat source.nix 
let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "hello" { buildInputs = [ ]; }
  ''
    cp ./talk.md $out
  ''
e423deb6bfc3:/code# nix-build source.nix 
these derivations will be built:
  /nix/store/1sv9746b39f7a1ax0paa4xkc8i83p2wx-hello.drv
building '/nix/store/1sv9746b39f7a1ax0paa4xkc8i83p2wx-hello.drv'...
cp: cannot stat './talk.md': No such file or directory
builder for '/nix/store/1sv9746b39f7a1ax0paa4xkc8i83p2wx-hello.drv' failed with exit code 1
error: build of '/nix/store/1sv9746b39f7a1ax0paa4xkc8i83p2wx-hello.drv' failed
```

```
e423deb6bfc3:/code# nix-build file.nix 
these derivations will be built:
  /nix/store/ns0252m5xwm9dny6fcibqm4r1nck3v6y-file-lorem-ipsum.drv
building '/nix/store/ns0252m5xwm9dny6fcibqm4r1nck3v6y-file-lorem-ipsum.drv'...
/nix/store/80g6ylq8vbj8jsgc6g86v8sn6kyi0wzd-file-lorem-ipsum
e423deb6bfc3:/code# cat result 
"Aquele que ama ou exerce ou deseja a dor, pode ocasionalmente adquirir algum prazer na labuta. Para dar um exemplo trivial, qual de nós se submete a laborioso exercício físico, exceto para obter alguma vantagem com isso. Desmoralizado pelos encantos do prazer, percebe que a dor não resulta em prazer algum. Está tão cego pelo desejo que não pode prever quem não cumprirá seu dever por fraqueza de vontade."
```

https://pt.wikipedia.org/wiki/Lorem_ipsum



Será que tem que fazer source?
echo 'sandbox = true' >> nix.conf


[Why hashs?](https://www.youtube.com/embed/lxtHH838yko?start=1921&end=1977&version=3)
[Hash mismatch in fixed-output derivation and big downloads saved](https://www.youtube.com/embed/lxtHH838yko?start=2037&end=2082&version=3)

[the TOFU model](https://www.youtube.com/embed/lxtHH838yko?start=2126&end=2137&version=3)
[the TOFU model, longer explanation, PyPI etc](https://www.youtube.com/embed/lxtHH838yko?start=2126&end=2164&version=3)

https://www.youtube.com/embed/lxtHH838yko?start=2171&end=2216&version=3


[Mirrors and hash of file](https://www.youtube.com/embed/lxtHH838yko?start=2395&end=2416&version=3)



TODO:
https://www.youtube.com/watch?v=zBqPg80l7xA
https://www.youtube.com/watch?v=tufKNhgOYYA
https://www.youtube.com/watch?v=QW5-oYKws6o


https://www.youtube.com/watch?v=V-55IH6CVd4


https://www.youtube.com/watch?v=26Dykdv8nOw


https://www.youtube.com/watch?v=kk8wsWgclN0&feature=emb_rel_end


```
4bac8bc9ff5a:/code# nix-build network-fetchurl.nix
...
/nix/store/wyjd6gky5fcmwag0cz56ffxzvpic5dgf-grahamc.com
4bac8bc9ff5a:/code# cat result 
```

[ver, está com um ; no fim errado](https://www.youtube.com/embed/lxtHH838yko?start=3299&end=3372&version=3)
