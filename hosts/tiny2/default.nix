{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/server.nix
    ../../modules/nixos/minecraft.nix
  ];

  networking = {
    hostName = "jebba";
    useDHCP = false;
    interfaces.eno1.ipv4.addresses = [
      {
        address = "10.50.60.10";
        prefixLength = 24;
      }
    ];
    defaultGateway = "10.50.60.1";
    nameservers = [ "10.50.60.1" ];
  };

  system.stateVersion = "25.11";
}
