{
  description = "Maxine's Neovim configuration flake";

  inputs = {
    devenv-root = {
      url = "file+file:///dev/null";
      flake = false;
    };

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.flake-parts.follows = "flake-parts";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixvim/nixpkgs";

    nixpkgs.follows = "nixvim/nixpkgs";

    flake-module.url = ./flake-module.nix;
    flake-module.flake = false;

    partitions.url = ./partitions.nix;
    partitions.flake = false;

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
        importApply = inputs.nixpkgs.lib.flip flake-parts.lib.importApply {
          inputs = { inherit nixvim-modules nixvim; };
        };

      in {
        imports = [
          (importApply inputs.flake-module)

          (importApply inputs.partitions)
        ];

        systems = inputs.nixpkgs.lib.systems.flakeExposed;
        # systems = [ "x86_64-linux" "i686-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

        nixvimUser = "maxine";

        nixvimEnvironments = [
          "typescript"
          "python"
          "rust"
          "docker"
          "godot"
        ];
      }
    );
}
