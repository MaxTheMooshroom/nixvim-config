_: { pkgs, ... }:
{
  config.dependencies.flutter.enable = true;
  config.dependencies.flutter.package = pkgs.flutter;
  config.plugins.flutter-tools.enable = true;
  config.plugins.flutter-tools.package = pkgs.vimPlugins.flutter-tools-nvim;
}
