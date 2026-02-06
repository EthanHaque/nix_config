{ pkgs, config, ... }:

{
  programs.rofi = {
    enable = true;
    theme = ./theme.rasi;
    extraConfig = {
      modi = "drun,run";
      drun-display-format = "{name}";
      drun-show-actions = true;
      drun-url-launcher = "xdg-open";
      drun-match-fields = "name,generic,exec,categories,keywords";

      show-icons = true;
      display-drun = "Apps";
      display-run = "Run";
    };
  };
}
