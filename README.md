# GNU-Nix-ES


TODO:
https://www.youtube.com/user/elitespartan117j27/videos


   nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };


flake.nix

{
  outputs = { self, nixpkgs }: {
     # replace 'pedro' with your hostname here.
     nixosConfigurations.pedro = nixpkgs.lib.nixosSystem {
       system = "x86_64-linux";
       modules = [ ./configuration.nix ];
     }
  };
}