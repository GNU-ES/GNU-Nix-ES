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

#RUN groupadd --gid 5000 pedro_group \
# && useradd --no-log-init --uid 5000 --gid pedro_group pedro_user
# && chown -R pedro_user:pedro_group /home/pedro_user

RUN adduser --quiet --disabled-password --shell /bin/bash --home /home/pedro --gecos "User" pedro

RUN echo "pedro:123" | chpasswd

RUN usermod -a -G sudo pedro

RUN mkdir -m 0755 /nix && chown pedro /nix

USER pedro

#RUN curl -L https://nixos.org/nix/install | sh
RUN echo "123" | sudo -S curl -L https://nixos.org/nix/install | sh \
 && echo '. /home/pedro/.nix-profile/etc/profile.d/nix.sh' >> ~/.bashrc

#ARG NIX_VERSION=2.3.6
#RUN wget https://nixos.org/releases/nix/nix-${NIX_VERSION}/nix-${NIX_VERSION}-x86_64-linux.tar.xz \
#&& tar xf nix-${NIX_VERSION}-x86_64-linux.tar.xz
  
#RUN groupadd --system nixbld \
# && for n in $(seq 1 10); do \
#    useradd \
#    --comment "Nix build user $n" \ 
#    --gid nixbld \
#    --groups nixbld \
#    --home-dir /var/empty \
#    --no-create-home \
#    --no-user-group \
#    --shell "$(which nologin)" \
#    --system \
#    nixbld$n; done

#RUN mkdir -m 0755 /etc/nix \
#  && echo 'sandbox = false' > /etc/nix/nix.conf \
#  && mkdir -m 0755 /nix && USER=root sh nix-${NIX_VERSION}-x86_64-linux/install \
#  && ln -s /nix/var/nix/profiles/default/etc/profile.d/nix.sh /etc/profile.d/ \
#  && rm -r /nix-${NIX_VERSION}-x86_64-linux* \
#  && rm -rf /var/cache/apk/* \
#  && /nix/var/nix/profiles/default/bin/nix-collect-garbage --delete-old \
#  && /nix/var/nix/profiles/default/bin/nix-store --optimise \
#  && /nix/var/nix/profiles/default/bin/nix-store --verify --check-contents

# && useradd --create-home --no-log-init --uid 5000 --gid app_group app_user \
# && chown -R app_user:app_group /nix
# && chown -R app_user:app_group /code/

#USER app_user



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