#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -eux pipefail

PROJECT_FOLDER_NAME='test-project'


poetry new "$PROJECT_FOLDER_NAME" \
&& cd "$PROJECT_FOLDER_NAME" \
&& ls -la \
&& poetry show --tree \
&& poetry lock \
&& ls -la \
&& mv poetry.lock ../poetry.lock \
&& ls -la \
&& mv pyproject.toml ../pyproject.toml \
&& ls -la \
&& cd .. \
&& rm --recursive "$PROJECT_FOLDER_NAME" \
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


#mkdir "$PROJECT_FOLDER_NAME"
#touch "$PROJECT_FOLDER_NAME"/'__init__.py'