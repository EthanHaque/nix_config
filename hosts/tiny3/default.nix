{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/server.nix
    ../../modules/nixos/vaultwarden.nix
  ];

  networking = {
    hostName = "fort";
    useDHCP = false;
    interfaces.eno1.ipv4.addresses = [
      {
        address = "10.50.25.10";
        prefixLength = 24;
      }
    ];
    defaultGateway = "10.50.25.1";
    nameservers = [ "10.50.25.1" ];
  };

  system.stateVersion = "25.11";
}
