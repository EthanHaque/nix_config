{
pkgs,
config,
...
}:
{
  gtk.enable = true;

  gtk.theme.name = "Graphite-Dark";
  gtk.theme.package = pkgs.graphite-gtk-theme;

  gtk.iconTheme.name = "Papirus-Dark";
  gtk.iconTheme.package = pkgs.papirus-icon-theme;
}
