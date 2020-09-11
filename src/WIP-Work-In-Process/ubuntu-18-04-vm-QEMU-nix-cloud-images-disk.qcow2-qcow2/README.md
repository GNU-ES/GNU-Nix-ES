

# Usage


Note that it is adapted from [what Zimbatm did](https://github.com/zimbatm/nix-experiments/tree/d5c6a2506d5f1a9b60b5c47e5829ff36007aa864/ubuntu-vm)
thanks, really, it was an amazing improvement, it is as if I had reached the [Iron Age](https://en.wikipedia.org/wiki/Iron_Age) just now! Thank you!!

For now all that we have a is a Ubuntu VM to test the installer manually.
Automated tests come next.

Run ./wootbuntu to start the VM. It will automatically download the ISO and
setup QEMU. Make sure to have KVM enabled on your machine for it to be fast
(/dev/kvm should exist on the host).

# Management commands 

```
git clone https://github.com/GNU-ES/GNU-Nix-ES.git \
&& cd GNU-Nix-ES \
&& git checkout c218f41265401072b9acd96f54a709f07a24d114 \
&& cd src/WIP-Work-In-Process/nix-experiments/ubuntu-vm \
&& ./wootbuntu 
```

## Clear and boot again
 
```
rm disk.qcow2 userdata.qcow2 \
&& ./wootbuntu 
```

## Test 1

### Install Docker
```
curl -fsSL https://get.docker.com | sudo sh \
&& sudo usermod -aG docker "$USER" \
&& docker --version \
&& sudo reboot
```

### Test if it works
```
docker run hello-world
```

## Test 2

sudo adduser --quiet --disabled-password --shell /bin/bash --home /home/pedro --gecos "User" pedro \
&& echo "pedro:123" | sudo chpasswd \
&& sudo usermod -a -G sudo "$USER" \
&& sudo mkdir -m 0755 /nix \
&& chown "$USER" /nix

echo "123" | sudo -S curl -L https://nixos.org/nix/install | sh \
&& echo '. /home/pedro/.nix-profile/etc/profile.d/nix.sh' >> ~/.bashrc


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



https://serverfault.com/questions/632718/access-pty-login-prompt-in-vm

https://stackoverflow.com/a/59403566

About the daemon:
https://github.com/NixOS/nixpkgs/blob/bba8571c39d41ac432fd74922e53737fb11eb85d/pkgs/applications/virtualization/docker/default.nix
https://github.com/NixOS/nixpkgs/issues/47201
https://stackoverflow.com/questions/56763989/dockerd-not-running-on-nixos

`systemctl show --property ActiveState docker` BMitch
https://stackoverflow.com/a/43723174

`systemctl is-active docker`
https://stackoverflow.com/a/47382158

https://stackoverflow.com/a/52752360
https://stackoverflow.com/a/43978990

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
