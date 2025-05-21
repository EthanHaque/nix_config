local lspconfig = require("lspconfig")
local util = require("lspconfig.util")
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.biome.setup({
  cmd = { "biome", "lsp-proxy" },
  filetypes = { "javascript", "typescript", "json", "jsonc" },
  root_dir = util.root_pattern("biome.json", ".git"),
  single_file_support = false,
  capabilities = lsp_capabilities,
})

lspconfig.ruff.setup {
  capabilities = lsp_capabilities,
  on_attach = function(client)
    if client.name == 'ruff' then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end
}
lspconfig.pyright.setup({
  capabilities = lsp_capabilities,
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = { '*' },
      },
    },
  },
})
lspconfig.lua_ls.setup({
  capabilities = lsp_capabilities,
})
lspconfig.ccls.setup({
  capabilities = lsp_capabilities,
})
