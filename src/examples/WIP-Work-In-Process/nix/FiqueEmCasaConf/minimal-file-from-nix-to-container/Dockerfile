FROM nixos/nix:2.3.4 as builder

RUN nix-env --file '<nixpkgs>' --install --attr man

WORKDIR /output/store

COPY . .

#RUN nix-env --profile /output/profile --install --attr nixpkgs.python39Full nixpkgs.gcc-unwrapped 
RUN nix-env --profile /output/profile --file default.nix --install

#RUN cp -av $(nix-store -qR /output/profile) /output/store
#RUN cp --archive --verbose $(nix-store -qR /output/profile) /output/store
#RUN cp -dpR --verbose $(nix-store -qR /output/profile) /output/store
#RUN cp --no-dereference --recursive --verbose $(nix-store --query --requisites /output/profile) /output/store


FROM debian:buster-slim as prod
COPY --from=0 /output/store /nix/store
COPY --from=0 /output/profile/ /usr/local/

