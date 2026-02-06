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
      ls = "lsd --group-directories-first";
      ll = "lsd -l --group-directories-first";
      la = "lsd -a --group-directories-first";
      lla = "lsd -la --group-directories-first";
      g = "git";
      ga = "git add";
      gc = "git commit -a --verbose";
    };

  initExtra = ''
      export GPG_TTY=$(tty)
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    '';
  };
}
