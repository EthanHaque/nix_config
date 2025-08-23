inputs @ { config, pkgs, vars, lib, ... }: {
  imports = [
    ./modules/bash
    ./modules/browsers
    ./modules/neovim
    ./modules/git
    ./modules/i3
    ./modules/kitty
    ./modules/ranger
    ./modules/rofi
    ./modules/starship
    ./modules/tmux
  ];
  home.username = vars.username;
  home.homeDirectory = "/home/${vars.username}";

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    ruff
    btop
    devenv
    gnomeExtensions.pop-shell
    bat
    lsd
    keepassxc
    networkmanager
    blueman
    playerctl
    wl-clipboard
  ];

  programs.kitty.font.size = lib.mkForce 10;

  programs.home-manager.enable = true;
}
