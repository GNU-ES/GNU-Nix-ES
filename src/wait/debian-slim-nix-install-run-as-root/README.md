# First

```
#!/usr/bin/env bash
git clone https://github.com/GNU-ES/GNU-Nix-ES.git \
&& cd GNU-Nix-ES \
&& git checkout REVISION \
&& cd debian-slim-nix-install-run-as-root \
&& ./run.sh
```

If you already have cloned, run the script:
`./run.sh`


## Play around

If it works play in the interactive mode

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
