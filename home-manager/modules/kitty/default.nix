{
pkgs,
config,
...
}:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font Mono";
      size = 10;
    };
    settings = {
      enable_audio_bell = false;

      cursor = "#ffffff";
      cursor_shape = "underline";
      cursor_underline_thickness = 1.5;
      cursor_blink_interval = 0.7;
      cursor_trail = 4;
      cursor_trail_decay = "0.1 0.2";

      scrollback_lines = 2000;
      scrollback_fill_enlarged_window = false;
      wheel_scroll_multiplier = 8.0;
      wheel_scroll_min_lines = 1;

      tab_bar_style = "powerline";

      repaint_delay = 20;
      input_delay = 5;
      sync_to_monitor = true;

      foreground = "#ffffff";
      background = "#16181a";
      background_opacity = 0.8;
      background_tint = 1.0;
      dim_opacity = 0.75;
      selection_foreground = "#16181a";
      selection_background = "#5ea1ff";

      color0 = "#16181a";
      color8 = "#1e2124";
      color1 = "#ff6e5e";
      color9 = "#ff6e5e";
      color2 = "#5eff6c";
      color10 = "#5eff6c";
      color3 = "#f1ff5e";
      color11 = "#f1ff5e";
      color4 = "#5ea1ff";
      color12 = "#5ea1ff";
      color5 = "#ff5ef1";
      color13 = "#ff5ef1";
      color6 = "#5ef1ff";
      color14 = "#5ef1ff";
      color7 = "#ffffff";
      color15 = "#ffffff";

      keybindings = ''
        map ctrl+w close_tab
        map ctrl+t new_tab_with_cwd
        map f1 set_tab_title


        enabled_layouts Tall, *
        map ctrl+enter new_window
        map ctrl+h neighboring_window left
        map ctrl+j neighboring_window bottom
        map ctrl+k neighboring_window top
        map ctrl+l neighboring_window right
      '';
    };
  };
}
