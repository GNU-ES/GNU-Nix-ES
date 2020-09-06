
http://rebeccaskinner.net/blog/python_and_nix/


`docker build --tag pedroregispoar/nixos/hello .`

```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
pedroregispoar/nixos/hello
```
