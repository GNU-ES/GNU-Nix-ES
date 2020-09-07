

`echo 'Hello world! It is working!' > my-input-data-file.txt`

```
$ ls
my-input-data-file.txt  README.md
```

```
$ cat my-input-data-file.txt
Hello world! It is working!
```

 
```
let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "minimal-derivation-example" { buildInputs = [ ]; }
  ''
    cp ${./file.txt} $out
  ''
```

nix-build mwe-input-file-data.nix
these derivations will be built:
  /nix/store/5ikynfm2a8v527nmp3i00vfmhx9375jz-minimal-derivation-example.drv
building '/nix/store/5ikynfm2a8v527nmp3i00vfmhx9375jz-minimal-derivation-example.drv'...
/nix/store/k7afgp17s167q6pc0fiinc5pqcbp220h-minimal-derivation-example


cat result
Hello world! It is working!


readlink result       
/nix/store/k7afgp17s167q6pc0fiinc5pqcbp220h-minimal-derivation-example
 ~/r/tests-docker/nix/FiqueEmCasaConf/minimal-file-from-nix-to-container/mwe-documented-step-by-step  ls -l $(readlink result)
-r--r--r-- 1 pedro-regis pedro-regis 28 dez 31  1969 /nix/store/k7afgp17s167q6pc0fiinc5pqcbp220h-minimal-derivation-example
 ~/r/tests-docker/nix/FiqueEmCasaConf/minimal-file-from-nix-to-container/mwe-documented-step-by-step  cat $(readlink result)
Hello world! It is working!
 ~/r/tests-docker/nix/FiqueEmCasaConf/minimal-file-from-nix-to-container/mwe-documented-step-by-step  


nix-store --query --requisites $(readlink result)
/nix/store/k7afgp17s167q6pc0fiinc5pqcbp220h-minimal-derivation-example



`docker build --tag pedroregispoar/mwe-nixos-to-docker-image .`


docker run \
--interactive \
--rm \
--tty \
pedroregispoar/mwe-nixos-to-docker-image \
bash



docker build --target builder --tag pedroregispoar/builder/flasknix .

```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
pedroregispoar/flasknix
```

docker run pedroregispoar/flasknix nixfriday



docker run \
--interactive \
--rm \
--tty \
pedroregispoar/builder/flasknix






docker run \
--interactive \
--rm \
--tty \
4a487cbbcb42


ls -ls /dev/console
