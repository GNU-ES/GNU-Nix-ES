let
    pkgs = import <nixpkgs> {};

  testFile = pkgs.writeText "test.conf" ''
    some data
  '';
  test = pkgs.writeShellScriptBin "test" ''
    set -e
    mkdir /app
    ${pkgs.coreutils}/bin/cat ${testFile}
    ${pkgs.coreutils}/bin/ls -l ${testFile}
    ${pkgs.utillinux}/bin/hexdump ${testFile}
  '';

  runAsRoot = ''
    #!${pkgs.stdenv.shell}
    ${pkgs.dockerTools.shadowSetup}
    usermod -aG sudo somebody
    chown root:root /sbin/sudo
    chmod 4755 /sbin/sudo
'';

in

pkgs.dockerTools.buildLayeredImage {

    name = "bash-interactive-play";
    tag = "0.0.1";
    created = "now";

  contents = with pkgs; [
    bashInteractive
    findutils
    git
    test
   ];

   config.Entrypoint = [ "${pkgs.bashInteractive}/bin/bash" ];

    config = {
      Env = [
        "NIX_PAGER=cat"
        # A user is required by nix
        # https://github.com/NixOS/nix/blob/9348f9291e5d9e4ba3c4347ea1b235640f54fd79/src/libutil/util.cc#L478
        "USER=root"
        "ENV=/etc/profile"
        "PATH=/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:/bin:/sbin:/usr/bin:/usr/sbin"
        "NIX_PATH=/nix/var/nix/profiles/per-user/root/channels"
        "SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bunle.crt"
        "GIT_SSL_CAINFO=${pkgs.cacert}/etc/ssl/certs/ca-bunle.crt"
        "NIX_VERSION=2.3.7"
      ];
    };

}