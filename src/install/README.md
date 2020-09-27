


## Docker

Just open an terminal, if you have git and Docker installed, and run:

```
git clone https://github.com/GNU-ES/GNU-Nix-ES.git \
&& cd GNU-Nix-ES \
&& git checkout c6d8df53ed09b762472f1b7789e599cac2ef8809 \
&& cd src/install \
&& ./run.sh
```



docker run -it --rm -v "$(pwd)":/code -w /code ubuntu:20.04 bash -c './utils/install-using-apt.sh'

$ docker run -it --rm -v "$(pwd)":/code -w /code ubuntu:20.04
root@36ece3651664:/code# ./utils/install-using-apt.sh GNU-Nix-ES 123


# TODO

Reproduce:
https://askubuntu.com/a/476489



# Refs


