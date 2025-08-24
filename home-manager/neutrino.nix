inputs @ { config, pkgs, vars, lib, ... }: {
  imports = [
    ./modules/bash
    ./modules/browsers
    ./modules/git
    ./modules/kitty
    ./modules/neovim
    ./modules/ranger
    ./modules/rofi
    ./modules/starship
    ./modules/sway
    ./modules/swaync
    ./modules/tmux
    ./modules/gtk
  ];
  home.username = vars.username;
  home.homeDirectory = "/home/${vars.username}";

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    ruff
    btop
    devenv
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
