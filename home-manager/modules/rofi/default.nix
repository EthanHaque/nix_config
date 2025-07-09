
{
pkgs,
config,
...
}:
{
  programs.rofi = {
    enable = true;
    config = {
      modes = "combi,drun,recursivebrowser,filebrowser,window,run,ssh,keys";
      combi-modes = "drun,filebrowser";
      show-icons = true;
      case-sensitive = false;
      cycle = true;
      filter = "";
      scroll-method = 0;
      normalize-match = true;
      terminal = "Ghostty";
      preview-cmd = "rofi-preview -m {mode} -i {input}";
      hover-select = true;
      steal-focus = false;
      me-select-entry = "MouseSecondary";
      me-accept-entry = "MousePrimary";

      # Matching
      matching = "normal";
      tokenize = true;

      # Layout
      location = 0;
      yoffset = 0;
      xoffset = 0;
      sidebar-mode = true;
      fixed-num-lines = true;

      # Drun
      drun-display-format = "{name}";
      drun-categories = "";
      drun-show-actions = true;
      drun-url-launcher = "xdg-open";
      drun-match-fields = "name,generic,exec,categories,keywords";
      "drun" = {
        scan-desktop = false;
        parse-user = false;
      };

      # Run
      run-command = "{cmd}";
      run-list-command = "";
      run-shell-command = "{terminal} -e {cmd}";
      "run" = {
        # Make sure this path is accessible on your system
        fallback-icon = "/home/sujan/dotfiles/.config/rofi/icons/icons8-script-listener-64.png";
      };

      # Window Switcher
      window-command = "wmctrl -i -R {window}";
      window-match-fields = "all";
      window-format = "{w} . {c} . {t-1}";

      # SSH
      ssh-client = "ssh";
      ssh-command = "{terminal} -e {ssh-client} {host} [-p {port}]";
      parse-hosts = true;
      parse-known-hosts = true;
      "ssh" = {
        fallback-icon = "/home/sujan/dotfiles/.config/rofi/icons/icons8-ssh-64.png";
      };

      # File browser
      "filebrowser" = {
        directory = "$HOME";
        directories-first = true;
        sorting-method = "name";
        show-hidden = true;
        fallback-icon = "/home/sujan/dotfiles/.config/rofi/icons/icons8-question-mark-64.png";
      };

      # Recursive File browser
      "recursivebrowser" = {
        directory = "$HOME";
        filter-regex = "(.*cache.*|.*\\.o)";
        command = "xdg-open";
        fallback-icon = "/home/sujan/dotfiles/.config/rofi/icons/icons8-search-file-64.png";
      };

      # Keys
      "keys" = {
        fallback-icon = "/home/sujan/dotfiles/.config/rofi/icons/icons8-keyboard-64.png";
      };

      # History and Sorting
      disable-history = false;
      sorting-method = "normal";
      max-history-size = 24;

      # Display
      display-drun = "  Apps";
      display-run = "  Term";
      display-window = "  Window";
      display-filebrowser = "  Files";
      display-combi = "  Combi";
      display-keys = " Keys";
      display-ssh = "  SSH";
      display-recursivebrowser = "󰱼 Recursive File Search";
    };
  };
}
