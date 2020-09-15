# First

```
#!/usr/bin/env bash
git clone https://github.com/GNU-ES/GNU-Nix-ES.git \
&& cd GNU-Nix-ES \
&& git checkout b84a6f991d20e01c007beff7759bfcbd573071f8 \
&& cd src/examples/to-test-ci \
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


[Dockerfile souce](https://github.com/docker-library/python/blob/b84a6f991d20e01c007beff7759bfcbd573071f8/3.8/alpine3.12/Dockerfile)
