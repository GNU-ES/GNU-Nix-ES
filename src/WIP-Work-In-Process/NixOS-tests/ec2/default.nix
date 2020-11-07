{ pkgs ? import <nixpkgs> {} }: {
    test = pkgs.nixosTest ./ec2.nix;
}