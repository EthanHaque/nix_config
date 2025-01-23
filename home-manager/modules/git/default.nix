{
pkgs,
config,
...
}: {
  programs.git = {
    enable = true;
    userName = "Ethan Haque";
    userEmail = "ethan.k.haque@gmail.com";
    extraConfig.init.defaultBranch = "main";
    extraConfig.pull.rebase = true;
    extraConfig.push.autoSetupRemote = true;
  };
}
