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

  gtk.cursorTheme.name = "Bibata-Modern-Ice";
  gtk.cursorTheme.package = pkgs.bibata-cursors;
}
