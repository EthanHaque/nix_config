{ config, lib, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    withNodeJs = true;

    extraPackages = with pkgs; [
      gcc
      xclip
      ripgrep
      lua-language-server
      stylua
      pyrefly
      eslint
      ruff
      vtsls
    ];
  };

  # This line now handles everything else.
  xdg.configFile."nvim".source = pkgs.fetchFromGitHub {
    owner = "EthanHaque";
    repo = "nvim_lazy_config";
    rev = "0f6d60c088e3a8e7952381b219a0541442dfc43f";
    sha256 = "+357VBODem6f35wdDceSJjyflfGc10yLcAvl5ZFoCYg=";
  };
}
