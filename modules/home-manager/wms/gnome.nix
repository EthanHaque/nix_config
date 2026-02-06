{ pkgs, lib, ... }:
{
  imports = [
    ../modules/gnome/dconf.nix
  ];

  home.packages = with pkgs; [
    gnome-tweaks
  ];
}
