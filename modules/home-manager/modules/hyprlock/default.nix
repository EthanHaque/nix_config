{
  pkgs,
  config,
  ...
}:
let
  wallpaper = "~/Pictures/forest_rays.jpg";

  colors = {
    dark   = "1a1917";
    text   = "D4BE98";
    green  = "2E8B57";
    blue   = "87CEEB";
    purple = "8A2BE2";
    fail   = "E95678";
  };

in
{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
        immediate_render = true;
        hide_cursor = false;
        no_fade_in = true;
      };

      animation = [
        "inputFieldDots, 1, 2, linear"
        "fadeIn, 0"
      ];

      background = [
        {
          monitor = "";
          path = "${wallpaper}";
          blur_passes = 2;
          contrast = 1;
          brightness = 0.8;
          vibrancy = 0.2;
        }
      ];

      input-field = [
        {
          monitor = "";

          size = "300, 50";
          valign = "center";
          position = "0%, -5%";

          outline_thickness = 1;

          font_family = "JetBrainsMono Nerd Font";
          font_color = "rgb(${colors.text})";
          outer_color = "rgb(${colors.green})";
          inner_color = "rgb(${colors.dark})";
          check_color = "rgb(${colors.blue})";
          fail_color = "rgb(${colors.fail})";

          fade_on_empty = false;
          placeholder_text = "Enter Password";

          dots_spacing = 0.2;
          dots_center = true;
          dots_fade_time = 100;

          shadow_color = "rgba(0, 0, 0, 0.1)";
          shadow_size = 7;
          shadow_passes = 2;
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          font_size = 150;
          font_family = "JetBrainsMono Nerd Font ExtraBold";
          color = "rgb(${colors.green})";

          position = "0%, 10%";

          valign = "center";
          halign = "center";

          shadow_color = "rgba(0, 0, 0, 0.1)";
          shadow_size = 20;
          shadow_passes = 2;
          shadow_boost = 0.3;
        }
        {
          monitor = "";
          text = "cmd[update:3600000] date +'%a %b %d'";
          font_size = 20;
          font_family = "JetBrainsMono Nerd Font";
          color = "rgb(${colors.text})";

          position = "0%, 20%";

          valign = "center";
          halign = "center";

          shadow_color = "rgba(0, 0, 0, 0.1)";
          shadow_size = 20;
          shadow_passes = 2;
          shadow_boost = 0.3;
        }
      ];
    };
  };
}
