FROM lnl7/nix:2.3.6


RUN nix-env \
    --install \
    --attr \
    nixpkgs.commonsCompress \
    nixpkgs.gnutar \
    nixpkgs.lzma.bin \
    nixpkgs.git

RUN mkdir --mode=0755 --parent ~/.config/nix/nix \
 && echo 'experimental-features = nix-command flakes ca-references' >> ~/.config/nix/nix.conf \
 && mkdir --parents /output/store /output/profile \
 && nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'id'

RUN nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix build github:NixOS/nix#nix-static'

#RUN cp -av $(nix-store -qR /output/profile) /output/store
#RUN cp --archive --verbose $(nix-store -qR /output/profile) /output/store
#RUN cp -dpR --verbose $(nix-store -qR /output/profile) /output/store
RUN cp --no-dereference --recursive --verbose $(nix-store --query --requisites /result) /output/store \
 && touch /output/store.links

# https://github.com/containers/podman/blob/master/docs/source/markdown/podman-cp.1.md#alternatives
FROM alpine:3.13.0 as ETC_FILES_ALPINE

RUN apk add --no-cache shadow \
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

RUN apk add --no-cache shadow \
 && groupadd --gid 12345 ada_group \
 && useradd \
    --create-home \
    --no-log-init \
    --uid 6789 \
    --gid ada_group ada_user

RUN mkdir \
    --parent \
    /root/.config/nix \
    /home/ada_user/.config/nix \
 && echo 'experimental-features = nix-command flakes ca-references' >> /root/.config/nix/nix.conf \
 && echo 'experimental-features = nix-command flakes ca-references' >> /home/ada_user/.config/nix/nix.conf \
 && chmod \
    0755 \
    /tmp/ \
    /home/ada_user \
 && chown \
   -R \
   ada_user:ada_group \
   /home/ada_user \
   /tmp/


FROM ubuntu:20.04 as ETC_FILES_UBUNTU

RUN groupadd --gid 30000 nixbld \
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

RUN mkdir \
    --parent \
    /root/.config/nix \
 && echo 'experimental-features = nix-command flakes ca-references' >> /root/.config/nix/nix.conf


FROM scratch AS NIX_STATIC_SCRATCH

COPY --from=ETC_FILES_ALPINE /etc/passwd /etc/passwd
COPY --from=ETC_FILES_ALPINE /etc/group /etc/group
COPY --from=ETC_FILES_ALPINE /root/.config/nix/nix.conf /root/.config/nix/nix.conf
COPY --from=ETC_FILES_ALPINE /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

COPY --from=0 /output/store /nix/store
COPY --from=0 /nix/var/nix/profiles/per-user/root/profile/bin/ /usr/local/bin/
COPY --from=0 /tmp/ /tmp/


ENTRYPOINT [ "/nix/store/0spz4mm8x6brb1r2sw96m8wb8iwdl5x4-nix-2.4pre20210326_dd77f71-x86_64-unknown-linux-musl/bin/nix-shell" ]

ENV \
    ENV=/etc/profile \
    USER=root \
    PATH=/nix/store/0spz4mm8x6brb1r2sw96m8wb8iwdl5x4-nix-2.4pre20210326_dd77f71-x86_64-unknown-linux-musl/bin:/nix/var/nix/profiles/per-user/root/profile/bin:/nix/var/nix/profiles/per-user/root/profile/sbin:/bin:/sbin:/usr/bin:/usr/sbin \
    GIT_SSL_CAINFO=/etc/ssl/certs/ca-certificates.crt \
    NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt


FROM alpine:3.13.0 AS NIX_STATIC_ALPINE_AS_ROOT

COPY --from=ETC_FILES_ALPINE /etc/passwd /etc/passwd
COPY --from=ETC_FILES_ALPINE /etc/group /etc/group
COPY --from=ETC_FILES_ALPINE /root/.config/nix/nix.conf /root/.config/nix/nix.conf
# COPY --from=ETC_FILES_ALPINE /home/ada_user /home/ada_user
#
# COPY --from=0 /nix/store/.links /nix/store/.links
# COPY --from=0 /nix/var /nix/var

COPY --from=0 /output/store /nix/store
COPY --from=0 /nix/var/nix/profiles/per-user/root/profile/bin/ /usr/local/bin/
COPY --from=0 /tmp/ /tmp/

# RUN chmod 0755 /nix/var/nix/profiles/per-user \
#  && chown -R ada_user:ada_group /nix/ /home/ada_user

