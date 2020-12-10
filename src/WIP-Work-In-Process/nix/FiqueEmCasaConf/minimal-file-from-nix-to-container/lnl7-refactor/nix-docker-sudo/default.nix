{ src ? ./src/2020-09-11.nix, nixpkgs ? <nixpkgs>
, system ? builtins.currentSystem }:

let
  inherit (pkgs) dockerTools stdenv buildEnv writeText;
  inherit (pkgs)
    bashInteractive coreutils cacert nix findutils file which su sudo shadow;

  inherit (native.lib) concatStringsSep genList;

  pkgs = import unstable { system = "x86_64-linux"; };

  native = import nixpkgs { inherit system; };
  unstable = native.callPackage src { stdenv = native.stdenvNoCC; };

  #    shadow = pkgs.shadow.override { pam = null; };

  path = buildEnv {
    name = "system-path";
    paths =
      [ findutils file bashInteractive coreutils nix which shadow su sudo ];
  };

  nixconf = ''
    build-users-group = nixbld
    sandbox = false
  '';

  passwd = ''
    root:x:0:0::/root:/run/current-system/sw/bin/bash
    pedroregispoar:x:12345:10::/home/pedroregispoar:/run/current-system/sw/bin/bash
    ${concatStringsSep "\n" (genList (i:
      "nixbld${toString (i + 1)}:x:${
        toString (i + 30001)
      }:30000::/var/empty:/run/current-system/sw/bin/nologin") 32)}
  '';

  group = ''
    root:x:0:
    pedroregispoar:x:67890:
    wheel:x:10:
    nixbld:x:30000:${
      concatStringsSep "," (genList (i: "nixbld${toString (i + 1)}") 32)
    }
  '';

  contents = stdenv.mkDerivation {
    name = "user-environment";
    phases = [ "installPhase" "fixupPhase" ];

    exportReferencesGraph =
      map (drv: [ ("closure-" + baseNameOf drv) drv ]) [ path cacert unstable ];

    installPhase = ''
      mkdir --parent $out/run/current-system
      mkdir --parent $out/var

      ln --symbolic /run $out/var/run
      ln --symbolic ${path} $out/run/current-system/sw

      mkdir --parent $out/bin
      mkdir --parent $out/usr/bin
      mkdir --parent $out/sbin

      ln --symbolic ${sudo}/bin/sudo $out/bin/sudo
      ln --symbolic ${su}/bin/su $out/bin/su

      ln --symbolic ${stdenv.shell} $out/bin/sh
      ln --symbolic ${coreutils}/bin/env $out/usr/bin/env

      mkdir --parent $out/etc/nix
      echo '${nixconf}' > $out/etc/nix/nix.conf
      echo '${passwd}' > $out/etc/passwd
      echo '${group}' > $out/etc/group

      printRegistration=1 ${pkgs.perl}/bin/perl ${pkgs.pathsFromGraph} closure-* > $out/.reginfo

      mkdir --mode=1777 --parent $out/tmp
    '';
  };

  entrypoint = pkgs.writeScript "entrypoin-file.sh" ''
    #!${pkgs.stdenv.shell}

    echo 'Runnung the config.Entrypoint script!'

    mkdir --parent /nix/var/nix/gcroots
    mkdir --parent /var/empty

    mkdir --parent /nix/var/nix/profiles/per-user/root
    mkdir --parent /root/.nix-defexpr

    mkdir --parent /nix/var/nix/profiles/per-user/pedroregispoar
    mkdir --parent /pedroregispoar/.nix-defexpr


    ln --symbolic ${path} /nix/var/nix/gcroots/booted-system

    # For root
    ln --symbolic /nix/var/nix/profiles/per-user/root/profile /root/.nix-profile
    ln --symbolic ${unstable} /root/.nix-defexpr/nixos
    ln --symbolic ${unstable} /root/.nix-defexpr/nixpkgs

    #For pedroregispoar
    ln --symbolic /nix/var/nix/profiles/per-user/pedroregispoar/profile /pedroregispoar/.nix-profile
    ln --symbolic ${unstable} /pedroregispoar/.nix-defexpr/nixos
    ln --symbolic ${unstable} /pedroregispoar/.nix-defexpr/nixpkgs

    nix-store --init
    nix-store --load-db < /.reginfo

    #chmod 4511 /sbin/sudo
    #chmod 4511 /bin/sudo

    exec "$@"
  '';

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

      #    chmod 4511 /bin/su
      #    chmod 4511 /bin/sudo
      #    chmod 4511 /run/current-system/sw/bin/sudo

          echo "Set disable_coredump false" >> etc/sudo.conf
    '';

    #extraCommands = ''
    #'';

    config.Entrypoint = [ entrypoint ];

    config.Cmd = [ "${bashInteractive}/bin/bash" ];

    config.Env = [
      "PATH=/root/.nix-profile/bin:/pedroregispoar/.nix-profile/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/sbin:/bin:/sbin:/usr/bin:/usr/sbin"
      "MANPATH=/root/.nix-profile/share/man:/pedroregispoar/.nix-profile/share/man:/run/current-system/sw/share/man"
      "NIX_PAGER=cat"
      "USER=pedroregispoar"
      "HOME=/home/pedroregispoar"
      "NIX_PATH=nixpkgs=${unstable}"
      "NIX_SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt"
    ];
  };

in { inherit image; }
