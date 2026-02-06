{ config, pkgs, inputs, vars, ... }: {
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos/core.nix
      ../../modules/nixos/workstation.nix
      ../../modules/nixos/gnome.nix
      inputs.nixos-hardware.nixosModules.dell-precision-5530
      inputs.home-manager.nixosModules.home-manager
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "charm";
  networking.networkmanager.enable = true;

  hardware.graphics.enable = true;
  hardware.nvidia.modesetting.enable = true;
  services.printing.enable = true;

  virtualisation.docker.enable = true;

  programs.sway.enable = true;
  programs.sway.extraOptions = [ "--unsupported-gpu" ];
  services.xserver.displayManager.gdm.wayland = true;

  users.users.${vars.username} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [ ];
  };

  programs.steam.enable = true;

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    LIBGL_ALWAYS_SOFTWARE = "0";
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${vars.username} = {
      imports = [
        ../../modules/home-manager/gui.nix
        ../../modules/home-manager/wms/sway.nix
      ];

      wayland.windowManager.sway.config = {
        bars = [];
        output = {
          "eDP-1" = {
            mode = "1920x1080@60Hz";
            pos = "0 0";
            scale = "1.0";
          };
        };

        input = {
          "type:touchpad" = {
            dwt = "enabled";
            tap = "enabled";
            natural_scroll = "enabled";
            middle_emulation = "enabled";
          };
        };

      };

      home.username = vars.username;
      home.homeDirectory = "/home/${vars.username}";
      home.stateVersion = "24.11";
    };
  };

  system.stateVersion = "24.11";
}
