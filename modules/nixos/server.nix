{ vars, inputs, ... }:
{
  imports = [
    ./core.nix
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
    networkmanager.enable = false;
    firewall.enable = true;
  };

  users.users.${vars.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
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
    };
  };
}
