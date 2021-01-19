

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

TODO: this command is not idempotent, make it be!!



```bash
test -d /nix || sudo mkdir --mode=0755 /nix \
&& sudo chown "$USER": /nix \
&& command -v nix >/dev/null 2>&1 || curl -L https://nixos.org/nix/install | sh \
&& test -d ~/.config/nix || mkdir --parent --mode=755 ~/.config/nix && touch ~/.config/nix/nix.conf \
&& cat ~/.config/nix/nix.conf | grep 'kvm' >/dev/null && /bin/true || echo 'system-features = kvm' >> ~/.config/nix/nix.conf \
&& cat ~/.config/nix/nix.conf | grep 'flakes' >/dev/null && /bin/true || echo 'experimental-features = nix-command flakes ca-references' >> ~/.config/nix/nix.conf \
&& test -d ~/.config/nixpkgs || mkdir --parent --mode=755 ~/.config/nixpkgs && touch ~/.config/nixpkgs/config.nix \
&& cat ~/.config/nixpkgs/config.nix | grep 'allowUnfree' >/dev/null && /bin/true || echo '{ allowUnfree = true; }' >> ~/.config/nixpkgs/config.nix \
&& . "$HOME"/.nix-profile/etc/profile.d/nix.sh \
&& echo 'Testing the installer installing the hello package' \
&& nix-env --install --attr nixpkgs.hello \
&& hello \
&& echo 'Unstalling the hello package' \
&& nix-env --uninstall nixpkgs.hello \
&& nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix flake show github:GNU-ES/hello' \
&& nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix shell nixpkgs#nix-info --command nix-info --markdown' \
&& nix-collect-garbage --delete-old \
&& nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'echo Instalation seems to be successfull!'
```
https://stackoverflow.com/a/57737607


TODO: change the `[]` to `test -f "$file" || echo "$file"`
https://stackoverflow.com/a/7023478

POSIX
https://stackoverflow.com/a/7810345


TODO: test it 

mkdir -m 0755 /etc/nix
echo 'sandbox = false' > /etc/nix/nix.conf


## First clone and open a terminal and run:
```
git clone https://github.com/GNU-ES/GNU-Nix-ES.git \
&& cd GNU-Nix-ES \
&& git checkout 71f58bc999b3ff8dcd3bff3c598e8955dad12915 \
&& cd src/WIP-Work-In-Process/ubuntu-18-04-vm-QEMU-nix-cloud-images \
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
rm --force --verbose disk.qcow2 userdata.qcow2 \
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

```
sudo groupadd docker \
&& sudo usermod --append --groups docker "$USER" \
&& nix shell nixpkgs#docker --command docker --version \
&& docker run hello-world 
```

docker --version \
&& docker run hello-world 

nix-env --install --attr nixpkgs.docker \
&& docker --version \
&& docker run hello-world 


sudo groupadd podman \
&& sudo usermod --append --groups podman "$USER" \
nix shell nixpkgs#podman

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



How to share a folder between KVM host and guest using virt-manager?
https://askubuntu.com/a/1274315

TODO: test the debug strategy, console=ttyS0, mount
https://askubuntu.com/questions/1108334/how-to-boot-and-install-the-ubuntu-server-image-on-qemu-nographic-without-the-g?noredirect=1&lq=1


How can I copy&paste from the host to a KVM guest?
TODO: openssh-server? "It also seems that an X server needs to be running for the clipboard 
to work via SPICE if using virt-viewer but it should work with virt-manager with spice-vdagent installed."

TODO: test Ciro Santilli script
https://askubuntu.com/questions/884534/how-to-run-ubuntu-desktop-on-qemu

TODO: how nix package the "two operating mode" of QEMU?
qemu-system-x86_64 -boot d -cdrom image.iso -m 512
https://linux-tips.com/t/booting-from-an-iso-image-using-qemu/136


QEMU and NixOS

http://www.cs.fsu.edu/~langley/CNT4603/2019-Fall/assignment-nixos-2019-fall.html

qemu-system-x86_64 -enable-kvm -m 8192 -boot d -cdrom nixos-graphical-19.09.891.80b42e630b2-x86_64-linux.iso -hda nixos.img 


TODO: re do all this and please, use long flags, i have no ideia on what `-d -J -p -R -i` is.
isoinfo -d -J -p -R -i

https://discourse.nixos.org/t/booting-nixos-installation-iso-fails-on-hosters-qemu-kvm-virtual-machine/8783/4


Maybe that is the problem: i mean, some kernel module is missing?
`boot.initrd.kernelModules = [ "cdrom" "sr_mod" "isofs" ];`
https://discourse.nixos.org/t/booting-nixos-installation-iso-fails-on-hosters-qemu-kvm-virtual-machine/8783/5


TODO: re do this, i tryied using a remote access and i am not sure about the result, it looks like it "hangs"

What i think is really important is the syntax. How to do the same with the minimal iso?
 
https://gist.github.com/573/c1d73a4fd04b8f8ca63885393856f9ea
`nix-build '<nixpkgs/nixos>' -A vm --arg configuration "{ imports = [ <nixpkgs/nixos/maintainers/scripts/openstack/openstack-image.nix> ]; }"`

Related with the above:

`boot.kernelParams = [ "console=ttyS0" ];`

Have not tested it, but looks interesting, a think add the kernel things 
`boot.initrd.kernelModules = [ "cdrom" "sr_mod" "isofs" ];` to do a test.

https://gist.github.com/tarnacious/f9674436fff0efeb4bb6585c79a3b9ff


I think it is all related.

About `-vnc` flag to view via `vncviewer`, what is that?
https://github.com/NixOS/nixpkgs/issues/36134#issuecomment-369542629

Is it doable in NixOS, create an `configuration.nix` and build it?
https://github.com/Mic92/nixos-shell/blob/master/share/nixos-shell/nixos-shell.nix#L87-L93

TODO: study this super nix script
https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/virtualisation/qemu-vm.nix

TODO: try this
https://unix.stackexchange.com/a/276490

I was doing this in some folder, dont remember where. 
https://documentation.suse.com/sles/11-SP4/html/SLES-all/cha-qemu-running.html#cha-qemu-running-gen-opts-basic



TODO: do it using flakes!
How do I get a shell.nix with cross compiler and qemu?

```
  nativeBuildInputs = [
    buildPackages.buildPackages.qemu
    buildPackages.gdb
  ];
```

https://discourse.nixos.org/t/how-do-i-get-a-shell-nix-with-cross-compiler-and-qemu/7658/2


TODO: well, really advanced (just because it is broken. If it not runs successfully in one command,
it is broken, for me it is like software without tests, broken by default.).
https://nixos.wiki/wiki/Kernel_Debugging_with_QEMU


TODO: simplify and build, the EC2 one, if works would be cool
https://github.com/NixOS/nixpkgs/blob/master/nixos/release.nix


TODO:
https://wiki.debian.org/QEMU#Installation



egrep -c '(vmx|svm)' /proc/cpuinfo

egrep -q 'vmx|svm' /proc/cpuinfo && echo yes || echo no

https://github.com/actions/virtual-environments/issues/183#issuecomment-580992331
https://github.com/sickcodes/Docker-OSX/issues/15#issuecomment-640088527
https://minikube.sigs.k8s.io/docs/drivers/kvm2/#installing-prerequisites

Related:
https://github.com/NixOS/nix/issues/2964#issuecomment-504164262


About KVM and nix build in AWS:
https://github.com/NixOS/nix/issues/2964

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
