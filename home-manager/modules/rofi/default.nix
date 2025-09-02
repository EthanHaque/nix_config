
{
pkgs,
config,
...
}:
{
  programs.rofi = {
    enable = true;
    extraConfig = {
      drun-display-format = "{name}";
      drun-categories = "";
      drun-show-actions = true;
      drun-url-launcher = "xdg-open";
      drun-match-fields = "name,generic,exec,categories,keywords";
    };
  };
}
