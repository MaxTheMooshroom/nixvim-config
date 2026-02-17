{ config, lib, ... }:
let
  inherit (lib) mkOption types;

  # imported =
  #   types.addCheck
  #     types.pathInStore
  #     (x: (builtins.tryEval (import x)).success);
  #
  # importType =
  #   types.coercedTo
  #     imported
  #     builtins.import;

  # still requires parameters `f` and `to`, where `f` is the mapping function
  # and `to` is the type it resolves to after applying the map function.
  # packageOf = types.coercedTo types.package;

  userDefinitionType =
    types.coercedTo
      types.path
      builtins.import
      types.deferredModule;

  canonical-users = config.userDefinitions;

  # mkIf = pred: value: (lib.mkIf pred value) // {
  #   __toString = self: if self.condition then self.content else null;
  # };
in {
  options.userDefinitions = mkOption {
    type = types.attrsOf userDefinitionType;
    default = {};
  };

  config.flake.flakeModules.default = { config, lib, ... }:
    let
      users = config.userDefinitions;
    in {
      options = {
        userDefinitions = mkOption {
          type = types.attrsOf userDefinitionType;
          default = canonical-users;
        };

        userProfiles = mkOption {
          type = types.attrsOf types.deferredModule;
          default = users;
        };

        nixvimUser = mkOption {
          type =
            types.nullOr
              ( types.coercedTo
                ( types.enum (builtins.attrNames users))
                ( user: users.${user})
                types.deferredModule
              );

          default = null;
        };
      };

      config.nixvimProfiles = [ (lib.mkIf (config.nixvimUser != null) config.nixvimUser) ];
    };
}
