#






## Docker

Just open an terminal, if you have docker installed, run:

```
docker build --tag pedroregispoar/alpine-python-no-pip . \
&& echo 'End of build!' \
&& docker run \
--interactive \
--tty \
--rm \
pedroregispoar/alpine-python-no-pip \
sh -c 'python --version'
```


And that is it, it should have worked!


### Install Docker

If you want to install [Docker](https://www.docker.com/) you can follow the official instructions to install [docker-ce](https://docs.docker.com/engine/install/).

And for completeness here is the docker version that was used:
```
docker --version
Docker version 19.03.12, build v19.03.12
```

## Links and sources


[Dockerfile souce](https://github.com/docker-library/python/blob/1b78ff417e41b6448d98d6dd6890a1f95b0ce4be/3.8/alpine3.12/Dockerfile)
