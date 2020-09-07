FROM nixos/nix:2.3.4 as builder

# RUN nix-env --file '<nixpkgs>' --install --attr man

WORKDIR /output/store

#COPY mwe-input-file-data.nix mwe-input-file-data.nix
#COPY my-input-data-file.txt my-input-data-file.txt

#RUN nix-env --profile /output/profile --install --attr nixpkgs.python3 nixpkgs.shadow
RUN nix-env --profile /output/profile --install --attr nixpkgs.nix

#RUN nix-env --profile /output/profile --file mwe-input-file-data.nix --install

#RUN cp -av $(nix-store -qR /output/profile) /output/store
#RUN cp --archive --verbose $(nix-store -qR /output/profile) /output/store
#RUN cp -dpR --verbose $(nix-store -qR /output/profile) /output/store
RUN cp --no-dereference --recursive --verbose $(nix-store --query --requisites /output/profile) /output/store


#FROM alpine:3.12.0 as prod
FROM scratch as prod
COPY --from=0 /output/store /nix/store
COPY --from=0 /output/profile/ /usr/local/

# Set python environment variables
#ENV PYTHONDONTWRITEBYTECODE 1
#ENV PYTHONUNBUFFERED 1
#ENV PIP_NO_CACHE_DIR 0
#ENV PIP_DISABLE_PIP_VERSION_CHECK 1

#WORKDIR /app

#RUN addgroup app_group -g 5000 \
# && adduser app_user -u 5000 -D -G app_group \
# && chown -R app_user /app/

#USER app_user

#RUN nix --version
