{
pkgs,
config,
...
}:
{
  programs.yazi = {
    enable = true;
  };

  home.packages = with pkgs; [
    poppler # pdf preview
    ffmpeg  # video thumbnails
  ];
}
