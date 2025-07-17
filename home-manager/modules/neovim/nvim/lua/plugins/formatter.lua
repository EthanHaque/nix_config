return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      ["javascript"] = { "prettierd" },
      ["javascriptreact"] = { "prettierd" },
      ["typescript"] = { "prettierd" },
      ["typescriptreact"] = { "prettierd" },
      ["css"] = { "prettierd" },
      ["html"] = { "prettierd" },
      ["json"] = { "prettierd" },
      ["yaml"] = { "prettierd" },
      ["markdown"] = { "prettierd" },
      ["lua"] = { "stylua" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
