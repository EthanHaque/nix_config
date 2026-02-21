{ config, pkgs, lib, inputs, ... }:

let
  inherit (inputs.nix-minecraft.lib) collectFilesAt;

  homesteadModpack = pkgs.fetchPackwizModpack {
    src = inputs.homestead-pack;
    packHash = "sha256-v1Q1sLrL40qgCc3GyMo06W0JFKkPBrYihxGgdPihIQk=";
  };

  distantHorizons = pkgs.fetchurl {
    url = "https://cdn.modrinth.com/data/uCdwusMi/versions/lC6CwqPp/DistantHorizons-2.4.5-b-1.20.1-fabric-forge.jar";
    hash = "sha512-Z5y2+bVdfupDwX8CBAQhQFkN5xKwzs3BQBboBkqYRmleL0OJIjd/ZY4mU0xJy2Hm2pOaa+U8LLHNG8CItp2z7g==";
  };
in
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;

    servers.homestead = {
      enable = true;
      openFirewall = true;
      package = pkgs.fabricServers.fabric-1_20_1;

      jvmOpts = "-Xms4G -Xmx8G";

      serverProperties = {
        server-port = 25565;
        white-list = true;
        difficulty = "hard";
        gamemode = "survival";
        motd = "Homestead on Nix";
        max-players = 10;
        view-distance = 12;
        simulation-distance = 10;
      };

      whitelist = {
        "bbeeath" = "e82e11fa-74f8-4958-b1fa-e9f4d1357c95";
      };

      operators = {
        "bbeeath" = "e82e11fa-74f8-4958-b1fa-e9f4d1357c95";
      }

      symlinks = collectFilesAt homesteadModpack "mods" // {
        "mods/DistantHorizons-2.4.5-b-1.20.1.jar" = distantHorizons;
      };

      files = collectFilesAt homesteadModpack "config";
    };
  };
}
