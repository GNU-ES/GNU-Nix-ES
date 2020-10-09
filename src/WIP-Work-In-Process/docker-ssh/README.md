

# Usage

```
apt-get update \
&& apt-get install -y git \
&& git clone https://github.com/GNU-ES/GNU-Nix-ES.git \
&& cd GNU-Nix-ES \
&& git checkout 32c705ab18a6b9cc2b0b585f4aeb3731200c273b \
&& cd src/WIP-Work-In-Process/docker-ssh \
&& ./run.sh
```


### Install Docker
```
curl -fsSL https://get.docker.com | sudo sh \
&& sudo usermod --append --groups docker "$USER" \
&& docker --version \
&& sudo reboot
```

### Test if it works

```
docker run hello-world
```

## Refs

https://docs.docker.com/engine/examples/running_ssh_service/

Why so many commands??! Really hard to check if it works!
https://linoxide.com/linux-how-to/ssh-docker-container/