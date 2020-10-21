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
        opt_g='app_group'
        VOLUME_AND_WORKDIR='/code'

        OLD_UID=$( ${pkgs.getent}/bin/getent passwd "$opt_u" | cut --field=3 --delimiter=:)
        NEW_UID=$(stat --format="%u" $VOLUME_AND_WORKDIR)

        if [ "$OLD_UID" != "$NEW_UID" ]; then
            echo "Changing UID of $opt_u from $OLD_UID to $NEW_UID"
            usermod -u "$NEW_UID" -o "$opt_u"
            if [ -n "$opt_r" ]; then
                ${pkgs.coreutils}/bin/find / -xdev -user "$OLD_UID" -exec chown -h "$opt_u" {} \;
            fi
        fi

        OLD_GID=$(${pkgs.getent}/bin/getent group "$opt_g" | cut -f3 -d:)
        NEW_GID=$(stat --format="%g" /code)

        if [ "$OLD_GID" != "$NEW_GID" ]; then
            echo "Changing GID of $opt_g from $OLD_GID to $NEW_GID"
            groupmod -g "$NEW_GID" -o "$opt_g"
            if [ -n "$opt_r" ]; then
                find / -xdev -group "$OLD_GID" -exec chgrp -h "$opt_g" {} \;
            fi
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
        export PATH=/bin:/usr/bin:/sbin:/usr/sbin:$PATH
        ${pkgs.dockerTools.shadowSetup}
        groupadd --gid 5000 app_group
        useradd --no-log-init --uid 5000 --gid app_group app_user
    '';

    contents = with pkgs; [
        bashInteractive
        coreutils
        findutils
        which
        su
        sudo
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