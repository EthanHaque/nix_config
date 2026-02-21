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

      jvmOpts = builtins.concatStringsSep " " [
        "-Xms8G"
        "-Xmx8G"
        "-XX:+UseG1GC"
        "-XX:+ParallelRefProcEnabled"
        "-XX:MaxGCPauseMillis=200"
        "-XX:+UnlockExperimentalVMOptions"
        "-XX:+DisableExplicitGC"
        "-XX:+AlwaysPreTouch"
        "-XX:G1NewSizePercent=30"
        "-XX:G1MaxNewSizePercent=40"
        "-XX:G1HeapRegionSize=8M"
        "-XX:G1ReservePercent=20"
        "-XX:G1HeapWastePercent=5"
        "-XX:G1MixedGCCountTarget=4"
        "-XX:InitiatingHeapOccupancyPercent=15"
        "-XX:G1MixedGCLiveThresholdPercent=90"
        "-XX:G1RSetUpdatingPauseTimePercent=5"
        "-XX:SurvivorRatio=32"
        "-XX:+PerfDisableSharedMem"
        "-XX:MaxTenuringThreshold=1"
      ];


      serverProperties = {
        server-port = 25565;
        white-list = true;
        difficulty = "hard";
        gamemode = "survival";
        motd = "Homestead on Nix";
        max-players = 10;
        view-distance = 10;
        simulation-distance = 6;
      };

      whitelist = {
        "bbeeath" = "e82e11fa-74f8-4958-b1fa-e9f4d1357c95";
      };

      operators = {
        "bbeeath" = "e82e11fa-74f8-4958-b1fa-e9f4d1357c95";
      };

      symlinks = collectFilesAt homesteadModpack "mods"
        // collectFilesAt homesteadModpack "patchouli_books";

      files = collectFilesAt homesteadModpack "config"
        // collectFilesAt homesteadModpack "kubejs"
        // collectFilesAt homesteadModpack "scripts";
    };
  };
}
