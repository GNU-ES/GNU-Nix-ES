{
  description = "my project description";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in
        {
          devShell = import ./shell.nix { inherit pkgs; };

              nixosConfigurations.container = nixpkgs.lib.nixosSystem {

                  modules =
                    [ ({ pkgs, ... }: {
                        boot.isContainer = true;

                        # Let 'nixos-version --json' know about the Git revision
                        # of this flake.
                        system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;

                        # Network configuration.
                        networking.useDHCP = false;
                        networking.firewall.allowedTCPPorts = [ 80 ];

                        # Enable a web server.
                        services.httpd = {
                          enable = true;
                          adminAddr = "morty@example.org";
                        };
                      })
                    ];
                };
        }
      );
}