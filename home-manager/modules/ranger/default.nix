{
pkgs,
config,
...
}:
{
  programs.ranger = {
    enable = true;
    settings = {
      preview_images = true;
      preview_images_method = "kitty";
    };
  };

  home.packages = with pkgs; [
    python3Packages.pillow  # Required for image previews
  ];
}
