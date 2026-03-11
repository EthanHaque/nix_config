{ pkgs, lib, inputs, ... }:

let
  # Fetch a Modrinth .mrpack and build a derivation containing all server-side
  # mods and override files. Based on https://leixb.fly.dev/blog/modrinth-modpacks-nix
  fetchMrpack = { url, hash }:
    let
      mrpackZip = pkgs.fetchurl {
        inherit url hash;
      };

      mrpack = pkgs.runCommand "mrpack-unpacked" { nativeBuildInputs = [ pkgs.unzip ]; } ''
        mkdir -p $out
        unzip -o -q ${mrpackZip} -d $out
        chmod -R u+r $out
      '';

      index = builtins.fromJSON (builtins.readFile "${mrpack}/modrinth.index.json");

      serverFiles = builtins.filter
        (f: !(f ? env) || f.env.server != "unsupported")
        index.files;

      downloads = builtins.map (file: pkgs.fetchurl {
        urls = file.downloads;
        inherit (file.hashes) sha512;
      }) serverFiles;

      paths = builtins.map (builtins.getAttr "path") serverFiles;

      derivations = lib.zipListsWith (path: download:
        let parts = builtins.match "(.*)/(.*$)" path;
        in pkgs.runCommand (builtins.elemAt parts 1) {} ''
          mkdir -p "$out/${builtins.elemAt parts 0}"
          cp ${download} "$out/${path}"
        ''
      ) paths downloads;
    in pkgs.symlinkJoin {
      name = "${index.name}-${index.versionId}";
      paths = derivations
        ++ lib.optional (builtins.pathExists "${mrpack}/overrides") "${mrpack}/overrides"
        ++ lib.optional (builtins.pathExists "${mrpack}/server-overrides") "${mrpack}/server-overrides";
    };

  prominencePack = fetchMrpack {
    url = "https://cdn.modrinth.com/data/EGs3lC8D/versions/nF5w8UmJ/Prominence%20II%20%5BFABRIC%5D%202.2.0.mrpack";
    hash = "sha256-pXQB7kn7hiWwIieI0XixBWLcRRIPE2YWRf+1XN6nZa4=";
  };

  extraServerMods = {
    C2ME = pkgs.fetchurl {
      url = "https://cdn.modrinth.com/data/VSNURh3q/versions/s4WOiNtz/c2me-fabric-mc1.20.1-0.2.0%2Balpha.11.16.jar";
      sha512 = "359c715fd6a0464192d36b4d9dbb7927776eaae498f0cab939b49740fc724bda83aaf4f069f395dc5975d1e82762ee3b602111d9375eb27ab6f5360c4b17f2ff";
    };
  };

  extraModsDrv = pkgs.runCommand "extra-mods" {} ''
    mkdir -p $out/mods
    ${lib.concatStringsSep "\n" (lib.mapAttrsToList
      (name: drv: "cp ${drv} $out/mods/${name}.jar") extraServerMods)}
  '';

  # Merge modpack + extra mods into one derivation
  serverPack = pkgs.symlinkJoin {
    name = "prominence-server-pack";
    paths = [ prominencePack extraModsDrv ];
  };

  # Recursively collect files under a directory into an attrset for symlinks/files
  collectFiles = base: dir:
    let
      fullDir = "${base}/${dir}";
      entries = builtins.readDir fullDir;
      process = name: type:
        if type == "directory"
        then collectFiles base "${dir}/${name}"
        else { "${dir}/${name}" = "${fullDir}/${name}"; };
    in lib.foldlAttrs (acc: name: type: acc // process name type) {} entries;
in
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

      # Flags sourced from:
      #   https://wiki.openjdk.org/display/zgc/Main
      #   https://docs.oracle.com/en/java/javase/24/gctuning/z-garbage-collector.html
      jvmOpts = builtins.concatStringsSep " " [
        "-Xms8G"
        "-Xmx8G"
        "-XX:+UseZGC"
        "-XX:+ZGenerational"
        "-XX:+AlwaysPreTouch"
        "-XX:+DisableExplicitGC"
        "-XX:+PerfDisableSharedMem"
      ];

      symlinks = {
        "mods" = "${serverPack}/mods";
      };

      files = lib.optionalAttrs (builtins.pathExists "${serverPack}/config")
        (collectFiles serverPack "config");

      serverProperties = {
        server-port = 25565;
        white-list = true;
        difficulty = "hard";
        gamemode = "survival";
        motd = "Prominence II on Nix";
        max-players = 10;
        view-distance = 10;
        simulation-distance = 8;
        sync-chunk-writes = false;
        network-compression-threshold = 256;
      };

      whitelist = {
        "bbeeath" = "e82e11fa-74f8-4958-b1fa-e9f4d1357c95";
      };

      operators = {
        "bbeeath" = "e82e11fa-74f8-4958-b1fa-e9f4d1357c95";
      };
    };
  };
}

