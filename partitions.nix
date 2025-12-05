localFlake:
{ lib, config, self, inputs, ... }: {
  imports = [ inputs.flake-parts.flakeModules.partitions ];

  partitionedAttrs.devShells = "dev";
  partitions.dev = {
    extraInputsFlake = ./dev;

    module = { inputs, ... }: {
      imports = [ inputs.devenv.flakeModule ];

      perSystem = { config, self', inputs', pkgs, system, ... }: {
        devenv.shells.default = {
          name = "nixvim-config";

          packages = [
            config.packages.default
          ];

          languages.nix.enable = true;

          git-hooks.hooks = {
            commitizen.enable = true;

            markdownlint = {
              enable = true;
              settings.configuration = {
                MD013.line_length = 120;
              };
            };

            nil.enable = true;
          };
        };
      };
    };
  };
}
