docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
lnl7/nix:2.3.6


nix-build

./result

mkdir --parents /output/store

nix-env --profile /output/profile --install --file default.nix




