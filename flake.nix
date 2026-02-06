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
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {


    nixosConfigurations = {
      zone = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [ ./hosts/adlink/default.nix ];
        specialArgs = { inherit inputs; vars = { username = "tape"; }; };
      };


      tau = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/powerspec/default.nix ];
        specialArgs = { inherit inputs; vars = { username = "neutrino"; }; };
      };


      charm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/precision/default.nix ];
        specialArgs = { inherit inputs; vars = { username = "strange"; }; };
      };
    };


    homeConfigurations = {
      "tape@zone" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-linux;
        modules = [
            ./modules/home-manager/core.nix
          {
            home.username = "tape";
            home.homeDirectory = "/home/tape";
          }
        ];
        extraSpecialArgs = { inherit inputs; };
      };


      "neutrino@tau" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
            ./modules/home-manager/gui.nix
            ./modules/home-manager/wms/sway.nix
            ./modules/home-manager/wms/gnome.nix
            {
              home.username = "neutrino";
              home.homeDirectory = "/home/neutrino";
            }
        ];
        extraSpecialArgs = { inherit inputs; };
      };


      "strange@charm" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
            ./modules/home-manager/gui.nix
            ./modules/home-manager/wms/gnome.nix
            {
              home.username = "strange";
              home.homeDirectory = "/home/strange";
            }
        ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
  };
}
