{ src ? ./src/2020-09-11.nix, nixpkgs ? <nixpkgs>, system ? builtins.currentSystem }:

let
    inherit (pkgs) dockerTools stdenv buildEnv writeText;
    inherit (pkgs) bashInteractive coreutils cacert nix findutils su;

    inherit (native.lib) concatStringsSep genList;

    pkgs = import unstable { system = "x86_64-linux"; };

    native = import nixpkgs { inherit system; };
    unstable = native.callPackage src { stdenv = native.stdenvNoCC; };

    shadow = pkgs.shadow.override { pam = null; };

    sudo = pkgs.sudo.override { pam = null; };

    path = buildEnv {
        name = "system-path";
        paths = [ findutils bashInteractive coreutils nix shadow su sudo ];
    };

    nixconf = ''
        build-users-group = nixbld
        sandbox = false
    '';

    passwd = ''
        root:x:0:0::/root:${run_time_bash}
        ${new_user_name}:x:${new_user_name_id}:${new_user_group_id}::/home/${new_user_name}:${run_time_bash}
        ${concatStringsSep "\n" (genList (i: "nixbld${toString (i+1)}:x:${toString (i+30001)}:30000::/var/empty:/run/current-system/sw/bin/nologin") 32)}
    '';

    group = ''
        root:x:0:
        wheel:x:1:${new_user_name}
        ${new_user_name}:x:100:
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
            find --version
            #nix-store --init
            #nix-store --load-db < /.reginfo

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

            mkdir --mode=1777 --parent $out/tmp

            # If add breaks the build
            mkdir --mode=0755 --parent $out/nix/store/.links
            mkdir --mode=0755 --parent $out/nix/var/nix/temproots
            mkdir --mode=0755 --parent $out/home/pedroregispoar/.nix-defexpr
        '';
    };

    new_user_name = "pedroregispoar";
    new_user_name_id = "1001";

    new_user_group = "users";
    new_user_group_id = "100";

    volume_and_workdir = "/code";

    # TODO: check what exactly is this.
    run_time_bash = "/run/current-system/sw/bin/bash";


    entrypoint = pkgs.writeScript "entrypoin-file.sh" ''
        #!${pkgs.stdenv.shell}
        ${pkgs.dockerTools.shadowSetup}

        echo 'Runnung the config.Entrypoint script!'

        mkdir --parent /nix/var/nix/gcroots
        mkdir --parent /var/empty

        mkdir --parent /nix/var/nix/profiles/per-user/root
        #mkdir --parent /root/.nix-defexpr

        mkdir --parent /nix/var/nix/profiles/per-user/pedroregispoar
        mkdir --parent /pedroregispoar/.nix-defexpr

        #ln --symbolic ${path} /nix/var/nix/gcroots/booted-system

        # For root
        #ln --symbolic /nix/var/nix/profiles/per-user/root/profile /root/.nix-profile
        #ln --symbolic ${unstable} /root/.nix-defexpr/nixos
        #ln --symbolic ${unstable} /root/.nix-defexpr/nixpkgs

        #For pedroregispoar
        #ln --symbolic /nix/var/nix/profiles/per-user/pedroregispoar/profile /pedroregispoar/.nix-profile
        #ln --symbolic ${unstable} /pedroregispoar/.nix-defexpr/nixos
        #ln --symbolic ${unstable} /pedroregispoar/.nix-defexpr/nixpkgs

        #echo '@@@@@@@'
        #nix-store --init
        #nix-store --load-db < /.reginfo

        chmod 4755 $(readlink /run/current-system/sw/bin/sudo)

        set -e

        # allow the container to be started with `--user`
        if [ "$(${pkgs.coreutils}/bin/id --user)" = "0" ]; then

            NEW_USER_NAME=${new_user_name}
            NEW_GROUP_NAME=${new_user_group}
            VOLUME_AND_WORKDIR=${volume_and_workdir}

            echo "$NEW_USER_NAME"
            echo "$NEW_GROUP_NAME"
            echo "$VOLUME_AND_WORKDIR"

            cat /etc/passwd
            cat /etc/group

            OLD_USER_ID=$( ${pkgs.getent}/bin/getent passwd "$NEW_USER_NAME" | cut --field=3 --delimiter=:)
            NEW_USER_ID=$(stat --format="%u" "$VOLUME_AND_WORKDIR")

            echo "$OLD_USER_ID"
            echo "$NEW_USER_ID"

            if [ "$OLD_USER_ID" != "$NEW_USER_ID" ]; then
                echo "Changing uid (user identifier) of "$NEW_USER_NAME" from $OLD_USER_ID to $NEW_USER_ID"
                stat /etc/passwd

                chmod 1777 /etc/passwd
                chmod 1777 /etc/group

                chown "$NEW_USER_NAME":"$NEW_GROUP_NAME"  /etc/passwd
                chown "$NEW_USER_NAME":"$NEW_GROUP_NAME"  /etc/group

                stat /etc/passwd

                usermod --uid "$NEW_USER_ID" --non-unique "$NEW_USER_NAME"

                ${pkgs.findutils}/bin/find / -xdev -user "$OLD_USER_ID" -exec chown --no-dereference "$NEW_USER_NAME" {} \;
            fi

            OLD_GROUP_ID=$(${pkgs.getent}/bin/getent group ${new_user_group_id} | cut --field=3 --delimiter=:)
            NEW_GROUP_ID=$(stat --format="%g" $VOLUME_AND_WORKDIR)

            if [ "$OLD_GROUP_ID" != "$NEW_GROUP_ID" ]; then
                echo "Changing gid (group identifier) of "$NEW_GROUP_NAME" from $OLD_GROUP_ID to $NEW_GROUP_ID"
                groupmod --gid "$NEW_GROUP_ID" --non-unique "$NEW_GROUP_NAME"

                ${pkgs.findutils}/bin/find / -xdev -group "$OLD_GROUP_ID" -exec chgrp --no-dereference "$NEW_GROUP_NAME" {} \;
            fi
            exec ${pkgs.gosu}/bin/gosu "$NEW_USER_NAME" "$BASH_SOURCE" "$@"
        fi
        exec "$@"
    '';

    image = dockerTools.buildImage rec {
        name = "nix-base";
        tag = "0.0.1";
        inherit contents;

        runAsRoot = ''
            #!${pkgs.stdenv}
            ${pkgs.dockerTools.shadowSetup}

            echo 'root ALL=(ALL) ALL' >> /etc/sudoers
            echo ' %wheel ALL=(ALL) ALL' >> /etc/sudoers
            echo ' %wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

            chmod 0755 /nix/
            #chmod 4511 /sbin/sudo
            #chmod 4511 /bin/sudo
            mkdir --mode=1777 --parents /nix/store/.links
        #    chown pedroregispoar /nix/store/.links
        #        mkdir --mode=755 --parents /nix/var/nix/profiles/per-user/pedroregispoar

            echo "Set disable_coredump false" >> etc/sudo.conf
        '';


        extraCommands = ''
            #chown pedroregispoar ${pkgs.sudo}/bin/

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
            "MANPATH=/root/.nix-profile/share/man:/run/current-system/sw/share/man"
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

