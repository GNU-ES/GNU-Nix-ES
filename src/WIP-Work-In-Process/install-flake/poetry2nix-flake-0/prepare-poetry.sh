#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -eux pipefail


poetry new test-project \
&& cd test-project \
&& ls -la \
&& poetry show --tree \
&& poetry lock \
&& ls -la \
&& mv poetry.lock ../poetry.lock \
&& ls -la \
&& mv pyproject.toml ../pyproject.toml \
&& ls -la \
&& cd .. \
&& rm --recursive test-project \
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
&& ls -la
