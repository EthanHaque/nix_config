{ config, pkgs, inputs, vars, ... }: {
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos/core.nix
      ../../modules/nixos/workstation.nix
      ../../modules/nixos/gnome.nix
      inputs.nixos-hardware.nixosModules.dell-precision-5530
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "charm";
  networking.networkmanager.enable = true;

  hardware.graphics.enable = true;
  hardware.nvidia.modesetting.enable = true;

  services.printing.enable = true;

  virtualisation.docker.enable = true;

  users.users.${vars.username} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [ ];
  };

  programs.steam.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  system.stateVersion = "24.11";
}
