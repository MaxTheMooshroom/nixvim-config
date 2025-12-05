{
  inputs = {
    flake-parts = {
      url = /dev/null;
      flake = false;
    };

    maxine = { url = ./maxine.nix; flake = false; };
  };

  outputs = { self, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } ({
      flake.flakeModules.default = { config, lib, ... }:
      let
        inherit (lib) mkOption types;

        users = {
          inherit (inputs)
            maxine;
        };
      in {
        options = {
          nixvimUser = mkOption {
            type =
              types.nullOr (types.coercedTo
                (types.enum (builtins.attrNames users))
                (user: users.${user}.outPath)
                types.pathInStore);
            default = null;
          };
        };

        config.nixvimProfiles = [ (lib.mkIf (config.nixvimUser != null) config.nixvimUser) ];
      };
    });
}
