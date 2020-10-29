let
    pkgs = import <nixpkgs> {};


    entrypoint = pkgs.writeScript "entrypoint.sh" ''
    #!${pkgs.stdenv.shell}
    ${pkgs.dockerTools.shadowSetup}

    set -e

    # allow the container to be started with `--user`
    if [ "$(${pkgs.coreutils}/bin/id --user)" = "0" ]; then

        opt_u='app_user'
        opt_g='app_group'
        VOLUME_AND_WORKDIR='/code'

        OLD_UID=$( ${pkgs.getent}/bin/getent passwd "$opt_u" | cut --field=3 --delimiter=:)
        NEW_UID=$(stat --format="%u" "$VOLUME_AND_WORKDIR")

        if [ "$OLD_UID" != "$NEW_UID" ]; then
            echo "Changing UID of $opt_u from $OLD_UID to $NEW_UID"
            usermod --uid "$NEW_UID" --non-unique "$opt_u"

            ${pkgs.findutils}/bin/find / -xdev -user "$OLD_UID" -exec chown --no-dereference "$opt_u" {} \;
        fi

        OLD_GID=$(${pkgs.getent}/bin/getent group "$opt_g" | cut --field=3 --delimiter=:)
        NEW_GID=$(stat --format="%g" $VOLUME_AND_WORKDIR)

        if [ "$OLD_GID" != "$NEW_GID" ]; then
            echo "Changing GID of $opt_g from $OLD_GID to $NEW_GID"
            groupmod --gid "$NEW_GID" --non-unique "$opt_g"

            ${pkgs.findutils}/bin/find  / -xdev -group "$OLD_GID" -exec chgrp --no-dereference "$opt_g" {} \;
        fi
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
        ${pkgs.dockerTools.shadowSetup}
        groupadd --gid 5678 app_group
        useradd --no-log-init --uid 5678 --gid app_group app_user
    '';

    contents = with pkgs; [
        bashInteractive
        coreutils
        which
       ];

    config = {

        Cmd = [ "${pkgs.bashInteractive}/bin/bash" ];

        Entrypoint = [ entrypoint ];

        WorkingDir = "/code";

        Volumes = {
          "/code" = {};
        };
    };
}