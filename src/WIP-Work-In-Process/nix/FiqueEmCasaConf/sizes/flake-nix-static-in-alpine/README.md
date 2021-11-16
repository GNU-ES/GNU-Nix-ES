

[Jérôme Petazzoni - Creating Optimized Images for Docker and Kubernetes](https://www.youtube.com/watch?v=UbXv-T4IUXk&list=PLf-O3X2-mxDmn0ikyO7OF8sPr2GDQeZXk&index=15)

`./run.sh`


TODO: using `flake` in the terminal run:

```
$ nix develop --help
...
To store the build environment in a profile:
$ nix develop --profile /tmp/my-shell nixpkgs#hello
...
```

It looks like it is possible to the same "trick" [Jérôme Petazzoni](put some usefull url here, his github?), 
i mean, install some thing to a profile using [`flake`](add link here) and use the `COPY` thing from 
"Docker mult stage build".

```
IMAGE='alpine-nix-static-non-root' 
VERSION=0.0.1
IMAGE_VERSION="$IMAGE":"$VERSION"
docker \
run \
--env=PATH=/nix/store/0spz4mm8x6brb1r2sw96m8wb8iwdl5x4-nix-2.4pre20210326_dd77f71-x86_64-unknown-linux-musl/bin:/nix/var/nix/profiles/per-user/root/profile/bin:/nix/var/nix/profiles/per-user/root/profile/sbin:/bin:/sbin:/usr/bin:/usr/sbin \
--interactive=true \
--tty=true \
--rm=true \
--user='ada_user' \
"$IMAGE_VERSION" \
sh \
-c \
"nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix shell nixpkgs#{file,which,findutils,coreutils,shadow} --command bash'"
```


```
IMAGE='alpine-nix-static-non-root'     
VERSION=0.0.1       
IMAGE_VERSION="$IMAGE":"$VERSION"
docker \
 run \
--interactive=true \
--tty=true \
--rm=true \
--user='ada_user' \
--workdir='/home/ada_user' \
--volume="$(pwd)":/code \
"$IMAGE_VERSION" \
sh
```

```
IMAGE='alpine-nix-static-non-root-scratch'
VERSION=0.0.1
IMAGE_VERSION="$IMAGE":"$VERSION"
docker \
 run \
--interactive=true \
--tty=1 \
--rm=true \
--user='ada_user' \
--workdir='/home/ada_user' \
--volume="$(pwd)":/code \
"$IMAGE_VERSION"
```


https://unix.stackexchange.com/questions/338962/install-apk-tool-on-alpine-linux

DOING
apt-get update
apt-get install -y file wget tar
wget http://dl-cdn.alpinelinux.org/alpine/v3.9/main/x86_64/apk-tools-static-2.10.3-r1.apk
tar -zxvf apk-tools-static-2.10.3-r1.apk
file sbin/apk.static
ldd sbin/apk.static
sbin/apk.static add curl




podman \
 run \
--interactive=true \
--tty=false \
--rm=true \
--user='0' \
docker.io/library/busybox:1.32.1-musl \
sh \
<<COMMAND
wget http://dl-cdn.alpinelinux.org/alpine/v3.9/main/x86_64/apk-tools-static-2.10.3-r1.apk \
&& tar -zxvf apk-tools-static-2.10.3-r1.apk \
&& ./sbin/apk.static -X http://dl-cdn.alpinelinux.org/alpine/v3.13/main -U --allow-untrusted --initdb add apk-tools-static \
&& ./sbin/apk.static update \
&& ./sbin/apk.static -X http://dl-cdn.alpinelinux.org/alpine/v3.13/main -U --allow-untrusted add apk-tools
./sbin/apk.static update
./sbin/apk.static -X http://dl-cdn.alpinelinux.org/alpine/v3.13/main -U --allow-untrusted --initdb add git
git --version

./sbin/apk.static -X http://dl-cdn.alpinelinux.org/alpine/v3.13/main --allow-untrusted add file
COMMAND



apk update

&& echo 'https://dl-cdn.alpinelinux.org/alpine/v3.13/main' >> /etc/apk/repositories \
&& echo 'https://dl-cdn.alpinelinux.org/alpine/v3.13/community' >> /etc/apk/repositories \

apk fix
apk stats
apk audit


```
apt-get update
apt-get install -y wget tar
wget http://dl-cdn.alpinelinux.org/alpine/v3.9/main/x86_64/apk-tools-static-2.10.3-r1.apk \
&& tar -zxvf apk-tools-static-2.10.3-r1.apk \
&& ./sbin/apk.static -X http://dl-cdn.alpinelinux.org/alpine/v3.13/main -U --allow-untrusted --initdb add apk-tools-static \
&& ./sbin/apk.static update \
&& ./sbin/apk.static -X http://dl-cdn.alpinelinux.org/alpine/v3.13/main -U --allow-untrusted add apk-tools
./sbin/apk.static update
./sbin/apk.static -X http://dl-cdn.alpinelinux.org/alpine/v3.13/main -U --allow-untrusted --initdb add git
git --version
./sbin/apk.static -X http://dl-cdn.alpinelinux.org/alpine/v3.13/main --allow-untrusted add file
```



## QEMU
`sudo su`

```
apt-get update
apt-get install -y curl

mkdir -p /home/nix_user
cd /home/nix_user

cat << 'EOF' >> /etc/passwd
nix_user:x:6789:12345::/home/nix_user:/bin/bash
nixbld1:x:122:30000:Nix build user 1:/var/empty:/sbin/nologin
nixbld2:x:121:30000:Nix build user 2:/var/empty:/sbin/nologin
nixbld3:x:120:30000:Nix build user 3:/var/empty:/sbin/nologin
nixbld4:x:119:30000:Nix build user 4:/var/empty:/sbin/nologin
nixbld5:x:118:30000:Nix build user 5:/var/empty:/sbin/nologin
nixbld6:x:117:30000:Nix build user 6:/var/empty:/sbin/nologin
nixbld7:x:116:30000:Nix build user 7:/var/empty:/sbin/nologin
nixbld8:x:115:30000:Nix build user 8:/var/empty:/sbin/nologin
nixbld9:x:114:30000:Nix build user 9:/var/empty:/sbin/nologin
nixbld10:x:113:30000:Nix build user 10:/var/empty:/sbin/nologin
nixbld11:x:112:30000:Nix build user 11:/var/empty:/sbin/nologin
nixbld12:x:111:30000:Nix build user 12:/var/empty:/sbin/nologin
nixbld13:x:110:30000:Nix build user 13:/var/empty:/sbin/nologin
nixbld14:x:109:30000:Nix build user 14:/var/empty:/sbin/nologin
nixbld15:x:108:30000:Nix build user 15:/var/empty:/sbin/nologin
nixbld16:x:107:30000:Nix build user 16:/var/empty:/sbin/nologin
nixbld17:x:106:30000:Nix build user 17:/var/empty:/sbin/nologin
nixbld18:x:105:30000:Nix build user 18:/var/empty:/sbin/nologin
nixbld19:x:104:30000:Nix build user 19:/var/empty:/sbin/nologin
nixbld20:x:103:30000:Nix build user 20:/var/empty:/sbin/nologin
nixbld21:x:102:30000:Nix build user 21:/var/empty:/sbin/nologin
nixbld22:x:101:30000:Nix build user 22:/var/empty:/sbin/nologin
nixbld23:x:999:30000:Nix build user 23:/var/empty:/sbin/nologin
nixbld24:x:998:30000:Nix build user 24:/var/empty:/sbin/nologin
nixbld25:x:997:30000:Nix build user 25:/var/empty:/sbin/nologin
nixbld26:x:996:30000:Nix build user 26:/var/empty:/sbin/nologin
nixbld27:x:995:30000:Nix build user 27:/var/empty:/sbin/nologin
nixbld28:x:994:30000:Nix build user 28:/var/empty:/sbin/nologin
nixbld29:x:993:30000:Nix build user 29:/var/empty:/sbin/nologin
nixbld30:x:992:30000:Nix build user 30:/var/empty:/sbin/nologin
nixbld31:x:991:30000:Nix build user 31:/var/empty:/sbin/nologin
nixbld32:x:990:30000:Nix build user 32:/var/empty:/sbin/nologin
EOF

cat << 'EOF' >> /etc/group
nix_group:x:12345:
nixbld:x:30000:nixbld1,nixbld2,nixbld3,nixbld4,nixbld5,nixbld6,nixbld7,nixbld8,nixbld9,nixbld10,nixbld11,nixbld12,nixbld13,nixbld14,nixbld15,nixbld16,nixbld17,nixbld18,nixbld19,nixbld20,nixbld21,nixbld22,nixbld23,nixbld24,nixbld25,nixbld26,nixbld27,nixbld28,nixbld29,nixbld30,nixbld31,nixbld32
EOF

echo "nix_user:123" | chpasswd

chown \
   -R \
   nix_user:nix_group \
   /home/nix_user \
   /tmp

curl -L https://hydra.nixos.org/job/nix/master/buildStatic.x86_64-linux/latest/download-by-type/file/binary-dist > nix
chmod +x ./nix

chown \
   -R \
   nix_user:nix_group \
   nix
   
mkdir -p /home/nix_user/nix/var/nix/profiles/per-user
mkdir -p /home/nix_user/nix/var/nix/temproots
mkdir -p /home/nix_user/nix/var/nix/gcroots
mkdir -p /home/nix_user/nix/var/nix/db
mkdir -p /home/nix_user/nix/store
mkdir -p /home/nix_user/nix/store/.links


chown \
   -R \
   nix_user:nix_group \
   /home/nix_user/nix \
   /tmp

chmod --recursive 0755 /home/nix_user
su nix_user
cd /home/nix_user
```


```
echo '123' | su nix_user 
NIX_REMOTE="local?store=/home/nix_user/nix/store&state=/home/nix_user/nix/var/nix&log=/home/nix_user/nix/var/log/nix" \
"$(pwd)"/nix-static \
  --experimental-features 'nix-command flakes' \
  build nixpkgs#python3Minimal \
&& result/python --version
```



PATH=/run/wrappers/bin:/home/nix_user/.nix-profile/bin:/etc/profiles/per-user/nix_user/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin
export PATH='nix/var/nix/profiles/per-user/':"$PATH"

NIX_REMOTE="local?store=/home/nix_user/nix/store&state=/home/nix_user/nix/var/nix&log=/home/nix_user/nix/var/log/nix" \
"$(pwd)"/nix-static \
  --experimental-features 'nix-command flakes' \
  shell nixpkgs#hello \
  --command \
  hello

ls -al nix/store/ | grep hello


## Play with turn off 

https://github.com/seansummers/docker-alpine-apk-static


podman \
run \
--interactive=true \
--tty=true \
--rm=true \
--user=0 \
--volume="$(pwd)":'/code' \
--workdir='/home' \
docker.io/library/alpine:3.14.2 \
sh


podman \
run \
--interactive=true \
--tty=true \
--rm=true \
--user=0 \
--volume="$(pwd)":'/code' \
--workdir='/home' \
docker.io/library/ubuntu:20.04 \
bash

cat << 'EOF' >> /etc/shadow
nix_user:x:6789:12345::/home/nix_user:/bin/ash
EOF

cat << 'EOF' >> /etc/passwd
nix_user:x:6789:12345::/home/nix_user:/bin/ash
EOF

cat << 'EOF' >> /etc/group
nix_group:x:12345:
nixbld:x:30000:nixbld1,nixbld2,nixbld3,nixbld4,nixbld5,nixbld6,nixbld7,nixbld8,nixbld9,nixbld10,nixbld11,nixbld12,nixbld13,nixbld14,nixbld15,nixbld16,nixbld17,nixbld18,nixbld19,nixbld20,nixbld21,nixbld22,nixbld23,nixbld24,nixbld25,nixbld26,nixbld27,nixbld28,nixbld29,nixbld30,nixbld31,nixbld32
EOF


mkdir -p -m 0755 /home/nix_user

chown \
   -R \
   nix_user:nix_group \
   /home/nix_user \
   /tmp

passwd nix_user
su nix_user -c 'id'

ldd $(which cat)
echo 'abc' | cat

chown root:root /lib/ld-musl-x86_64.so.1
chmod 0700 /lib/ld-musl-x86_64.so.1

echo 'abc' | cat

https://askubuntu.com/a/193066
https://serverfault.com/a/45468



# SELinux

https://opensource.com/article/20/11/selinux-containers

https://www.youtube.com/watch?v=Wv9kwlabdlo
