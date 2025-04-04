{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.device = "nodev";


  networking.hostName = "gluon";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  virtualisation.docker.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.muon = {
    isNormalUser = true;
    description = "muon";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [ ];
  };

  programs.nano.enable = false;

  nixpkgs.config.allowUnfree = true;

  environment.variables.EDITOR = "vim";
  environment.systemPackages = with pkgs; [
    vim
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  environment.gnome.excludePackages = with pkgs; [
    orca
    evince
    # file-roller
    geary
    # gnome-disk-utility
    # seahorse
    # sushi
    # sysprof
    #
    # gnome-shell-extensions
    #
    # adwaita-icon-theme
    # nixos-background-info
    gnome-backgrounds
    # gnome-bluetooth
    # gnome-color-manager
    # gnome-control-center
    # gnome-shell-extensions
    gnome-tour # GNOME Shell detects the .desktop file on first log-in.
    gnome-user-docs
    # glib # for gsettings program
    # gnome-menus
    # gtk3.out # for gtk-launch program
    # xdg-user-dirs # Update user dirs as described in https://freedesktop.org/wiki/Software/xdg-user-dirs/
    # xdg-user-dirs-gtk # Used to create the default bookmarks
    #
    baobab
    epiphany
    gnome-text-editor
    gnome-calculator
    gnome-calendar
    # gnome-characters
    # gnome-clocks
    gnome-console
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-system-monitor
    gnome-weather
    # loupe
    # nautilus
    gnome-connections
    simple-scan
    snapshot
    # totem
    yelp
    gnome-software
  ];

  system.stateVersion = "24.11";

}
