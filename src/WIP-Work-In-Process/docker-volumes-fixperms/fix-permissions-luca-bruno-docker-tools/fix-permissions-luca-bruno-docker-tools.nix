let
    pkgs = import <nixpkgs> {};


    entrypoint = pkgs.writeScript "entrypoint.sh" ''
        #!${pkgs.stdenv.shell}
        ${pkgs.dockerTools.shadowSetup}


#        set -e
#        ls -al

        #if [ "$(${pkgs.coreutils}/bin/id  --user)" = "0" ]; then
        #echo "Running the fix-perms script."
        #fix-perms -r -u app_user -g app_group /app

#        ${pkgs.findutils}/bin/find --version
#        groupadd --gid 5000 app_group
#        useradd --no-log-init --uid 5000 --gid app_group app_user
#        opt_u='app_user'
#        OLD_UID=$(getent passwd app_user | cut -f3 -d:)
#        NEW_UID=$(stat -c "%u" /code)
#
#        if [ "$OLD_UID" != "$NEW_UID" ]; then
#            echo "Changing UID of $opt_u from $OLD_UID to $NEW_UID"
#            usermod -u "$NEW_UID" -o "$opt_u"
#            ${pkgs.findutils}/bin/find / -xdev -user "$OLD_UID" -exec chown --no-dereference "$opt_u" {} \;
#        fi

        #echo "Running: gosu app_user "$@""
        #exec ${pkgs.gosu.bin}/bin/gosu app_user "$@"
        #fi
#        exec "$@"
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
        #groupadd --gid 5000 app_group
        #useradd --no-log-init --uid 5000 --gid app_group app_user
    '';

    contents = with pkgs; [
        bashInteractive
        coreutils
        which
       ];

    config = {

        #Cmd = [ "${pkgs.bashInteractive}/bin/bash" ];

   #     Entrypoint = [ entrypoint ];
        Entrypoint = [ "${pkgs.bashInteractive}/bin/bash" ];


        WorkingDir = "/code";

        Volumes = {
          "/code" = {};
        };
    };
}