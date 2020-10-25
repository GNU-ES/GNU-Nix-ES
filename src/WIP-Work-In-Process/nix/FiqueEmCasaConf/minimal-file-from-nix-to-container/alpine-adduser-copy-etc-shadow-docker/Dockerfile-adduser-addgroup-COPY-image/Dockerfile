FROM alpine:3.12.0 as BUILDER

COPY ./*.sh /shs/

RUN chmod 777 /shs/*

RUN cd /shs \
 && ./install.sh

# RUN apk add --no-cache shadow sudo

# RUN apk add --no-cache shadow sudo \
#  && addgroup app_group_image -g 5000 \
#  && adduser app_user_image -u 5000 -D -G app_group_image

# FROM alpine:3.12.0 as prod
#
# COPY --from=BUILDER /etc/group /etc/group
# COPY --from=BUILDER /etc/passwd /etc/passwd
# COPY --from=BUILDER /etc/shadow /etc/shadow

USER pedroregispoar

# RUN cd /shs \
#  && ls -la \
#  && ./install_nix.sh
#


RUN sudo mkdir -m 0755 /nix \
 && sudo chown pedroregispoar /nix \
 && sudo curl -L https://nixos.org/nix/install | sh \
 && echo '. /home/pedroregispoar/.nix-profile/etc/profile.d/nix.sh' >> /home/pedroregispoar/.bashrc

ONBUILD ENV \
    ENV=/etc/profile \
    USER=pedroregispoar \
    PATH=/nix/var/nix/profiles/per-user/pedroregispoar/profile/bin:/nix/var/nix/profiles/per-user/pedroregispoar/profile/sbin:/bin:/sbin:/usr/bin:/usr/sbin \
    GIT_SSL_CAINFO=/etc/ssl/certs/ca-certificates.crt \
    NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

ENV \
    ENV=/etc/profile \
    USER=pedroregispoar \
    PATH=/nix/var/nix/profiles/per-user/pedroregispoar/profile/bin:/nix/var/nix/profiles/per-user/pedroregispoar/profile/sbin:/bin:/sbin:/usr/bin:/usr/sbin \
    GIT_SSL_CAINFO=/etc/ssl/certs/ca-certificates.crt \
    NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt \
    NIX_PATH=/nix/var/nix/profiles/per-user/pedroregispoar/channels

#ENTRYPOINT ["nix-shell", "-I", "nixpkgs=channel:nixos-20.03", "--packages", "nixFlakes"]
