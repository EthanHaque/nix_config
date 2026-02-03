{ config, pkgs, lib, inputs, ... }:
{
  imports =
    [
    ./hardware-configuration.nix
    ];

  nixpkgs.overlays = [];

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
      AllowStreamLocalForwarding = "yes";
      StreamLocalBindUnlink = "yes";
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


  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };


  virtualisation.docker= {
    enable = true;
  };
  hardware.nvidia-container-toolkit.enable = true;

  users.mutableUsers = false;
  users.users.root.hashedPassword = ";";
  users.users.tape = {
    hashedPassword = ";";
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKBdFy0tjrBNCw5R7egxbw9tNKWy7eaObMljZd4YNCkE cardno:35_274_370"
    ];
  };

  security.sudo.wheelNeedsPassword = false;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "tape" ];
    substituters = [
      "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    stalled-download-timeout = 500;
  };


  nixpkgs.config = {
    allowUnfree = true;
  };

  programs.nano.enable = false;

  environment.variables.EDITOR = "vim";
  environment.systemPackages = with pkgs; [
    vim
    docker-compose
    pinentry-curses
    ethtool
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.stateVersion = "25.11";
}
