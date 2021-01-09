

# Usage


Note that it is adapted from [what Zimbatm did](https://github.com/zimbatm/nix-experiments/tree/a674302cf85f80ff9b7368c25ccd8f61d8205cca/ubuntu-vm),
and I have found it because of [this youtube video (I pinned the relevant part, and it is in the correct moment etc, it has 00:02:30)](https://www.youtube.com/embed/2emuPcomQ98?start=90&end=228&version=3)
 **thanks**, really, it was an amazing improvement, it was is as if I was stuck in the [Iron Age](https://en.wikipedia.org/wiki/Iron_Age), and have find 
[hardware virtualisation](https://en.wikipedia.org/wiki/Hardware_virtualization) with [KVM](https://en.wikipedia.org/wiki/Hardware_virtualization) using 
[Nix](https://nixos.org/manual/nix/stable/#ch-about-nix) just now! Thank you!!

For now all that we have a is a Ubuntu VM to test the installer manually.
Automated tests come next.

Run ./wootbuntu to start the VM. It will automatically download the ISO and
setup QEMU. Make sure to have KVM enabled on your machine for it to be fast
(/dev/kvm should exist on the host).

# Install

Note: you may need anable KVM. Refs: ["KVM: disabled by BIOS" error](https://www.linux-kvm.org/page/FAQ#.22KVM:_disabled_by_BIOS.22_error),
 [Note: You may need to enable virtualization support in your BIOS](https://wiki.archlinux.org/index.php/KVM).

You can see a YouTube video example [Nix Friday - Home manager, (00:01:59 all duration)]( https://www.youtube.com/embed/2emuPcomQ98?start=227&end=346&version=3),
 he explains about [4.1. Single User Installation](https://nixos.org/manual/nix/stable/#sect-single-user-installation) 
 and about  [4.2. Multi User Installation](https://nixos.org/manual/nix/stable/#sect-multi-user-installation).

## First clone and open a terminal and run:
```
git clone https://github.com/GNU-ES/GNU-Nix-ES.git \
&& cd GNU-Nix-ES \
&& git checkout 10f01d84fcbc461c869294b114705cb639cc028b \
&& cd src/WIP-Work-In-Process/ubuntu-18-04-vm-QEMU-nix-cloud-images-disk.qcow2-qcow2 \
&& ./wootbuntu 
```

TODO: bypass this annoying input of user and login, it is going to be really cool to use this VM, 
like a Docker container, but with hardware virtualization (and I know slower, really slower than 
Docker to start etc, but it is ok for me).

## Test 1

### Install Docker
```
curl -fsSL https://get.docker.com | sudo sh \
&& sudo usermod --append --groups docker "$USER" \
&& docker --version \
&& sudo reboot
```

TODO: bypass this annoying interative process of input manually things, pretty sure that it is possible to be done.

### Test if it works

TODO: merge, somehow, this command with the above install one.

```
docker run hello-world
```


### Clear and boot again
 
```
rm -f disk.qcow2 userdata.qcow2 \
&& ./wootbuntu 
```


## Test 2, Nix, Docker install (Broken)


```
sudo adduser --quiet --disabled-password --shell /bin/bash --home /home/pedro --gecos "User" pedro \
&& echo "pedro:123" | sudo chpasswd \
&& sudo usermod -a -G sudo "$USER" \
&& sudo mkdir -m 0755 /nix \
&& sudo chown "$USER" /nix \
&& echo "123" | sudo -S curl -L https://nixos.org/nix/install | sh \
&& echo '. /home/pedro/.nix-profile/etc/profile.d/nix.sh' >> ~/.bashrc \
&& . /home/ubuntu/.nix-profile/etc/profile.d/nix.sh \
&& nix-env --install --attr nixpkgs.docker \
&& docker --version \
&& docker run hello-world \
&& sudo reboot
```

Error after reboot:
```
ubuntu@ubuntu:~$ docker run hello-world
docker: Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon runni.
See 'docker run --help'.
```


## Commands for debug:

### Run one by one

I have no ideia why the output does not work well, so run one by one (line by line):
```
systemctl show --property ActiveState docker \
&& systemctl is-active docker \
&& systemctl status docker \
&& docker info \
&& service docker status \
&& service docker start \
&& systemctl start docker
```

The deeper that I went for now:
```
ubuntu@ubuntu:~$ systemctl start docker
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ===
Authentication is required to start 'docker.service'.
Authenticating as: Ubuntu (ubuntu)
Password: 
==== AUTHENTICATION COMPLETE ===
Failed to start docker.service: Unit docker.service not found.
```

**How to solve this?!**

### Refs

`systemctl show --property ActiveState docker` 
BMitch https://stackoverflow.com/a/43723174
https://stackoverflow.com/a/47382158
https://stackoverflow.com/a/52752360
https://stackoverflow.com/a/43978990



## Test 3, Nix, Poetry, flask (Broken)


```
sudo adduser --quiet --disabled-password --shell /bin/bash --home /home/pedro --gecos "User" pedro \
&& echo "pedro:123" | sudo chpasswd \
&& sudo usermod -a -G sudo "$USER" \
&& sudo mkdir --mode=0755 /nix \
&& sudo chown "$USER" /nix \
&& echo "123" | sudo -S curl -L https://nixos.org/nix/install | sh \
&& echo '. /home/pedro/.nix-profile/etc/profile.d/nix.sh' >> ~/.bashrc \
&& . /home/ubuntu/.nix-profile/etc/profile.d/nix.sh \
&& nix-env --install --attr nixpkgs.python39 nixpkgs.poetry \
&& python --version \
&& poetry --version \
&& poetry new test \
&& cd test \
&& poetry add flask \
&& python -c 'import flask'
```

```
sudo mkdir --mode=0755 /nix \
&& sudo chown "$USER" /nix \
&& sudo curl -L https://nixos.org/nix/install | sh \
&& echo '. /home/pedro/.nix-profile/etc/profile.d/nix.sh' >> ~/.bashrc \
&& . /home/ubuntu/.nix-profile/etc/profile.d/nix.sh \
&& nix-env --install --attr nixpkgs.docker \
&& sudo groupadd docker \
&& sudo usermod --append --groups docker "$USER" \
&& docker --version \
&& sudo reboot
```

The solution should be to make a nix `shell.nix` with `python` and `poetry` like in [Nix Friday - poetry2nix part 1](https://youtu.be/XfqJulSAPBQ?t=1128)
 but while restart from scratch still being annoying and boring it is hard to be done (I dont know how to mount a volume like I do in Docker).


## Podman

```
curl -L https://nixos.org/nix/install | sh \
&& git clone https://github.com/containers/podman.git \
&& cd podman \
&& nix build -f nix/ \
&& ./result/bin/podman --version
```

[Rootless containers with Podman: The basics](https://developers.redhat.com/blog/2020/09/25/rootless-containers-with-podman-the-basics/)

[Static build](https://podman.io/getting-started/installation.html#static-build) using Nix. 
How to do it using muslibc and not the glibc?


### Podman from `apt` (Working)


```bash
. /etc/os-release \
&& echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list \
&& curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key | sudo apt-key add - \
&& sudo apt-get update \
&& sudo apt-get -y upgrade \
&& sudo apt-get -y install podman \
&& podman \
run \
--interactive \
--net=host \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
ubuntu:20.04 \
bash -c 'cat /etc/os-release && apt-get update && apt-get install -y hello && hello'
```

# Ref and TODOS


[Configure and run a QEMU-based VM outside of libvirt with virt-manager](https://developers.redhat.com/blog/2020/03/06/configure-and-run-a-qemu-based-vm-outside-of-libvirt/)

TODO: [Enabling nested virtualization in KVM](https://docs.fedoraproject.org/en-US/quick-docs/using-nested-virtualization-in-kvm/)

TODO: disable virtual env creation! Look in the poetry docs [local configuration](https://python-poetry.org/docs/configuration/#local-configuration)

TODO: the humanity really need it
https://python-poetry.org/docs/#enable-tab-completion-for-bash-fish-or-zsh


TODO: make a nix `shell.nix` with `python` and `poetry` like in [Nix Friday - poetry2nix part 1](https://youtu.be/XfqJulSAPBQ?t=1128)

TODO:
git clone https://github.com/NixOS/nixpkgs \
&& nix-env --file nixpkgs/ --upgrade discord

Refs:
https://nixos.org/manual/nixpkgs/stable/#chap-quick-start
https://github.com/NixOS/nixpkgs/pull/97710/files

TODO:
nix-env --install --attr nixpkgs.docker
sudo adduser pedro
vim install.sh \
&& chmod +x install.sh \
&& ./install.sh \
&& sudo addgroup docker \
&& nix --version \
&& docker --version \
&& docker run --rm hello


TODO:
         Mounting /mnt...
[FAILED] Failed to mount /mnt.
See 'systemctl status mnt.mount' for details.
[DEPEND] Dependency failed for Local File Systems.
         Starting Set console font and keymap...
         Starting ebtables ruleset management...



https://serverfault.com/questions/632718/access-pty-login-prompt-in-vm

https://stackoverflow.com/a/59403566

About the daemon:
https://github.com/NixOS/nixpkgs/blob/a674302cf85f80ff9b7368c25ccd8f61d8205cca/pkgs/applications/virtualization/docker/default.nix
https://github.com/NixOS/nixpkgs/issues/47201
https://stackoverflow.com/questions/56763989/dockerd-not-running-on-nixos

Must see:
https://askubuntu.com/a/1996


Others Refs:
https://docs.docker.com/engine/install/debian/
https://stackoverflow.com/questions/29224136/how-to-make-a-script-run-commands-as-root
https://stackoverflow.com/questions/7875540/how-to-write-multiple-line-string-using-bash-with-variables
https://github.com/NixOS/nix/issues/1489
https://github.com/NixOS/nix/issues/1880

# Login

Next comes the login session. Use these credentials:

username: ubuntu
password: ubuntu

# SSH access

From the installer-test folder, run:

```sh
./ssh
```

# FIXME: mount /mnt

```sh
mount -t 9p hostshare /mnt -o trans=virtio,version=9p2000.L
```

# Run the installer

The nix folder is mounted read-only under /mnt. Build the installer on the
host and then run the installer on the guest.

# Shutdown

Press `ctrl+a c` to open the qemu console and then type `quit`.

[1]: https://bugs.launchpad.net/cloud-images/+bug/1726476
