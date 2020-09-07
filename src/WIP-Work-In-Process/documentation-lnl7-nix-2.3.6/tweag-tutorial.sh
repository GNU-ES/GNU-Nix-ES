#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail

ls -la \
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
&& python -c 'import flask' \
&& find . -name '*flask' \
&& ls -la /root/.cache/pypoetry/virtualenvs/gnu-nix-es-swbZ_4R8-py3.8/lib/python3.8/site-packages/flask \
&& python -c 'import sys; print(sys.path)' \
&& ls -la /nix/store/bs03sg8b0gq2zr4v252hh9psp780qj5q-python3-3.8.5/lib/python3.8/site-packages \
&& ls -la
