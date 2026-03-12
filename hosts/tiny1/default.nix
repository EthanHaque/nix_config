{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/server.nix
    ../../modules/nixos/omada.nix
    ../../modules/nixos/caddy.nix
  ];

  networking = {
    hostName = "paper";
    useDHCP = false;
    interfaces.eno1.ipv4.addresses = [
      {
        address = "10.50.20.20";
        prefixLength = 24;
      }
    ];
    defaultGateway = "10.50.20.1";
    nameservers = [ "10.50.20.1" ];
  };

  virtualisation.docker.enable = true;
  virtualisation.oci-containers.backend = "docker";

  system.stateVersion = "25.11";
}
