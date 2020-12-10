{ pkgs, ... }: {

  #nodes.server = ./server.nix;

  nodes = {
    docker = { pkgs, ... }: {
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

  testScript = with pkgs.dockerTools; ''
    docker.wait_for_unit("sockets.target")
    with subtest("Ensure Docker images use a stable date by default"):
        docker.succeed(
            "docker load  --input='${examples.bash}'"
        )
  '';
}
