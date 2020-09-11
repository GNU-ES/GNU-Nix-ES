FROM alpine:3.12.0

RUN apk add --no-cache --update \
    ca-certificates \
    curl \
    xz \
    shadow \
    sudo \
    tar

# TODO: check why not work
# RUN addgroup sudo \
#  && usermod -a -G sudo pedro

RUN echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel

RUN adduser -D -s /bin/sh -h /home/pedro -g "User" pedro -G wheel

RUN echo "pedro:123" | chpasswd

RUN mkdir -m 0755 /nix && chown pedro /nix

USER pedro

#RUN curl -L https://nixos.org/nix/install | sh
RUN echo "123" | sudo --user=pedro --stdin curl -L https://nixos.org/nix/install | sh \
 && echo '. /home/pedro/.nix-profile/etc/profile.d/nix.sh' >> ~/.bashrc

ONBUILD ENV \
    ENV=/etc/profile \
    USER=pedro \
    PATH=/nix/var/nix/profiles/per-user/pedro/profile/bin:/nix/var/nix/profiles/per-user/pedro/profile/sbin:/bin:/sbin:/usr/bin:/usr/sbin \
    GIT_SSL_CAINFO=/etc/ssl/certs/ca-certificates.crt \
    NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

ENV \
    ENV=/etc/profile \
    USER=pedro \
    PATH=/nix/var/nix/profiles/per-user/pedro/profile/bin:/nix/var/nix/profiles/per-user/pedro/profile/sbin:/bin:/sbin:/usr/bin:/usr/sbin \
    GIT_SSL_CAINFO=/etc/ssl/certs/ca-certificates.crt \
    NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt \
    NIX_PATH=/nix/var/nix/profiles/per-user/pedro/channels
