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

      paper = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/tiny1/default.nix ];
        specialArgs = { inherit inputs; vars = { username = "goober"; }; };
      };

      jebba = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/tiny2/default.nix ];
        specialArgs = { inherit inputs; vars = { username = "pigman"; }; };
      };

      fort = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/tiny3/default.nix ];
        specialArgs = { inherit inputs; vars = { username = "hard"; }; };
      };
    };
  };
}
