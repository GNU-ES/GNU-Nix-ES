{
  description = "A usefull description";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = { allowUnfree = true; };
      };
      myExampleFlake = import ./default.nix {
        pkgs = pkgs;
      };

      config = {
        projectDir = ./.;
        #propagatedBuildInputs = runtimeDeps;
      };
      
      env = pkgs.poetry2nix.mkPoetryEnv config;
  
    in
    {

      # TODO: make it work. What is the sintax?
      #packages.x86_64-linux.myattr = myExampleFlake;
      #defaultPackage = self.packages.${system}.myExampleFlake;
      
      #env = pkgs.poetry2nix.mkPoetryEnv config;

      devShell = pkgs.mkShell {
        #buildInputs = with pkgs; [ env ];

        buildInputs = with pkgs; [ gnumake 
                                   env
                                   coreutils 
                                   nodejs
                                   podman
                                   firefox
                                   opera
                                   keepassxc
                                   which findutils awscli httpie terraform terraform vscodium insomnia ];
        #buildInputs = with pkgs; [ ngrok opera google-crhome ];
      };

    }
  );

}
