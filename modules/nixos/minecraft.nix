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

  cobbleversePack = fetchMrpack {
    url = "https://cdn.modrinth.com/data/Jkb29YJU/versions/jImAfjVc/COBBLEVERSE%201.7.30.mrpack";
    hash = "";
  };

  extraServerMods = {
    C2ME = pkgs.fetchurl {
      url = "https://cdn.modrinth.com/data/VSNURh3q/versions/HqusQu7H/c2me-fabric-mc1.21.1-0.3.0%2Balpha.0.317.jar";
      sha512 = "c4cd79e20a8b69ecedf507cad8d4d532db5dab2c1e34c5a254e6f8414cafd9f9cd01c0394e730c16340211d397bd30960e247c09bf66c48e455e481e3a9bf6db";
    };
  };

  extraModsDrv = pkgs.runCommand "extra-mods" {} ''
    mkdir -p $out/mods
    ${lib.concatStringsSep "\n" (lib.mapAttrsToList
      (name: drv: "cp ${drv} $out/mods/${name}.jar") extraServerMods)}
  '';

  # Merge modpack + extra mods into one derivation
  serverPack = pkgs.symlinkJoin {
    name = "cobbleverse-server-pack";
    paths = [ cobbleversePack extraModsDrv ];
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
      package = pkgs.fabricServers.fabric-1_21_1;

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
        motd = "Cobbleverse on Nix";
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
