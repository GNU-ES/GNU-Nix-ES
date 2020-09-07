FROM nixos/nix:2.3.4 as auxiliary

RUN nix-env --file '<nixpkgs>' --install --attr man


FROM nixos/nix:2.3.4 as builder

RUN nix-env --file '<nixpkgs>' --install --attr man

RUN mkdir --parents /output/store

#RUN nix-env --profile /output/profile --install redis

RUN touch /output/profile.lock

WORKDIR /build

COPY /default.nix /build/default.nix
COPY /nixfriday.py /build/nixfriday.py
COPY /poetry.lock /build/poetry.lock
COPY /pyproject.toml /build/pyproject.toml

RUN nix-env --profile /output/profile --install --file default.nix

# --no-dereference --preserve=links --recursive --verbose
#RUN cp -av $(nix-store -qR /output/profile) /output/store

#RUN cp --archive --verbose $(nix-store -qR /output/profile) /output/store

#RUN cp -dpR --verbose $(nix-store -qR /output/profile) /output/store
RUN cp --no-dereference --recursive --verbose $(nix-store --query --requisites /output/profile) /output/store


FROM scratch
COPY --from=0 /output/store /nix/store
COPY --from=0 /output/profile/ /usr/local/