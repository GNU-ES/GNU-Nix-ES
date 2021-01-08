


[ nixpkgs/nixos/tests/postgis.nix ](https://github.com/NixOS/nixpkgs/blob/c1cc2459344ca3ebd224f51d2d1a08368de68ce0/nixos/tests/postgis.nix)

NIX_BASE_IMAGE='nix-base:0.0.1' \
&& NIX_CACHE_VOLUME='nix-cache-volume' \
&& docker run \
--cap-add SYS_ADMIN \
--cpus='0.7' \       
--device=/dev/kvm \
--env=DISPLAY="$DISPLAY" \
--interactive \      
--mount source="$NIX_CACHE_VOLUME",target=/nix \
--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.cache/ \
--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.config/nix/ \
--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.nix-defexpr/ \
--net=host \
--privileged=true \
--tty \
--rm \ 
--workdir /code \
--volume="$(pwd)":/code \
--volume="$XAUTHORITY":/root/.Xauthority \
--volume=/sys/fs/cgroup/:/sys/fs/cgroup:ro \
"$NIX_BASE_IMAGE" bash -c 'sudo --preserve-env ./run.sh'
