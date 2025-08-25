{ pkgs, ... }:
{
  config = {
    extraLuaPackages = ps: [ ps.magick ];

    extraPackages = [
      pkgs.imagemagick
      pkgs.mermaid-cli
      # pkgs.d2
      # pkgs.gnuplot_qt
      # pkgs.plantuml
    ];

    plugins.diagram = {
      enable = false;

      settings = {
        mermaid.theme = "dark";
        d2.dark_theme = 200;
        gnuplot.theme = "dark";
      };
    };
  };
}
