##


[chapter-1](https://nixos.org/nixos/nix-pills/why-you-should-give-it-a-try.html)


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


But then how do you mix multiple stacks? Python, Rust, C, C++(98, 03, [11](https://pt.wikipedia.org/wiki/C%2B%2B11), 
[14](https://pt.wikipedia.org/wiki/C%2B%2B14), [17](https://pt.wikipedia.org/wiki/C%2B%2B17), 
[20](https://pt.wikipedia.org/wiki/C%2B%2B20)), FORTRAN([66](https://pt.wikipedia.org/wiki/Fortran),
 [77](https://web.stanford.edu/class/me200c/tutorial_77/02_whatis.html),
 90, 95, [2003](http://fortranwiki.org/fortran/show/Fortran+2003))


[Resolvendo uma equação de 2°. grau em FORTRAN](https://pt.wikipedia.org/wiki/Fortran)


## Porque o resultado é diferente do Nix pill?

A resposta é que [essa imagem Docker](nixos/nix:2.3.4) é baseada no [Alpine](https://hub.docker.com/_/alpine)
por isso usa a [musl libc](https://musl.libc.org/).


TODO: corrigir o link [em](https://hub.docker.com/_/alpine) para a musl libc, a página mudou de link.
  
ldd  `which bash`
