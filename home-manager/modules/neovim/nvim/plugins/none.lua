local nls = require("null-ls")

nls.setup({
  sources = {
    nls.builtins.formatting.biome,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(c) return c.name == "null-ls" end,
          })
        end,
      })
    end
  end,
})
