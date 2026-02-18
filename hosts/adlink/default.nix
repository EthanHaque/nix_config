{ config, pkgs, lib, vars, inputs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos/core.nix
      ../../modules/nixos/searxng.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.device = "nodev";

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  networking = {
    hostName = "zone";
    networkmanager.enable = false;
    useDHCP = true;
    localCommands = ''
      ${pkgs.ethtool}/bin/ethtool -s enP2s1f3np3 speed 10000 duplex full autoneg off
    '';
    firewall = {
      enable = true;
      allowedTCPPorts = [];
    };
  };

  services.xserver.videoDrivers = ["nvidia"];
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
  users.users.${vars.username} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKBdFy0tjrBNCw5R7egxbw9tNKWy7eaObMljZd4YNCkE cardno:35_274_370"
    ];
  };

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

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${vars.username} = {
      imports = [ ../../modules/home-manager/core.nix ];
      home.username = vars.username;
      home.homeDirectory = "/home/${vars.username}";
      home.stateVersion = "24.11";
    };
  };

  system.stateVersion = "25.11";
}
