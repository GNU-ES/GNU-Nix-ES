


Initialy is necessary run:

`docker build --target auxiliary --tag pedroregispoar/auxiliary .`

```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
pedroregispoar/auxiliary
```


`28fa858cb76c:/code# nix-shell`


`[nix-shell:/code]# poetry init` 

...

```
[tool.poetry]
name = "labels"
version = "0.0.1"
description = ""
authors = ["Your Name <you@example.com>"]

[tool.poetry.dependencies]
python = "^3.7"
python-decouple = "^3.3"
pygithub = "^1.51"

[tool.poetry.dev-dependencies]

[build-system]
requires = ["poetry>=0.12"]
build-backend = "poetry.masonry.api"
```

`docker build --tag pedroregispoar/labels .`


```
[nix-shell:/code]# poetry lock
Skipping virtualenv creation, as specified in config file.
Updating dependencies
Resolving dependencies... (11.1s)

Writing lock file
```


`28fa858cb76c:/code# nix-shell shell2.nix`


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