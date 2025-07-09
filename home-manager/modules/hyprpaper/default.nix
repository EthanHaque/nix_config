{
pkgs,
config,
...
}:
let
  wallpaper = "~/Pictures/forest_rays.jpg";
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "${wallpaper}"
      ];
      wallpaper = [
        ",${wallpaper}"
      ];
    };
  };
}
