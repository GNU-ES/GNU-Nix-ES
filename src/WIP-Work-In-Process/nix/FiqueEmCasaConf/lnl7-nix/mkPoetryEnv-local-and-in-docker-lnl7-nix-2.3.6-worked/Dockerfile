FROM nixos/nix:2.3.4 as builder

RUN nix-env --file '<nixpkgs>' --install --attr man

# WORKDIR /output/store

COPY builder.sh builder.sh

COPY default.nix default.nix
COPY poetry.lock poetry.lock
COPY pyproject.toml pyproject.toml

RUN ../../builder.sh

# #RUN nix-env --profile /output/profile --install --attr nixpkgs.python39Full nixpkgs.gcc-unwrapped
# RUN nix-env --profile /output/profile --file /build/default.nix --install
#
# #RUN cp -av $(nix-store -qR /output/profile) /output/store
# #RUN cp --archive --verbose $(nix-store -qR /output/profile) /output/store
# #RUN cp -dpR --verbose $(nix-store -qR /output/profile) /output/store
# RUN cp --no-dereference --recursive --verbose $(nix-store --query --requisites /output/profile) /output/store
#
#
# FROM ubuntu:20.04 as prod
#
# COPY --from=0 /output/store /nix/store
# COPY --from=0 /output/profile/ /usr/local/
#
# CMD [ "./usr/local/bin/nixfriday" ]
