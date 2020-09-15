#


## Docker

Just open an terminal, if you have git and Docker installed, and run:

```
git clone https://github.com/GNU-ES/GNU-Nix-ES.git \
&& cd GNU-Nix-ES \
&& git checkout 0e05c4e8a07f096527dd27db78a2e2e1624f4c00 \
&& cd src/broken/to-test-ci \
&& ./run.sh
```

And that is it, it should have worked!


### Install Docker

If you want to install [Docker](https://www.docker.com/) you can follow the official instructions to install [docker-ce](https://docs.docker.com/engine/install/).

And for completeness here is the docker version that was used:
```
docker --version
Docker version 19.03.12, build v19.03.12
```
