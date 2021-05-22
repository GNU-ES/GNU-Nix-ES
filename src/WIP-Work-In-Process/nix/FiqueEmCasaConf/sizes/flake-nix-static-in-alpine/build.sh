#!/usr/bin/env sh
# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


nix build github:NixOS/nix#nix-static


file result/bin/nix


sudo rm --recursive --force output
mkdir --mode=0755 output

cp --no-dereference --recursive --verbose $(nix-store --query --requisites result) output

du -hs  output


cp --force output/*-nix-2.4*-x86_64-unknown-linux-musl/bin/nix nix-static

./nix-static shell nixpkgs#hello --command hello

./nix-static build github:NixOS/nix#nix-static

rm --recursive --force result result-dev result-doc

sudo rm --recursive --force output


sha256sum result/bin/nix



mkdir --mode=0755 output
cp --no-dereference --recursive --verbose $(nix-store --query --requisites result) output
podman \
run \
--interactive=true \
--tty=true \
--rm=true \
--user=0 \
--volume="$(pwd)":'/code' \
--workdir=/code' \
docker.io/library/alpine:3.13.0 \
sh

mkdir -p /home/nix_user/nix-static/

cd /home/nix_user

cp -r /code/output/* /home/nix_user/nix-static/

cat << 'EOF' >> /etc/passwd
nix_user:x:6789:12345::/home/nix_user:/bin/ash
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

HOME='/home/nix_user'
NIX_STATIC="$(echo $(pwd)/nix-static/*-nix-2.4pre*-x86_64-unknown-linux-musl/bin)"
NIX_REMOTE="local?store=/home/nix_user/nix/store&state=/home/nix_user/nix/var/nix&log=/home/nix_user/nix/var/log/nix" \
"$NIX_STATIC"/nix \
  --experimental-features 'nix-command flakes' \
  build nixpkgs#hello \
  --show-trace \
  >> file.txt 2>&1
  cat file.txt


NIX_STATIC="$(echo $(pwd)/nix-static/*-nix-2.4pre*-x86_64-unknown-linux-musl/bin)"
NIX_REMOTE="local?store=/home/nix_user/nix/store&state=/home/nix_user/nix/var/nix&log=/home/nix_user/nix/var/log/nix" \
"$NIX_STATIC"/nix \
  --experimental-features 'nix-command flakes' \
  shell nixpkgs#python3Minimal


chown \
   -R \
   nix_user:nix_group \
   /home/nix_user \
   /tmp \
   /nix

apk add --no-cache shadow \
 && groupadd --gid 12345 nix_group \
 && useradd \
    --create-home \
    --no-log-init \
    --uid 6789 \
    --gid nix_group nix_user \
 && groupadd --gid 30000 nixbld \
 && for n in $(seq 1 32); do \
    useradd \
    --comment "Nix build user $n" \
    --gid nixbld \
    --groups nixbld \
    --home-dir /var/empty \
    --no-create-home \
    --no-user-group \
    --shell "$(which nologin)" \
    --system \
    nixbld$n; done


mkdir nix-static
cd nix-static/
curl -L https://hydra.nixos.org/job/nix/master/buildStatic.x86_64-linux/latest/download-by-type/file/binary-dist > nix
chmod +x ./nix
