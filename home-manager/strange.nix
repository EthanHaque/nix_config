inputs @ { config, pkgs, vars, ... }: {
  imports = [
    ./modules/browsers
    ./modules/neovim
    ./modules/kitty
    ./modules/tmux
    ./modules/starship
  ];
  home.username = "strange";
  home.homeDirectory = "/home/strange";

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    ruff
    btop
    devenv
    gnomeExtensions.pop-shell
    bat
    lsd
  ];

  home.file = { };

  dconf.settings = {
    "org/gnome/shell" = {
      disabled-extensions = "disabled";
      enabled-extensions = ["pop-shell@system76.com"];
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
    "org/gnome/shell/keybindings" = {
      screenshot = [];
      screenshot-window = [];
      show-screen-recording-ui = [];
      show-screenshot-ui = [];
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
    };

    "org/gnome/shell/extensions/pop-shell" = {
      active-hint = true;
      stacking-with-mouse = false;
      tile-by-default = true;
    };
  };

  programs.git = {
    enable = true;
    userName = "Ethan Haque";
    userEmail = "ethan.k.haque@gmail.com";
    extraConfig.init.defaultBranch = "main";
    extraConfig.pull.rebase = true;
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      cat = "bat";
      ls = "lsd";
      ll = "ls -l";
      la = "ls -a";
      lla = "ls -la";
    };
  };
  programs.home-manager.enable = true;
}
