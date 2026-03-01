{ config, pkgs, lib, inputs, ... }:

let
  inherit (inputs.nix-minecraft.lib) collectFilesAt;

  homesteadModpack = pkgs.fetchPackwizModpack {
    src = inputs.homestead-pack;
    packHash = "sha256-DIc1/wRvHw0YJrmRUUtXIJSSUaXFeR/SpK49OUEk080=";
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
        "-XX:+UseZGC"
        "-XX:+ZGenerational"
        "-XX:+AlwaysPreTouch"
        "-XX:+DisableExplicitGC"
        "-XX:+PerfDisableSharedMem"
        "-XX:+UnlockExperimentalVMOptions"
        "-XX:ConcGCThreads=4"
      ];


      serverProperties = {
        server-port = 25565;
        white-list = true;
        difficulty = "hard";
        gamemode = "survival";
        motd = "Homestead on Nix";
        max-players = 10;
        view-distance = 10;
        simulation-distance = 8;
        level-seed = "jebba05";
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
