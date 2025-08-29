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

  outputs = inputs@{ nixpkgs, home-manager, nixos-hardware, nvim-lazy-config, ... }: {
    nixosConfigurations = {
      charm = nixpkgs.lib.nixosSystem rec {
        specialArgs = {
          inherit inputs;
          vars = {
            username = "strange";
          };
        };
        system = "x86_64-linux";
        modules = [
          ./hosts/precision
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.strange = import ./home-manager/strange.nix;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.backupFileExtension = "backup";
          }
          nixos-hardware.nixosModules.dell-precision-5530
        ];
      };
      gluon = nixpkgs.lib.nixosSystem rec {
        specialArgs = {
          inherit inputs;
          vars = {
            username = "muon";
          };
        };
        system = "aarch64-linux";
        modules = [
          ./hosts/adlink
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.muon = import ./home-manager/muon.nix;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.backupFileExtension = "backup";
          }
        ];
      };
      tau = nixpkgs.lib.nixosSystem rec {
        specialArgs = {
          inherit inputs;
          vars = {
            username = "neutrino";
          };
        };
        system = "x86_64-linux";
        modules = [
          ./hosts/powerspec
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.neutrino = import ./home-manager/neutrino.nix;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.backupFileExtension = "backup";
          }
        ];
      };
    };
  };
}
