{
pkgs,
config,
...
}:
{
  xdg.configFile = {
    "i3/config".text = builtins.readFile ./config;
  };
}
