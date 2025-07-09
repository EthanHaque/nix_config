{ config, pkgs, ... }:

let
  # Scripts Path
  # This makes it easy to reference the scripts package below
  mechabar-scripts = pkgs.callPackage ./mechabar-scripts.nix { };

in
{
  # -------------------------------------------------------------------
  # 1. Install Dependencies
  # -------------------------------------------------------------------
  # Packages required by mechabar and its scripts
  home.packages = with pkgs; [
    bluez
    brightnessctl
    pipewire
    wireplumber
    rofi-wayland
    bluetui
    networkmanager
    upower
    libnotify
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # -------------------------------------------------------------------
  # 2. Waybar Configuration
  # -------------------------------------------------------------------
  programs.waybar = {
    enable = true;

    # The main JSONC config is taken from the mechabar repository.
    # We replace the script paths with our Nix-managed script package.
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        height = 35;
        spacing = 0;
        "margin-top" = 0;
        "margin-bottom" = 0;
        "modules-left" = [
          "custom/theme"
          "custom/paddl"
          "custom/left1"
          "workspaces"
          "custom/right1"
          "custom/paddm"
          "custom/left2"
          "custom/temperature"
          "custom/left3"
          "memory"
          "custom/left4"
          "cpu"
          "custom/left5"
          "custom/distro"
          "custom/right2"
        ];
        "modules-center" = [ "window" ];
        "modules-right" = [
          "custom/rightin1"
          "idle_inhibitor"
          "clock#time"
          "custom/right3"
          "clock#date"
          "custom/right4"
          "custom/wifi"
          "bluetooth"
          "custom/update"
          "custom/right5"
          "mpris"
          "custom/left6"
          "pulseaudio"
          "custom/left7"
          "backlight"
          "custom/left8"
          "battery"
          "custom/leftin2"
          "custom/power"
        ];
        "custom/theme" = {
          format = "󰉼";
          tooltip = false;
          on-click = "${mechabar-scripts}/bin/theme-switcher";
        };
        workspaces = {
          format = "{icon}";
          "format-icons" = {
            "1" = "󰎦"; "2" = "󰎩"; "3" = "󰎬"; "4" = "󰎮"; "5" = "󰎰";
            "6" = "󰎵"; "7" = "󰎸"; "8" = "󰎻"; "9" = "󰎾"; "10" = "󰽀";
            focused = "󰮯";
            default = "󱙜";
          };
        };
        "custom/temperature" = {
          format = "{}";
          return-type = "json";
          exec = "${mechabar-scripts}/bin/cpu-temp";
          on-click = "kitty --hold -e btop";
        };
        memory = {
          interval = 1;
          format = "󰍛 {}%";
          "format-alt" = "󰍛 {used:0.2f}GB";
        };
        cpu = {
          interval = 1;
          format = "󰻠 {usage}%";
          "format-alt" = "󰻠 {avg_frequency}GHz";
        };
        "custom/distro" = {
          format = "󰣇";
          tooltip = false;
        };
        "clock#time" = {
          format = "{:%I:%M %p}";
        };
        "clock#date" = {
          format = "{:%a, %b %d}";
          "format-alt" = "{:%Y-%m-%d}";
        };
        "custom/wifi" = {
          format = "{}";
          return-type = "json";
          exec = "${mechabar-scripts}/bin/wifi-status";
          on-click = "${mechabar-scripts}/bin/wifi-menu";
          "on-click-right" = "nm-connection-editor";
        };
        bluetooth = {
          format = "󰂯";
          "format-disabled" = "󰂲";
          "format-off" = "󰂲";
          on-click = "${mechabar-scripts}/bin/bluetooth-menu";
        };
        "custom/update" = {
          format = "{}";
          return-type = "json";
          interval = 3600; # Check every hour
          exec = "${mechabar-scripts}/bin/system-update";
          on-click = "${mechabar-scripts}/bin/system-update up";
        };
        mpris = {
          "player-icons" = { default = "󰝚"; };
          "status-icons" = { "playing" = "󰐊"; "paused" = "󰏤"; };
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          "format-muted" = "󰝟 Muted";
          "format-icons" = {
            default = [ "" "" "" ];
          };
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        };
        backlight = {
          device = "intel_backlight";
          format = "{icon} {percent}%";
          "format-icons" = [ "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨" ];
          on-scroll-up = "${mechabar-scripts}/bin/brightness-control -o i";
          on-scroll-down = "${mechabar-scripts}/bin/brightness-control -o d";
        };
        battery = {
          states = { warning = 20; critical = 10; };
          format = "{icon} {capacity}%";
          "format-charging" = "󰂄 {capacity}%";
          "format-plugged" = "󰂄 {capacity}%";
          "format-icons" = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        };
        "custom/power" = {
          format = "󰐥";
          tooltip = false;
          on-click = "${mechabar-scripts}/bin/power-menu";
        };
        # --- Powerline Glyphs ---
        "custom/left1" = { "format" = ""; };
        "custom/right1" = { "format" = ""; };
        "custom/left2" = { "format" = ""; };
        "custom/right2" = { "format" = ""; };
        # ... and so on for all the separators
      };
    };

    # Combined and adapted CSS from the repo
    style = ''
      @import "${pkgs.catppuccin-gtk}/share/themes/Catppuccin-Mocha-Standard-Blue-Dark/gtk-3.0/gtk.css";

      * {
        min-height: 0;
        border: none;
        margin: 0;
        padding: 0;
        font-family: "JetBrainsMono Nerd Font";
        font-size: 14px;
        font-weight: bold;
      }

      window#waybar {
        background: rgba(24, 24, 37, 0.8); /* Crust with transparency */
        border: 1px solid @theme_selected_bg_color;
        border-radius: 12px;
      }

      #workspaces, #memory, #cpu, #pulseaudio, #backlight, #battery, #clock, #tray, #custom-wifi, #bluetooth, #custom-update, #custom-power, #custom-theme, #custom-temperature {
        padding: 0 10px;
        margin: 3px 0;
      }

      #workspaces button {
        color: @theme_fg_color;
        padding: 0 5px;
        background: transparent;
      }

      #workspaces button.focused {
        color: @theme_bg_color;
        background: @theme_selected_bg_color;
        border-radius: 8px;
      }

      #workspaces button:hover {
        background: @theme_selected_bg_color;
        color: @theme_bg_color;
        border-radius: 8px;
      }

      .modules-right > * {
        margin-left: 5px;
      }

      #battery.critical {
        color: #f38ba8; /* Catppuccin Red */
      }
    '';
  };

  # -------------------------------------------------------------------
  # 3. Rofi Configuration
  # -------------------------------------------------------------------
  programs.rofi = {
    enable = true;
    theme = "catppuccin"; # Assumes a rofi theme named this exists
    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      terminal = "kitty";
    };
  };

  # -------------------------------------------------------------------
  # 4. Systemd User Services for Battery Notifications
  # -------------------------------------------------------------------
  systemd.user.services.battery-level = {
    Unit = {
      Description = "Battery Level Checker";
      After = "graphical.target";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${mechabar-scripts}/bin/battery-level";
    };
  };

  systemd.user.timers.battery-level = {
    Unit = {
      Description = "Run Battery Level Checker every minute";
    };
    Timer = {
      OnBootSec = "1min";
      OnUnitActiveSec = "1min";
      Unit = "battery-level.service";
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };

  # -------------------------------------------------------------------
  # 5. Udev Rule for Battery State Change Notifications
  # -------------------------------------------------------------------
  # This part belongs in your system-wide configuration.nix
  # services.udev.extraRules = ''
  #   ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0", ENV{DISPLAY}=":0", RUN+="${pkgs.su}/bin/su ${config.home.username} -c '${mechabar-scripts}/bin/battery-state discharging'"
  #   ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", ENV{DISPLAY}=":0", RUN+="${pkgs.su}/bin/su ${config.home.username} -c '${mechabar-scripts}/bin/battery-state charging'"
  # '';
}
