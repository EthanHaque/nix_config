{ pkgs, ... }: {
  imports = [
    ./core.nix
    ./modules/browsers
    ./modules/ghostty
    ./modules/gtk
  ];

  home.packages = with pkgs; [
    keepassxc            # Password Manager

    pavucontrol          # The standard GUI volume mixer (works everywhere)
    playerctl            # CLI media controls (play/pause works on all)
  ];
}
