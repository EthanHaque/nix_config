{ config, pkgs, inputs, vars, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos/core.nix
      ../../modules/nixos/vaultwarden.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  networking = {
    hostName = "fort";
    networkmanager.enable = false;
    useDHCP = false;
    interfaces.eno1 = {
      useDHCP = false;
      ipv4.addresses = [{
        address = "10.50.25.10";
        prefixLength = 24;
      }];
    };
    defaultGateway = "10.50.25.1";
    nameservers = [ "10.50.25.1" ];
    firewall = {
      enable = true;
      allowedTCPPorts = [];
    };
  };

  users.users.${vars.username} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKBdFy0tjrBNCw5R7egxbw9tNKWy7eaObMljZd4YNCkE cardno:35_274_370"
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
