with import <nixpkgs> {};

python35.withPackages (ps: with ps; [ mwePyPI ])
