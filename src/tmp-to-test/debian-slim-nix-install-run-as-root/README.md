##

Just run:
`./run.sh`




TODO: from where did I get this `install.sh` script?



TODO: do crazy things, run as priviliged, why not?!
```
docker build --tag pedroregispoar/debian-slim-nix-install . --no-cache && docker run \
--interactive \
--privileged \
--rm \
--tty \
--volume "$(pwd)":/code \
--volume /var/run/docker.sock:/var/run/docker.sock \
gnu-nix-es/debian-slim-nix-install \
bash -c "docker images"
```

TODO: test for many other images debian based!
```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
debian:buster-slim \
bash -c "source ./code/install.sh && nix --version"
```
