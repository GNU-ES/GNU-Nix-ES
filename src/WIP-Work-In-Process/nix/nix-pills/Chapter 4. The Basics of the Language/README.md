##

[Chapter 4. The Basics of the Language](https://nixos.org/nixos/nix-pills/basics-of-language.html)


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

Qual a diferença: `nix repl` and `nix repl '<nixpkgs>'`  


Nix is a domain-specific language for writing packages!

Nix has integer, floating point, string, path, boolean and null simple types. 
Then there are also lists, sets and functions. 
These types are enough to build an operating system.

Nix is strongly typed, but it's not statically typed. 
That is, you cannot mix strings and integers, you must first do the conversion.


```
nix-build simple.nix 
these derivations will be built:
  /nix/store/q26n2nwwkygs2cy0fn7rv12yr27zlznp-simple.drv
building '/nix/store/q26n2nwwkygs2cy0fn7rv12yr27zlznp-simple.drv'...
/nix/store/638whp4vr371apmin6w18p5zr4rg20g9-simple.c: In function 'main':
/nix/store/638whp4vr371apmin6w18p5zr4rg20g9-simple.c:2:3: warning: implicit declaration of function 'puts' [-Wimplicit-function-declaration]
    2 |   puts("Simple!");
      |   ^~~~
/nix/store/30arlg07ra111sj3nc4pylschbgj78rk-simple
```



```
ls -l
total 20
-rw-rw-r-- 1 pedro-regis pedro-regis   73 mai 20 23:00 Dockerfile
-rw-rw-r-- 1 pedro-regis pedro-regis 1232 jun 24 22:05 README.md
lrwxrwxrwx 1 pedro-regis pedro-regis   50 jun 24 22:01 result -> /nix/store/30arlg07ra111sj3nc4pylschbgj78rk-simple
-rw-rw-r-- 1 pedro-regis pedro-regis   72 mai 23 23:43 simple_builder.sh
-rw-rw-r-- 1 pedro-regis pedro-regis   34 mai 23 23:43 simple.c
-rw-rw-r-- 1 pedro-regis pedro-regis  207 mai 23 23:51 simple.nix
```

```
file result 
result: symbolic link to /nix/store/30arlg07ra111sj3nc4pylschbgj78rk-simple
```

```
file result/simple 
result/simple: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /nix/store/c2rlh7xa8fcgg7qz8pl76ipvvb172c6k-glibc-2.30/lib/ld-linux-x86-64.so.2, for GNU/Linux 2.6.32, with debug_info, not stripped
```

```
./result/simple       
Simple!
```



