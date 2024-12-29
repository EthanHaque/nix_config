{ config, pkgs, ... }:
{
  imports = [
    ./modules/browsers
    ./modules/neovim
    ./modules/kitty
    ./modules/tmux
    ./modules/starship
  ];
  home.username = "strange";
  home.homeDirectory = "/home/strange";

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    ruff
    btop
  ];

  home.file = { };

  programs.git = {
    enable = true;
    userName = "Ethan Haque";
    userEmail = "ethan.k.haque@gmail.com";
  };
  programs.bash.enable = true;
  programs.home-manager.enable = true;
}
