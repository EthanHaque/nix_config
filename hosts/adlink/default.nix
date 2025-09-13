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
      package = pkgs.fabricServers.fabric-1_21_5;
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
              url = "https://cdn.modrinth.com/data/VSNURh3q/versions/jrmtD6AF/c2me-fabric-mc1.21.5-0.3.3.0.0.jar";
              sha512 = "3wsjlk0la76lr1asgd4jydihcd013khsh4cssa9bavba3qvd03wx0glp9iy4bpb8lx294jm93b7a093qlbmkb7ijjsciblsxzy3wsjd";
            };
            fabric-api = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/kKEGlsne/fabric-api-0.128.2%2B1.21.5.jar";
              sha512 = "3vvr6f8dqlb6pw9jjvm0jpidcajs2cgb2z900ds393x8pdbzz3rcbq2shrzi8dghzb686ajlnynn8sdbz8szaydchdmr93338nvfhhf";
            };
            ferrite-core = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/uXXizFIs/versions/CtMpt7Jr/ferritecore-8.0.0-fabric.jar";
              sha512 = "12pg6yw3dn1x2rg1xwz8bgb20w894jwxn77v8ay5smfpymkbd184fnad34byqb23b9hdh9hry7dc16ncb1kijxz6mj9dw36sg8q46qk";
            };
            lithium = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/xcELvp6R/lithium-fabric-0.16.3%2Bmc1.21.5.jar";
              sha512 = "1w4vb1zrkz3v7nfr7l8jbd5jhgd1y6zbq7b080y11pppjq7l9ijyb9xv1vn6mxqlgr7rgcd3sq9zs73phagr3i0frgb6fwima657la2";
            };
            scalable-lux = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/Ps1zyz6x/versions/HOeUVEEY/ScalableLux-0.1.3.1%2Bfabric.ce1e005-all.jar";
              sha512 = "1sj4j9q1imv4r1vzhyncld1bri7gq1fjsdhqnq17d4s0kzkhirhma2mzsvb6yh7ky35ps1mfg0d8jv0459qp23lfni2wamwqb4byfi4";
            };
            spark = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/l6YH9Als/versions/65SnrRgF/spark-1.10.138-fabric.jar";
              sha512 = "2fcgbd36jfz2m4nszsimgd3fy03y3iafjfs57h4jv6l21acyb9l48lzmrbwi67lwimqjwc5plw5iz9kajcrmzxhxzwq65zcqxqv3gf2";
            };
            distant-horizons = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/uCdwusMi/versions/AfpfSizB/DistantHorizons-2.3.4-b-1.21.5-fabric-neoforge.jar";
              sha512 = "2jlxvxvh3hsn9lkqsxa758pd5ysrvdnfqnwscbk60x14i21hw0dp2636pmlb323l1xvcfdwygl95m0pn01m8rxzc4xyksfb4k4vi31c";
            };
            terralith = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/8oi3bsk5/versions/BhiTK9tz/Terralith_1.21.x_v2.5.11.jar";
              sha512 = "112bgvl51sldy1sb2bzavxxqwv4dkmbgsh9chm52sz8ii8p9frnh15085shsbda4109xfcsw9wb1z11744ypyxa6cc3msf0bm2qxqvv";
            };
            tectonic = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/lWDHr9jE/versions/96BO8leD/tectonic-3.0.1-fabric-1.21.5.jar";
              sha512 = "1w9z0pp4mm7kzvdzvxqih0f602x84n2xcqi5yfy73bw622gfvrng23dikf4q0cgzlgl5lb1cwpvw1018f4p2hpwhj5akrdwk33r7ki6";
            };
            lithostiched = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/XaDC71GB/versions/wupt6y4U/lithostitched-fabric-1.21.5-1.4.8.jar";
              sha512 = "153n1zd45aq18y0ybm63m27b56nyd92n3qw6mv3q5cdgksqz72cx99hk10g6i4szdal4j4jbly11ml45jz80qsm1g96xhpnkhqd7ixz";
            };
            ping-wheel = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/QQXAdCzh/versions/9et2fLTE/Ping-Wheel-1.11.0-fabric-1.21.5.jar";
              sha512 = "02n09sg7vhwh8rpf00mwskl66nmbnxfa2yysl72vvw45b1kh2n4kb4wbccp1qdfxj6zm3akkzcg03a4ffgrxmjp1xf97081dp2rhnis";
            };
            carry-on = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/joEfVgkn/versions/y2tspn55/carryon-fabric-1.21.5-2.4.0.jar";
              sha512 = "16ijxpiwqqxjzhlailjqpfwzz4miwdn45irs440b698jlc018951npvs6lhfzy9fihb32564g3pvqyrhzyjwg2napgw28x7dy6r512x";
            };
            krypton = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/neW85eWt/krypton-0.2.9.jar";
              sha512 = "3mzyfa9mpnk3jw9fwskpxrwz5bfnlf515pskyl3l358ay7p1yq3v4xjdqk9365zxr6x3z3xbhravgy9aipf54pf79w9bkvyn6qh88rf";
            };
            noisium = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/KuNKN7d2/versions/sUh67T4Y/noisium-fabric-2.6.0%2Bmc1.21.5.jar";
              sha512 = "0wgj6lrjjr8xik4lssi5yqxafjk4q9r8h8nqcb20cjnw118dmjwlylfmg065hrd1wx30mrwp9l1wx1nr0mfd3yzhyci1qp7gl9vcwa4";
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
