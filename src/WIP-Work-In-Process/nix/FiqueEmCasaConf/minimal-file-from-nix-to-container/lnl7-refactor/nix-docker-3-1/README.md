

`shadow = pkgs.shadow.override { pam = null; };` Is it a type of [overlay](https://www.youtube.com/watch?v=W85mF1zWA2o)?


        checkPhase = ''
            set -o pipefail
            mkdir $out/xablau
            nix --version
            find --version
            #nix-store --init
            #nix-store --load-db < /.reginfo
            chown ${new_user_name} /nix/var/nix/profiles/per-user
            chown ${new_user_name} /nix/var/nix/gcroots/per-user
            chown ${new_user_name} /nix/var/nix/profiles/per-user/${new_user_name}
            chown ${new_user_name} /nix/var/nix/db/big-lock
            chown ${new_user_name} /nix/var/nix/db
            chown --recursive --verbose ${new_user_name} /nix/store/ /nix/var/ /tmp/

            touch /nix/var/nix/gc.lock
            chown ${new_user_name} /nix/var/nix/gc.lock
            chown ${new_user_name} /nix/var/nix/temproots
            chmod 0775 /nix/var/nix/temproots

            mkdir --parent /nix/var/nix/gcroots
            mkdir --parent /var/empty

            mkdir --parent /nix/var/nix/profiles/per-user/root
            #mkdir --parent /root/.nix-defexpr

            mkdir --parent /nix/var/nix/profiles/per-user/${new_user_name}
            mkdir --parent /${new_user_name}/.nix-defexpr


            mkdir --parent /home/${new_user_name}/.local/share/nix

            touch /home/${new_user_name}/.nix-profile.lock
            chmod 0775 /home/${new_user_name}/.nix-profile.lock
            chown ${new_user_name}:wheel /home/${new_user_name}/.nix-profile.lock
            stat /home/${new_user_name}/.nix-profile.lock
            chmod 0777 --recursive --verbose /tmp/
            mkdir --mode=0777 /nix/var/log
            #chown --recursive root:root --verbose $(echo $(readlink $(which sudo)) | cut --delimiter='/' --fields=1-4)
            #chmod 4755 --recursive --verbose $(echo $(readlink $(which sudo)) | cut --delimiter='/' --fields=1-4)
            #cd /
            #sudo nix-store --init
            #sudo nix-store --load-db < /.reginfo
            #chmod 1777 /etc/passwd
            #chmod 1777 /etc/group

            #chmod 4755 $(readlink $(which sudo))
            #chmod 4755 /run/current-system/sw/bin/sudo
        '';
        
        
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
"$NIX_BASE_IMAGE" bash
