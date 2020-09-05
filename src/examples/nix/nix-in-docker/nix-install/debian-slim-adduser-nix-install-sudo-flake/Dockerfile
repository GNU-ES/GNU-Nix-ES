FROM debian:buster-20200803-slim

RUN apt-get update \
 && apt-get install --no-install-recommends --no-install-suggests -y \
    ca-certificates \
    curl \
    xz-utils \
    sudo \
    tar \
 && apt-get -y autoremove \
 && apt-get -y clean  \
 && rm -rf /var/lib/apt/lists/*

RUN adduser --quiet --disabled-password --shell /bin/bash --home /home/pedro --gecos "User" pedro \
 && echo "pedro:123" | chpasswd \
 && usermod -a -G sudo pedro \
 && mkdir -m 0755 /nix \
 && chown pedro /nix

USER pedro

RUN mkdir -p ~/.config/nix/nix \
 && echo 'experimental-features = nix-command flakes ca-references' >> /home/pedro/.config/nix/nix.conf

USER pedro

#RUN curl -L https://nixos.org/nix/install | sh
RUN echo "123" | sudo -S curl -L https://nixos.org/nix/install | sh \
 && echo '. /home/pedro/.nix-profile/etc/profile.d/nix.sh' >> ~/.bashrc

# TODO:
# USER root
#
# # RUN echo "123" | sudo -S sh -c 'nix-shell -I nixpkgs=channel:nixos-20.03 --packages nixFlakes'
# RUN . /home/pedro/.nix-profile/etc/profile.d/nix.sh \
#  && nix-shell -I nixpkgs=channel:nixos-20.03 --packages nixFlakes

USER pedro

ENTRYPOINT ["nix-shell", "-I", "nixpkgs=channel:nixos-20.03", "--packages", "nixFlakes"]

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

