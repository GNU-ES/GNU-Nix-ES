##



`docker build --tag pedroregispoar/nixos/qgis .`


```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
pedroregispoar/nixos/qgis
```
