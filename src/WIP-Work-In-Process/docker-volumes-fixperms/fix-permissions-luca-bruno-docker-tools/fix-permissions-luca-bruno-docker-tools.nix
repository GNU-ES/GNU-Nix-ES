let
    pkgs = import <nixpkgs> {};


    entrypoint = pkgs.writeScript "entrypoin-file.sh" ''
        #!${pkgs.stdenv.shell}
        ${pkgs.dockerTools.shadowSetup}

        set -e

        # allow the container to be started with `--user`
        if [ "$(${pkgs.coreutils}/bin/id --user)" = "0" ]; then

            NEW_USER_NAME='app_user'
            NEW_GROUP_NAME='app_group'
            VOLUME_AND_WORKDIR='/code'

            OLD_USER_ID=$( ${pkgs.getent}/bin/getent passwd "$NEW_USER_NAME" | cut --field=3 --delimiter=:)
            NEW_USER_ID=$(stat --format="%u" "$VOLUME_AND_WORKDIR")

            if [ "$OLD_USER_ID" != "$NEW_USER_ID" ]; then
                echo "Changing uid (user identifier) of "$NEW_USER_NAME" from $OLD_USER_ID to $NEW_USER_ID"
                usermod --uid "$NEW_USER_ID" --non-unique "$NEW_USER_NAME"

                ${pkgs.findutils}/bin/find / -xdev -user "$OLD_USER_ID" -exec chown --no-dereference "$NEW_USER_NAME" {} \;
            fi

            OLD_GROUP_ID=$(${pkgs.getent}/bin/getent group "$NEW_GROUP_NAME" | cut --field=3 --delimiter=:)
            NEW_GROUP_ID=$(stat --format="%g" $VOLUME_AND_WORKDIR)

            if [ "$OLD_GROUP_ID" != "$NEW_GROUP_ID" ]; then
                echo "Changing gid (group identifier) of "$NEW_GROUP_NAME" from $OLD_GROUP_ID to $NEW_GROUP_ID"
                groupmod --gid "$NEW_GROUP_ID" --non-unique "$NEW_GROUP_NAME"

                ${pkgs.findutils}/bin/find / -xdev -group "$OLD_GROUP_ID" -exec chgrp --no-dereference "$NEW_GROUP_NAME" {} \;
            fi
            exec ${pkgs.gosu.bin}/bin/gosu "$NEW_USER_NAME" "$BASH_SOURCE" "$@"
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
        groupadd --gid 56789 app_group
        useradd --no-log-init --uid 12345 --gid app_group app_user
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

#        Volumes = {
#          "/code" = {};
#        };
    };
}