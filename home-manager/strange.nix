inputs @ { config, pkgs, vars, ... }: {
  imports = [
    ./modules/browsers
    ./modules/neovim
    ./modules/kitty
    ./modules/tmux
    ./modules/starship
  ];
  home.username = "muon";
  home.homeDirectory = "/home/muon";

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    ruff
    btop
    gnome-tweaks  # TODO: come up with a better solution for swapping caps and esc
    devenv
  ];

  home.file = { };

  programs.git = {
    enable = true;
    userName = "Ethan Haque";
    userEmail = "ethan.k.haque@gmail.com";
    extraConfig.init.defaultBranch = "main";
  };

  programs.bash.enable = true;
  programs.home-manager.enable = true;
}
