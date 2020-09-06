FROM nixos/nix:2.3.4

# mkdir --parents /output/store

# addgroup app_group -g 5000 && adduser app_user -u 5000 -D -G app_group

RUN mkdir --parents /output/store
RUN nix-env --profile /output/profile --install --attr nixpkgs.stdenv

#RUN cp -av $(nix-store -qR /output/profile) /output/store
#RUN cp --archive --verbose $(nix-store -qR /output/profile) /output/store
#RUN cp -dpR --verbose $(nix-store -qR /output/profile) /output/store
RUN cp --no-dereference --recursive --verbose $(nix-store --query --requisites /output/profile) /output/store


FROM scratch
COPY --from=0 /output/store /nix/store
COPY --from=0 /output/profile/ /usr/local/


