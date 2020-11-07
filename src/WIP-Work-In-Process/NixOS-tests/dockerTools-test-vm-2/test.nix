{ pkgs, ... }: {

  # helloDockerTools = import ./hello.nix;

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


  testScript = { nodes, ... }: let
    helloDockerTools = (import ./hello.nix).myHello;
  in ''
    docker.wait_for_unit("sockets.target")
    with subtest("Runs the GNU hello from a docker image built with dockerTools"):
        docker.succeed("docker load --input='${helloDockerTools}'")
  '';

#  testScript = with pkgs.dockerTools.examples; ''
#    docker.wait_for_unit("sockets.target")
#    with subtest("Runs the GNU hello from a docker image built with dockerTools"):
#        docker.succeed(
#            "docker load --input='${bash}'"
#        )
#  '';

#  testScript = with helloDockerTools; ''
#    docker.wait_for_unit("sockets.target")
#    with subtest("Runs the GNU hello from a docker image built with dockerTools"):
#        docker.succeed("docker load --input='${helloDockerTools.myHello}'")
#  '';

#  testScript = with import ./hello.nix; ''
#    docker.wait_for_unit("sockets.target")
#    with subtest("Runs the GNU hello from a docker image built with dockerTools"):
#        docker.succeed("docker load --input='${myHello}'")
#  '';

}
