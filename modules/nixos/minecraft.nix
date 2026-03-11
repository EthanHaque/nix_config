{ pkgs, inputs, ... }:
let
  inherit (inputs.nix-minecraft.lib) collectFilesAt;
  serverModpack = pkgs.fetchPackwizModpack {
    src = inputs.perf_packwiz;
    packHash = "";
  }
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  # Pin the Minecraft server to P-cores (threads 0-15) on the i7-14700.
  # P-cores turbo to 5.3 GHz vs E-cores at 4.2 GHz
  systemd.services.minecraft-server-jebbaserver.serviceConfig.AllowedCPUs = "0-15";

  services.minecraft-servers = {
    enable = true;
    eula = true;

    servers.jebbaserver = {
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
      ];

      serverProperties = {
        server-port = 25565;
        white-list = true;
        difficulty = "hard";
        gamemode = "survival";
        motd = "jebbaserver on Nix";
        max-players = 10;
        view-distance = 10;
        simulation-distance = 8;
        level-seed = "jebba05";
        sync-chunk-writes = false;
        network-compression-threshold = 256;
      };

      symlicks = collectFilesAt serverModpack "mods";

      whitelist = {
        "bbeeath" = "e82e11fa-74f8-4958-b1fa-e9f4d1357c95";
      };

      operators = {
        "bbeeath" = "e82e11fa-74f8-4958-b1fa-e9f4d1357c95";
      };
    };
  };
}
