{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nvim-lazy-config = {
      url = "github:EthanHaque/nvim_lazy_config";
      # TODO: add flake to lazy config repo
      flake = false;
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, nixos-hardware, ... }:
    let
    mkHost = { hostname, system, username, extraModules ? [] }: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs;
        vars = { inherit username; };
      };
      modules = [
        ./hosts/${hostname}
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${username} = import ./modules/home-manager/${username}.nix;
        home-manager.extraSpecialArgs = { inherit inputs; vars = { inherit username; }; };
        home-manager.backupFileExtension = "backup";
      }
      ] ++ extraModules;
    };
  in {
    nixosConfigurations = {
      charm = mkHost {
        hostname = "precision"; # Folder name in ./hosts/
        system = "x86_64-linux";
        username = "strange";
      };
      zone = mkHost {
        hostname = "adlink";
        system = "aarch64-linux";
        username = "tape";
      };
      tau = mkHost {
        hostname = "powerspec";
        system = "x86_64-linux";
        username = "neutrino";
      };
    };
  };
}
