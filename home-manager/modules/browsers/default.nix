{
pkgs,
config,
inputs,
...
}: {
  programs.firefox = {
    enable = true;
    profiles.default = {
      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        ublock-origin
        tridactyl
        noscript
      ];
    };
  };
}
