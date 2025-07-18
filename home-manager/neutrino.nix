inputs @ { config, pkgs, vars, lib, ... }: {
  imports = [
    ./modules/browsers
    ./modules/neovim
    ./modules/kitty
    ./modules/tmux
    ./modules/starship
    ./modules/bash
    ./modules/git
    ./modules/gnome/dconf.nix
    ./modules/gtk
    ./modules/ranger
    ./modules/hyprland
    ./modules/hyprlock
    ./modules/hyprpaper
    ./modules/waybar
    ./modules/swaync
    ./modules/rofi
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
