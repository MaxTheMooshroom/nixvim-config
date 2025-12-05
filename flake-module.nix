# The importApply argument. Use this to reference things defined locally,
# as opposed to the flake where this is imported.
localFlake:

# Regular module arguments; self, inputs, etc all reference the final user flake,
# where this module was imported.
{ lib, config, self, inputs, ... }:
let
  inherit (lib) mkOption types;
  inherit (inputs) nixvim nixvim-modules;

  inherit (nixvim-modules.lib.types) foreignModule;

  foreignConfig = types.submodule {
    options = {
      system = mkOption { type = types.enum lib.systems.flakeExposed; };

      modules = mkOption { type = types.listOf foreignModule; };
    };
  };
in {
  imports = [
    nixvim.flakeModules.default

    nixvim-modules.flakeModules.default
  ];

  options = {
    # nixvimModules = mkOption {
    #   type = types.attrsOf type-foreignModule;
    # };
    #
    # nixvimConfigurations = mkOption {
    #   type = types.attrsOf foreignConfig;
    # };
  };

  config.flake.lib.types = nixvim-modules.lib.types // { inherit foreignConfig; };

  config.nixvim = {
    packages = {
      enable = true;
      nameFunction = name: if name == "default" then "nvim" else "nvim-" + name;
    };

    checks = {
      enable = true;
      nameFunction = name: "nixvim-" + name + "-test";
    };
  };

  config.perSystem = { self', inputs', pkgs, lib, system, ... }: {
    nixvimConfigurations.default = nixvim.lib.evalNixvim {
      inherit system;

      modules =
        assert lib.assertMsg
          (builtins.all
            (item:
              assert lib.assertMsg
                ((builtins.isPath item) || lib.types.pathInStore.check item)
                "item was ${builtins.typeOf item} instead of type path!";
              true
            )
            config.nixvimProfiles)
          "expected all nixvimProfiles to be path objects!";
        config.nixvimProfiles;
    };

    packages.default = self'.packages.nvim;
    packages.nvimpager = pkgs.nvimpager.override {
      neovim = self'.packages.nvim;
    };
  };
}
