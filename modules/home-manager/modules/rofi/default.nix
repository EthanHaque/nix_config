
{
pkgs,
config,
...
}:
{
  programs.rofi = {
    enable = true;
    theme = ./theme.rasi;
    extraConfig = {
      drun-display-format = "{name}";
      drun-categories = "";
      drun-show-actions = true;
      drun-url-launcher = "xdg-open";
      drun-match-fields = "name,generic,exec,categories,keywords";
    };
  };
}
