{
pkgs,
config,
...
}:
{
  services.swaync = {
    enable = true;
    style = builtins.readFile ./style.css;
    settings = {
      positionX = "right";
      positionY = "bottom";
      control-center-positionX = "none";
      control-center-positionY = "none";
      control-center-margin-top = 8;
      control-center-margin-bottom = 8;
      control-center-margin-right = 8;
      control-center-margin-left = 8;
      control-center-width = 400;
      control-center-height = 600;
      fit-to-screen = true;
      layer = "overlay";
      control-center-layer = "overlay";
      cssPriority = "user";
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      notification-inline-replies = false;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      notification-window-width = 500;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = true;
      hide-on-action = true;
      script-fail-notify = true;
      widgets = [
        "menubar"
        "buttons-grid"
        "volume"
        "mpris"
        "inhibitors"
        "title"
        "dnd"
        "notifications"
      ];
      widget-config = {
        inhibitors = {
          text = "Inhibitors";
          button-text = "Clear All";
          clear-all-button = true;
        };
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        mpris = {
          image-size = 96;
          image-radius = 6;
        };
        volume = {
          label = "🔊";
        };
        menubar = {
          "menu#power-buttons" = {
            label = "";
            position = "right";
            actions = [
              {
                label = "  Reboot";
                command = "systemctl reboot";
              }
              {
                label = "  Lock";
                command = "hyprlock";
              }
              {
                label = "  Logout";
                command = "hyprctl dispatch exit";
              }
              {
                label = "  Shut down";
                command = "systemctl poweroff";
              }
            ];
          };
          "menu#dotfiles-buttons" = {
            label = " ";
            position = "left";
            actions = [
              {
                label = "  My Github";
                command = "firefox https://github.com/EthanHaque";
              }
            ];
          };
        };
        "buttons-grid" = {
          actions = [
            {
              label = " ";
              command = "kitty nmtui";
            }
            {
              label = "";
              command = "blueman-manager";
            }
            {
              label = "";
              command = "firefox";
            }
            {
              label = "󱂵";
              command = "nautilus";
            }
          ];
        };
      };
    };
  };
}
