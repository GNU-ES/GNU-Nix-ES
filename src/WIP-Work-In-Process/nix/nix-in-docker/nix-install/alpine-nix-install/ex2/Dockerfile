FROM alpine:3.12.0 AS BUILD

RUN apk add --no-cache --update  \
 && apk add --no-cache --update \
    ca-certificates \
    curl \
    xz \
    shadow \
    sudo \
    tar

#RUN groupadd --gid 5000 pedro_group \
# && useradd --no-log-init --uid 5000 --gid pedro_group pedro_user
# && chown -R pedro_user:pedro_group /home/pedro_user

# https://docs.alpinelinux.org/user-handbook/0.1a/Working/post-install.html
RUN echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel

RUN adduser -D -s /bin/sh -h /home/pedro -g "User" pedro -G wheel

RUN echo "pedro:123" | chpasswd

# RUN addgroup sudo \
#  && usermod -a -G sudo pedro

RUN mkdir -m 0755 /nix && chown -R pedro /nix

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



FROM lnl7/nix:2.3.6 AS NIX

RUN mkdir --parents /output/store
RUN nix-env --profile /output/profile --install --attr nixpkgs.nix

#RUN cp -av $(nix-store -qR /output/profile) /output/store
#RUN cp --archive --verbose $(nix-store -qR /output/profile) /output/store
#RUN cp -dpR --verbose $(nix-store -qR /output/profile) /output/store
RUN cp --no-dereference --recursive --verbose $(nix-store --query --requisites /output/profile) /output/store


FROM alpine:3.12.0

RUN apk add --no-cache --update  \
 && apk add --no-cache --update \
    sudo

COPY --from=NIX /output/store /nix/store
COPY --from=NIX /output/profile/ /usr/local/

# COPY --from=BUILD /etc/group /etc/group
# COPY --from=BUILD /etc/passwd /etc/passwd
# COPY --from=BUILD /etc/profile /etc/profile
# COPY --from=BUILD /etc/shadow /etc/shadow

COPY --from=BUILD /home /home

COPY --from=BUILD /etc /etc

COPY --from=BUILD /nix/var/nix/db /nix/var/nix/db
COPY --from=BUILD /nix/var/nix/gcroots /nix/var/nix/gcroots
COPY --from=BUILD /nix/var/nix/profiles/per-user/pedro /nix/var/nix/profiles/per-user/pedro
COPY --from=BUILD /nix/var/nix/temproots /nix/var/nix/temproots
COPY --from=BUILD /nix/store/.links /nix/store/.links

ENV \
    ENV=/etc/profile \
    USER=pedro \
    PATH=/nix/var/nix/profiles/per-user/pedro/profile/bin:/nix/var/nix/profiles/per-user/pedro/profile/sbin:/bin:/sbin:/usr/bin:/usr/sbin \
    GIT_SSL_CAINFO=/etc/ssl/certs/ca-certificates.crt \
    NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt \
    NIX_PATH=/nix/var/nix/profiles/per-user/pedro/channels
             /nix/var/nix/profiles/per-user/pedro/channels

RUN ln -s /nix/var/nix/profiles/default/etc/profile.d/nix.sh /etc/profile.d/ \
 && chown -R pedro /nix \
 && mkdir -p /etc/nix \
 && echo "sandbox = false" >> /etc/nix/nix.conf \
 && addgroup -g 30000 -S nixbld \
 && for i in $(seq 1 30); do adduser -S -D -h /var/empty -g "Nix build user $i" -u $((30000 + i)) -G nixbld "nixbld$i"; done

USER pedro
