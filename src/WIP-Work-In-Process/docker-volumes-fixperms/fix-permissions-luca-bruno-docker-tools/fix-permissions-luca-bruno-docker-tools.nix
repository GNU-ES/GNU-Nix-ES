let
    pkgs = import <nixpkgs> {};


    entrypoint = pkgs.writeScript "entrypoint.sh" ''
    #!${pkgs.stdenv.shell}
    ${pkgs.dockerTools.shadowSetup}

    set -e

    # allow the container to be started with `--user`
    if [ "$(${pkgs.coreutils}/bin/id -u)" = "0" ]; then
        #${pkgs.coreutils}/bin/chown -R redis .
        #groupadd --gid 5000 app_group
        #useradd --no-log-init --uid 5000 --gid app_group app_user
        opt_u='app_user'
        OLD_UID=$( ${pkgs.getent}/bin/getent passwd "$opt_u" | cut --field=3 --delimiter=:)
        echo 'OLD_UID='$OLD_UID

        exec ${pkgs.gosu.bin}/bin/gosu app_user "$BASH_SOURCE" "$@"
    fi
    exec "$@"
    '';
in

pkgs.dockerTools.buildImage {

    name = "fix-permissions-luca-bruno-docker-tools";
    tag = "0.0.1";
    created = "now";

    runAsRoot = ''
        #!${pkgs.stdenv}
        export PATH=/bin:/usr/bin:/sbin:/usr/sbin:$PATH
        ${pkgs.dockerTools.shadowSetup}
        groupadd --gid 5000 app_group
        useradd --no-log-init --uid 5000 --gid app_group app_user
    '';

    contents = with pkgs; [
        bashInteractive
        coreutils
        which
       ];

    config = {

        Cmd = [ "${pkgs.bashInteractive}/bin/bash" ];

        Entrypoint = [ entrypoint ];
#        Entrypoint = [ "${pkgs.bashInteractive}/bin/bash" ];


        WorkingDir = "/code";

        Volumes = {
          "/code" = {};
        };
    };
}