{pkgs, ... }: {

    #nodes.server = ./server.nix;

    nodes = {
    docker =
      { pkgs, ... }:
        {
          virtualisation.docker.enable = true;
          virtualisation.docker.package = pkgs.docker;

          users.users = {
            noprivs = {
              isNormalUser = true;
              description = "Can't access the docker daemon";
              password = "foobar";
            };

            hasprivs = {
              isNormalUser = true;
              description = "Can access the docker daemon";
              password = "foobar";
              extraGroups = [ "docker" ];
            };
          };
        };
    };

    testScript = with pkgs.dockerTools; ''
        unix_time_second1 = "1970-01-01T00:00:01Z"
        docker.wait_for_unit("sockets.target")
        with subtest("Ensure Docker images use a stable date by default"):
            docker.succeed(
                "docker load --input='${examples.bash}'"
            )
            assert unix_time_second1 in docker.succeed(
                "docker inspect ${examples.bash.imageName} "
                + "| ${pkgs.jq}/bin/jq -r .[].Created",
            )
    '';
}

