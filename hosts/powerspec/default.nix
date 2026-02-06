{ config, pkgs, vars, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos/core.nix
      ../../modules/nixos/workstation.nix
      ../../modules/nixos/gnome.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "tau";
  networking.networkmanager.enable = true;

  services.xserver.videoDrivers = ["nvidia"];

  programs.sway.enable = true;
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

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${vars.username} = {
      imports = [
        ../../modules/home-manager/gui.nix
          ../../modules/home-manager/wms/sway.nix
          ../../modules/home-manager/wms/gnome.nix
      ];
      home.username = vars.username;
      home.homeDirectory = "/home/${vars.username}";
      home.stateVersion = "24.11";
    };
  };

  system.stateVersion = "25.05";
}
