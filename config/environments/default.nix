{ lib, inputs, ... }:
let
  inherit (lib) mkOption types;

  swap = x: f: f x;
  pipe = lib.flip lib.pipe;
  toFunction = x: if !(lib.isFunction x) then lib.const x else x;

  all-environments =
    {
      cpp         = ./cpp.nix;
      docker      = ./docker.nix;
      flutter     = ./flutter.nix;
      godot       = ./godot.nix;
      java        = ./java.nix;
      obsidian    = ./obsidian.nix;
      python      = ./python.nix;
      rust        = ./rust.nix;
      spyglass    = ./spyglass.nix;
      typescript  = ./typescript.nix;
    };

    importEnvironment =
      with builtins;
      pipe
        [
          (lib.flip getAttr all-environments)
          import
          toFunction
          (swap { inherit inputs; })
        ];
in
{
  imports = [ ];

  options = {
    nixvimEnvironments = mkOption {
      type =
        with builtins;
        types.coercedTo
          (
            types.listOf
              (types.enum (attrNames all-environments))
          )
          (map importEnvironment)
          (types.listOf types.deferredModule);

      apply = lib.unique;
    };
  };

  config = { };
}
