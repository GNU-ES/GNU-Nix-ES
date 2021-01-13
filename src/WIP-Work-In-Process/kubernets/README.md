

    
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


