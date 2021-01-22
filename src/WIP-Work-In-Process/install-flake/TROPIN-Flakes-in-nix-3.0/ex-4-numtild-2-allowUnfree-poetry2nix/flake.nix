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

      freePackages = with pkgs; [  gnumake 
                                   coreutils 
                                   nodejs 
                                   firefox
                                   keepassxc
                                   which    
                                   findutils
                                   awscli   
                                   httpie    
                                   terraform 
                                   vscodium  
                                   insomnia
	                           gnupg 
				 ];
  
    unfreePackages = with pkgs; [
                                  ngrok 
                                  opera 
                                  google-chrome 
                                  gitkraken
                                ];  

    podmandDependencies = with pkgs; [ podman 
                                       conmon
                                       runc
                                       slirp4netns
                                       shadow
                                        ];

    in
    {

      # TODO: make it work. What is the sintax?
      #packages.x86_64-linux.myattr = myExampleFlake;
      #defaultPackage = self.packages.${system}.myExampleFlake;
      
      #env = pkgs.poetry2nix.mkPoetryEnv config;

      devShell = pkgs.mkShell {
        #buildInputs = with pkgs; [ env ];
        buildInputs = with pkgs; [ env ] ++ freePackages ++ unfreePackages ++ podmandDependencies;
        #buildInputs = with pkgs; [ ngrok opera google-crhome ];
       };

    }
  );

}
