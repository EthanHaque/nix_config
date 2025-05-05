{
pkgs,
config,
...
}:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      cat = "bat";
      ls = "lsd";
      ll = "ls -l";
      la = "ls -a";
      lla = "ls -la";
      g = "git";
    };
  };
}
