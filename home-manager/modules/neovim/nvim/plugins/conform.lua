require("conform").setup({
  formatters = {
    biome = {
      command = "biome",
      args    = { "format", "--stdin-file-path", "$FILENAME" },
      stdin   = true,
    },
  },
})
