{ pkgs, ... }: {
  imports = [
    ../modules/sway
    ../modules/swaylock
    ../modules/waybar
    ../modules/rofi
  ];

  home.packages = with pkgs; [
    wl-clipboard
    grim
    slurp
  ];
}
