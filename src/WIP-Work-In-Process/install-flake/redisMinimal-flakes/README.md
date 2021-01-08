

https://youtu.be/h2I1FHpbaIg?t=2528

niv update nixpkgs --branch nixos-20.09


TODO:
https://youtu.be/h2I1FHpbaIg?t=2741
https://youtu.be/h2I1FHpbaIg?t=2982


TODO:
https://youtu.be/h2I1FHpbaIg?t=3041

build-vm
https://youtu.be/h2I1FHpbaIg?t=3220


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
--volume=/var/run/docker.sock:/var/run/docker.sock \
"$NIX_BASE_IMAGE" bash -c "sudo --preserve-env nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run './run.sh''"
