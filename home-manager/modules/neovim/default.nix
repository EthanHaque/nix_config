{
pkgs,
config,
...
}:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      xclip
      ripgrep
      fd
      pyright
      lua-language-server
    ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/autopairs.lua;
      }
      {
        plugin =
        nvim-cmp;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/cmp.lua;
      }
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp_luasnip
      luasnip
      friendly-snippets
      {
        plugin = cyberdream-nvim;
        config = ''
        colorscheme cyberdream
        '';
      }
      {
        plugin = comment-nvim;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/comment.lua;
      }
      {
        plugin = conform-nvim;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/conform.lua;
      }
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/gitsigns.lua;
      }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/lualine.lua;
      }
      {
        plugin = nvim-lspconfig;
        config = builtins.readFile ./nvim/plugins/lsp.lua;
        type = "lua";
      }
      {
        plugin = telescope-nvim;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/telescope.lua;
      }
      telescope-fzf-native-nvim
      {
        plugin = toggleterm-nvim;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/toggleterm.lua;
      }
      {
        plugin = nvim-treesitter;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/treesitter.lua;
      }
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./nvim/config/keymaps.lua}
      ${builtins.readFile ./nvim/config/options.lua}
      ${builtins.readFile ./nvim/config/autocmds.lua}
    '';
  };
}
