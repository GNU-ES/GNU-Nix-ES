

    
[Jaka Hudoklin: Kubernetes cluster on NixOS](https://www.youtube.com/watch?v=XgZWbrBLP4I)



https://stackoverflow.com/a/51737180

TODO:
https://iximiuz.com/en/posts/from-docker-container-to-bootable-linux-disk-image/
https://thekev.in/blog/2019-08-05-dockerfile-bootable-vm/index.html


docker run \
    --mount type=bind,src=/hostFolder,dst=/containerFolder \
    --mount type=volume,dst=/containerFolder/subFolder \
    ...other-args...
https://stackoverflow.com/a/56334999

https://stackoverflow.com/a/57116371


# Timing things time

- https://stackoverflow.com/a/556411
- https://unix.stackexchange.com/questions/52313/how-to-get-execution-time-of-a-script-effectively
- https://unix.stackexchange.com/questions/12068/how-to-measure-time-of-program-execution-and-store-that-inside-a-variable
- https://stackoverflow.com/questions/1656425/print-execution-time-of-a-shell-command



https://github.com/gotoz/runq

docker run --device=/dev/kvm -it ubuntu bash

apt-get update -y
apt-get install -y qemu-system-x86
qemu-system-x86_64 \
  -append 'root=/dev/vda console=ttyS0' \
  -drive file='rootfs.ext2.qcow2,if=virtio,format=qcow2'  \
  -enable-kvm \
  -kernel 'bzImage' \
  -nographic \
;

https://stackoverflow.com/a/64978456


https://github.com/opencontainers/runc

https://forums.docker.com/t/systemctl-status-is-not-working-in-my-docker-container/9075/21

https://github.com/gdraheim/docker-systemctl-replacement


https://lwn.net/Articles/676831/
https://www.reddit.com/r/NixOS/comments/ej4b0c/how_to_use_nixoscontainer_on_nonnixos_systems/
https://stackoverflow.com/questions/56032747/how-to-run-podman-from-inside-a-container?rq=1



https://datakurre.github.io/pyconpl19/slides.pdf
https://www.youtube.com/watch?v=Vnq6ngcqJAg


nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run '

nix shell nixpkgs#minikube nixpkgs#podman --command minikube start --driver=podman --container-runtime=cri-o && minikube kubectl -- get pods -A

nix shell nixpkgs#minikube --command minikube start --driver=docker --container-runtime=cri-o && minikube kubectl -- get pods -A

minikube start --driver=podman --container-runtime=cri-o && minikube kubectl -- get pods -A
minikube start --driver=docker --container-runtime=cri-o && minikube kubectl -- get pods -A


nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix shell nixpkgs#podman nixpkgs#conmon nixpkgs#cri-o nixpkgs#slirp4netns nixpkgs#shadow'

nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix shell nixpkgs#podman nixpkgs#conmon nixpkgs#cri-o nixpkgs#slirp4netns nixpkgs#shadow --command podman run alpin'



nix shell nixpkgs#podman nixpkgs#conmon nixpkgs#cri-o nixpkgs#slirp4netns nixpkgs#shadow nixpkgs#libvirt nixpkgs#katago
podman run -it --log-level=debug --runtime $(which cri-o) docker.io/library/busybox sh -c id


nix shell nixpkgs#podman nixpkgs#conmon nixpkgs#crun nixpkgs#slirp4netns nixpkgs#shadow nixpkgs#libvirt nixpkgs#katago
podman run -it --log-level=debug --runtime $(which crun) docker.io/library/busybox sh -c id


nix shell nixpkgs#podman nixpkgs#conmon nixpkgs#runc nixpkgs#slirp4netns nixpkgs#shadow nixpkgs#libvirt nixpkgs#katago
podman run -it --log-level=debug --runtime $(which runc) docker.io/library/busybox sh -c id

podman --runtime $(which runc) 


chmod 4755 $(which newuidmap)
chmod 4755 $(which newgidmap) 

stat $(which newuidmap)
stat $(which newgidmap)


sudo touch /usr/bin/newuidmap
sudo touch /usr/bin/newgidmap

sudo chown "$USER": /usr/bin/newuidmap
sudo chown "$USER": /usr/bin/newgidmap

chmod 4755 /usr/bin/newuidmap
chmod 4755 /usr/bin/newgidmap

stat /usr/bin/newuidmap
stat /usr/bin/newgidmap


sudo rm /usr/bin/newuidmap
sudo rm /usr/bin/newgidmap



sudo ln --symbolic $(which newuidmap) /usr/bin/newuidmap
sudo ln --symbolic $(which newgidmap) /usr/bin/newgidmap

sudo chmod 4755 /usr/bin/newuidmap
sudo chmod 4755 /usr/bin/newgidmap

sudo chown --no-dereference "$USER": /usr/bin/newuidmap
sudo chown --no-dereference "$USER": /usr/bin/newgidmap

stat /usr/bin/newuidmap
stat /usr/bin/newgidmap

stat --dereference /usr/bin/newuidmap
stat --dereference /usr/bin/newgidmap


cat /proc/self/setgroups

grep "$USER" /etc/sub?id

which newuidmap newgidmap

"symlinks does not have permissions" Source: https://askubuntu.com/a/1151273



https://github.com/containers/podman/issues/2788#issuecomment-479972943
getcap /usr/bin/newuidmap /usr/bin/newgidmap


More steps:
https://forum.artixlinux.org/index.php/topic,1341.0.html

sudo setcap cap_setuid+ep $(readlink $(which newuidmap))
sudo setcap cap_setgid+ep $(readlink $(which newgidmap))

chmod -s $(readlink $(which newuidmap))
chmod -s $(readlink $(which newgidmap))


```bash
nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes
```

```bash
nix shell nixpkgs#podman nixpkgs#conmon nixpkgs#runc nixpkgs#slirp4netns nixpkgs#shadow
```

TODO: 
nix shell --ignore-environment nixpkgs#{coreutils,shadow,which} --command readlink --canonicalize $(which newuidmap)
nix shell --ignore-environment nixpkgs#{coreutils,shadow,which} --command readlink $(which newuidmap)

```bash
sudo setcap cap_setuid+ep $(readlink --canonicalize $(which newuidmap))
sudo setcap cap_setgid+ep $(readlink --canonicalize $(which newgidmap))

sudo chmod -s $(readlink --canonicalize $(which newuidmap))
sudo chmod -s $(readlink --canonicalize $(which newgidmap))
```


```
#mkdir --mode=755 --parent ~/.config/containers
# TODO: make test showing it is idempotent and respet if the 
# folder has some thing in it.
mkdir --mode=755 --parent ~/.config/containers --verbose

cat << EOF > ~/.config/containers/policy.json
{
    "default": [
        {
            "type": "insecureAcceptAnything"
        }
    ],
    "transports":
        {
            "docker-daemon":
                {
                    "": [{"type":"insecureAcceptAnything"}]
                }
        }
}
EOF

podman \
run \
--interactive \
--rm \
--runtime $(which runc) \
docker.io/tianon/toybox \
sh -c id
```

```bash
podman \
run \
--interactive \
--rm \
--runtime $(which runc) \
docker.io/library/busybox \
sh -c id
```


```
cat << EOF > policy.json
{
    "default": [
        {
            "type": "insecureAcceptAnything"
        }
    ],
    "transports":
        {
            "docker-daemon":
                {
                    "": [{"type":"insecureAcceptAnything"}]
                }
        }
}
EOF

podman \
run \
--interactive \
--rm \
--runtime $(which runc) \
--signature-policy policy.json \
docker.io/tianon/toybox \
sh -c id
```

Fonte da flag --signature-policy:
https://github.com/containers/podman/issues/6053#issuecomment-639637411

```bash
podman \
run \
--interactive \
--net=host \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
docker.io/library/ubuntu:20.04 \
bash -c 'apt-get update && apt-get install -y hello && hello'
```

Tryed: `minikube start --force --driver=podman --container-runtime=$(which runc)`

https://github.com/containers/podman/issues/6053#issuecomment-624056425


$ docker run --rm -it --name img --volume $(pwd):/home/user/src:ro --workdir /home/user/src --cap-add SETGID --cap-add SETUID --security-opt apparmor=unconfined --security-opt seccomp=unconfined r.j3ss.co/img pull alpine
newuidmap: write to uid_map failed: Operation not permitted
nsenter: failed to use newuidmap: Invalid argument
nsenter: failed to sync with parent: SYNC_USERMAP_ACK: got 255: Invalid argument
https://github.com/genuinetools/img/issues/144#issuecomment-409551567


sticky bit
https://unix.stackexchange.com/a/464921

sudo groupadd podman \
&& sudo usermod --append --groups podman "$USER"

Search for nix to find:

```
git clone https://github.com/containers/podman.git && cd podman
nix build --file nix/
./result/bin/podman --version
```

https://podman.io/getting-started/installation


`podman run --log-level=debug hello-world`
https://github.com/containers/podman/pull/6402#issuecomment-698130183


What podman need?

https://github.com/containers/podman/pull/6402#issuecomment-701944042

https://github.com/containers/podman/pull/6402#issuecomment-702134975

CRI-O user nix to build its binaries?
https://github.com/containers/podman/issues/8788#issuecomment-748682207
