


Initialy is necessary run:

`docker build --target auxiliary --tag pedroregispoar/ex3/auxiliary .`

```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
pedroregispoar/ex3/auxiliary
```

```
e58f99eb4d4c:/code# nix-shell
...
[nix-shell:/code]#
```

```
[nix-shell:/code]# poetry run my-script
Skipping virtualenv creation, as specified in config file.
Hello
```

```
[nix-shell:/code]# poetry build
Skipping virtualenv creation, as specified in config file.
Building say_hello (0.1.0)
 - Building sdist
 - Built say_hello-0.1.0.tar.gz

 - Building wheel
 - Built say_hello-0.1.0-py3-none-any.whl

[nix-shell:/code]#
```


TODO: Why the `none` in `say_hello-0.1.0-py3-none-any.whl`? 

`docker rmi pedroregispoar/ex3/auxiliary`