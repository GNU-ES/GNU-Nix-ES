#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail

git config --global user.email "pedroalencarregis@hotmail.com"
git config --global user.name "PedroRegisPOAR"

git add .

git commit --message "Add example:$1"
