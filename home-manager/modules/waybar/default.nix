{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./style.css;
    settings = [
      # ------------------- Top Bar -------------------
      {
        name = "topbar";
        layer = "top";
        position = "top";
        mode = "dock";
        exclusive = true;
        spacing = 2;
        passthrough = false;
        "gtk-layer-shell" = true;
        "reload_style_on_change" = true;

        modules-left = [
          "clock"
          "bluetooth"
          "network"
          "privacy"
          "hyprland/submap"
        ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "mpris"
          "mpd"
          "wireplumber"
          "group/cpu-load"
          "memory"
          "systemd-failed-units"
          "group/power"
        ];

        "group/power" = {
          orientation = "inherit";
          drawer = {
            "transition-duration" = 500;
            "children-class" = "drawer-child";
            "transition-left-to-right" = false;
          };
          modules = [
            "custom/power"
            "custom/quit"
            "custom/lock"
            "custom/reboot"
          ];
        };
        "custom/quit" = {
          format = "󰗼";
          tooltip = true;
          "tooltip-format" = "Quit";
          "on-click" = "hyprctl dispatch exit";
        };
        "custom/lock" = {
          format = "󰍁";
          tooltip = true;
          "tooltip-format" = "Lock";
          "on-click" = "${pkgs.hyprlock}/bin/hyprlock";
        };
        "custom/reboot" = {
          format = "󰜉";
          tooltip = true;
          "tooltip-format" = "Reboot";
          "on-click" = "systemctl reboot";
        };
        "custom/power" = {
          format = "";
          tooltip = true;
          "tooltip-format" = "Shutdown";
          "on-click" = "shutdown now";
        };

        "group/cpu-load" = {
          orientation = "inherit";
          drawer = {
            "transition-duration" = 500;
            "children-class" = "drawer-child";
            "transition-left-to-right" = false;
          };
          modules = [ "cpu" "load" ];
        };
        cpu = {
          interval = 1;
          format = "󰍛 {usage}%";
          "on-click" = "";
          tooltip = false;
        };
        load = {
          interval = 10;
          format = "load: {load1} {load5} {load15}";
        };

        memory = {
          interval = 30;
          format = " {}%";
          "format-alt" = " {used}G";
          tooltip = true;
          "tooltip-format" = "{used:0.1f}G/{total:0.1f}G";
        };
        bluetooth = {
          format = " {status}";
          "format-connected" = " {device_alias}";
          "format-connected-battery" = " {device_alias} {device_battery_percentage}%";
          "tooltip-format" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          "tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
          "tooltip-format-enumerate-connected-battery" = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
        };
        "hyprland/window" = {
          format = "{}";
          "max-length" = 50;
          rewrite = {
            "(.*) — Mozilla Firefox" = "🌎 $1";
          };
          "separate-outputs" = true;
        };
        privacy = {
          "icon-spacing" = 4;
          "icon-size" = 14;
          "transition-duration" = 250;
          modules = [
            { type = "screenshare"; tooltip = true; "tooltip-icon-size" = 14; }
            { type = "audio-out"; tooltip = true; "tooltip-icon-size" = 14; }
            { type = "audio-in"; tooltip = true; "tooltip-icon-size" = 14; }
          ];
        };
        network = {
          format = "{ifname} [󰾆 {bandwidthTotalBytes}]";
          "format-wifi" = "{icon} {essid} [󰾆 {bandwidthTotalBytes}]";
          "format-ethernet" = "󱘖  {ifname} [󰾆 {bandwidthTotalBytes}]";
          "format-disconnected" = "󰌙 Disconnected ⚠";
          "format-alt" = "  {ipaddr}  {bandwidthUpBytes}  {bandwidthDownBytes}";
          "tooltip-format" = "{ifname} via {gwaddr} ";
          "tooltip-format-wifi" = "{frequency} MHz ({signalStrength}%)";
          "tooltip-format-ethernet" = "{ipaddr}/{cidr}  {bandwidthUpBytes}  {bandwidthDownBytes}";
          "tooltip-format-disconnected" = "Disconnected ⚠";
          "max-length" = 72;
          "format-icons" = [ "󰤯 " "󰤟 " "󰤢 " "󰤢 " "󰤨 " ];
        };
        clock = {
          format = "⏰{:%I:%M %p}";
          "format-alt" = "📅{:%A, %B %d, %Y (%I:%M %p)}";
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            "mode-mon-col" = 3;
            "weeks-pos" = "right";
            "on-scroll" = 1;
            "on-click-right" = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            "on-click-right" = "mode";
            "on-click-forward" = "tz_up";
            "on-click-backward" = "tz_down";
            "on-scroll-up" = "shift_up";
            "on-scroll-down" = "shift_down";
          };
        };
        wireplumber = {
          format = "{icon} {volume}%";
          "format-muted" = " Muted";
          "format-icons" = [ " " " " " " ];
          "scroll-step" = 0.2;
          "max-volume" = 100;
          "on-click" = "pavucontrol";
          "on-click-right" = "qpwgraph";
        };
        mpris = {
          format = "{player_icon} {dynamic}";
          "format-paused" = "{status_icon} <i>{dynamic}</i>";
          "max-length" = 50;
          "player-icons" = { default = "󰎆 "; cmus = ""; mpv = "🎵"; vlc = "🎬"; spotify = " "; };
          "status-icons" = { paused = "⏸"; };
          "on-click" = "playerctl play-pause";
          "on-click-right" = "playerctl stop";
          "smooth-scrolling-threshold" = 10;
          "on-scroll-down" = "playerctl previous";
        };
        "systemd-failed-units" = {
          format = "✗ {nr_failed}";
          "format-ok" = "✓";
          system = true;
          user = false;
        };
      }

      # ------------------- Bottom Bar -------------------
      {
        name = "bottombar";
        layer = "top";
        position = "bottom";
        height = 40;
        mode = "dock";
        exclusive = true;
        spacing = 2;
        passthrough = false;
        "gtk-layer-shell" = true;
        "reload_style_on_change" = true;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "wlr/taskbar" ];
        modules-right = [ "tray" "custom/notification" ];

        "hyprland/submap" = {
          format = "✌️ {}";
          "max-length" = 8;
          tooltip = false;
        };
        "hyprland/workspaces" = {
          "on-click" = "activate";
          format = "{icon} {windows}";
          "format-window-separator" = " ";
          "window-rewrite-default" = "";
          "window-rewrite" = {
            "title<.*youtube.*>" = " ";
            "class<firefox>" = "";
            "class<Postman>" = "";
          };
          "on-scroll-up" = "hyprctl dispatch workspace m-1 > /dev/null";
          "on-scroll-down" = "hyprctl dispatch workspace m+1 > /dev/null";
          "format-icons" = {
            special = "🎁";
            persistent = "";
          };
        };
        "wlr/taskbar" = {
          format = "{icon} {title:.17}";
          "icon-size" = 18;
          "icon-theme" = "BeautyLine";
          "tooltip-format" = "{title}";
          "on-click" = "activate";
          "on-click-middle" = "close";
          "app_ids-mapping" = {
            "firefoxdeveloperedition" = "firefox-developer-edition";
          };
          rewrite = {
            "Firefox Web Browser" = "Firefox";
          };
        };
        tray = {
          "icon-size" = 18;
          spacing = 10;
        };
        "custom/notification" = {
          tooltip = false;
          format = "{} {icon}";
          "format-icons" = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            "dnd-notification" = "<span foreground='red'><sup></sup></span>";
            "dnd-none" = "";
            "inhibited-notification" = "<span foreground='red'><sup></sup></span>";
            "inhibited-none" = "";
            "dnd-inhibited-notification" = "<span foreground='red'><sup></sup></span>";
            "dnd-inhibited-none" = "";
          };
          "return-type" = "json";
          "exec-if" = "which swaync-client";
          exec = "swaync-client -swb";
          "on-click" = "swaync-client -t -sw";
          "on-click-right" = "swaync-client -d -sw";
          escape = true;
        };
      }
    ];
  };
}
