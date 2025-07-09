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
  ];

  home.file."Pictures/buffalo_trail.jpg".source = ./modules/wallpapers/buffalo_trail.jpg;

  programs.kitty.font.size = lib.mkForce 10;


  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    xwayland.enable = true;
  };

  programs.home-manager.enable = true;
}
