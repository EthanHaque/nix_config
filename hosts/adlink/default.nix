
  config,
  pkgs,
  lib,
  vars,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/server.nix
    ../../modules/nixos/searxng.nix
  ];

  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    device = "nodev";
  };

  networking = {
    hostName = "zone";
    useDHCP = true;
    localCommands = ''
      ${pkgs.ethtool}/bin/ethtool -s enP2s1f3np3 speed 10000 duplex full autoneg off
    '';
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  virtualisation.docker.enable = true;
  hardware.nvidia-container-toolkit.enable = true;

  users.mutableUsers = true;
  users.users.root.hashedPassword = "!";
  users.users.${vars.username}.extraGroups = [ "docker" ];

  nix.settings = {
    trusted-users = [ vars.username ];
    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  system.stateVersion = "25.11";
}
