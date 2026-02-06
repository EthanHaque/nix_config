{ pkgs, lib, ... }: {
  imports = [
    ../modules/sway
    ../modules/swaylock
    ../modules/waybar
    ../modules/rofi
  ];

  wayland.windowManager.sway = {
    enable = true;

    extraConfig = builtins.readFile ./config;
  };

  home.packages = with pkgs; [
    wl-clipboard
    grim
    slurp
  ];
}
