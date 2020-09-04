FROM nixos/nix:2.3.6

RUN mkdir --parents /output/store
RUN nix-env --profile /output/profile --install --attr nixpkgs.gcc

#RUN cp -av $(nix-store -qR /output/profile) /output/store
#RUN cp --archive --verbose $(nix-store -qR /output/profile) /output/store
#RUN cp -dpR --verbose $(nix-store -qR /output/profile) /output/store
RUN cp --no-dereference --recursive --verbose $(nix-store --query --requisites /output/profile) /output/store


FROM centos:5.11
COPY --from=0 /output/store /nix/store
COPY --from=0 /output/profile/ /usr/local/
