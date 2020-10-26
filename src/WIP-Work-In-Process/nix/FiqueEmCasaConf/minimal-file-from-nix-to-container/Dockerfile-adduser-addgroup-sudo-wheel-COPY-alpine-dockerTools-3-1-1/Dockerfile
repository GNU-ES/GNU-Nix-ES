FROM alpine:3.12.0 as builder


COPY ./*.sh /shs/

RUN chmod 777 /shs/*

RUN cd /shs \
 && ./install.sh



FROM alpine-gnu-nix-es:3.12.0 as prod


RUN apk update \
&& apk add --no-cache --clean-protected 'sudo'

# RUN chown -R pedroregispoar /nix
#
# USER pedroregispoar
#
# RUN id
#
# ENV SSL_CERT_FILE=/nix/store/fna8lggi520pgvdwi8p1xyzcj9706j04-nss-cacert-3.40.1/etc/ssl/certs/ca-bundle.crt
#
# RUN sudo mkdir /home/$USER
#
# # RUN USER=pedroregispoar curl -L https://nixos.org/nix/install | sh
#
# RUN sudo mkdir /home/pedroregispoar/.nix-defexpr \
# && sudo chmod 777 /home/pedroregispoar/.nix-defexpr/ \
# && nix-channel --update \
# && USER=pedroregispoar curl -L https://nixos.org/nix/install | sh
#
# ENV PATH=/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:/bin:/sbin:/usr/bin:/usr/sbin
