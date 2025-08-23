{
pkgs,
config,
...
}:
{
  xdg.configFile = {
    "sway/config".text = builtins.readFile ./config;
  };
}
