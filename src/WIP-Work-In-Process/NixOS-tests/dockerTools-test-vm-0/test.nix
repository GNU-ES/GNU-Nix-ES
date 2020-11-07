{pkgs, ... }: {

    #nodes.server = ./server.nix;

    nodes = {
    docker =
      { pkgs, ... }:
        {
          virtualisation.docker.enable = true;
          virtualisation.docker.package = pkgs.docker;

          users.users = {
            hasprivs = {
              isNormalUser = true;
              description = "Can access the docker daemon";
              password = "foobar";
              extraGroups = [ "docker" ];
            };
          };
        };
    };

    testScript = ''
        start_all()
        docker.wait_for_unit("sockets.target")

        # Must match version 4 times to ensure client and server git commits and versions are correct
        docker.succeed('[ $(docker version | grep ${pkgs.docker.version} | wc -l) = "4" ]')

        # docker.succeed('[ ${pkgs.docker.version} = 19.03.12 ]')
        # docker.succeed('[ "${pkgs.docker.version}" = "19.03.12" ]')
    '';
}