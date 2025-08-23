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

  home.file."Pictures/buffalo_trail.jpg".source = ./modules/wallpapers/buffalo_trail.jpg;
  home.file."Pictures/forest_rays.jpg".source = ./modules/wallpapers/forest_rays.jpg;

  programs.kitty.font.size = lib.mkForce 10;

  programs.home-manager.enable = true;
}
