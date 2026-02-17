localFlake:
{ lib, config, self, inputs, ... }:
let
  inherit (lib) mkOption types;
  inherit (inputs) nixvim nixvim-modules;

  zipLists = f: a: b:
    with builtins;
    assert ((length a) == (length b));
    genList (i: f (elemAt a i) (elemAt b i)) (length a);

  doAssert = check: value: assert (check value); value;

  doAsserts = checks: value: builtins.map (c: doAssert c value) checks;

  evalAsserts = checks: values: builtins.map (doAsserts checks) values;
in {
  imports = [
    nixvim.flakeModules.default

    nixvim-modules.flakeModules.default
  ];

  options = {
    __nixvimProfiles = mkOption {
      type = types.listOf types.deferredModule;
    };

    nixvimConfigurations = mkOption {
      type = types.attrsOf types.deferredModule;
    };
  };

  config.systems = lib.systems.flakeExposed;

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

  config.__nixvimProfiles = lib.mkForce config.nixvimProfiles;

  config.perSystem = { self', inputs', pkgs, lib, system, ... }: {

    nixvimConfigurations.default = nixvim.lib.evalNixvim {
      inherit system;

      modules = config.__nixvimProfiles;
    };

    packages.default = self'.packages.nvim;
    packages.nvimpager = pkgs.nvimpager.override {
      neovim = self'.packages.nvim;
    };
  };
}
