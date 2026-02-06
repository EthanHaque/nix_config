{ pkgs, ... }: {
  imports = [
    ../modules/sway
    ../modules/swaylock
    ../modules/rofi
  ];

  wayland.windowManager.sway = {
    enable = true;
    extraConfig = builtins.readFile ../modules/sway/config;
  };

  home.packages = with pkgs; [
    wl-clipboard
    grim
    slurp
    i3status
  ];
}
