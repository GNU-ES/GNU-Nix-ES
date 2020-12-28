FROM nix-base:0.0.1

#RUN cd / \
# && nix-store --init \
# && nix-store --load-db < .reginfo \
# && nix-store --gc

# Why there is no long form of the flag -I in `nix-shell -I` ?
RUN sh -c 'nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes'


RUN chmod +x /nix/store/qbnrig9bqwllq7nr5m5yn6kjyqizdmjc-entrypoint-file.sh

ENTRYPOINT [ "/nix/store/qbnrig9bqwllq7nr5m5yn6kjyqizdmjc-entrypoint-file.sh" ]
