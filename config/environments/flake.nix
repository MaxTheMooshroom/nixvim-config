{
  inputs = {
    flake-parts = {
      url = /dev/null;
      flake = false;
    };

    docker      = { url = ./docker.nix;       flake = false; };
    godot       = { url = ./godot.nix;        flake = false; };
    obsidian    = { url = ./obsidian.nix;     flake = false; };
    python      = { url = ./python.nix;       flake = false; };
    rust        = { url = ./rust.nix;         flake = false; };
    typescript  = { url = ./typescript.nix;   flake = false; };
  };

  outputs = { self, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } ({
      flake.flakeModules.default = { config, lib, ... }:
      let
        env = {
          inherit (inputs)
            docker
            godot
            obsidian
            python
            rust
            typescript;
        };
        type-path = lib.mkOptionType {
          name = "path";
          description = "a nix path object";
          descriptionClass = "noun";
          check = builtins.isPath;
        };
      in {
        options = let inherit (lib) mkOption types; in {
          nixvimEnvironments = mkOption {
            type =
              types.coercedTo
                (types.listOf types.str)
                (map (item: env.${item}.outPath))
                (types.listOf types.pathInStore);
            # type =
            #   types.coercedTo
            #     (types.listOf (types.enum (builtins.attrNames env)))
            #     (list: map (item: builtins.getAttr item env) list)
            #     (types.listOf type-path);
          };
        };

        config.nixvimProfiles = config.nixvimEnvironments;
      };
    });
}
