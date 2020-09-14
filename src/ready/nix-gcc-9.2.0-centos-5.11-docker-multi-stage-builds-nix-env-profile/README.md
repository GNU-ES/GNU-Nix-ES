# First

```
#!/usr/bin/env bash
git clone https://github.com/GNU-ES/GNU-Nix-ES.git \
&& cd GNU-Nix-ES \
&& git checkout 053a5f241c81afe647dc0ddda20b4942050aa1b9 \
&& cd src/examples \
&& cd nix-gcc-9.2.0-centos-5.11-docker-multi-stage-builds-nix-env-profile \
&& ./run.sh
```

If you already have cloned, run the script:
`./run.sh`


## Play around

If it works play in the interactive mode

Adapted from: [Jérôme Petazzoni - Creating Optimized Images for Docker and Kubernetes](https://www.youtube.com/watch?v=UbXv-T4IUXk&list=PLf-O3X2-mxDmn0ikyO7OF8sPr2GDQeZXk&index=15)

`./run.sh`


TODO:

`nix path-info --recursive --size --closure-size --human-readable nixpkgs.coreutils`


Are all equivalents:
```
RUN cp -av $(nix-store -qR /output/profile) /output/store
RUN cp --archive --verbose $(nix-store -qR /output/profile) /output/store
RUN cp -dpR --verbose $(nix-store -qR /output/profile) /output/store
RUN cp --no-dereference --recursive --verbose $(nix-store --query --requisites /output/profile) /output/store
```


## Refs

Docker Docs: [Use multi-stage builds](https://docs.docker.com/develop/develop-images/multistage-build/)

