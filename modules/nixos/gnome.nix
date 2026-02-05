{ pkgs, lib, ... }:
{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    excludePackages = [ pkgs.xterm ];
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  environment.gnome.excludePackages = (with pkgs; [
    orca
    evince
    geary
    gnome-backgrounds
    gnome-tour
    gnome-user-docs
    baobab
    epiphany
    gnome-text-editor
    gnome-calculator
    gnome-calendar
    gnome-console
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-system-monitor
    gnome-weather
    gnome-connections
    simple-scan
    snapshot
    yelp
    gnome-software
  ]);
}
