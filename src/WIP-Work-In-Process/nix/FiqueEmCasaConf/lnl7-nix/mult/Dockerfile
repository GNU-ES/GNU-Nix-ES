FROM lnl7/nix:2.3.6 as base

RUN nix-env --install --attr \
    nixpkgs.binutils \
    nixpkgs.diffutils \
    nixpkgs.findutils \
    nixpkgs.git \
    nixpkgs.gnugrep \
    nixpkgs.gzip \
    nixpkgs.man \
    nixpkgs.neovim \
    nixpkgs.poetry \
    nixpkgs.poetry2nix \
    nixpkgs.python39 \
    nixpkgs.stdenv \
    nixpkgs.tree

RUN tree ./nix/store/15sy8xayildvq71kwwl4cjvy7289mbzl-python3-3.9.0a4/lib/python3.9/site-packages/ > /tmp/imagem.a 



FROM base


RUN python -m ensurepip --default-pip \
 && python -m pip install --disable-pip-version-check requests \
 && python -m pip uninstall -y pip

RUN tree ./nix/store/15sy8xayildvq71kwwl4cjvy7289mbzl-python3-3.9.0a4/lib/python3.9/site-packages/ > /tmp/imagem.b

RUN nix-env --install --attr nixpkgs.shadow \
 && nix-shell -p '(import <nixpkgs> {}).shadow.override { pam = null; }' --run 'useradd app_user' \
 && nix-env --uninstall nixpkgs.shadow 

USER app_user
