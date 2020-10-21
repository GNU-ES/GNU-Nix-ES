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

        echo '###'
        id

        OLD_UID=$( ${pkgs.getent}/bin/getent passwd "$opt_u" | cut --field=3 --delimiter=:)
        NEW_UID=$(stat --format="%u" $VOLUME_AND_WORKDIR)

        if [ "$OLD_UID" != "$NEW_UID" ]; then
            echo "Changing UID of $opt_u from $OLD_UID to $NEW_UID"
            usermod --uid "$NEW_UID" --non-unique "$opt_u"
            if [ -n "$opt_r" ]; then
                ${pkgs.coreutils}/bin/find / -xdev -user "$OLD_UID" -exec chown --no-dereference "$opt_u" {} \;
            fi
        fi

        OLD_GID=$(${pkgs.getent}/bin/getent group "$opt_g" | cut --field=3 --delimiter=:)
        NEW_GID=$(stat --format="%g" $VOLUME_AND_WORKDIR)

        if [ "$OLD_GID" != "$NEW_GID" ]; then
            echo "Changing GID of $opt_g from $OLD_GID to $NEW_GID"
            groupmod --gid "$NEW_GID" --non-unique "$opt_g"
            if [ -n "$opt_r" ]; then
                find / -xdev -group "$OLD_GID" -exec chgrp --no-dereference "$opt_g" {} \;
            fi
        fi
        
        #exec ${pkgs.gosu.bin}/bin/gosu app_user "$BASH_SOURCE" "$@"
        exec "$@"
    fi
    exec "$@"
    '';
in

pkgs.dockerTools.buildImage {

    name = "sudo-user-fix-permissions-luca-bruno-docker-tools";
    tag = "0.0.1";
    created = "now";

    runAsRoot = ''
        #!${pkgs.stdenv}
        export PATH=/bin:/usr/bin:/sbin:/usr/sbin:$PATH
        ${pkgs.dockerTools.shadowSetup}
        groupadd --gid 5000 app_group
        useradd --no-log-init --uid 5000 --gid app_group app_user
        chown root:root /sbin/sudo
        chmod 777 /sbin/sudo
        chmod g+s /sbin/sudo

        #
        # https://wiki.debian.org/WHEEL/PAM
        groupadd --system wheel
        # TODO
        usermod --append --groups wheel app_user

        # Here the sudoers file is edited
        # https://stackoverflow.com/a/27355109
        ${pkgs.gnused}/bin/sed -i '/wheel/s/^#//g' /etc/sudoers

        echo '#Admins' >> /etc/sudoers
        echo 'app_user    ALL=(ALL) ALL' >> /etc/sudoers
    '';

    contents = with pkgs; [
        bashInteractive
        coreutils
        findutils
        which
        ripgrep
        su
        sudo
        tree
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