{
  description = "Maxine's Neovim configuration";

  inputs = {
    # see .envrc file for more info on what this is
    devenv-root = {
      url = "file+file:///dev/null";
      flake = false;
    };

    nixvim.url = "github:MaxTheMooshroom/nixvim";
    nixvim.inputs.flake-parts.follows = "flake-parts";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixvim/nixpkgs";

    nixpkgs.follows = "nixvim/nixpkgs";

    flake-module  = { url = ./flake-module.nix;   flake = false; };
    partitions    = { url = ./partitions.nix;     flake = false; };

    nixvim-modules.url = ./config;
    nixvim-modules.inputs.nixpkgs.follows = "nixpkgs";
    nixvim-modules.inputs.flake-parts.follows = "flake-parts";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = { self, flake-parts, nixvim-modules, nixvim, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } (
      let
        inherit (inputs) nixpkgs flake-module partitions;
        inherit (flake-parts) lib;

        importApply = nixpkgs.lib.flip lib.importApply { inherit inputs; };
      in {
        imports = builtins.map importApply [ flake-module partitions ];

        # todo: select multiple users and switch between user modes at runtime?
        nixvimUser = "maxine";

        nixvimEnvironments = [
          "rust"
          # "java"
          # "spyglass"
          # "typescript"
          # "python"
          "docker"
          # "godot"
        ];
      }
    );
}
