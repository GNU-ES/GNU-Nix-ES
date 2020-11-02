{ src ? ./srcs/2020-09-11.nix, nixpkgs ? <nixpkgs>, system ? builtins.currentSystem }:

let
  inherit (pkgs) dockerTools stdenv buildEnv writeText;
  inherit (pkgs) bashInteractive coreutils cacert nix;

  inherit (native.lib) concatStringsSep genList;

  pkgs = import unstable { system = "x86_64-linux"; };

  native = import nixpkgs { inherit system; };
  unstable = native.callPackage src { stdenv = native.stdenvNoCC; };

  shadow = pkgs.shadow.override { pam = null; };

  path = buildEnv {
    name = "system-path";
    paths = [ bashInteractive coreutils nix shadow ];
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
    phases = [ "installPhase" "fixupPhase" ];

    exportReferencesGraph =
      map (drv: [("closure-" + baseNameOf drv) drv]) [ path cacert unstable ];

    installPhase = ''
      mkdir -p $out/run/current-system $out/var
      ln -s /run $out/var/run
      ln -s ${path} $out/run/current-system/sw

      mkdir -p $out/bin $out/usr/bin $out/sbin
      ln -s ${stdenv.shell} $out/bin/sh
      ln -s ${coreutils}/bin/env $out/usr/bin/env

      mkdir -p $out/etc/nix
      echo '${nixconf}' > $out/etc/nix/nix.conf
      echo '${passwd}' > $out/etc/passwd
      echo '${group}' > $out/etc/group

      printRegistration=1 ${pkgs.perl}/bin/perl ${pkgs.pathsFromGraph} closure-* > $out/.reginfo

      mkdir --mode=1777 --parent $out/tmp
      #mkdir --parent $out/nix/var/nix/gcroots $out/nix/var/nix/profiles/per-user/root $out/root/.nix-defexpr $out/var/empty
      #ln -s ${path} $out/nix/var/nix/gcroots/booted-system
      #ln -s $out/nix/var/nix/profiles/per-user/root/profile $out/root/.nix-profile
      #ln -s ${unstable} $out/root/.nix-defexpr/nixos
      #ln -s ${unstable} $out/root/.nix-defexpr/nixpkgs
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

