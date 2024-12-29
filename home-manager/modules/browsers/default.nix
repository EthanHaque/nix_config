{
pkgs,
config,
inputs,
...
}: {
  programs.firefox = {
    enable = true;
    profiles.default = {
      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        ublock-origin
        tridactyl
        noscript
      ];
    };
  };
}
