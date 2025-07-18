return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
      {'<leader>fd', "<cmd>Telescope find_files<cr>", desc = "Find file"},
      {'<leader>fg', "<cmd>Telescope live_grep<cr>", desc = "Live grep"},
      {'<leader>fb', "<cmd>Telescope buffers<cr>", desc = "Buffers"},
      {'<leader>fh', "<cmd>Telescope help_tags<cr>", desc = "Help tag"},
  },
}
