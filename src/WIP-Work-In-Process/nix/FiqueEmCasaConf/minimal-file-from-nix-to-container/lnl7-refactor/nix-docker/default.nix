{ src ? ./src/2020-09-11.nix, nixpkgs ? <nixpkgs>, system ? builtins.currentSystem }:

let
  inherit (pkgs) dockerTools stdenv buildEnv writeText;
  inherit (pkgs) bashInteractive coreutils cacert nix findutils;

  inherit (native.lib) concatStringsSep genList;

  pkgs = import unstable { system = "x86_64-linux"; };

  native = import nixpkgs { inherit system; };
  unstable = native.callPackage src { stdenv = native.stdenvNoCC; };

  shadow = pkgs.shadow.override { pam = null; };

  path = buildEnv {
    name = "system-path";
    paths = [ findutils bashInteractive coreutils nix shadow ];
  };

  nixconf = ''
    build-users-group = nixbld
    sandbox = false
  '';

  passwd = ''
    root:x:0:0::/root:/run/current-system/sw/bin/bash
    pedroregispoar:x:12345:67890::/home/pedroregispoar:
    ${concatStringsSep "\n" (genList (i: "nixbld${toString (i+1)}:x:${toString (i+30001)}:30000::/var/empty:/run/current-system/sw/bin/nologin") 32)}
  '';

  group = ''
    root:x:0:
    pedroregispoar:x:67890:
    nixbld:x:30000:${concatStringsSep "," (genList (i: "nixbld${toString (i+1)}") 32)}
  '';

  contents = stdenv.mkDerivation {
    name = "user-environment";
    phases = [ "installPhase" "fixupPhase" "checkPhase"];

    exportReferencesGraph =
      map (drv: [("closure-" + baseNameOf drv) drv]) [ path cacert unstable ];

    checkPhase = ''
        set -o pipefail
        mkdir $out/xablau
        nix --version
    '';

    installPhase = ''
      mkdir --parent $out/run/current-system
      mkdir --parent $out/var

      ln --symbolic /run $out/var/run
      ln --symbolic ${path} $out/run/current-system/sw

      mkdir --parent $out/bin
      mkdir --parent $out/usr/bin
      mkdir --parent $out/sbin

      ln --symbolic ${stdenv.shell} $out/bin/sh
      ln --symbolic ${coreutils}/bin/env $out/usr/bin/env

      mkdir --parent $out/etc/nix
      echo '${nixconf}' > $out/etc/nix/nix.conf
      echo '${passwd}' > $out/etc/passwd
      echo '${group}' > $out/etc/group

      printRegistration=1 ${pkgs.perl}/bin/perl ${pkgs.pathsFromGraph} closure-* > $out/.reginfo

      find --version
        #mkdir --mode=0755 --parent $out/nix/var
        #${pkgs.nix}/bin/nix-store --init
        #nix-store --load-db < .reginfo

        mkdir --mode=1777 --parent $out/tmp

        mkdir --mode=1777 --parent $out/jkldsfkldfhkjs

        #mkdir --parent $out/nix/var/nix/gcroots
        #mkdir --parent $out/nix/var/nix/profiles/per-user/root
        #mkdir --parent $out/root/.nix-defexpr
        #mkdir --parent $out/var/empty

        #ln --symbolic ${path} $out/nix/var/nix/gcroots/booted-system
        #ln --symbolic $out/nix/var/nix/profiles/per-user/root/profile $out/root/.nix-profile
        #ln --symbolic ${unstable} $out/root/.nix-defexpr/nixos
        #ln --symbolic ${unstable} $out/root/.nix-defexpr/nixpkgs
    '';
  };

  image = dockerTools.buildImage rec {
    name = "nix-base";
    tag = "0.0.1";
    inherit contents;

    runAsRoot = ''
        #!${pkgs.stdenv}

        ${pkgs.dockerTools.shadowSetup}

        #groupadd --gid 10 wheel

        #useradd --no-log-init -s "${pkgs.bashInteractive}/bin/bash" --home-dir /home/pedroregispoar --system --uid 5000 --gid wheel pedroregispoar

        echo 'root ALL=(ALL) ALL' >> /etc/sudoers
        echo ' %wheel ALL=(ALL) ALL' >> /etc/sudoers
        echo ' %wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

        chmod 0755 /nix/
        #chmod 4511 /sbin/sudo
        #chmod 4511 /bin/sudo
#        mkdir --mode=755 --parents /nix/store/.links
#        mkdir --mode=755 --parents /nix/var/nix/profiles/per-user/pedroregispoar

        echo "Set disable_coredump false" >> etc/sudo.conf
    '';


    extraCommands = ''
        #chown pedroregispoar ${pkgs.sudo}/bin/]

        #mkdir xablau
        mkdir --parent $out/nix/var/nix/gcroots
        mkdir --parent $out/nix/var/nix/profiles/per-user/root
        mkdir --parent $out/root/.nix-defexpr
        mkdir --parent $out/var/empty

        ln --symbolic ${path} $out/nix/var/nix/gcroots/booted-system
        ln --symbolic $out/nix/var/nix/profiles/per-user/root/profile $out/root/.nix-profile
        ln --symbolic ${unstable} $out/root/.nix-defexpr/nixos
        ln --symbolic ${unstable} $out/root/.nix-defexpr/nixpkgs

    '';


    config.Cmd = [ "${bashInteractive}/bin/bash" ];
    config.Env =
      [ "PATH=/root/.nix-profile/bin:/run/current-system/sw/bin"
        "MANPATH=/root/.nix-profile/share/man:/run/current-system/sw/share/man"
        "NIX_PAGER=cat"
        "NIX_PATH=nixpkgs=${unstable}"
        "NIX_SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt"
      ];
  };

in

{
  inherit image;
}

