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
  ];

  programs.kitty.font.size = lib.mkForce 10;

  programs.home-manager.enable = true;
}
