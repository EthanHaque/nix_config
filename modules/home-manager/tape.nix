inputs @ { config, pkgs, vars, ... }: {
  imports = [
    ./modules/neovim
    ./modules/tmux
    ./modules/starship
    ./modules/bash
    ./modules/git
    ./modules/ranger
  ];
  home.username = vars.username;
  home.homeDirectory = "/home/${vars.username}";

  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    ruff
    btop
    devenv
    bat
    lsd
  ];


  programs.home-manager.enable = true;
}