RUN ln -s /nix/store/*-nix-*-x86_64-unknown-linux-musl/bin/nix /bin/nix \
 && ln -s /nix/store/*-nix-*-x86_64-unknown-linux-musl/bin/nix-shell /bin/nix-shell

# ENTRYPOINT [ "/nix/store/0spz4mm8x6brb1r2sw96m8wb8iwdl5x4-nix-2.4pre20210326_dd77f71-x86_64-unknown-linux-musl/bin/nix-shell" ]

ENV \
    ENV=/etc/profile \
    USER=root \
    PATH=/nix/store/0spz4mm8x6brb1r2sw96m8wb8iwdl5x4-nix-2.4pre20210326_dd77f71-x86_64-unknown-linux-musl/bin:/nix/var/nix/profiles/per-user/root/profile/bin:/nix/var/nix/profiles/per-user/root/profile/sbin:/bin:/sbin:/usr/bin:/usr/sbin \
    GIT_SSL_CAINFO=/etc/ssl/certs/ca-certificates.crt \
    NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt


FROM alpine:3.13.0 AS NIX_STATIC_ALPINE_ROOTLESS

COPY --from=ETC_FILES_ALPINE /etc/passwd /etc/passwd
COPY --from=ETC_FILES_ALPINE /etc/group /etc/group
COPY --from=ETC_FILES_ALPINE --chown=ada_user:ada_group /home/ada_user /home/ada_user

COPY --from=0 --chown=ada_user:ada_group /output/store /nix/store
COPY --from=0 --chown=ada_user:ada_group /nix/var /nix/var
COPY --from=0 --chown=ada_user:ada_group /tmp/ /tmp/

RUN ln -s /nix/store/*-nix-*-x86_64-unknown-linux-musl/bin/nix /bin/nix \
 && ln -s /nix/store/*-nix-*-x86_64-unknown-linux-musl/bin/nix-shell /bin/nix-shell

ENV \
    ENV=/etc/profile \
    USER=root \
    PATH=/nix/store/0spz4mm8x6brb1r2sw96m8wb8iwdl5x4-nix-2.4pre20210326_dd77f71-x86_64-unknown-linux-musl/bin:/nix/var/nix/profiles/per-user/root/profile/bin:/nix/var/nix/profiles/per-user/root/profile/sbin:/bin:/sbin:/usr/bin:/usr/sbin \
    GIT_SSL_CAINFO=/etc/ssl/certs/ca-certificates.crt \
    NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt


FROM scratch AS NIX_STATIC_SCRATCH_ROOTLESS
# FROM alpine:3.13.0 AS NIX_STATIC_SCRATCH_ROOTLESS

COPY --from=ETC_FILES_ALPINE /etc/passwd /etc/passwd
COPY --from=ETC_FILES_ALPINE /etc/group /etc/group
COPY --from=ETC_FILES_ALPINE --chown=ada_user:ada_group /home/ada_user /home/ada_user
COPY --from=ETC_FILES_ALPINE /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

COPY --from=0 --chown=ada_user:ada_group /output/store /nix/store
COPY --from=0 --chown=ada_user:ada_group /nix/var /nix/var
COPY --from=0 --chown=ada_user:ada_group /tmp/ /tmp/

# RUN ln -s /nix/store/*-nix-*-x86_64-unknown-linux-musl/bin/nix /bin/nix \
#  && ln -s /nix/store/*-nix-*-x86_64-unknown-linux-musl/bin/nix-shell /bin/nix-shell

ENTRYPOINT [ "/nix/store/0spz4mm8x6brb1r2sw96m8wb8iwdl5x4-nix-2.4pre20210326_dd77f71-x86_64-unknown-linux-musl/bin/nix" ]

ENV \
    ENV=/etc/profile \
    USER=root \
    PATH=/nix/store/0spz4mm8x6brb1r2sw96m8wb8iwdl5x4-nix-2.4pre20210326_dd77f71-x86_64-unknown-linux-musl/bin:/nix/var/nix/profiles/per-user/root/profile/bin:/nix/var/nix/profiles/per-user/root/profile/sbin:/bin:/sbin:/usr/bin:/usr/sbin \
    GIT_SSL_CAINFO=/etc/ssl/certs/ca-certificates.crt \
    NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

# FROM ubuntu:20.04 AS NIX_STATIC_UBUNTU
#
# COPY --from=ETC_FILES_UBUNTU /etc/passwd /etc/passwd
# COPY --from=ETC_FILES_UBUNTU /etc/group /etc/group
# COPY --from=ETC_FILES_UBUNTU /root/.config/nix/nix.conf /root/.config/nix/nix.conf
#
# COPY --from=0 /output/store /nix/store
# COPY --from=0 /nix/var/nix/profiles/per-user/root/profile/bin/ /usr/local/bin/
# COPY --from=0 /tmp/ /tmp/
#
# ENTRYPOINT [ "/nix/store/0spz4mm8x6brb1r2sw96m8wb8iwdl5x4-nix-2.4pre20210326_dd77f71-x86_64-unknown-linux-musl/bin/nix-shell" ]
#
# ENV \
#     ENV=/etc/profile \
#     USER=root \
#     PATH=/nix/store/0spz4mm8x6brb1r2sw96m8wb8iwdl5x4-nix-2.4pre20210326_dd77f71-x86_64-unknown-linux-musl/bin:/nix/var/nix/profiles/per-user/root/profile/bin:/nix/var/nix/profiles/per-user/root/profile/sbin:/bin:/sbin:/usr/bin:/usr/sbin \
#     GIT_SSL_CAINFO=/etc/ssl/certs/ca-certificates.crt \
#     NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
