{ src ? ./src/2020-09-11.nix, nixpkgs ? <nixpkgs>, system ? builtins.currentSystem }:

let
    inherit (pkgs) dockerTools stdenv buildEnv writeText;
    inherit (pkgs) bashInteractive cacert commonsCompress coreutils findutils git gnutar gzip nix man man-db qemu su which;

    inherit (native.lib) concatStringsSep genList;

    pkgs = import unstable { system = "x86_64-linux"; };

    native = import nixpkgs { inherit system; };
    unstable = native.callPackage src { stdenv = native.stdenvNoCC; };

    shadow = pkgs.shadow.override { pam = null; };

    sudo = pkgs.sudo.override { pam = null; };

    path = buildEnv {
        name = "system-path";
        paths = [ bashInteractive cacert commonsCompress coreutils findutils git gnutar gzip pkgs.lzma.bin nix man man-db shadow su sudo which ];
    };

    nixconf = ''
        build-users-group = nixbld
        sandbox = false
        experimental-features = nix-command flakes ca-references
        system-features = kvm nixos-test
    '';

    passwd = ''
        root:x:0:0::/root:${run_time_bash}
        ${user_name}:x:${user_id}:${user_id}::/home/${user_name}:${run_time_bash}
        ${concatStringsSep "\n" (genList (i: "nixbld${toString (i+1)}:x:${toString (i+30001)}:30000::/var/empty:/run/current-system/sw/bin/nologin") 32)}
    '';
#        ${user_name}:x:${user_id}:${user_group_id}::/home/${user_name}:${run_time_bash}

    group = ''
        root:x:0:
        wheel:x:1:${user_name},kvm
        kvm:x:2:kvm
        ${user_group}:x:${user_group_id}:
        nixbld:x:30000:${concatStringsSep "," (genList (i: "nixbld${toString (i+1)}") 32)}
    '';
#${user_group}:x:${user_group_id}:${user_name}
    sudoconf = ''
        Set disable_coredump false
    '';

    etcsudoers = ''
            ${toString "root ALL=(ALL) ALL"}
            ${toString " %wheel ALL=(ALL) ALL"}
            ${toString " %wheel ALL=(ALL) NOPASSWD: ALL"}
       '';

    # Sorry free software
    nixconfig = ''
             ${toString "{ allowUnfree = true; }"}
        '';

    contents = stdenv.mkDerivation {
        name = "user-environment";
        phases = [ "installPhase" "fixupPhase" "checkPhase"];

        exportReferencesGraph =
            map (drv: [("closure-" + baseNameOf drv) drv]) [ path unstable ];

        installPhase = ''
            mkdir --parent $out/run/current-system
            mkdir --parent $out/var

            ln --symbolic /run    $out/var/run
            ln --symbolic ${path} $out/run/current-system/sw

            mkdir --parent $out/bin
            mkdir --parent $out/usr/bin
            mkdir --parent $out/sbin

            ln --symbolic ${stdenv.shell}      $out/bin/sh
            ln --symbolic ${coreutils}/bin/env $out/usr/bin/env

            mkdir --parent $out/etc/nix
            echo '${nixconf}' > $out/etc/nix/nix.conf
            echo '${passwd}' > $out/etc/passwd
            echo '${group}' > $out/etc/group
            echo '${sudoconf}' > $out/etc/sudo.conf
            echo '${etcsudoers}' > $out/etc/sudoers

            mkdir --parent $out/root/.config/nixpkgs
            echo '${nixconfig}' > $out/root/.config/nixpkgs/config.nix

            mkdir --parent $out/${user_name}/.config/nixpkgs
            echo '${nixconfig}' > $out/${user_name}/.config/nixpkgs/config.nix

            printRegistration=1 ${pkgs.perl}/bin/perl ${pkgs.pathsFromGraph} closure-* > $out/.reginfo

            mkdir --mode=1777 --parent $out/tmp

            mkdir --mode=0755 --parent $out/nix/store/.links
            mkdir --mode=0755 --parent $out/nix/var/nix/temproots
            mkdir --mode=0755 --parent $out/home/${user_name}/.nix-defexpr
        '';
    };

    user_name = "pedroregispoar";
    user_id = "999";

    user_group = "pedroregispoargroup";
    user_group_id = "88";

    volume_and_workdir = "/code";

    # TODO: check what exactly is this.
    run_time_bash = "/run/current-system/sw/bin/bash";


    entrypoint = pkgs.writeScript "entrypoin-file.sh" ''
        #!${pkgs.stdenv.shell}
        ${pkgs.dockerTools.shadowSetup}

        #echo 'Runnung the config.Entrypoint script!'
        #chmod 4755 $out/run/current-system/sw/bin/sudo
        #chmod 4755  ${pkgs.sudo}/bin/
        #chmod 4755 /nix/store/pan38n758f87hxj2ngmmsd3x4ld6s4m5-user-environment/run/current-system/sw/bin/sudo
        #chmod 4755 $(readlink $(which su)) 2> /dev/null
        chmod 4755 $(readlink $(which sudo)) 2> /dev/null

        chmod 755 --recursive /tmp 2> /dev/null
        chown --recursive pedroregispoar:wheel /tmp 2> /dev/null


        set -e

        # allow the container to be started with `--user`
        if [ "$(${pkgs.coreutils}/bin/id --user)" = "0" ]; then

            NEW_USER_NAME=${user_name}
            NEW_GROUP_NAME=${user_group}
            VOLUME_AND_WORKDIR=${volume_and_workdir}

            exec ${pkgs.gosu}/bin/gosu "$NEW_USER_NAME":"$NEW_GROUP_NAME" "$BASH_SOURCE" "$@"
        fi
        exec "$@"
    '';

    image = dockerTools.buildImage rec {
        name = "nix-base";
        tag = "0.0.1";
        inherit contents;

        runAsRoot = ''
        '';


        extraCommands = ''
            mkdir --parent $out/nix/var/nix/gcroots
            mkdir --mode=0755 --parent $out/nix/var/nix/profiles/per-user/root
            mkdir --parent $out/root/.nix-defexpr
            mkdir --parent $out/var/empty

            ln --symbolic ${path} $out/nix/var/nix/gcroots/booted-system
            ln --symbolic $out/nix/var/nix/profiles/per-user/root/profile $out/root/.nix-profile
            ln --symbolic ${unstable} $out/root/.nix-defexpr/nixos
            ln --symbolic ${unstable} $out/root/.nix-defexpr/nixpkgs

        '';

        config.Entrypoint = [ entrypoint ];

        config.Cmd = [ "${bashInteractive}/bin/bash" ];

        config.Env = [ "PATH=/root/.nix-profile/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:/bin:/sbin:/usr/bin:/usr/sbin"
            "MANPATH=/root/.nix-profile/share/man:/home/pedroregispoar/.nix-profile/share/man:/run/current-system/sw/share/man"
            "NIX_PAGER=cat"
            "NIX_PATH=nixpkgs=${unstable}"
            "NIX_SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt"
            "ENV=/etc/profile"
        ];
    };
in

{
  inherit image;
}

