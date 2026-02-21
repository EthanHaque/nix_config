{ config, pkgs, lib, inputs, ... }:

let
  inherit (inputs.nix-minecraft.lib) collectFilesAt;

  homesteadModpack = pkgs.fetchPackwizModpack {
    src = inputs.homestead-pack;
    packHash = lib.fakeHash;
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
        difficulty = "normal";
        gamemode = "survival";
        motd = "Homestead";
        max-players = 10;
        view-distance = 12;
        simulation-distance = 10;
      };

      symlinks = collectFilesAt homesteadModpack "mods" // {
        "mods/DistantHorizons-2.4.5-b-1.20.1.jar" = distantHorizons;
      };

      files = collectFilesAt homesteadModpack "config";
    };
  };
}
