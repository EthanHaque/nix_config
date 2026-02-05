{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos/core.nix
      ../../modules/nixos/workstation.nix
      ../../modules/nixos/gnome.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "tau"; # Define your hostname.
  networking.networkmanager.enable = true;

  services.xserver.videoDrivers = ["nvidia"];

  programs.sway.enable=true;
  programs.sway.extraOptions = [ "--unsupported-gpu" ];


  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  services.printing.enable = true;

  virtualisation.docker.enable = true;

  users.users.${vars.username} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" "input" ];
    packages = with pkgs; [ ];
  };

  programs.steam.enable = true;

  system.stateVersion = "25.05";
}
