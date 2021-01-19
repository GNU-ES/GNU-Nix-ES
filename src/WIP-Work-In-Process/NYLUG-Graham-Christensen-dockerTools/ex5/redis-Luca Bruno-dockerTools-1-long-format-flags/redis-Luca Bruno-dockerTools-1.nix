let
    pkgs = import <nixpkgs> {};

    entrypoint = pkgs.writeScript "entrypoint.sh" ''
    #!${pkgs.stdenv.shell}
    ${pkgs.dockerTools.shadowSetup}

    set -e
    # allow the container to be started with `--user`
    if [ "$1" = "redis-server" -a "$(${pkgs.coreutils}/bin/id --user)" = "0" ]; then
      ${pkgs.coreutils}/bin/chown --recursive redis .
      exec ${pkgs.gosu}/bin/gosu redis "$BASH_SOURCE" "$@"
    fi
    exec "$@"
    '';

in

pkgs.dockerTools.buildImage {

    name = "redis";
    tag = "0.0.1";
    #created = "now";

    runAsRoot = ''
        #!${pkgs.stdenv}
        export PATH=/bin:/usr/bin:/sbin:/usr/sbin:$PATH
        ${pkgs.dockerTools.shadowSetup}

        groupadd --system redis
        useradd --system --gid redis --home-dir /data --no-create-home redis
        ${pkgs.coreutils}/bin/mkdir /data
        ${pkgs.coreutils}/bin/chown redis:redis /data
    '';

    contents = [ pkgs.redis ];

    config = {

        Cmd = [ "redis-server" ];

        Entrypoint = [ entrypoint ];

        ExposedPorts = {
          "6379/tcp" = {};
        };

        WorkingDir = "/data";

        Volumes = {
          "/data" = {};
        };
    };
}
