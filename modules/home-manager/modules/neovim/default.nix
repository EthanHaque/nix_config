{ config, lib, pkgs, inputs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    withNodeJs = true;

    plugins = with pkgs.vimPlugins; [
    ];

    extraPackages = with pkgs; [
      gcc
      ripgrep
      lua-language-server
      stylua
      pyright
      eslint
      ruff
      vtsls
    ];
  };

  xdg.configFile."nvim".source = inputs.nvim-lazy-config;
}
