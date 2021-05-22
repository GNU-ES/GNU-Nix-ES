# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

id

nix --version


nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix build nixpkgs#hello'
result/bin/hello
rm result
