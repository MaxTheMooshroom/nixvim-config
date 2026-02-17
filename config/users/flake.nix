{
  inputs = {
    flake-parts = {
      url = ./.;
      flake = false;
    };

    flake-module =  { url = ./flake-module.nix; flake = false; };

    maxine =        { url = ./maxine.nix;       flake = false; };
  };

  outputs = { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        flake-parts.flakeModules.flakeModules

        inputs.flake-module.outPath
      ];

      userDefinitions = {
        inherit (inputs)
          maxine
          ;
      };

      # flake.flakeModules.default = {};
    };
}
