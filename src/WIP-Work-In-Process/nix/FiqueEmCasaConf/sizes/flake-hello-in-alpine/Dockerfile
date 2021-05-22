FROM lnl7/nix:2.3.6


RUN nix-env \
    --install \
    --attr \
    nixpkgs.commonsCompress \
    nixpkgs.gnutar \
    nixpkgs.lzma.bin \
    nixpkgs.git \
 && mkdir --mode=0755 --parent ~/.config/nix/nix \
 && echo 'experimental-features = nix-command flakes ca-references' >> ~/.config/nix/nix.conf \
 && mkdir --parents /output/store /output/profile \
 && nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix profile install nixpkgs#hello'

#RUN cp -av $(nix-store -qR /output/profile) /output/store
#RUN cp --archive --verbose $(nix-store -qR /output/profile) /output/store
#RUN cp -dpR --verbose $(nix-store -qR /output/profile) /output/store
RUN cp --no-dereference --recursive --verbose $(nix-store --query --requisites /nix/var/nix/profiles/per-user/root/profile) /output/store


#FROM scratch
FROM alpine:3.13.0
COPY --from=0 /output/store /nix/store
COPY --from=0 /nix/var/nix/profiles/per-user/root/profile/ /usr/local/
