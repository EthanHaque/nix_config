{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/server.nix
    ../../modules/nixos/minecraft.nix
  ];

  networking = {
    hostName = "eepy";
    useDHCP = false;
    interfaces.enp1s0.ipv4.addresses = [
      {
        address = "10.50.60.20";
        prefixLength = 24;
      }
    ];
    defaultGateway = "10.50.60.1";
    nameservers = [ "10.50.60.1" ];
  };

  system.stateVersion = "25.11";
}
