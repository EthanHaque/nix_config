{ config, pkgs, lib, inputs, ... }:

let
  inherit (inputs.nix-minecraft.lib) collectFilesAt;

  homesteadModpack = pkgs.fetchPackwizModpack {
    src = inputs.homestead-pack;
    packHash = "sha256-v1Q1sLrL40qgCc3GyMo06W0JFKkPBrYihxGgdPihIQk=";
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
        view-distance = 6;
        simulation-distance = 6;
      };

      whitelist = {
        "bbeeath" = "e82e11fa-74f8-4958-b1fa-e9f4d1357c95";
      };

      operators = {
        "bbeeath" = "e82e11fa-74f8-4958-b1fa-e9f4d1357c95";
      };

      symlinks = collectFilesAt homesteadModpack "mods"
        // collectFilesAt homesteadModpack "patchouli_books"
        // collectFilesAt homesteadModpack "resourcepacks";

      files = collectFilesAt homesteadModpack "config";
        // collectFilesAt homesteadModpack "kubejs"
        // collectFilesAt homesteadModpack "scripts";
    };
  };
}
