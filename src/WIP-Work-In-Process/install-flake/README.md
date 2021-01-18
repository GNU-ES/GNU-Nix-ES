

Ideia: use `ONBUILD RUN` for entrypoint.

[Nix Installation Guide](https://nixos.wiki/wiki/Nix_Installation_Guide)

[Install Nix in multi-user mode on non-NixOS](https://nixos.wiki/wiki/Install_Nix_in_multi-user_mode_on_non-NixOS)


[This is how I currently got Nix installed on OSX:](https://github.com/NixOS/nix/issues/697)



[Docker image nixos/nix](https://hub.docker.com/r/nixos/nix/dockerfile)

the workaround I have seen is to (simplified):

    create a temporary user with sudo access
    install nix under that user
    delete the user
    configure the root account with the nix profile
[source](https://www.gitmemory.com/issue/NixOS/nix/1559/531690854)





https://wiki.debian.org/QEMU#Installation

systemctl status display-manager.service

xhost

xhost +local:
TODO: Is this link the correct fix for this?
https://bbs.archlinux.org/viewtopic.php?pid=1680674#p1680674


export DISPLAY=':0.0' 

Extra: about xterm
https://unix.stackexchange.com/a/429120


nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes

nix shell nixpkgs#qemu


qemu-img create -f qcow2 nixos.img 2G


qemu-system-x86_64 -enable-kvm -m 8192 -boot d -cdrom latest-nixos-minimal-x86_64-linux.iso -hda nixos.img
 
qemu-system-x86_64 \
-enable-kvm -m 8192 \
-boot d \
-cdrom latest-nixos-minimal-x86_64-linux.iso \
-hda nixos.img \
-vnc :1 \
-serial mon:stdio \
-smp 2 \
-device "rtl8139,netdev=net0" \
-netdev "user,id=net0,hostfwd=tcp:127.0.0.1:10022-:22"


qemu-system-x86_64 \
-enable-kvm -m 8192 \
-cdrom latest-nixos-minimal-x86_64-linux.iso \
-hda nixos.img \
-vnc :1 \
-serial mon:stdio \
-vga std

qemu-system-x86_64 \
-enable-kvm -m 8192 \
-cdrom latest-nixos-minimal-x86_64-linux.iso \
-hda nixos.img \
-vnc :1 \
-serial mon:stdio \
-nographic


qemu-system-x86_64 \
-enable-kvm -m 8192 \
-cdrom latest-nixos-minimal-x86_64-linux.iso \
-hda nixos.img \
-nographic

qemu-system-x86_64 \
-enable-kvm -m 8192 \
-cdrom latest-nixos-plasma5-x86_64-linux.iso \
-hda nixos.img \
-nographic




nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run "nix shell nixpkgs#xorg.xclock --command 'xclock'"
nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run "nix shell nixpkgs#python38Full --command python -c 'from tkinter import Tk; Tk()'"

nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix shell nixpkgs#wget nixpkgs#man nixpkgs#man-db nixpkgs#qemu nixpkgs#stdenv'
wget --output-document=debian-testing-amd64-netinst.iso http://cdimage.debian.org/cdimage/daily-builds/daily/arch-latest/amd64/iso-cd/debian-testing-amd64-netinst.iso \
&& qemu-img create -f qcow2 debian.qcow 2G \
&& qemu-system-x86_64 -hda debian.qcow -cdrom debian-testing-amd64-netinst.iso -boot d -m 512 -nographic \
&& echo

qemu-system-x86_64 -enable-kvm -boot d -cdrom latest-nixos-minimal-x86_64-linux.iso -m 512 -nographic

nix shell nixpkgs#qemu 


https://nixos.wiki/wiki/Using_X_without_a_Display_Manager
wget --output-document=latest-nixos-minimal-x86_64-linux.iso https://channels.nixos.org/nixos-20.09/latest-nixos-minimal-x86_64-linux.iso

nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix shell nixpkgs#xorg.xclock --command xclock'

nix-shell -p "jetbrains.pycharm-community" --run "pycharm-community"
https://github.com/NixOS/nixpkgs/issues/78728

Needed test with new volume, but same image:

docker volume ls

docker ps --all --quiet | xargs --no-run-if-empty docker stop --time=0 \
&& docker ps --all --quiet | xargs --no-run-if-empty docker rm --force \
&& docker volume prune --force "$NIX_CACHE_VOLUME"

docker ps --all --quiet | xargs --no-run-if-empty docker stop --time=0 \
&& docker ps --all --quiet | xargs --no-run-if-empty docker rm --force \
&& docker container prune --force \
&& docker volume prune --force


echo 'Start' \
&& NIX_BASE_IMAGE='nix-base:0.0.1' \
&& NIX_CACHE_VOLUME='nix-cache-volume' \
&& NIX_CACHE_VOLUME_TMP='nix-cache-volume-tmp' \
&& docker run \
--cap-add ALL \
--cpus='0.99' \
--device=/dev/kvm \
--env="DISPLAY=${DISPLAY:-:0.0}" \
--interactive \
--mount source="$NIX_CACHE_VOLUME",target=/nix \
--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.cache/ \
--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.config/nix/ \
--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.nix-defexpr/ \
--mount source="$NIX_CACHE_VOLUME_TMP",target=/tmp/ \
--net=host \
--privileged=true \
--tty \
--rm \
--workdir /code \
--volume="$(pwd)":/code \
--volume="$XAUTHORITY":/root/.Xauthority \
--volume=/sys/fs/cgroup/:/sys/fs/cgroup:ro \
--volume /tmp/.X11-unix:/tmp/.X11-unix \
"$NIX_BASE_IMAGE" bash -c 'nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes' \
&& echo 'End'



echo 'Start' \
&& NIX_BASE_IMAGE='nix-base:0.0.1' \
&& NIX_CACHE_VOLUME='nix-cache-volume' \
&& NIX_CACHE_VOLUME_TMP='nix-cache-volume-tmp' \
&& docker run \
--cap-add ALL \
--cpus='0.99' \
--device=/dev/kvm \
--env="DISPLAY=${DISPLAY:-:0.0}" \
--interactive \
--mount source="$NIX_CACHE_VOLUME",target=/nix \
--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.cache/ \
--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.config/nix/ \
--mount source="$NIX_CACHE_VOLUME",target=/home/pedroregispoar/.nix-defexpr/ \
--mount source="$NIX_CACHE_VOLUME_TMP",target=/tmp/ \
--net=host \
--privileged=true \
--tty \
--rm \
--workdir /code \
--volume="$(pwd)":/code \
--volume="$XAUTHORITY":/root/.Xauthority \
--volume=/sys/fs/cgroup/:/sys/fs/cgroup:ro \
--volume /tmp/.X11-unix:/tmp/.X11-unix \
"$NIX_BASE_IMAGE" bash \
&& echo 'End'


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
"$NIX_BASE_IMAGE" bash -c "sudo python -c 'from tkinter import Tk; Tk()' && sudo --preserve-env python -c 'from tkinter import Tk; Tk()'"


sudo --preserve-env su -c 'nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes'

docker run \
--env=DISPLAY="$DISPLAY" \
--interactive \
--net=host \
--tty \
--rm \
--workdir /code \
--volume="$(pwd)":/code \
--volume="$XAUTHORITY":/root/.Xauthority \
python:3.9 bash -c "python -c 'from tkinter import Tk; Tk()'"



systemctl --user show-environment
systemctl --user import-environment DISPLAY XAUTHORITY

export DISPLAY=':0.0' && python -c 'from tkinter import Tk; Tk()'

https://stackoverflow.com/questions/45129706/how-to-install-x-on-nixos
systemctl status display-manager.service
systemctl start display-manager.service
systemctl status display-manager.service

export DISPLAY=':0.0' && python -c 'from tkinter import Tk; Tk()'


xhost +local:

xhost -local:

xhost +local:
https://askubuntu.com/a/1113062


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
"$NIX_BASE_IMAGE" bash -c "sudo --preserve-env nix-env --file '<nixpkgs>' --install --attr python38Full --show-trace && sudo python -c 'from tkinter import Tk; Tk()'"


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
"$NIX_BASE_IMAGE" bash -c "sudo --preserve-env su -c 'nix-shell --packages "jetbrains.pycharm-community" --run "pycharm-community"'"



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
"$NIX_BASE_IMAGE" bash -c "sudo --preserve-env su -c 'nix-shell --packages "jetbrains.pycharm-community" --run "pycharm-community"'"



xorg.xclock

TODO:
https://askubuntu.com/questions/1249043/run-simple-x11-app-in-docker-container-on-ubuntu-20-04?rq=1
https://stackoverflow.com/questions/51192198/how-to-video-record-selenium-tests-running-headless-inside-a-docker
https://www.linuxquestions.org/questions/linux-general-1/root-can%27t-start-x-apps-512667/#post2554053
http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/

Put it in a OCI image
nix develop --profile nixpkgs#xorg.xclock

[Think of the ONBUILD command as an instruction the parent Dockerfile gives to the child Dockerfile.](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#onbuild)

## On Alpine


# On NixOS


nix --version

sudo nix-channel --list

sudo nixos-rebuild switch --show-trace

sudo nixos-rebuild switch --no-write-lock-file

nixos-rebuild --flake .#mymachine switch


sudo nix-channel --list
sudo nix-channel --add https://nixos.org/channels/nixos-20.09
sudo nix-channel --list

sudo nix-channel --add https://nixos.org/channels/nixos-20.03

nix-instantiate --eval --expr '(import <nixpkgs> {}).lib.version'

sudo nix-channel --remove nixos-20.09

NIX_PATH=nixos-config=/etc/nixos/configuration.nix:nixpkgs=channel:nixos-20.03 sudo nixos-rebuild switch



Works:

nix --version
nix (Nix) 2.3.6

sudo nix-channel --list
nixos https://nixos.org/channels/nixos-20.03
nixos-20.03 https://nixos.org/channels/nixos-20.03
nixpkgs https://nixos.org/channels/nixpkgs-unstable

nix-instantiate --eval --expr '(import <nixpkgs> {}).lib.version'
"20.03.3236.2257e6cf4d7"


## Trying to make flake work 

git log --pretty=oneline

sudo git checkout f0a3924b1d88ea569555944ba2df22afe575c9f7

cd /etc/nixos
nix flake update

git switch -

sudo git checkout d0c6577d81dd976b28b3b117ffe60eb32e8f0c47

nix flake update

sudo nix-channel --list
sudo nix-channel --add https://nixos.org/channels/nixos-20.09
sudo nix-channel --list

----

sudo nix-channel --list
nixos https://nixos.org/channels/nixos-unstable
nixos-20.03 https://nixos.org/channels/nixos-20.03
nixos-20.09 https://nixos.org/channels/nixos-20.09
nixpkgs https://nixos.org/channels/nixpkgs-unstable


After first step commit:
`sudo nixos-rebuild switch`

sudo mv _flake.nix flake.nix
sudo git add .
sudo git commit -m 'Add flake.nix'

nix --version

nix flake update


nix flake info nixpkgs

sudo nixos-rebuild switch --flake '.#' --no-write-lock-file


### Referências

- Instalação do `minikube`: https://minikube.sigs.k8s.io/docs/start/


Teste feito usando ssh no PC do João, QEMU + cloud image ubuntu, `nix` + `flake` usando o `nix shell`:
![image](https://user-images.githubusercontent.com/20312381/104532702-9fb64780-55ef-11eb-8611-99efc7484cde.png)


https://github.com/actions/virtual-environments/issues/183#issuecomment-610723516

