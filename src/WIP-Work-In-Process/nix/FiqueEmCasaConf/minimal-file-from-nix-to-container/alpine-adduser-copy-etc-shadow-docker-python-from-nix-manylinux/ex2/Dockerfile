FROM alpine:3.12.0 as BUILD_USER

RUN apk add --no-cache shadow \
 && addgroup app_group -g 5000 \
 && adduser app_user -u 5000 -D -G app_group \
 && apk del shadow


#FROM nixos/nix:2.3.4 as BUILD_PYTHON

FROM lnl7/nix:2020-06-07 as BUILD_PYTHON

# COPY build/ /output/store/

WORKDIR /output/store

RUN nix-env --profile /output/profile --install --attr \
    nixpkgs.man
#RUN nix-env --profile /output/profile --install --attr \
#    nixpkgs.python3
#    nixpkgs.xorg.libX11 \
#    nixpkgs.xorg.libXext \
#    nixpkgs.xorg.libXrender \
#    nixpkgs.xorg.libICE \
#    nixpkgs.glib

RUN nix-env --profile /output/profile --file many.nix --install
# RUN nix-env --profile /output/profile --install --file default2.nix

RUN cp --no-dereference --recursive --verbose $(nix-store --query --requisites /output/profile) /output/store


#FROM alpine:3.12.0 as BUILD_APP

#COPY --from=BUILD_USER /etc/group /etc/group
#COPY --from=BUILD_USER /etc/group /etc/group
#COPY --from=BUILD_USER /etc/shadow /etc/shadow

#COPY --from=BUILD_PYTHON /output/store /nix/store
#COPY --from=BUILD_PYTHON /output/profile/ /usr/local/

# Why?
# USER app_user

#RUN python -m ensurepip --default-pip \
# && pip install --upgrade pip==20.2.1 \
# && pip install flask \
# && pip uninstall -y pip



FROM alpine:3.12.0

# COPY --from=BUILD_USER /etc/group /etc/group
# COPY --from=BUILD_USER /etc/passwd /etc/passwd
# COPY --from=BUILD_USER /etc/shadow /etc/shadow
#
# COPY --from=BUILD_PYTHON /output/store /nix/store
# COPY --from=BUILD_PYTHON /output/profile/ /usr/local/

#COPY --from=BUILD_APP ./nix/store/ihy2vly61ndky6qlv1q4dfdiv28vszkh-python3-3.7.7/lib/python3.7/site-packages/ ./nix/store/ihy2vly61ndky6qlv1q4dfdiv28vszkh-python3-3.7.7/lib/python3.7/site-packages/

USER app_user

