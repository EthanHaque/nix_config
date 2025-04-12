{
pkgs,
config,
...
}:
{
  dconf.settings = {
    "org/gnome/shell" = {
      allow-extension-installation = true;
      always-show-log-out = false;
      app-picker-layout = ''
        [{'org.gnome.Geary.desktop': <{'position': <0>}>,
          'org.gnome.Contacts.desktop': <{'position': <1>}>,
          'org.gnome.Weather.desktop': <{'position': <2>}>,
          'org.gnome.clocks.desktop': <{'position': <3>}>,
          'org.gnome.Maps.desktop': <{'position': <4>}>,
          'org.gnome.Books.desktop': <{'position': <5>}>,
          'org.gnome.Photos.desktop': <{'position': <6>}>,
          'org.gnome.Totem.desktop': <{'position': <7>}>,
          'org.gnome.Calculator.desktop': <{'position': <8>}>,
          'org.gnome.gedit.desktop': <{'position': <9>}>,
          'simple-scan.desktop': <{'position': <10>}>,
          'org.gnome.Settings.desktop': <{'position': <11>}>,
          'org.gnome.SystemMonitor.desktop': <{'position': <12>}>,
          'org.gnome.Boxes.desktop': <{'position': <13>}>,
          'org.gnome.Terminal.desktop': <{'position': <14>}>,
          'Utilities': <{'position': <15>}>,
          'org.gnome.Characters.desktop': <{'position': <16>}>,
          'yelp.desktop': <{'position': <17>}>,
          'org.gnome.Screenshot.desktop': <{'position': <18>}>,
          'org.gnome.Cheese.desktop': <{'position': <19>}>,
          'org.gnome.font-viewer.desktop': <{'position': <20>}>}]
      '';
      command-history = [];
      development-tools = true;
      disable-extension-version-validation = false;
      disable-user-extensions = false;
      disabled-extensions = [];
      enabled-extensions = ["pop-shell@system76.com"];
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
      ];
      last-selected-power-profile = "power-saver";
      looking-glass-history = [];
      remember-mount-password = false;
      welcome-dialog-last-shown-version = "47.2";
    };
    "org/gnome/shell/app-switcher" = {
      current-workspace-only = false;
    };
    "org/gnome/shell/window-switcher" = {
      app-icon-mode = "both";
      current-workspace-only = true;
    };
    "org/gnome/shell/weather" = {
      automatic-location = false;
      locations = [];
    };
    "org/gnome/shell/world-clocks" = {
      locations = [];
    };
    "org/gnome/shell/keybindings" = {
      focus-active-notification = ["<Super>n"];
      open-new-window-application-1 = ["<Super><Control>1"];
      open-new-window-application-2 = ["<Super><Control>2"];
      open-new-window-application-3 = ["<Super><Control>3"];
      open-new-window-application-4 = ["<Super><Control>4"];
      open-new-window-application-5 = ["<Super><Control>5"];
      open-new-window-application-6 = ["<Super><Control>6"];
      open-new-window-application-7 = ["<Super><Control>7"];
      open-new-window-application-8 = ["<Super><Control>8"];
      open-new-window-application-9 = ["<Super><Control>9"];
      screenshot = [];
      screenshot-window = [];
      shift-overview-down = ["<Super><Alt>Down"];
      shift-overview-up = ["<Super><Alt>Up"];
      show-screen-recording-ui = [];
      show-screenshot-ui = [];
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
      switch-to-application-5 = ["<Super>5"];
      switch-to-application-6 = ["<Super>6"];
      switch-to-application-7 = ["<Super>7"];
      switch-to-application-8 = ["<Super>8"];
      switch-to-application-9 = ["<Super>9"];
      toggle-application-view = ["<Super>a"];
      toggle-message-tray = ["<Super>v" "<Super>m"];
      toggle-overview = [];
      toggle-quick-settings = ["<Super>s"];
    };
    "org/gnome/shell/extensions/pop-shell" = {
      active-hint = true;
      gap-inner = 2;
      gap-outer = 2;
      show-title = true;
      show-skip-taskbar = true;
      column-size = 64;
      row-size = 64;
      smart-gaps = false;
      snap-to-grid = false;
      tile-by-default = true;

      focus-left = ["<Super>Left" "<Super>KP_Left" "<Super>h"];
      focus-down = ["<Super>Down" "<Super>KP_Down" "<Super>j"];
      focus-up = ["<Super>Up" "<Super>KP_Up" "<Super>k"];
      focus-right = ["<Super>Right" "<Super>KP_Right" "<Super>l"];

      activate-launcher = ["<Super>slash"];
      toggle-stacking = ["s"];
      toggle-stacking-global = ["<Super>s"];
      management-orientation = ["o"];
      tile-enter = ["<Super>Return" "<Super>KP_Enter"];
      tile-accept = ["Return" "KP_Enter"];
      tile-reject = ["Escape"];
      toggle-floating = ["<Super>g"];
      toggle-tiling = ["<Super>y"];

      tile-move-left = ["Left" "KP_Left" "h"];
      tile-move-down = ["Down" "KP_Down" "j"];
      tile-move-up = ["Up" "KP_Up" "k"];
      tile-move-right = ["Right" "KP_Right" "l"];
      tile-orientation = ["<Super>o"];

      tile-resize-left = ["<Shift>Left" "<Shift>KP_Left" "<Shift>h"];
      tile-resize-down = ["<Shift>Down" "<Shift>KP_Down" "<Shift>j"];
      tile-resize-up = ["<Shift>Up" "<Shift>KP_Up" "<Shift>k"];
      tile-resize-right = ["<Shift>Right" "<Shift>KP_Right" "<Shift>l"];

      tile-swap-left = ["<Primary>Left" "<Primary>KP_Left" "<Primary>h"];
      tile-swap-down = ["<Primary>Down" "<Primary>KP_Down" "<Primary>j"];
      tile-swap-up = ["<Primary>Up" "<Primary>KP_Up" "<Primary>k"];
      tile-swap-right = ["<Primary>Right" "<Primary>KP_Right" "<Primary>l"];

      pop-workspace-down = ["<Super><Shift>Down" "<Super><Shift>KP_Down" "<Super><Shift>j"];
      pop-workspace-up = ["<Super><Shift>Up" "<Super><Shift>KP_Up" "<Super><Shift>k"];
      pop-monitor-down = ["<Super><Shift><Primary>Down" "<Super><Shift><Primary>KP_Down" "<Super><Shift><Primary>j"];
      pop-monitor-up = ["<Super><Shift><Primary>Up" "<Super><Shift><Primary>KP_Up" "<Super><Shift><Primary>k"];
      pop-monitor-left = ["<Super><Shift>Left" "<Super><Shift>KP_Left" "<Super><Shift>h"];
      pop-monitor-right = ["<Super><Shift>Right" "<Super><Shift>KP_Right" "<Super><Shift>l"];

      hint-color-rgba = "rgba(10, 184, 108, 1)";
      log-level = 0;
    };
    "org/gnome/desktop/wm/keybindings" = {
      activate-window-menu = [];
      always-on-top = [];
      begin-move = [];
      begin-resize = [];
      close = ["<Super>q"];
      cycle-group = [];
      cycle-group-backward = [];
      cycle-panels = [];
      cycle-panels-backward = [];
      cycle-windows = [];
      cycle-windows-backward = [];
      lower = [];
      maximize-horizontally = [];
      maximize = ["<Super>Up"];
      maximize-vertically = [];
      minimize = [];
      move-to-center = [];
      move-to-corner-ne = [];
      move-to-corner-nw = [];
      move-to-corner-se = [];
      move-to-corner-sw = [];
      move-to-monitor-down = [];
      move-to-monitor-left = [];
      move-to-monitor-right = [];
      move-to-monitor-up = [];
      move-to-side-e = [];
      move-to-side-n = [];
      move-to-side-s = [];
      move-to-side-w = [];
      move-to-workspace-1 = [];
      move-to-workspace-2 = [];
      move-to-workspace-3 = [];
      move-to-workspace-4 = [];
      move-to-workspace-5 = [];
      move-to-workspace-6 = [];
      move-to-workspace-7 = [];
      move-to-workspace-8 = [];
      move-to-workspace-9 = [];
      move-to-workspace-10 = [];
      move-to-workspace-11 = [];
      move-to-workspace-12 = [];
      move-to-workspace-down = ["<Control><Shift><Alt>Down"];
      move-to-workspace-last = [];
      move-to-workspace-left = [];
      move-to-workspace-right = [];
      move-to-workspace-up = ["<Control><Shift><Alt>Up"];
      panel-main-menu = [];
      panel-run-dialog = ["<Alt>F2"];
      raise = [];
      raise-or-lower = [];
      set-spew-mark = [];
      show-desktop = [];
      switch-applications-backward = ["<Shift><Super>Tab" "<Shift><Alt>Tab"];
      switch-applications = ["<Super>Tab" "<Alt>Tab"];
      switch-group-backward = ["<Shift><Super>Above_Tab" "<Shift><Alt>Above_Tab"];
      switch-group = ["<Super>Above_Tab" "<Alt>Above_Tab"];
      switch-input-source-backward = ["<Shift><Super>space" "<Shift>XF86Keyboard"];
      switch-input-source = ["<Super>space" "XF86Keyboard"];
      switch-panels = [];
      switch-panels-backward = [];
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-to-workspace-5 = ["<Super>5"];
      switch-to-workspace-6 = ["<Super>6"];
      switch-to-workspace-7 = ["<Super>7"];
      switch-to-workspace-8 = ["<Super>8"];
      switch-to-workspace-9 = ["<Super>9"];
      switch-to-workspace-10 = [];
      switch-to-workspace-11 = [];
      switch-to-workspace-12 = [];
      switch-to-workspace-down = ["<Control><Alt>Down"];
      switch-to-workspace-last = ["<Super>End"];
      switch-to-workspace-left = ["<Shift><Super>h"];
      switch-to-workspace-right = ["<Shift><Super>l"];
      switch-to-workspace-up = ["<Control><Alt>Up"];
      switch-windows = [];
      switch-windows-backward = [];
      toggle-above = [];
      toggle-fullscreen = [];
      toggle-maximized = [];
      toggle-on-all-workspaces = [];
      unmaximize = [];
    };
  };
}
