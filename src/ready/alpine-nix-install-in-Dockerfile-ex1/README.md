# First

```
#!/usr/bin/env bash
git clone https://github.com/GNU-ES/GNU-Nix-ES.git \
&& cd GNU-Nix-ES \
&& git checkout 053a5f241c81afe647dc0ddda20b4942050aa1b9 \
&& cd src/examples/alpine-nix-install-in-Dockerfile-ex1 \
&& ./run.sh
```

If you already have cloned, run the script:
`./run.sh`


## Play around

If it works play in the interactive mode:

```
IMAGE="gnu-nix-es/"$(basename "$(pwd)")""
VERSION=0.0.1

IMAGE_VERSION="$IMAGE":"$VERSION"

docker build --tag "$IMAGE_VERSION" .

docker run \
--interactive \
--tty \
--rm \
--user pedro \
"$IMAGE_VERSION" \
sh 
```

Now it has a value for `IMAGE_VERSION`. You can check that with `echo "$IMAGE_VERSION"`.

# TODOS

A need sphinx!
https://docs.alpinelinux.org/user-handbook/0.1a/Working/post-install.html
RUN echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel

- look the install.sh
