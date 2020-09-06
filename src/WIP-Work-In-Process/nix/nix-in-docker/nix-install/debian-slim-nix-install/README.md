

docker build --tag pedroregispoar/debian-slim-nix-install . --no-cache && docker run \
--interactive \
--privileged \
--rm \
--tty \
--volume "$(pwd)":/code \
--volume /var/run/docker.sock:/var/run/docker.sock \
pedroregispoar/debian-slim-nix-install \
bash -c "docker images"



docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
debian:buster-slim \
bash -c "source ./code/install.sh && nix --version"

