{
pkgs,
config,
...
}:
let
  wallpaper = "~/Pictures/buffalo_trail.jpg";
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
