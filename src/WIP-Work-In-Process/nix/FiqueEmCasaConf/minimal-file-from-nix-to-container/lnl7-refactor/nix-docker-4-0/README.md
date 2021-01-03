

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
        

https://www.cyberciti.biz/faq/understanding-etcgroup-file/

https://www.cyberciti.biz/faq/understanding-etcpasswd-file-format/


docker ps --all

docker volume ls

docker images

docker create \
--name=nix-volume-container \
--volume=/nix-volume \
docker-tools-empty-image-size:0.0.1 sh

docker ps --all

docker volume ls
docker volume ls --quiet

ls -al /nix-volume/ \
&& touch /nix-volume/file.txt \
&& stat /nix-volume/file.txt \
&& chmod +x /nix-volume/file.txt \
&& stat /nix-volume/file.txt


docker run \
--interactive \
--tty \
--rm \
--volumes-from=nix-volume-container \
bash-minimal:0.0.1 -c 'ls -la /nix-volume'

docker run \
--interactive \
--tty \
--rm \
--volumes-from=nix-volume-container \
--volume /nix:/nix-volume \
nixos/nix sh -c 'nix-env --install --attr nixpkgs.hello'

docker run \
--interactive \
--tty \
--rm \
--volumes-from=nix-volume-container \
bash-minimal:0.0.1 -c 'ls -la /nix-volume'

docker run -it --rm bash-minimal:0.0.1 -c 'ls -la'

docker run \                                   
--interactive \
--tty \
--rm \
--volumes-from=nix-volume-container \
--volume /nix-volume:/nix \
nixos/nix sh -c 'nix-env --install --attr nixpkgs.hello'

ls -al /nix-volume/store/

docker run \
--interactive \
--tty \
--rm \
--volumes-from=nix-volume-container \
alpine sh -c 'stat /nix/file.txt'

docker create --name nix-volume-container --volume /nix-volume alpine sh

ID=$(docker create --name nix-volume-container --volume /nix-volume alpine sh)

docker volume inspect $ID
docker volume ls 
docker ps --all

docker run \
--interactive \
--tty \
--mount source=nix-volume,target=/nix \
nixos/nix sh -c 'nix-env --install --attr nixpkgs.hello'

docker run \
--interactive \
--tty \
--mount source=nix-volume,target=/nix \
nixos/nix sh -c 'hello'
