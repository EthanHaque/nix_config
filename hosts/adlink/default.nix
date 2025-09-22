{ config, pkgs, lib, inputs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      inputs.nix-minecraft.nixosModules.minecraft-servers
    ];

  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    servers.jenna = {
      enable = true;
      package = pkgs.fabricServers.fabric-1_21_7;
      jvmOpts = "-Xms8G -Xmx8G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true";
      serverProperties = {
        gamemode = "survival";
        difficulty = "hard";
        motd = "Hiiiiii";
        max-players = 4;
        simulation-distance = 16;
        view-distance = 16;
        white-list = true;
        enforce-secure-profile = false;
      };
      whitelist = {
        lenacat = "a3ec2f68-787a-48e9-b02f-a8dbbbe62d97";
        bbeeath = "e82e11fa-74f8-4958-b1fa-e9f4d1357c95";
      };
      operators = {
        bbeeath = "e82e11fa-74f8-4958-b1fa-e9f4d1357c95";
      };
      symlinks = {
        mods = pkgs.linkFarmFromDrvs "mods" (
          builtins.attrValues {
            c2me = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/VSNURh3q/versions/tlZRTK1v/c2me-fabric-mc1.21.8-0.3.4.0.0.jar";
              sha256 = "1zpyrqwypgdvpip8ni25pk7khfrn7ygll7x1qanbqbs0iww1jiij";
            };
            fabric-api = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/JntuF9Ul/fabric-api-0.129.0%2B1.21.7.jar";
              sha256 = "0s172rg4vjhripqhwbfqc84ry92lf2lxgy1v6rnz8xx53bz1cpyv";
            };
            ferrite-core = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/uXXizFIs/versions/CtMpt7Jr/ferritecore-8.0.0-fabric.jar";
              sha256 = "1slflb2w9s9mpbxfx9mzslb8f7qrj5baa4lpacy8r055q80bz41b";
            };
            lithium = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/77EtzYFA/lithium-fabric-0.18.0%2Bmc1.21.7.jar";
              sha256 = "189661hsdw0c8hp9im2768kg1qjgwfvjvxibj7i9nscrb881fk5r";
            };
            scalable-lux = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/Ps1zyz6x/versions/Bi5i8Ema/ScalableLux-0.1.5.1%2Bfabric.abdeefa-all.jar";
              sha256 = "1ksp967jc1z2nzx50p9l8rshp6cd5kslbcvk7vak65d8xd6yknfj";
            };
            spark = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/l6YH9Als/versions/3KCl7Vx0/spark-1.10.142-fabric.jar";
              sha256 = "0bfds8dx7i72fvsqmryh2mdrs8s4bfncsfri9rcpxnamki7583ak";
            };
            distant-horizons = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/uCdwusMi/versions/2mY04ehi/DistantHorizons-2.3.3-b-1.21.7-fabric-neoforge.jar";
              sha256 = "1pciszd4nmadhdgfjkdp1ckpf0frg9fhd9wfvl73vhig9jdqrxka";
            };
            terralith = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/8oi3bsk5/versions/BhiTK9tz/Terralith_1.21.x_v2.5.11.jar";
              sha256 = "1pmilwrdli66d3m6s1173lvs0zh2vz99v5plr0n1xz6jgzy27bgx";
            };
            tectonic = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/lWDHr9jE/versions/GraxbWKG/tectonic-3.0.3-fabric-1.21.6.jar";
              sha256 = "0fnwsny4p8wy218ypxfjfk59b1p980qfqpvndgn1kkffln415nyd";
            };
            lithostiched = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/XaDC71GB/versions/ROo8a9VV/lithostitched-fabric-1.21.6-1.4.11.jar";
              sha256 = "1n5kz62xnzdz4l5s45axljrxq54cf0npaszpnk1frq2zkxj7sij3";
            };
            ping-wheel = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/QQXAdCzh/versions/DYlGFwQ1/Ping-Wheel-1.11.0-fabric-1.21.8.jar";
              sha256 = "1dydzjypmi7injwblv7dkdvsszv7f9ij5iln2j93y6wi2ljbd36y";
            };
            carry-on = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/joEfVgkn/versions/w6USVd4Y/carryon-fabric-1.21.7-2.6.0.jar";
              sha256 = "1lzsh60h0b28cnkjzi8mq1x5nz3cxfgky0jli0sa0ayd05cm701q";
            };
            krypton = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/neW85eWt/krypton-0.2.9.jar";
              sha256 = "1ak3rjfwsxbilccla63wqdz0mwzc7ccvnh8ccnqgc37nw5mj4rmq";
            };
          }
        );
      };
    };
  };

  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.device = "nodev";


  networking.hostName = "gluon";
  networking.networkmanager.enable = false;
  networking.useDHCP = false;
  networking.interfaces."enP2s1f0np0".useDHCP = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22
      80
    ];
  };
  services.duckdns = {
    enable = true;
    domains = [ "pion-01" ];
    tokenFile = /home/muon/Documents/token;
  };

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };


  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };


  virtualisation.docker= {
    enable = true;
  };
  hardware.nvidia-container-toolkit.enable = true;

  users.users.muon = {
    isNormalUser = true;
    description = "muon";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  services.openssh  = {
    enable = true;
    passwordAuthentication = false;
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "muon" ];
    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    stalled-download-timeout = 500;
  };


  nixpkgs.config = {
    allowUnfree = true;
  };

  programs.nano.enable = false;

  environment.variables.EDITOR = "vim";
  environment.systemPackages = with pkgs; [
    vim
    docker-compose
    pinentry-curses
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.stateVersion = "24.11";
}
