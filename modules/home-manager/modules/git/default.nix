{
pkgs,
config,
...
}: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Ethan Haque";
        email = "ethan.k.haque@gmail.com";
        signingKey = "41DEA5FD54E42FE99A4EA29858B99D9F7D818050";
      };

      commit = {
        gpgSign = true;
      };

      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;

      alias = {
        a = "add";
        c = "commit --verbose";
        ca = "commit --verbose --amend";
        cam = "commit --verbose --amend --no-edit";
        cleanup = "!git branch --merged | grep  -v '\\*\\|master\\|main\\|develop\\|staging' | xargs -n 1 -r git branch -d";
        cm = "commit -m";
        co = "checkout";
        cob = "checkout -b";
        d = "diff";
        s = "status";
        lol = "log --graph --decorate --pretty=oneline --abbrev-commit";
        lola = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
        lolp = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
        pl = "pull";
        ps = "push";
      };
    };
  };
}
