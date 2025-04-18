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
    aliases = {
      a = "add";
      c = "commit --verbose";
      ca = "commit --verbose --amend";
      cam = "commit --verbose --amend --no-edit";
      cm = "commit -m";
      co = "checkout";
      cob = "checkout -b";
      d = "diff";
      s = "status";
      lol = "log --graph --decorate --pretty=oneline --abbrev-commit";
      lola = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
      pl = "pull";
      ps = "push";
    };
  };
}
