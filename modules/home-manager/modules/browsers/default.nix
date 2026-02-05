{
  pkgs,
  config,
  inputs,
  ...
}:
let
  commonExtensions = with inputs.firefox-addons.packages.${pkgs.system}; [
    ublock-origin
    tridactyl
    noscript
  ];
in
{
  programs.firefox = {
    enable = true;

    profiles = {
      default = {
        id = 0;
        isDefault = true;
        extensions.packages = commonExtensions;
      };

      tradespace = {
        id = 1;
        isDefault = false;
        extensions.packages = commonExtensions;
      };
    };
  };
}
