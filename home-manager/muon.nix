inputs @ { config, pkgs, vars, ... }: {
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
    ./modules/sway
  ];
  home.username = vars.username;
  home.homeDirectory = "/home/${vars.username}";

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    ruff
    btop
    devenv
    gnomeExtensions.pop-shell
    bat
    lsd
    keepassxc
  ];


  home.file."Pictures/buffalo_trail.jpg".source = ./modules/wallpapers/buffalo_trail.jpg;

  programs.home-manager.enable = true;
}
