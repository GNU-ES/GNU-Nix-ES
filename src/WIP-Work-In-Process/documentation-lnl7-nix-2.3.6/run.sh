#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail

IMAGE='gnu-nix-es/ex1-hello-tweag'
VERSION=0.0.1

IMAGE_VERSION="$IMAGE":"$VERSION"

docker build --tag "$IMAGE_VERSION" .

# This does not work!
#docker run \
#--interactive \
#--tty \
#--rm \
#--workdir /code \
#--volume "$(pwd)":/code \
#"$IMAGE_VERSION" --run './tweag-tutorial.sh'


docker run \
--interactive \
--tty \
--rm \
"$IMAGE_VERSION" --run "ls -la \
    && nix profile install nixpkgs#python3 \
    && python --version \
    && nix profile install nixpkgs#poetry \
    && poetry --version \
    && mkdir test \
    && cd test \
    && poetry new GNU-Nix-ES \
    && cd GNU-Nix-ES \
    && poetry remove --dev pytest \
    && poetry show --tree \
    && poetry lock \
    && mv poetry.lock ../poetry.lock \
    && mv pyproject.toml ../pyproject.toml \
    && cd .. \
    && rm -r GNU-Nix-ES \
    && poetry add flask \
    && poetry show --tree \
    && ls -la
"

#    && python -c 'import flask' \

# To debug

docker run \
--interactive \
--tty \
--rm \
--volume "$(pwd)":/code \
"$IMAGE_VERSION" --run "ls -la \
    && nix profile install nixpkgs#file \
    && nix profile install nixpkgs#python3 \
    && nix profile install nixpkgs#poetry \
    && poetry --version \
    && python --version \
    && file python \
    && file $(readlink python) \
    && echo "$PATH" | grep '/root/.nix-profile/bin' \
    && file $(readlink /root/.nix-profile/bin/python3) \
    && ls -la /nix/store/bs03sg8b0gq2zr4v252hh9psp780qj5q-python3-3.8.5/lib/python3.8/ \
    && mkdir test \
    && cd test \
    && poetry new GNU-Nix-ES \
    && cd GNU-Nix-ES \
    && poetry show --tree \
    && poetry lock \
    && mv poetry.lock ../poetry.lock \
    && mv pyproject.toml ../pyproject.toml \
    && cd .. \
    && rm -r GNU-Nix-ES \
    && poetry remove --dev pytest \
    && poetry add flask \
    && poetry show --tree \
    && poetry lock \
    && find . -name '*flask' \
    && ls -la /root/.cache/pypoetry/virtualenvs/gnu-nix-es-swbZ_4R8-py3.8/lib/python3.8/site-packages/flask \
    && python -c 'import sys; print(sys.path)' \
    && ls -la /nix/store/bs03sg8b0gq2zr4v252hh9psp780qj5q-python3-3.8.5/lib/python3.8/site-packages \
    && ls -la
"


# Full mess:
docker run \
--interactive \
--tty \
--rm \
--volume "$(pwd)":/code \
"$IMAGE_VERSION" --run "ls -la \
    && mkdir test \
    && cd test \
    && nix profile install nixpkgs#file \
    && nix profile install nixpkgs#python3 \
    && python --version \
    && file python \
    && file $(readlink python) \
    && echo "$PATH" | grep '/root/.nix-profile/bin' \
    && file $(readlink /root/.nix-profile/bin/python3) \
    && ls -la /nix/store/bs03sg8b0gq2zr4v252hh9psp780qj5q-python3-3.8.5/lib/python3.8/ \
    && nix profile install nixpkgs#poetry \
    && poetry --version \
    && poetry new GNU-Nix-ES \
    && cd GNU-Nix-ES \
    && ls -la \
    && poetry show --tree \
    && poetry lock \
    && ls -la \
    && mv poetry.lock ../poetry.lock \
    && ls -la \
    && mv pyproject.toml ../pyproject.toml \
    && ls -la \
    && cd .. \
    && rm -r GNU-Nix-ES \
    && poetry show --tree \
    && cat poetry.lock \
    && cat pyproject.toml \
    && poetry remove --dev pytest \
    && poetry show --tree \
    && cat poetry.lock \
    && cat pyproject.toml \
    && poetry add flask \
    && poetry show --tree \
    && poetry lock \
    && find . -name '*flask' \
    && ls -la /root/.cache/pypoetry/virtualenvs/gnu-nix-es-swbZ_4R8-py3.8/lib/python3.8/site-packages/flask \
    && python -c 'import sys; print(sys.path)' \
    && ls -la /nix/store/bs03sg8b0gq2zr4v252hh9psp780qj5q-python3-3.8.5/lib/python3.8/site-packages \
    && ls -la
"
