


#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


git init

git config user.email "you@example.com"
git config user.name "Your Name"

git add .

git commit --message 'Save flake state'

#nix develop --command mywhich 'nix'

# To be able to run thin inside the super nix OCI image:
# stat "$HOME"
# sudo chown pedroregispoar:pedroregispoargroup "$HOME"
# sudo chown 755 "$HOME"

#nix develop --ignore-environment --command make --version

# Does not work because of the flag --ignore-environment obviusly...
#nix develop --ignore-environment --command 'test_free_packages.sh'
nix develop --command ./test_free_packages.sh
#nix develop --command opera --version

# To run this via ssh evem using -X i needed:
# export DISPLAY=':0.0'
sudo rm --force --recursive .git
#rm --force --recursive flake.lock
