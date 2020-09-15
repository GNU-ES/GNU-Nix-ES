# First

```
#!/usr/bin/env bash
git clone https://github.com/GNU-ES/GNU-Nix-ES.git \
&& cd GNU-Nix-ES \
&& git checkout 7984718b50a0572a0e42013cf44f1be561c3f1f0 \
&& cd src/broken/to-test-ci \
&& cd docker-alpine-python-no-pip \
&& ./run.sh
```

If you already have cloned, run the script:
`./run.sh`


## Play around

If it works play in the interactive mode


### Install Docker

If you want to install [Docker](https://www.docker.com/) you can follow the official instructions to install [docker-ce](https://docs.docker.com/engine/install/).

And for completeness here is the docker version that was used:
```
docker --version
Docker version 19.03.12, build v19.03.12
```

## Links and sources


[Dockerfile souce](https://github.com/docker-library/python/blob/7984718b50a0572a0e42013cf44f1be561c3f1f0/3.8/alpine3.12/Dockerfile)
