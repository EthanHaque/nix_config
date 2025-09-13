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
              sha512 = "MMvFIMuDSQNtVaHLHyaWTPAkEM9talYdnMBxZNdWajp1ZDZ95iUQ8rq1ByPCx8QBcYABFT+oM1YGNM5LLiEnZw==";
            };
            fabric-api = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/JntuF9Ul/fabric-api-0.129.0%2B1.21.7.jar";
              sha512 = "Q79q8UWmtFBQOm1+fsmjSRK9FJSWm12IYQZ/D4Rs9xCAVBX7D7yTya6fUWTUXHZJNC+EtPNFUrKr3Ykv07mDjg==";
            };
            ferrite-core = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/uXXizFIs/versions/CtMpt7Jr/ferritecore-8.0.0-fabric.jar";
              sha512 = "ExuC0dNm8JZkNb/LOMNi1gTWjs8wwQbTGmJhv8hoyjqCQluz+uuqLl6hfY7tXJKEOBDrLfR5Dy+LHmwb3Jt3RQ==";
            };
            lithium = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/77EtzYFA/lithium-fabric-0.18.0%2Bmc1.21.7.jar";
              sha512 = "r69t2vDLriBQ1yXv1DjEyYFB1zimN/DwWNy6/wd++Fr4AeLcoTjOn3+Lo6Fp3GrxyfVnNrJVxuoTNj+KG+js2w==";
            };
            scalable-lux = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/Ps1zyz6x/versions/Bi5i8Ema/ScalableLux-0.1.5.1%2Bfabric.abdeefa-all.jar";
              sha512 = "Qh4WkejZUG3vSJELsVyZQT6vabHE/ltyn1E/TC4c0l3bgVU5fpyeurNTznKFCnymJhnIX90G05vIfPp1IK8CgQ==";
            };
            spark = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/l6YH9Als/versions/3KCl7Vx0/spark-1.10.142-fabric.jar";
              sha512 = "lbfk8kFuIKv52d9B/LzgTyjr8KoIY3R0JlJ4mohkLdaCDIiEqyQDNFVTRbScOffQyvI9UhzslRaZHvQ7okdYrw==";
            };
            distant-horizons = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/uCdwusMi/versions/2mY04ehi/DistantHorizons-2.3.3-b-1.21.7-fabric-neoforge.jar";
              sha512 = "X41OVk9l3L5eA5r4YF2k34qO3MIhikaq2CeqqNHohIrbMCZyc19XlxW+HEgJVt1t11SKK/+brMTw7wWS7s6yOA==";
            };
            terralith = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/8oi3bsk5/versions/BhiTK9tz/Terralith_1.21.x_v2.5.11.jar";
              sha512 = "e+OORV3A6ToYM6r76wk5IfyweOKauZ5AIKotDXVBoARos0sXxYi+FqVClqB+q85GNse9b/WXWDr4RnUodL8lQg==";
            };
            tectonic = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/lWDHr9jE/versions/GraxbWKG/tectonic-3.0.3-fabric-1.21.6.jar";
              sha512 = "2sTy2YNaKT8btmQ0kSJkEr9UG7XX2GSkdJcm5hrMV+6bc7f8raywc7qN6Lzzxfzm5GCB95gHlqcUAYiBG5VFfA==";
            };
            lithostiched = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/XaDC71GB/versions/ROo8a9VV/lithostitched-fabric-1.21.6-1.4.11.jar";
              sha512 = "HWMZLbotzBbxVlLzEoo5DaWC+1vgmkqhrTgFyAXaD/87FfvK3h676dUD6uwb2ko+BjkCq6PW7soOuLzm/N24WQ==";
            };
            ping-wheel = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/QQXAdCzh/versions/DYlGFwQ1/Ping-Wheel-1.11.0-fabric-1.21.8.jar";
              sha512 = "ltSFkuDWtHTF5BuXrVnl2qhWNR151gZBwHoEOWqAPq46qAv27nVHKxDkticfT9xOqQC/3fk6/ewxSWehuFUDIA==";
            };
            carry-on = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/joEfVgkn/versions/w6USVd4Y/carryon-fabric-1.21.7-2.6.0.jar";
              sha512 = "fLYalvPeU1L5i4Zlukqa/aiKH1zWD6OungaoHcu2xgj1v0HayUvVWykuLz8700AQId0vKFB6K6jIFR5D5iSimw==";
            };
          }
        );
      };
    };
    servers.modded = {
      enable = false;
      package = pkgs.fabricServers.fabric-1_21_8;
      jvmOpts = "-Xms8G -Xmx8G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true";
      serverProperties = {
        gamemode = "survival";
        difficulty = "hard";
        motd = "The gang's Minecraft server";
        max-players = 10;
        simulation-distance = 16;
        view-distance = 16;
      };
      operators = {
        bbeeath = "e82e11fa-74f8-4958-b1fa-e9f4d1357c95";
      };
      symlinks = {
        mods = pkgs.linkFarmFromDrvs "mods" (
          builtins.attrValues {
            c2me = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/VSNURh3q/versions/tlZRTK1v/c2me-fabric-mc1.21.8-0.3.4.0.0.jar";
              sha512 = "MMvFIMuDSQNtVaHLHyaWTPAkEM9talYdnMBxZNdWajp1ZDZ95iUQ8rq1ByPCx8QBcYABFT+oM1YGNM5LLiEnZw==";
            };
            chunky = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/fALzjamp/versions/inWDi2cf/Chunky-Fabric-1.4.40.jar";
              sha512 = "ngOG0DJkGhJP2VOmiKSAZt9/TsEYb38PiwpW1J3O0iDi1pOO1W6djq14u4DduUG8eHP1g63Y5WW9rN9i4TrcKA==";
            };
            fabric-api = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/Q8ssLFZp/fabric-api-0.133.0%2B1.21.8.jar";
              sha512 = "BKsr0pgO86ygB2NnbRMokh4aixUxcS6nyot02u/Cu5hveME6LIIa5laFdOS96zyaMWrs3URZotQmRlCMdHjCbw==";
            };
            ferrite-core = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/uXXizFIs/versions/CtMpt7Jr/ferritecore-8.0.0-fabric.jar";
              sha512 = "ExuC0dNm8JZkNb/LOMNi1gTWjs8wwQbTGmJhv8hoyjqCQluz+uuqLl6hfY7tXJKEOBDrLfR5Dy+LHmwb3Jt3RQ==";
            };
            lithium = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/pDfTqezk/lithium-fabric-0.18.0%2Bmc1.21.8.jar";
              sha512 = "bGmVB2D0jviPDFhx5hAptZrwOrXtmwArakcNet/fJvC4ddzTYLZk6JcpEAJTCYHCDgsokPuInyns2qAH+IUQDw==";
            };
            scalable-lux = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/Ps1zyz6x/versions/Bi5i8Ema/ScalableLux-0.1.5.1%2Bfabric.abdeefa-all.jar";
              sha512 = "Qh4WkejZUG3vSJELsVyZQT6vabHE/ltyn1E/TC4c0l3bgVU5fpyeurNTznKFCnymJhnIX90G05vIfPp1IK8CgQ==";
            };
            spark = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/l6YH9Als/versions/3KCl7Vx0/spark-1.10.142-fabric.jar";
              sha512 = "lbfk8kFuIKv52d9B/LzgTyjr8KoIY3R0JlJ4mohkLdaCDIiEqyQDNFVTRbScOffQyvI9UhzslRaZHvQ7okdYrw==";
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
