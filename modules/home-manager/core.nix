{ pkgs, ... }: {
  imports = [
    ./modules/bash
    ./modules/git
    ./modules/gpg
    ./modules/neovim
    ./modules/tmux
    ./modules/starship
    ./modules/ranger
  ];

  home.packages = with pkgs; [
    bat
    lsd
    btop
    jq

    devenv
    ruff
    gnumake
    gcc

    unzip
    wget
    curl
  ];

  home.stateVersion = "24.11";
}
