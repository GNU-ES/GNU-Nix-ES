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

        freePackages = with pkgs; [
          awscli
          firefox
          gnumake
          gnupg
          httpie
          insomnia
          keepassxc
          nodejs
          terraform
          vscodium
        ];

        unfreePackages = with pkgs; [
          ngrok
          opera
          google-chrome
          gitkraken
        ];

        podmandDependencies = with pkgs; [
          conmon
          podman
          runc
          shadow
          slirp4netns
        ];

        minimalUtils = with pkgs; [
          coreutils
          file
          findutils
          nano
          neovim
          nixpkgs-fmt
          which
        ];
      in
      {

        # TODO: make it work. What is the sintax?
        #packages.x86_64-linux.myattr = myExampleFlake;
        #defaultPackage = self.packages.${system}.myExampleFlake;

        #env = pkgs.poetry2nix.mkPoetryEnv config;

        devShell = pkgs.mkShell {
          #buildInputs = with pkgs; [ env ]
          #  ++ freePackages
          #  ++ unfreePackages
          #  ++ podmandDependencies
          #  ++ minimalUtils;
          buildInputs = with pkgs; podmandDependencies ++ minimalUtils;
        };

      }
    );

}
