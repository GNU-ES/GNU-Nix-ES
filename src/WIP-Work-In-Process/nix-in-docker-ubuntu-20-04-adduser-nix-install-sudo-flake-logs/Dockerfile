FROM ubuntu:20.04

RUN apt-get update \
 && apt-get install --no-install-recommends --no-install-suggests -y \
    ca-certificates \
    curl \
    xz-utils \
    tar \
 && echo '##############################' \
 && adduser \
      --quiet \
      --disabled-password \
      --shell /bin/bash \
      --home /home/pedro \
      --gecos "User" \
      pedro \
 && echo "pedro:123" | chpasswd \
 && usermod \
    --append \
    --groups \
    sudo \
    pedro \
 && mkdir --mode=0755 /nix \
 && mkdir \
 --mode=0755 \
 --parent /home/pedro/.config/nix/nix \
 && chown pedro /nix /home/pedro/.config/nix/nix \
 && echo 'experimental-features = nix-command flakes ca-references' >> /home/pedro/.config/nix/nix.conf \
 && echo '##############################' \
 && addgroup --gid 30000 nixbld \
 && for i in $(seq 1 32); do adduser -S -D -h /var/empty --gecos "Nix build user $i" -u $((30000 + i)) -G nixbld nixbld$i ; done \
 && curl -L https://nixos.org/nix/install | sh \
 && echo '##############################' \
 && apt-get -y autoremove \
 && apt-get -y clean  \
 && rm -rf /var/lib/apt/lists/*

# && apt purge -y curl xz-utils tar \

# USER pedro
# RUN  id
# RUN curl -L https://nixos.org/nix/install | sh
# RUN echo "123" | sudo --stdin curl -L https://nixos.org/nix/install | sh \
#  && echo '. /home/pedro/.nix-profile/etc/profile.d/nix.sh' >> ~/.bashrc

# Why there is no long form of the flag -I in `nix-shell -I` ?
RUN /nix/var/nix/profiles/per-user/pedro/profile/bin/nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes

ENTRYPOINT ["nix-shell", "-I", "nixpkgs=channel:nixos-20.09", "--packages", "nixFlakes"]

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
